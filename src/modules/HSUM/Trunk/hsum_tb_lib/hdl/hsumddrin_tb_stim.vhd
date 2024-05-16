----------------------------------------------------------------------------
-- Module Name:  hsumddrin_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumddrin_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumddrin sub-module.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     23/05/19 Updated for increase to 16 harmonics.
-- 0.3  RMD     02/02/24 reset signal now a vector 
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2014 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use ieee.math_real.uniform;
use std.textio.all;
library hsum_lib;
use hsum_lib.hsum_pkg.all;

architecture stim of hsumddrin_tb is

constant clk_per_c : time := 5 ns;
-- Define a lookup table for the last column no for each harmonic.
constant last_col_c : natural_array_t(1 to 16) := last_column_c;
-- Define a lookup for the DDR address multiplier, depending on no of DDR interfaces.
constant ddr_addr_mult_c : natural_array_t(1 to 3) := (512, 256, 128);

component hsumddrin is
  generic (
    summer_g   : natural range 1 to 3;
    ddr_g      : natural range 1 to 3;
    harmonic_g : natural range 8 to 16 -- Max number of harmonics that
                                        -- may be processed (including fundamental).
  );
  port (
    -- Control and configuration inputs.
    hsum_page     : in  std_logic_vector(31 downto 0); -- Offset of data in DDR memory.
    new_col       : in  std_logic;                     -- Trigger to start reading new set of column data.
    seed_col      : in  std_logic_vector(21 downto 0); -- First column of a set to read.
    h             : in  std_logic_vector (3 downto 0); -- Number of harmonics to process.
    fop_row       : in  std_logic_vector (6 downto 0); -- Number of FOP rows to read.
    fop_col_offset: in  std_logic_vector(8 downto 0);  -- First actual column of FOP.
    triggered     : in  std_logic;                     -- Initialises write address at start of new run.
    ddrin_rd_page : in  std_logic_vector(1 downto 0);  -- RAM page to use when SUMMER is reading FOP data.

    -- Data select from SUMMER.
    hpsel          : in     std_logic_vector (summer_g*harmonic_g*7-1 downto 0);
    hpsel_en       : in     std_logic_vector (summer_g*harmonic_g-1 downto 0);

    -- Control & Data from DDR interface.
    ddr_data      : in  std_logic_vector(ddr_g*512-1 downto 0);
    data_valid    : in  std_logic;
    wait_request  : in  std_logic;

    -- Read request to DDR interface.
    ddr_addr      : out std_logic_vector(31 downto 0);
    ddr_read      : out std_logic;

    -- Data to SUMMER.
    data_sum       : out    std_logic_vector (summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);

    -- Control response to TGEN.
    done_req      : out std_logic;
    done_read     : out std_logic;

    -- Clock and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic_vector (0 to summer_g-1)
  );
end component hsumddrin;

-- Control and configuation inputs.
signal hsum_page : std_logic_vector(31 downto 0); -- Offset of data in DDR memory.
signal new_col : std_logic; -- Trigger to start reading new set of column data.
signal seed_col : std_logic_vector(21 downto 0); -- First column of a set to read.
signal h : std_logic_vector(3 downto 0); -- Number of harmonics to process.
signal fop_row : std_logic_vector(6 downto 0); -- Number of FOP rows to read.
signal fop_col_offset : std_logic_vector(8 downto 0); -- First actual column of FOP data.
signal triggered : std_logic; -- Initialises write address at start of new run.
signal ddrin_rd_page : unsigned(1 downto 0); -- RAM page to use when SUMMER is reading FOP data.

-- Data select from SUMMER.
signal hpsel : std_logic_vector(summer_g*harmonic_g*7-1 downto 0);
signal hpsel_en : std_logic_vector(summer_g*harmonic_g-1 downto 0);

-- Control & Data from DDR interface.
signal ddr_data : std_logic_vector(ddr_g*512-1 downto 0) := (others => '0');
signal data_valid : std_logic := '0';
signal wait_request : std_logic;

-- Read request to DDR interface.
signal ddr_addr : std_logic_vector(31 downto 0);
signal ddr_read : std_logic;

-- Data to SUMMER.
signal data_sum : std_logic_vector(summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);

-- Control response to TGEN.
signal done_req  : std_logic;
signal done_read : std_logic;

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic_vector (0 to summer_g-1);

-- Testbench signals.
constant max_reads_per_col_c : natural := 6;
type addr_list_t is array(1 to last_column_c(harmonic_g-1)*max_reads_per_col_c) of natural;
signal addr_list_s : addr_list_t;
signal num_of_addresses_s : natural range 1 to last_column_c(harmonic_g-1)*max_reads_per_col_c;
type summer_data_t is array(0 to last_column_c(harmonic_g-1)-1, 0 to 85/2) of integer;
signal summer_data_s : summer_data_t;
signal last_harmonic_s : natural;
signal fop_rows_s : natural range 1 to 85;

shared variable testbench_passed : boolean := true;

----------------------------------------------------------------------------
-- Procedure to output a message.
----------------------------------------------------------------------------
procedure puts(msg : string; header : boolean := false) is
  variable l : line;
begin
  if header then
    writeline(output,l);
    write(l, string'("--------------------------------------------------------------------------------"));
    writeline(output,l);
  else
    write(l, now, right, 12, ns);
    write(l, ' ');
  end if;
  write(l, msg);
  writeline(output, l);
  if header then
    write(l, string'("--------------------------------------------------------------------------------"));
    writeline(output,l);
  end if;
end procedure puts;

----------------------------------------------------------------------------
-- Generic check procedure.
----------------------------------------------------------------------------
procedure check(test : boolean;
                msg  : string) is
begin
  if not test then
    testbench_passed := false;
    report msg severity error;
  end if;
end procedure check;

begin

dut : hsumddrin
  generic map (
    summer_g   => summer_g,
    ddr_g      => ddr_g,
    harmonic_g => harmonic_g
  )
  port map (
    -- Control and configuation inputs.
    hsum_page     => hsum_page,
    new_col       => new_col,
    seed_col      => seed_col,
    h             => h,
    fop_row       => fop_row,
    fop_col_offset=> fop_col_offset,
    triggered     => triggered,
    ddrin_rd_page => std_logic_vector(ddrin_rd_page),

    -- Data select from SUMMER.
    hpsel         => hpsel,
    hpsel_en      => hpsel_en,

    -- Control & Data from DDR interface.
    ddr_data      => ddr_data,
    data_valid    => data_valid,
    wait_request  => wait_request,

    -- Read request to DDR interface.
    ddr_addr      => ddr_addr,
    ddr_read      => ddr_read,

    -- Data to SUMMER.
    data_sum      => data_sum,

    -- Control response to TGEN.
    done_req      => done_req,
    done_read     => done_read,

    -- Clock and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n
  );

----------------------------------------------------------------------------
-- Function:  Clock generator.
----------------------------------------------------------------------------
clk_gen_p : process
begin
  clk_sys <= '0', '1' after clk_per_c/2;
  wait for clk_per_c;
end process clk_gen_p;

----------------------------------------------------------------------------
-- Function:  Checks the read addresses generated by DDRIN.
----------------------------------------------------------------------------
check_rd_addr_p : process
  variable expected_address_v : unsigned(31 downto 0);
  variable l : line;
begin
  -- Wait for trigger.
  wait until rising_edge(new_col);
  wait until rising_edge(clk_sys);

  puts("Checking read addresses ...");
  for i in 1 to num_of_addresses_s loop
    expected_address_v := unsigned(hsum_page) + to_unsigned(addr_list_s(i),32);
    while (ddr_read = '0' or wait_request = '1') loop
      wait until rising_edge(clk_sys);
    end loop;
    if (expected_address_v /= unsigned(ddr_addr)) then
      write(l, now, right, 12, ns);
      write(l, string'(" ERROR: Incorrect read address "));
      write(l, i);
      write(l, string'(": expected "));
      hwrite(l, std_logic_vector(expected_address_v));
      write(l, string'(", got "));
      hwrite(l, ddr_addr);
      writeline(OUTPUT,l);
      testbench_passed := false;
      report "" severity error;
    end if;
    wait for clk_per_c;
  end loop;
  puts("  checked " & integer'image(num_of_addresses_s) & " addresses.");
end process check_rd_addr_p;

----------------------------------------------------------------------------
-- Function:  Simulate wait requests from DDR.
----------------------------------------------------------------------------
gen_wait_request_p : process
  variable seed1_v, seed2_v : positive;
  variable rand_v : real;
begin
  wait_request <= '0';
  loop
    wait for clk_per_c;
    uniform(seed1_v, seed2_v, rand_v);
    if (rand_v < 0.5) then
      wait_request <= '0';
    else
      wait_request <= '1';
    end if;
  end loop;
end process gen_wait_request_p;


----------------------------------------------------------------------------
-- Function:  Generate the read data from DDR.
----------------------------------------------------------------------------
gen_ddr_data_p : process
  variable fop_row_v  : natural := 0;
  variable data_v     : integer := 1;
  variable first_v    : boolean := true;
  variable col_count_v: natural := 0;
begin
  wait until rising_edge(clk_sys);

  if (ddr_read = '1' and wait_request = '0') then
    -- Send in a word of data.
    ddr_data <= (others => '0');
    outer : for ddr in 0 to ddr_g-1 loop
      if first_v then
        ddr_data(31 downto 0)  <= std_logic_vector(to_unsigned(data_v,32));
        ddr_data(63 downto 32) <= std_logic_vector(to_unsigned(data_v,32));
        summer_data_s(col_count_v, fop_row_v) <= data_v;
        fop_row_v := fop_row_v + 1;
        data_v := data_v + 1;
        first_v := false;
      end if;
      if fop_rows_s = 1 then
        first_v := true;
        fop_row_v := 0;
        col_count_v := col_count_v + 1;
        if col_count_v >= last_col_c(last_harmonic_s) then
          col_count_v := 0;
        end if;
        exit;
      end if;
      for i in 1 to 7 loop
        ddr_data(ddr*512+i*64+63 downto ddr*512+i*64) <=
          std_logic_vector(to_signed(-1*data_v,32))
          & std_logic_vector(to_unsigned(data_v,32));
        summer_data_s(col_count_v, fop_row_v) <= data_v;
        fop_row_v := fop_row_v + 1;
        data_v := data_v + 1;
        if fop_row_v*2 > fop_rows_s then
          first_v := true;
          fop_row_v := 0;
          col_count_v := col_count_v + 1;
          if col_count_v >= last_col_c(last_harmonic_s) then
            col_count_v := 0;
          end if;
          exit outer;
        end if;
      end loop;
    end loop;
    data_valid <= '1';
  else
    data_valid <= '0';
  end if;
end process gen_ddr_data_p;


----------------------------------------------------------------------------
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process

  -- Procedure to trigger DDRIN.
  -- It also calculates the expected read addresses.
  procedure start_read(seed      : natural range 0 to 4194303;
                       harmonics : natural range 1 to 16 := harmonic_g;
                       fop_rows  : natural range 1 to 85 := 85) is
    variable reads_per_col_v : natural range 1 to 6 := 1;
    variable fop_rows_v : integer := fop_rows;
    variable addr_count_v : natural := 0;
  begin
    -- Calculate read addresses.
    -- First determine the number of reads per column.
    puts("Starting read: seed = " & integer'image(seed) &
         ", harmonics = " & integer'image(harmonics), true);
    fop_rows_v := fop_rows_v - 15 - 14*(ddr_g - 1);
    while (fop_rows_v > 0) loop
      reads_per_col_v := reads_per_col_v + 1;
      fop_rows_v := fop_rows_v - 14*ddr_g;
    end loop;
    for h in 0 to harmonics-1 loop
      for o in -cols_per_harmonic_c(h)/2 to cols_per_harmonic_c(h)/2 loop
        for r in 0 to reads_per_col_v-1 loop
          addr_count_v := addr_count_v + 1;
          addr_list_s(addr_count_v) <=
           (seed*(h+1)+o + to_integer(unsigned(fop_col_offset)))*ddr_addr_mult_c(ddr_g) + r*64;
        end loop;
      end loop;
    end loop;
    num_of_addresses_s <= addr_count_v;

    -- Trigger DDRIN.
    h <= std_logic_vector(to_unsigned(harmonics-1,4));
    fop_row <= std_logic_vector(to_unsigned(fop_rows,7));
    fop_rows_s <= fop_rows;
    last_harmonic_s <= harmonics;
    wait for clk_per_c;
    new_col <= '1', '0' after clk_per_c;
    seed_col <= std_logic_vector(to_unsigned(seed,22));
    wait for clk_per_c;
  end procedure start_read;

  -- Procedure to read back data from the RAMs.
  procedure check_hsel(harmonics : natural range 1 to 16 := harmonic_g) is
    variable addr_v : natural;
    variable data_v : integer;
  begin
    for summer in 0 to summer_g-1 loop
      puts("Checking data for summer " & integer'image(summer) & " ...");
      for ram in 0 to last_col_c(harmonics)-1 loop
        puts("  reading ram " & integer'image(ram) & " ...");
        addr_v := 0;
        for row in 0 to fop_rows_s/2 loop
          for a in 0 to 1 loop
            hpsel <= (others => '0');
            hpsel_en <= (others => '0');
            hpsel((summer*harmonic_g + ram_harmonic_c(ram+1))*7+6 downto
                  (summer*harmonic_g + ram_harmonic_c(ram+1))*7) <= std_logic_vector(to_unsigned(addr_v,7));
            hpsel_en(summer*harmonic_g+ram_harmonic_c(ram+1)) <= '1';
            wait for clk_per_c;
            hpsel_en <= (others => '0');
            data_v := to_integer(signed(data_sum(summer*last_column_c(harmonic_g-1)*32+ram*32+31 downto
                                                 summer*last_column_c(harmonic_g-1)*32+ram*32)));
            if row = 0 or a = 0 then
              check(data_v = summer_data_s(ram, row),
                "Data mismatch (summer="&natural'image(summer)&",ram="&natural'image(ram)&",row="&natural'image(row)&
                "): expected "&integer'image(summer_data_s(ram, row))&", got "&
                integer'image(data_v));
            else
              check(data_v = -summer_data_s(ram, row),
                "Data mismatch (summer="&natural'image(summer)&",ram="&natural'image(ram)&",row="&natural'image(row)&
                "): expected "&integer'image(-summer_data_s(ram, row))&", got "&
                integer'image(data_v));
            end if;
            addr_v := addr_v + 1;
          end loop;
          if addr_v mod 16 = 0 then
            addr_v := addr_v + 2;
          end if;
        end loop;
      end loop;
    end loop;
    puts("  read done.");
  end procedure check_hsel;

  variable fop_rows_v : natural range 1 to 85;

begin
  -- Initialise input.
  hsum_page      <= (others => '0');
  new_col        <= '0';
  seed_col       <= (others => '0');
  h              <= (others => '0');
  ddrin_rd_page  <= "00";
  rst_sys_n      <= (others => '0');
  hpsel          <= (others => '0');
  hpsel_en       <= (others => '0');
  fop_col_offset <= (others => '0');
  triggered      <= '0';

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n <= (others => '1');

  for i in 1 to 3 loop
    triggered <= '1', '0' after clk_per_c;
    ddrin_rd_page <= "00";
    wait for clk_per_c;
    case i is
      when 1 =>
        fop_rows_v := 1;
      when 2 =>
        fop_rows_v := ddr_g*5;
        fop_col_offset <= std_logic_vector(to_unsigned(210, fop_col_offset'length));
      when 3 =>
        fop_rows_v := 85;
        fop_col_offset <= std_logic_vector(to_unsigned(510, fop_col_offset'length));
    end case;
    puts("FOP rows = " & natural'image(fop_rows_v), header => true);

    fop_row   <= (others => '0');
    hsum_page <= (others => '0');
    wait for clk_per_c;

    start_read(seed => 1, fop_rows => fop_rows_v);
    wait until falling_edge(done_read);
    wait until falling_edge(clk_sys);
    check_hsel;

    start_read(seed => 1234, fop_rows => fop_rows_v);
    wait until falling_edge(done_read);
    wait until falling_edge(clk_sys);
    ddrin_rd_page <= ddrin_rd_page + 1;
    check_hsel;

    hsum_page <= X"1CE84391";

    start_read(seed => 97, harmonics => 4, fop_rows => fop_rows_v);
    wait until falling_edge(done_read);
    wait until falling_edge(clk_sys);
    ddrin_rd_page <= ddrin_rd_page + 1;
    check_hsel(4);

    start_read(seed => 123456, harmonics => 7, fop_rows => fop_rows_v);
    wait until falling_edge(done_read);
    wait until falling_edge(clk_sys);
    ddrin_rd_page <= ddrin_rd_page + 1;
    check_hsel(7);

  end loop;

  puts("");
  if testbench_passed then
    puts("*** PASSED ***");
  else
    puts("!!! FAILED !!!");
  end if;

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

