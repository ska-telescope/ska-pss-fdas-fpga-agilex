----------------------------------------------------------------------------
-- Module Name:  hsumddrin
--
-- Source Path:  hsum_lib/hdl/hsumddrin_synth.vhd
--
-- Requirements Covered:
--   FDAS.HARMONIC_SUM:050/A
--   FDAS.HARMONIC_SUM:070/A
--
-- Functional Description:
--
-- Fetches the FOP columns for each harmonic of the specified seed column,
-- as shown below:
--
-- Seed column, n, where n = 0 to 2^22 - 1, contains power for frequency range
-- f, where n*f is the centre frequency of the column.
--
--         |----------+-----------+-----------------|
--         | Harmonic | # of cols | Columns to read |
--         |----------+-----------+-----------------|
--         |   1st    |     1     | seed_col        |
--         |----------+-----------+-----------------|
--         |   2nd    |     3     | 2*seed_col-1    |
--         |          |           | 2*seed_col      |
--         |          |           | 2*seed_col+1    |
--         |----------+-----------+-----------------|
--         |   3rd    |     3     | 3*seed_col-1    |
--         |          |           | 3*seed_col      |
--         |          |           | 3*seed_col+1    |
--         |----------+-----------+-----------------|
--         |   4th    |     5     | 4*seed_col-2    |
--         |          |           | 4*seed_col-1    |
--         |          |           | 4*seed_col      |
--         |          |           | 4*seed_col+1    |
--         |          |           | 4*seed_col+2    |
--         |----------+-----------+-----------------|
--         |   5th    |     5     | 5*seed_col-2    |
--         |          |           | 5*seed_col-1    |
--         |          |           | 5*seed_col      |
--         |          |           | 5*seed_col+1    |
--         |          |           | 5*seed_col+2    |
--         |----------+-----------+-----------------|
--         |   6th    |     7     | 6*seed_col-3    |
--         |          |           | 6*seed_col-2    |
--         |          |           | 6*seed_col-1    |
--         |          |           | 6*seed_col      |
--         |          |           | 6*seed_col+1    |
--         |          |           | 6*seed_col+2    |
--         |          |           | 6*seed_col+3    |
--         |----------+-----------+-----------------|
--         |   7th    |     7     | 7*seed_col-3    |
--         |          |           | 7*seed_col-2    |
--         |          |           | 7*seed_col-1    |
--         |          |           | 7*seed_col      |
--         |          |           | 7*seed_col+1    |
--         |          |           | 7*seed_col+2    |
--         |          |           | 7*seed_col+3    |
--         |----------+-----------+-----------------|
--         |   8th    |     9     | 8*seed_col-4    |
--         |          |           | 8*seed_col-3    |
--         |          |           | 8*seed_col-2    |
--         |          |           | 8*seed_col-1    |
--         |          |           | 8*seed_col      |
--         |          |           | 8*seed_col+1    |
--         |          |           | 8*seed_col+2    |
--         |          |           | 8*seed_col+3    |
--         |          |           | 8*seed_col+4    |
--         |----------+-----------+-----------------|
--              :           :              :
--         |----------+-----------+-----------------|
--         |  16th    |    17     | 16*seed_col-8   |
--         |          |           | 16*seed_col-7   |
--         |          |           | 16*seed_col-6   |
--         |          |           | 16*seed_col-5   |
--         |          |           | 16*seed_col-4   |
--         |          |           | 16*seed_col-3   |
--         |          |           | 16*seed_col-2   |
--         |          |           | 16*seed_col-1   |
--         |          |           | 16*seed_col     |
--         |          |           | 16*seed_col+1   |
--         |          |           | 16*seed_col+2   |
--         |          |           | 16*seed_col+3   |
--         |          |           | 16*seed_col+4   |
--         |          |           | 16*seed_col+5   |
--         |          |           | 16*seed_col+6   |
--         |          |           | 16*seed_col+7   |
--         |          |           | 16*seed_col+8   |
--         |----------+-----------+-----------------|
--
-- In practise, the FOP data does not start at column 0, but has an offset due to
-- the filter shifting in CONV. This is given by the configuration value
-- 'fop_col_offset' and is added to the column number used to generate the DDR read
-- address.
--
-- Each FOP column is stored in a separate RAM, thus 144 RAMs are required
-- for 16 harmonics.
-- The RAMs are wide and shallow because we want to store the column data
-- from the DDR as quickly as possible:
--   32 x 512  for ddr_g = 1 (32 x MLAB)
--   16 x 1024 for ddr_g = 2 (64 x MLAB)
--    8 x 1536 for ddr_g = 3 (96 x MLAB)
--
-- To improve timing margins the output of the RAM is retimed in hsummins,
-- thus giving an effective read latency of 2.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     29/10/18 Initial revision.
-- 0.2  RJH     04/04/19 Changed column stepping (back to original scheme).
--                       Removed redundant signals 'column_s' & 'seed_col_s'.
-- 0.3  RJH     25/04/19 Increased the maximum number of harmonics that can
--                       be processed to 16.
--                       Added a generic to set the maximum number of
--                       harmonics that can be processed.
-- 0.4  RMD     31/01/24 Reset signal now a vector to allow a reset  per instance
--                       to aid timing closure
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

architecture synth of hsumddrin is

-- Define a constant for the maximum number of columns to read depending on the maximum number of harmonics.
constant max_columns_c : natural := last_column_c(harmonic_g - 1);

-- Define types for the RAM read address and enable signals.
type ram_rd_addr_t is array(0 to summer_g-1, 0 to max_columns_c-1) of std_logic_vector(8 downto 0);
type ram_rd_en_t is array(0 to summer_g-1, 0 to max_columns_c-1) of std_logic;

signal column_step_s   : unsigned(21 downto 0); -- Column step when moving to next harmonic.
signal ddr_column_s    : unsigned(21 downto 0); -- Shifted column number: column + fop_col_offset
signal rd_addr_s       : unsigned(30 downto 0); -- Address offset for ddr_column_s column plus read_count_s.
signal col_count_s     : unsigned(7 downto 0); -- Counts 1 to 40 columns to fetch.
signal last_column_s   : unsigned(7 downto 0); -- Last column to read, defined by h_1 or h_2.
signal ddr_read_s      : std_logic; -- Read request enable.
signal reading_s       : std_logic; -- Indicates read request generation is active.
signal read_count_s    : unsigned(3-ddr_g downto 0); -- Counts reads per column.
signal num_reads_s     : unsigned(3-ddr_g downto 0); -- Number of reads required per column minus 1.
signal store_addr_s    : std_logic_vector(5-ddr_g downto 0); -- RAM write address.
signal store_data_s    : std_logic_vector(512*ddr_g-1 downto 0); -- RAM write data.
signal wren_s          : std_logic_vector(max_columns_c-1 downto 0); -- RAM write enables.
signal ram_select_s    : std_logic_vector(max_columns_c-1 downto 0); -- RAM selects.
signal write_count_s   : unsigned(3-ddr_g downto 0); -- Counts writes per column.
signal ddrin_wr_page_s : unsigned(1 downto 0); -- Page of RAM to write data to.
signal last_ram_s      : std_logic; -- ram_select_s bit for the last RAM to be written.
signal ram_rd_addr_s   : ram_rd_addr_t; -- hpsel expanded to one element per RAM.
signal ram_rd_en_s     : ram_rd_en_t; -- hpsel_en expanded to one element per RAM.

-- RAM component.
-- Note: Read latency is 2.
component hsumddrinram is
  generic (
    ddr_g  : natural range 1 to 3
  );
  port (
    -- Write port.
    write_data : in  std_logic_vector(512*ddr_g - 1 downto 0);
    write_addr : in  std_logic_vector(5-ddr_g downto 0);
    write_en   : in  std_logic;

    -- Read port.
    read_addr  : in  std_logic_vector(8 downto 0);
    read_en    : in  std_logic;
    read_data  : out std_logic_vector(31 downto 0);

    -- Clock and reset.
    clk_sys    : in  std_logic;
    rst_sys_n  : in  std_logic
  );
end component hsumddrinram;

begin

----------------------------------------------------------------------------
-- Function:  Determine the DDR address offset for a column and add in the
--            read_count_s offset. This depends on the generic ddr_g.
----------------------------------------------------------------------------
gen_rd_addr_p :
  rd_addr_s <= ddr_column_s & read_count_s & "000000" when ddr_g = 1 else
               "0" & ddr_column_s & read_count_s & "000000" when ddr_g = 2 else
               "00" & ddr_column_s & read_count_s & "000000";

----------------------------------------------------------------------------
-- Function:  Determine how many columns need to be read according to the
--            number of harmonics being processed.
----------------------------------------------------------------------------
gen_last_col_p : process(rst_sys_n(0), clk_sys)
begin
  if (rst_sys_n(0) = '0') then
    -- Initialise.
    last_column_s <= (others => '0');
  elsif rising_edge(clk_sys) then
    last_column_s <= to_unsigned(last_column_c(to_integer(unsigned(h))), last_column_s'length);
  end if;
end process gen_last_col_p;

----------------------------------------------------------------------------
-- Function:  Determine how many DDR reads are required for each column
--            according to the number of FOP rows.
----------------------------------------------------------------------------
g1 : if ddr_g = 1 generate
  gen_num_reads_p : process(rst_sys_n(0), clk_sys)
  begin
    if (rst_sys_n(0) = '0') then
      -- Initialise.
      num_reads_s <= (others => '0');
    elsif rising_edge(clk_sys) then
      if (unsigned(fop_row) < 16) then
        num_reads_s <= "000";
      elsif (unsigned(fop_row) < 30) then
        num_reads_s <= "001";
      elsif (unsigned(fop_row) < 44) then
        num_reads_s <= "010";
      elsif (unsigned(fop_row) < 58) then
        num_reads_s <= "011";
      elsif (unsigned(fop_row) < 70) then
        num_reads_s <= "100";
      else
        num_reads_s <= "101";
      end if;
    end if;
  end process gen_num_reads_p;
end generate g1;

g2 : if ddr_g = 2 generate
  gen_num_reads_p : process(rst_sys_n(0), clk_sys)
  begin
    if (rst_sys_n(0) = '0') then
      -- Initialise.
      num_reads_s <= (others => '0');
    elsif rising_edge(clk_sys) then
      if (unsigned(fop_row) < 30) then
        num_reads_s <= "00";
      elsif (unsigned(fop_row) < 58) then
        num_reads_s <= "01";
      else
        num_reads_s <= "10";
      end if;
    end if;
  end process gen_num_reads_p;
end generate g2;

g3 : if ddr_g = 3 generate
  gen_num_reads_p : process(rst_sys_n(0), clk_sys)
  begin
    if (rst_sys_n(0) = '0') then
      -- Initialise.
      num_reads_s <= (others => '0');
    elsif rising_edge(clk_sys) then
      if (unsigned(fop_row) < 44) then
        num_reads_s <= "0";
      else
        num_reads_s <= "1";
      end if;
    end if;
  end process gen_num_reads_p;
end generate g3;

----------------------------------------------------------------------------
-- Function:  Generate the read requests to the DDR interface.
----------------------------------------------------------------------------
gen_read_req_p : process(rst_sys_n(0), clk_sys)
begin
  if (rst_sys_n(0) = '0') then
    -- Initialise.
    column_step_s  <= (others => '0');
    ddr_column_s   <= (others => '0');
    col_count_s    <= (others => '0');
    read_count_s   <= (others => '0');
    reading_s      <= '0';
    ddr_read_s     <= '0';
    ddr_addr       <= (others => '0');
    done_req       <= '0';

  elsif rising_edge(clk_sys) then

    -- Defaults.
    done_req <= '0';

    if new_col = '1' then
      -- Fetch a new set of columns.
      ddr_column_s   <= unsigned(seed_col) + unsigned(fop_col_offset);
      column_step_s  <= unsigned(seed_col) - 1;
      col_count_s    <= to_unsigned(1, col_count_s'length);
      read_count_s   <= (others => '0');
      reading_s      <= '1';
    end if;


    if ddr_read_s = '0' or wait_request = '0' then

      if reading_s = '1' then
        -- Increment read counter.
        read_count_s <= read_count_s + 1;
        if read_count_s = num_reads_s then
          -- Move on to next column.
          read_count_s <= (others => '0');
          -- Increment column count.
          col_count_s <= col_count_s + 1;
          if (col_count_s = last_column_s) then
            -- Last column.
            col_count_s <= (others => '0');
            reading_s   <= '0';
            done_req    <= '1';
          end if;
          -- Update column number.
          ddr_column_s <= ddr_column_s + 1;
          -- Check for jump to the next harmonic.
          for i in 0 to harmonic_g-1 loop
            if col_count_s = last_column_c(i) then
              ddr_column_s  <= ddr_column_s + column_step_s;
              column_step_s <= column_step_s - 1;
            end if;
          end loop;
        end if; -- read_count_s = reads_per_col_c - 1

      end if; -- reading = '1'

      -- Output request.
      ddr_read_s <= reading_s;
      ddr_addr   <= std_logic_vector(unsigned(hsum_page) + rd_addr_s);

    end if; -- ddr_read_s = '0' or waitrequest = '0'

  end if;
end process gen_read_req_p;

-- Connect read request output.
con1 : ddr_read <= ddr_read_s;


----------------------------------------------------------------------------
-- Function:  Write the data received back from DDR into the RAMs which are
--            accessed by SUMMER sub-module.
----------------------------------------------------------------------------
store_data_p : process(rst_sys_n(0), clk_sys)
begin
  if rst_sys_n(0) = '0' then
    -- Initialise.
    store_addr_s    <= (others => '0');
    store_data_s    <= (others => '0');
    wren_s          <= (others => '0');
    ram_select_s    <= (others => '0');
    write_count_s   <= (others => '0');
    done_read       <= '0';
    ddrin_wr_page_s <= "00";

  elsif rising_edge(clk_sys) then

    if triggered = '1' then
      -- Prepare for a new set of data.
      write_count_s   <= (others => '0');
      ram_select_s    <= (others => '0');
      ram_select_s(0) <= '1';
      ddrin_wr_page_s <= "00";
    end if;

    -- Make write enables and done only a single cycle wide.
    wren_s    <= (others => '0');
    done_read <= '0';

    if data_valid = '1' then
      -- Update read counter.
      write_count_s <= write_count_s + 1;
      if write_count_s = num_reads_s then
        write_count_s <= (others => '0');
        -- Move on to next RAM.
        ram_select_s <= ram_select_s(ram_select_s'left-1 downto 0) & '0';
        if last_ram_s = '1' then
          done_read       <= '1';
          ram_select_s    <= (others => '0');
          ram_select_s(0) <= '1';
          ddrin_wr_page_s <= ddrin_wr_page_s + 1;
        end if;
      end if;

      -- Write to RAM.
      store_addr_s <= std_logic_vector(unsigned'(ddrin_wr_page_s & write_count_s));
      store_data_s <= ddr_data;
      wren_s       <= ram_select_s;

    end if; -- data_valid = '1'

  end if;
end process store_data_p;

----------------------------------------------------------------------------
-- Function:  Select the ram_select_s bit for the last RAM to be written
--            for the number of harmonics being processed.
----------------------------------------------------------------------------
sel_last_ram_p : process(h, ram_select_s)
begin
  last_ram_s <= '0';
  for i in 0 to harmonic_g-1 loop
    if unsigned(h) = i then
      last_ram_s <= ram_select_s(last_column_c(i)-1);
    end if;
  end loop;
end process sel_last_ram_p;

----------------------------------------------------------------------------
-- Function:  Split up hpsel and hpsel_en in to separate read addresses and
--            enables for each RAM for ease of wiring up in the generate
--            statement below.
----------------------------------------------------------------------------
gen_ram_rd_1 : for s in 0 to summer_g-1 generate
  gen_ram_rd_2 : for r in 0 to max_columns_c-1 generate
    ram_rd_addr_s(s,r) <= ddrin_rd_page & 
                          hpsel((s*harmonic_g+ram_harmonic_c(r+1))*7+6 downto
                                (s*harmonic_g+ram_harmonic_c(r+1))*7+0);
    ram_rd_en_s(s,r)   <= hpsel_en(s*harmonic_g + ram_harmonic_c(r+1));
  end generate gen_ram_rd_2;
end generate gen_ram_rd_1;


----------------------------------------------------------------------------
-- Generate the RAMs. One set for each SUMMMER.
-- Note: Read latency is 2.
----------------------------------------------------------------------------
gen_sum_ram : for s in 0 to summer_g-1 generate
  gen_ram_inst : for r in 0 to max_columns_c-1 generate

    ram_i : hsumddrinram
      generic map (
        ddr_g  => ddr_g
      )
      port map (
        -- Write port.
        write_data => store_data_s,
        write_addr => store_addr_s,
        write_en   => wren_s(r),

        -- Read port.
        read_addr  => ram_rd_addr_s(s,r),
        read_en    => ram_rd_en_s(s,r),
        read_data  => data_sum(s*last_column_c(harmonic_g-1)*32+r*32+31 downto
                               s*last_column_c(harmonic_g-1)*32+r*32),

        -- Clock and reset.
        clk_sys    => clk_sys,
        rst_sys_n  => rst_sys_n(s)
      );

  end generate gen_ram_inst;
end generate gen_sum_ram;

end architecture synth;
