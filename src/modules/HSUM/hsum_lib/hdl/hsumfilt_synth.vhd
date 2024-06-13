----------------------------------------------------------------------------
-- Module Name:  hsumfilt
--
-- Source Path:  hsum_lib/hdl/hsumfilt_synth.vhd
--
-- Requirements Covered:
--   FDAS.THRESHOLD:035/A
--
-- Functional Description:
--
--   The purpose of this sub-module is to keep the results from only the
--   highest harmonic that detects threshold crossings for each seed row.
--
--   First, the results from one ambiguity slope are filtered. This is
--   achieved by delaying the results from each harmonic to align with the
--   next harmonic and choosing the appropriate results at each stage.
--
--   Secondly, the results from each ambiguity slope are written to RAM and
--   the highest harmonic number is recorded. The results are then read from
--   RAM and only the results with a harmonic number matching the highest
--   recorded harmonic number are passed on to the hsumhres sub-modules.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     29/10/18 Initial revision.
-- 0.2  RJH     25/04/19 Added generic for max number of harmonics.
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

architecture synth of hsumfilt is

-- Calculate width of RAM required to store all the result values.
constant ram_data_width_c : natural := 32*cols_per_harmonic_c(harmonic_g-1) -- PWR
                                      + cols_per_harmonic_c(harmonic_g-1)   -- TC
                                      + 7                                   -- ROW_INFO
                                      + 4;                                  -- HARMONIC

-- Define constants for the start and end bit positions when the results
-- are concatenated together into one vector.
constant h_s : natural := 0;
constant h_e : natural := 3;
constant r_s : natural := h_e + 1;
constant r_e : natural := h_e + 7;
constant t_s : natural := r_e + 1;
constant t_e : natural := r_e + cols_per_harmonic_c(harmonic_g-1);
constant p_s : natural := t_e + 1;
constant p_e : natural := t_e + cols_per_harmonic_c(harmonic_g-1)*32;

-- Determine how many shift register stages are required.
-- The no. of stages = (harmonics - 1) * adder latency
--                     + extra delay in generating last comparator result
--                     + 1 for final retime.
constant num_stages_c : natural := (harmonic_g-1)*adder_latency_g
                                   + extra_delay_c(harmonic_g-1)
                                   + 1;

-- Define a type to hold the results. Dimension for highest harmonic.
type result_t is record
  row_info  : std_logic_vector(6 downto 0);
  tc        : std_logic_vector(cols_per_harmonic_c(harmonic_g-1)-1 downto 0);
  pwr       : std_logic_vector(cols_per_harmonic_c(harmonic_g-1)*32-1 downto 0);
  harmonic  : unsigned(3 downto 0);
end record result_t;

-- Define a type to create a shift register for the results.
type res_shift_reg_t is array(0 to num_stages_c - 1) of result_t;


-- Define signals.
signal res_shift_reg_s    : res_shift_reg_t;  -- Shift register to delay results.
signal sel_results_s      : result_t; -- Result from highest harmonic in use.
signal acount_s           : unsigned(3 downto 0);
signal wr_page_s          : std_logic; -- Write page select.
signal max_harmonic_in_s  : unsigned(3 downto 0);
signal max_harmonic_out_s : unsigned(3 downto 0);
signal last_result_d1     : std_logic;
signal last_result_d2     : std_logic;
signal seed_col_d1        : std_logic_vector(21 downto 0);
signal seed_col_d2        : std_logic_vector(21 downto 0);
signal seed_col_out_s     : std_logic_vector(21 downto 0);
signal wr_data_s          : std_logic_vector(ram_data_width_c-1 downto 0);
signal rd_data_s          : std_logic_vector(ram_data_width_c-1 downto 0);
signal wr_addr_s          : std_logic_vector(4 downto 0);
signal rd_addr_s          : std_logic_vector(4 downto 0);
signal rd_results_s       : result_t;
signal read_valid_s       : std_logic; -- Indicates RAM output is valid (new values).
signal valid_count_s      : unsigned(3 downto 0);

component hsumfiltram is
  generic (
    data_width_g : natural
  );
  port (
    -- Write port.
    write_data : in  std_logic_vector(data_width_g - 1 downto 0);
    write_addr : in  std_logic_vector(4 downto 0);
    write_en   : in  std_logic;

    -- Read port.
    read_addr  : in  std_logic_vector(4 downto 0);
    read_en    : in  std_logic;
    read_data  : out std_logic_vector(data_width_g - 1 downto 0);

    -- Clock and reset.
    clk_sys    : in  std_logic;
    rst_sys_n  : in  std_logic
  );
end component hsumfiltram;

begin

----------------------------------------------------------------------------
-- Function: Filter results for one ambiguity slope.
--           Results are delayed to bring them in line with those for the
--           next harmonic. If the 'next' harmonic has valid results, these
--           are selected to propogate throught the shift register, else
--           the results from the lower harmonics is retained.
----------------------------------------------------------------------------
filter_p : process(clk_sys, rst_sys_n)
  variable mux_stage_v : natural range 0 to num_stages_c;
begin
  if rst_sys_n = '0' then
    -- Initialise.
    res_shift_reg_s <= (others => ((others => '0'), (others => '0'), (others => '0'), (others => '0')));

  elsif rising_edge(clk_sys) then

    -- By default shift data along.
    for i in 1 to num_stages_c - 1 loop
      res_shift_reg_s(i) <= res_shift_reg_s(i-1);
    end loop;

    -- Stage 0 :
    -- Take results for fundamental.
    res_shift_reg_s(0).row_info         <= row_info_in(6 downto 0);
    res_shift_reg_s(0).tc               <= (others => '0');
    res_shift_reg_s(0).tc(0)            <= tc_in(0);
    res_shift_reg_s(0).pwr              <= (others => '0');
    res_shift_reg_s(0).pwr(31 downto 0) <= pwr_in(31 downto 0);
    res_shift_reg_s(0).harmonic         <= "0000";

    -- For each harmonic, decide whether to use its results, or keep the
    -- results from the lower harmonics.
    for i in 1 to harmonic_g - 1 loop
      -- Determine the delay stage at which selection occurs.
      mux_stage_v := i*adder_latency_g + extra_delay_c(i);
      -- Check TC for a result.
      if unsigned(tc_in(last_column_c(i)-1 downto last_column_c(i-1))) /= 0 then
        -- Pass on results for this harmonic.
        res_shift_reg_s(mux_stage_v).row_info <= row_info_in(i*7 + 6 downto i*7);
        res_shift_reg_s(mux_stage_v).tc(cols_per_harmonic_c(i)-1 downto 0) <=
           tc_in(last_column_c(i)-1 downto last_column_c(i-1));
        res_shift_reg_s(mux_stage_v).pwr(cols_per_harmonic_c(i)*32-1 downto 0) <=
           pwr_in(last_column_c(i)*32-1 downto last_column_c(i-1)*32);
        res_shift_reg_s(mux_stage_v).harmonic <= to_unsigned(i, 4);
      end if;
    end loop;

  end if; -- rst_sys_n = '0'
end process filter_p;

----------------------------------------------------------------------------
-- Function: Select the results to use depending on the number of harmonics
--           being processed.
----------------------------------------------------------------------------
result_select_p : process(res_shift_reg_s, h)
begin
  -- Default to ensure combinatorial logic.
  sel_results_s <= ((others => '0'), (others => '0'), (others => '0'), (others => '0'));

  for i in 0 to harmonic_g - 1 loop
    if unsigned(h) = i then
      sel_results_s <= res_shift_reg_s(i*adder_latency_g + extra_delay_c(i));
    end if;
  end loop;
end process result_select_p;


----------------------------------------------------------------------------
-- Function: Store control
--           A RAM is used to provide two pages of a circular buffer.
--           Results from the first stage of filtering are written to one
--           page, whilst the results are read out from the other.
--           When writing in the results the highest harmonic number is
--           recorded. When reading out results, only those matching the
--           highest harmonic number are passed on to the outputs.
--           Because the buffers are circular there is no need to synchronise
--           the address counter to the results, only the page swap must
--           occur at the correct time.
----------------------------------------------------------------------------
store_ctrl_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    acount_s           <= (others => '0');
    wr_page_s          <= '0';
    max_harmonic_in_s  <= (others => '0');
    max_harmonic_out_s <= (others => '0');
    last_result_d1     <= '0';
    last_result_d2     <= '0';
    seed_col_d1        <= (others => '0');
    seed_col_d2        <= (others => '0');
    seed_col_out_s     <= (others => '0');
    read_valid_s       <= '0';
    valid_count_s      <= (others => '0');

  elsif rising_edge(clk_sys) then

    -- Retime last_result input and seed_col.
    last_result_d1 <= last_result; -- In line with sel_results_s.
    last_result_d2 <= last_result_d1;
    seed_col_d1    <= seed_col;
    seed_col_d2    <= seed_col_d1;

    -- Define a free running counter that counts 0 to a.
    acount_s <= acount_s + 1;
    if acount_s(3 downto 0) >= unsigned(a) then
      acount_s <= (others => '0');
    end if;

    -- Define a down counter that marks when valid data can be read.
    if valid_count_s > 0 then
      valid_count_s <= valid_count_s - 1;
    end if;

    -- Swap RAM pages at end of ambiguity slope runs.
    if last_result_d1 = '1' then
      wr_page_s <= not wr_page_s;
    end if;

    -- Record the highest harmonic number.
    if last_result_d2 = '1' or sel_results_s.harmonic > max_harmonic_in_s then
      max_harmonic_in_s <= sel_results_s.harmonic;
    end if;

    -- Transfer highest harmonic and seed col to read side.
    if last_result_d2 = '1' then
      max_harmonic_out_s <= max_harmonic_in_s;
      seed_col_out_s     <= seed_col_d2;
    end if;

    -- Mark read data as valid when a new set of results is ready.
    if last_result_d2 = '1' then
      read_valid_s  <= '1';
      valid_count_s <= unsigned(a);
    elsif valid_count_s = 0 then
      read_valid_s <= '0';
    end if;

    -- Initialise max harmonic values at start of run.
    if clear_results = '1' then
      max_harmonic_in_s     <= (others => '0');
    end if;

  end if;
end process store_ctrl_p;

-- Convert data to be written to RAM into a single vector.
wrddat: wr_data_s <= sel_results_s.pwr & sel_results_s.tc
                   & sel_results_s.row_info & std_logic_vector(sel_results_s.harmonic);

-- Connect addresses.
wradd : wr_addr_s <= wr_page_s & std_logic_vector(acount_s);
rdadd : rd_addr_s <= (not wr_page_s) & std_logic_vector(acount_s);

-- Instantiate RAM.
filtram : hsumfiltram
  generic map (
    data_width_g => ram_data_width_c
  )
  port map (
    -- Write port.
    write_data => wr_data_s,
    write_addr => wr_addr_s,
    write_en   => '1',

    -- Read port.
    read_addr  => rd_addr_s,
    read_en    => '1',
    read_data  => rd_data_s,

    -- Clock and reset.
    clk_sys    => clk_sys,
    rst_sys_n  => rst_sys_n
  );

-- Convert data read from RAM back into a structured form.
rdd1 : rd_results_s.pwr      <= rd_data_s(p_e downto p_s);
rdd2 : rd_results_s.tc       <= rd_data_s(t_e downto t_s);
rdd3 : rd_results_s.row_info <= rd_data_s(r_e downto r_s);
rdd4 : rd_results_s.harmonic <= unsigned(rd_data_s(h_e downto h_s));


----------------------------------------------------------------------------
-- Function: Distribute the results to the appropriate part of the output
--           vectors for the harmonic result retained.
--           If filter is disabled, just pass through the inputs.
----------------------------------------------------------------------------
distribute_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    tc_out       <= (others => '0');
    row_info_out <= (others => '0');
    pwr_out      <= (others => '0');
    seed_col_out <= (others => '0');

  elsif rising_edge(clk_sys) then

    -- Defaults.
    tc_out <= (others => '0');

    -- Retime seed column .
    seed_col_out <= seed_col_out_s;

    -- Distribute data to outputs.
    for i in 0 to harmonic_g-1 loop
      row_info_out(i*7+6 downto i*7) <= rd_results_s.row_info;
      pwr_out(last_column_c(i)*32-1 downto first_res_c(i)*32) <=
        rd_results_s.pwr(cols_per_harmonic_c(i)*32-1 downto 0);

      if read_valid_s = '1' and rd_results_s.harmonic = max_harmonic_out_s and
         i = max_harmonic_out_s then
        tc_out(last_column_c(i)-1 downto first_res_c(i)) <= rd_results_s.tc(cols_per_harmonic_c(i)-1 downto 0);
      end if;
    end loop;

    -- If filter is disabled, just retime inputs to outputs.
    if t_filter_en = '0' then
      tc_out       <= tc_in;
      row_info_out <= row_info_in;
      pwr_out      <= pwr_in;
      seed_col_out <= seed_col;
    end if;

  end if; -- rst_sys_n = '0'
end process distribute_p;

end architecture synth;

