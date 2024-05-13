----------------------------------------------------------------------------
-- Module Name:  hsumhres
--
-- Source Path:  hsum_lib/hdl/hsumhres_synth.vhd
--
-- Requirements Covered:
--   FDAS.THRESHOLD:020/A
--   FDAS.THRESHOLD:030/A
--   FDAS.THRESHOLD:040/A
--
-- Functional Description:
--
-- Stores up to 25 analysis results from SUMMER and the storage exceeded
-- reports for 1 harmonic.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     23/05/19 Result RAM re-organised so that 256-bits can be read
--                       at a time by the DMA engine.
--                       P_EXC and S_EXC swapped in bitmap.
--                       Modified base_column_s calculation to work for up
--                       to 16 harmonics.
--                       Renamed generic 'harmonic_g' to 'harmonic_num_g' to
--                       differentiate it from 'harmonic_g' used elsewhere
--                       that has a different meaning.
--                       Removed 'results_g' generic and replaced with
--                       constant defined by 'res_per_h_c(harmonic_num_g)'.
-- 0.3  RJH     11/06/19 Corrected comment in process genfopcol_p header.
--                       Re-aligned some assignments.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2018 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library hsum_lib;
use hsum_lib.hsum_pkg.all;

architecture synth of hsumhres is

-- Define constant for the number of results generated for the harmonic being processed.
constant results_c : natural := res_per_h_c(harmonic_num_g);

-- Function to return the number of bits required to store a value.
function register_size(n : natural) return natural is
  variable count_v : natural := 0;
  variable n_v : natural := n;
begin
  while (n_v > 0) loop
    count_v := count_v + 1;
    n_v := n_v/2;
  end loop;
  return count_v;
end function register_size;

-- Function to return the smaller of the two arguments.
function minimum(a, b : natural) return natural is
begin
  if a < b then
    return a;
  else
    return b;
  end if;
end function minimum;

-- Function to return the larger of the two arguments.
function maximum(a, b : natural) return natural is
begin
  if a > b then
    return a;
  else
    return b;
  end if;
end function maximum;

-- Function to create a lookup table to convert input number into column offset.
type unsigned_array_t is array(natural range <>) of unsigned(21 downto 0);
type natural_array_t is array(natural range <>) of natural;
function column_lookup return unsigned_array_t is
  variable column_lookup_v : unsigned_array_t(0 to summer_g*results_c-1);
begin
  for s in 0 to summer_g-1 loop
    for r in 0 to results_c-1 loop
      column_lookup_v(s*results_c+r) := unsigned(to_signed(r-results_c/2, 22));
    end loop;
  end loop;
  return column_lookup_v;
end function column_lookup;

-- Function to create a lookup table to convert input number into row_info select.
function row_lookup return natural_array_t is
  variable row_lookup_v : natural_array_t(0 to summer_g*results_c-1);
begin
  for s in 0 to summer_g-1 loop
    for r in 0 to results_c-1 loop
      row_lookup_v(s*results_c+r) := s;
    end loop;
  end loop;
  return row_lookup_v;
end function row_lookup;

component hsumhresram is
  port (
    -- Port A: write.
    a_addr       : in  std_logic_vector(5 downto 0);
    a_write_data : in  std_logic_vector(127 downto 0);
    a_write_en   : in  std_logic;
    a_clk        : in  std_logic;

    -- Port B: read.
    b_addr       : in  std_logic_vector(5 downto 0);
    b_read_en    : in  std_logic;
    b_read_data  : out std_logic_vector(127 downto 0);
    b_clk        : in  std_logic
  );
end component hsumhresram;

constant count_size_c  : natural := maximum(summer_g*results_c, max_results_c);  -- Maximum results count required.
constant count_bits_c  : natural := register_size(count_size_c);  -- Number of bits required to count to count_size_c.
constant active_size_c : natural := minimum(summer_g*results_c, max_results_c+1); -- Number of elements in active_s.
constant active_bits_c : natural := register_size(summer_g*results_c); -- Size of each element of active_s.
constant offset_bits_c : natural := register_size(results_c-1);
constant offset_c : unsigned_array_t(0 to summer_g*results_c-1) := column_lookup;
constant summer_c : natural_array_t(0 to summer_g*results_c-1) := row_lookup;

type result_rec_t is record
  pwr   : std_logic_vector(31 downto 0);
  row   : std_logic_vector(6 downto 0);
  col   : std_logic_vector(21 downto 0);
  valid : std_logic;
end record result_rec_t;
type pwr_t is array(natural range <>) of std_logic_vector(31 downto 0);
type result_store_t is array(natural range <>) of result_rec_t; -- Stores max_results_c results plus 1 overflow result.
type row_info_t is array(0 to summer_g-1) of std_logic_vector(6 downto 0);
type active_t is array(natural range <>) of unsigned(active_bits_c-1 downto 0);

constant result_store_init_c : result_rec_t := ((others => '0'), (others => '0'), (others => '0'), '0');

signal seed_col_d1      : unsigned(21 downto 0);
signal seed_col_d2      : std_logic_vector(21 downto 0);
signal pwr_s            : pwr_t(0 to summer_g*results_c-1); -- Input pwr converted to array.
signal pwr_d1           : pwr_t(0 to summer_g*results_c-1); -- pwr_s delayed by 1 cycle.
signal pwr_d2           : pwr_t(0 to summer_g*results_c-1); -- pwr_s delayed by 2 cycles.
signal row_info_s       : row_info_t; -- Input row_info converted to array.
signal row_info_d1      : row_info_t; -- row_info_s delayed by 1 cycle.
signal row_info_d2      : row_info_t; -- row_info_s delayed by 2 cycles.
signal base_column_s    : unsigned(21 downto 0); -- Base FOP column number.
signal active_s         : active_t(0 to active_size_c-1); -- Array containing the input numbers for results to be recorded.
signal valid_s          : std_logic_vector(active_size_c-1 downto 0); -- Indicates which elements of active_s are valid.
signal selector_s       : active_t(0 to max_results_c); -- Result selector for each element of results_store_s.
signal load_en_s        : std_logic_vector(max_results_c downto 0); -- Load enable for each element of results_store_s.
signal new_count_s      : unsigned(count_bits_c-1 downto 0); -- Number of new results to store.
signal held_count_s     : unsigned(count_bits_c-1 downto 0); -- Number of results stored currently.
signal overflow_s       : std_logic; -- Indicates more than 25 results have been received.
signal result_store_s   : result_store_t(0 to max_results_c); -- Working result store.
signal ovrf_count_s     : unsigned(31 downto 0); -- Count of unstored results.
signal shift_s          : std_logic; -- Causes shift_store_s to shift.
signal wr_addr_s        : unsigned(3 downto 0); -- LSBs of write address for RAM.
signal mci_rd_addr_s    : std_logic_vector(5 downto 0); -- Micro read address for RAM.
signal mci_rd_en_s      : std_logic; -- Micro read enable for RAM.
signal rd_addr_s        : std_logic_vector(5 downto 0); -- Read address for RAM.
signal rd_en_s          : std_logic; -- Read enable for RAM.
signal rd_data_s        : std_logic_vector(127 downto 0); -- Read data from RAM.
signal wr_data_s        : std_logic_vector(127 downto 0); -- Write data to RAM.


begin

----------------------------------------------------------------------------
-- Function:  Convert pwr input vector into array.
----------------------------------------------------------------------------
sg : for s in 0 to summer_g-1 generate
  row : row_info_s(s) <= row_info(s*7+6 downto s*7);
  rg : for r in 0 to results_c-1 generate
    pwrin : pwr_s(s*results_c + r) <= pwr((s*results_c + r)*32+31 downto (s*results_c + r)*32);
  end generate rg;
end generate sg;


----------------------------------------------------------------------------
-- Function:  Pipeline the inputs to line up with processing below.
----------------------------------------------------------------------------
inprt_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    seed_col_d1 <= (others => '0');
    seed_col_d2 <= (others => '0');
    pwr_d1      <= (others => (others => '0'));
    pwr_d2      <= (others => (others => '0'));
    row_info_d1 <= (others => (others => '0'));
    row_info_d2 <= (others => (others => '0'));

  elsif rising_edge(clk_sys) then

    seed_col_d1 <= unsigned(seed_col);
    seed_col_d2 <= std_logic_vector(seed_col_d1);
    pwr_d1      <= pwr_s;
    pwr_d2      <= pwr_d1;
    row_info_d1 <= row_info_s;
    row_info_d2 <= row_info_d1;

  end if;
end process inprt_p;


----------------------------------------------------------------------------
-- Function:  Generate the base FOP column number for this harmonic.
----------------------------------------------------------------------------
genfopcol_p : process(clk_sys, rst_sys_n)
  variable sum_v : unsigned(21 downto 0);
begin
  if rst_sys_n = '0' then
    -- Initialise.
    base_column_s <= (others => '0');

  elsif rising_edge(clk_sys) then
    -- Calculate the base (centre) column for this harmonic.
    sum_v := (others => '0');
    for i in 0 to 4 loop
      if to_unsigned(harmonic_num_g+1, 5)(i) = '1' then
        sum_v := sum_v + shift_left(seed_col_d1, i);
      end if;
    end loop;
    base_column_s <= sum_v;
  end if;
end process genfopcol_p;


----------------------------------------------------------------------------
-- Function:  Count the number of active input results.
----------------------------------------------------------------------------
count_new_p : process(clk_sys, rst_sys_n)
  variable count_v        : natural range 0 to summer_g*results_c;
begin
  if rst_sys_n = '0' then
    -- Initialise.
    new_count_s <= (others => '0');

  elsif rising_edge(clk_sys) then

    count_v := 0;

    for i in 0 to summer_g*results_c-1 loop
      if tc(i) = '1' then
        count_v := count_v + 1;
      end if;
    end loop;

    new_count_s <= to_unsigned(count_v, new_count_s'length);
  end if;

end process count_new_p;


----------------------------------------------------------------------------
-- Function:  Find which input results are active and store them in an array.
----------------------------------------------------------------------------
findactive_p : process(clk_sys, rst_sys_n)
  variable count_v : natural range 0 to summer_g*results_c-1;
begin
  if rst_sys_n = '0' then
    -- Initialise.
    active_s <= (others => (others => '0'));
    valid_s  <= (others => '0');

  elsif rising_edge(clk_sys) then

    active_s <= (others => (others => '0'));
    valid_s  <= (others => '0');

    for i in 0 to active_size_c-1 loop
      for j in i to summer_g*results_c-1 loop
        if tc(j) = '1' then
          count_v := 0;
          for c in 0 to j-1 loop
            if tc(c) = '1' then
              count_v := count_v + 1;
            end if;
          end loop;
          if count_v = i then
            active_s(i) <= to_unsigned(j, active_bits_c);
            valid_s(i) <= '1';
            exit;
          end if;
        end if;
      end loop;
    end loop;

  end if;

end process findactive_p;

----------------------------------------------------------------------------
-- Function:  Determine which parts of the result store to update and which
--            result input goes where.
----------------------------------------------------------------------------
store_prepare_p : process(clk_sys, rst_sys_n)
  variable next_held_count_v : unsigned(count_bits_c downto 0);
  variable selector_v : natural range 0 to summer_g*results_c-1;
begin
  if rst_sys_n = '0' then
    -- Initialsise.
    overflow_s   <= '0';
    held_count_s <= (others => '0');
    ovrf_count_s <= (others => '0');
    selector_s   <= (others => (others => '0'));
    load_en_s    <= (others => '0');

  elsif rising_edge(clk_sys) then

    -- Defaults.
    next_held_count_v := ('0' & held_count_s) + new_count_s;
    selector_s <= (others => (others => '0'));
    load_en_s  <= (others => '0');

    -- Process incoming results.
    if overflow_s = '0' then

      -- Set up the selector for each store location.
      for i in 0 to max_results_c loop -- Loop through the results_store_s locations.
        if i = held_count_s then
          for j in 0 to active_size_c-1 loop -- Loop through the active results.
            selector_s(i+j) <= active_s(j);
            load_en_s(i+j)  <= valid_s(j);
            if i+j >= max_results_c then
              exit;
            end if;
          end loop;
        end if;
      end loop;

      -- Update result counts.
      if next_held_count_v > max_results_c then
        -- Result store overflow.
        held_count_s <= to_unsigned(max_results_c, held_count_s'length);
        ovrf_count_s <= resize(next_held_count_v, ovrf_count_s'length) - max_results_c;
        overflow_s   <= '1';
      else
        held_count_s <= next_held_count_v(count_bits_c - 1 downto 0);
      end if;

    else
      -- Accumulate number of unstored results.
      ovrf_count_s <= ovrf_count_s + new_count_s;
    end if; -- overflow_s = '0'

    -- Clear store at start of new run.
    if clear_results = '1' then
      held_count_s <= (others => '0');
      ovrf_count_s <= (others => '0');
      overflow_s   <= '0';
    end if;

  end if; -- rst_sys_n = '0'

end process store_prepare_p;

----------------------------------------------------------------------------
-- Function:  Store active results in appropriate part of results store.
----------------------------------------------------------------------------
store_p : process(clk_sys, rst_sys_n)
  variable next_held_count_v : unsigned(count_bits_c downto 0);
  variable selector_v : natural range 0 to summer_g*results_c-1;
begin
  if rst_sys_n = '0' then
    -- Initialise.
    result_store_s   <= (others => result_store_init_c);

  elsif rising_edge(clk_sys) then

    -- Update results store.
    for i in 0 to max_results_c-1 loop -- Loop through the results_store_s locations.
      if load_en_s(i) = '1' then
        selector_v              := to_integer(selector_s(i));
        result_store_s(i).pwr   <= pwr_d2(selector_v);
        result_store_s(i).valid <= '1';
        result_store_s(i).row   <= row_info_d2(summer_c(selector_v));
        result_store_s(i).col   <= std_logic_vector(base_column_s + offset_c(selector_v));
      end if;
    end loop;
    -- Overflow result is slightly different.
    if load_en_s(max_results_c) = '1' then
      selector_v                          := to_integer(selector_s(max_results_c));
      result_store_s(max_results_c).row   <= row_info_d2(summer_c(selector_v));
      result_store_s(max_results_c).col   <= std_logic_vector(seed_col_d1);
      result_store_s(max_results_c).valid <= '0';
    end if;

    -- Put overflow counter into results store at end of run.
    if save_results = '1' then
      result_store_s(max_results_c).pwr <= std_logic_vector(ovrf_count_s);
    end if;

    -- Shift results through store when transferring to RAM.
    -- Two results are written at a time, thus shift by two words.
    if shift_s = '1' then
      for i in 0 to max_results_c-2 loop
        result_store_s(i) <= result_store_s(i+2);
      end loop;
      -- Load the DM count into the end of the register.
      for i in max_results_c-1 to max_results_c loop
        result_store_s(i).pwr   <= dm_count;
        result_store_s(i).col   <= (others => '0');
        result_store_s(i).row   <= (others => '0');
        result_store_s(i).valid <= '0';
      end loop;
    end if;

    -- Clear store at start of new run.
    if clear_results = '1' then
      for i in 0 to max_results_c loop
        result_store_s(i).valid <= '0';
      end loop;
    end if;

  end if; -- rst_sys_n = '0'

end process store_p;


----------------------------------------------------------------------------
-- Function:  Transfer results to RAM.
--
--            Analysis results are stored using two words for each result:
--            Word 0 : Bit  31    = VALID
--                     Bits 28:22 = FOPROW
--                     Bits 21:0  = FOPCOL
--            Word 1 : Bits 31:0  = PWR
--
--            Two results are stored together in one word of RAM 128 bits wide.
--            When expanded to give 1 item per 32-bit word, this provides
--            enough data for a 256-bit DMA transfer.
--
--            The exceeded storage results are stored following the above:
--            Word 0 : Bits 28:22 = P_EXC
--                     Bits 21:0  = S_EXC
--            Word 1 : Bits 31:0  = T_EXC
--
--            The RAM is provisioned to provide enough storage for
--            upto 32 results of 2x32-bits each = 64 x 32 bits
--             x 2 analysis runs                = 128 x 32 bits
--             x 2 pages (working, non-working) = 256 x 32 bits
--                                              = 64 x 128 bits
--
----------------------------------------------------------------------------
transfer_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    shift_s   <= '0';
    wr_addr_s <= (others => '0');
    save_done <= '0';

  elsif rising_edge(clk_sys) then
    -- Defaults.
    save_done <= '0';

    if save_results = '1' then
      -- Start writing results to RAM.
      shift_s   <= '1';
      wr_addr_s <= (others => '0');
    end if;

    if shift_s = '1' then
      -- Increment write address.
      wr_addr_s <= wr_addr_s + 1;
    end if;

    if wr_addr_s = (max_results_c+1)/2 then
      -- All results have been written.
      shift_s   <= '0';
      save_done <= '1'; -- Indicate to TGEN.
    end if;

  end if; -- rst_sys_n = '0'
end process transfer_p;

-- Concatenate two results into one word.
sel_wr : wr_data_s <= result_store_s(1).pwr &                                                          -- 127:96
                      result_store_s(1).valid & "00" & result_store_s(1).row & result_store_s(1).col & -- 95:64
                      result_store_s(0).pwr &                                                          -- 63:32
                      result_store_s(0).valid & "00" & result_store_s(0).row & result_store_s(0).col;  -- 31:0

-- Note: Latency of read port is 2, to improve timing.
resultram : hsumhresram
  port map (
    -- Port A: write.
    a_addr(5)          => working_page,
    a_addr(4)          => analysis_run,
    a_addr(3 downto 0) => std_logic_vector(wr_addr_s),
    a_write_data       => wr_data_s,
    a_write_en         => shift_s,
    a_clk              => clk_sys,

    -- Port B: read.
    b_addr             => rd_addr_s,
    b_read_en          => rd_en_s,
    b_read_data        => rd_data_s,
    b_clk              => clk_sys
  );

----------------------------------------------------------------------------
-- Function:  Micro read back of results.
--
--            Analysis results are addressed as follows:
--            Base = page*4096 + analysis_run*2048 + harmonic*128 + harmonic_report_num*4
--            Offset : 0 = VALID and HARMONIC
--                     1 = FOPCOL
--                     2 = FOPROW
--                     3 = PWR
--
--            Storage exceeded reports are addressed as follows:
--            Base = dm_set*128 + analysis_run*64 + harmonic*4
--            Offset : 0 = T_EXC
--                     1 = S_EXC
--                     2 = P_EXC
----------------------------------------------------------------------------
micro_rd_p : process(results, exc, rd_data_s, working_page)
begin
  -- Defaults to ensure combinatorial logic.
  results_rd    <= (others => '0');
  exc_rd        <= (others => '0');
  mci_rd_addr_s <= (others => '0');
  mci_rd_en_s   <= '0';
  results_rd    <= (others => '0');
  exc_rd        <= (others => '0');

  if results.rden = '1' and unsigned(results.addr(10 downto 7)) = harmonic_num_g then
    -- Read analysis result.
    mci_rd_en_s   <= '1';
    mci_rd_addr_s <= ((not working_page) xor results.addr(12)) & results.addr(11)
                     & results.addr(6 downto 3);

    case results.addr(2 downto 0) is
      when "000" =>
        results_rd <= X"00000" & "000" & rd_data_s(31) & "0000" &
                      std_logic_vector(to_unsigned(harmonic_num_g,4));
      when "001" =>
        results_rd <= X"00" & "00" & rd_data_s(21 downto 0);
      when "010" =>
        results_rd <= X"000000" & "0" & rd_data_s(28 downto 22);
      when "011" =>
        results_rd <= rd_data_s(63 downto 32);
      when "100" =>
        results_rd <= X"00000" & "000" & rd_data_s(95) & "0000" &
                      std_logic_vector(to_unsigned(harmonic_num_g,4));
      when "101" =>
        results_rd <= X"00" & "00" & rd_data_s(85 downto 64);
      when "110" =>
        results_rd <= X"000000" & "0" & rd_data_s(92 downto 86);
      when "111" =>
        results_rd <= rd_data_s(127 downto 96);
      when others =>
        null;
    end case;

  end if; -- results.rden = '1' and unsigned(results.addr(10 downto 7)) = harmonic_num_g

  if exc.rden = '1' and unsigned(exc.addr(5 downto 2)) = harmonic_num_g then
    -- Read exceeded storage report.
    mci_rd_en_s <= '1';
    mci_rd_addr_s <= ((not working_page) xor exc.addr(7)) & exc.addr(6) &
                 std_logic_vector(to_unsigned((max_results_c)/2,4));

    if max_results_c mod 2 = 0  then
      case exc.addr(1 downto 0) is
        when "00" =>
          exc_rd <= rd_data_s(63 downto 32);
        when "01" =>
          exc_rd <= X"00" & "00" &  rd_data_s(21 downto 0);
        when "10" =>
          exc_rd <= X"000000" & "0" & rd_data_s(28 downto 22);
        when others =>
          null;
      end case;
    else
      case exc.addr(1 downto 0) is
        when "00" =>
          exc_rd <= rd_data_s(127 downto 96);
        when "01" =>
          exc_rd <= X"00" & "00" &  rd_data_s(85 downto 64);
        when "10" =>
          exc_rd <= X"000000" & "0" & rd_data_s(92 downto 86);
        when others =>
          null;
      end case;
    end if;
  end if; -- exc.rden = '1' and unsigned(exc.addr(5 downto 2)) = harmonic_num_g

end process micro_rd_p;

-- Connect micro read signals to RAM.
ram_rden : rd_en_s   <= mci_rd_en_s;
ram_addr : rd_addr_s <= mci_rd_addr_s;

end architecture synth;

