----------------------------------------------------------------------------
-- Module Name:  hsum_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsum_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsum module.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     23/05/19 Updated for increase to 16 harmonics.
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
library hsum_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use ieee.math_real.all;
use std.textio.all;
use hsum_lib.hsum_pkg.all;

architecture stim of hsum_tb is

constant clk_per_c : time := 5 ns;
constant max_results_c : natural := 25;

-- Mapping of row number to DDR address LSBs and word position.
type ddr_pos_t is record
  rowi : natural;
  word : natural;
end record ddr_pos_t;
type ddr_map_t is array(1 to 3, -42 to 42) of ddr_pos_t;
constant ddr_map_c : ddr_map_t := (
 -- ddr_g = 1
 ( (5,15), (5,13), (5,11), (5,9), (5,7), (5,5), (5,3), -- -42 to -36
   (4,15), (4,13), (4,11), (4,9), (4,7), (4,5), (4,3), -- -35 to -29
   (3,15), (3,13), (3,11), (3,9), (3,7), (3,5), (3,3), -- -28 to -22
   (2,15), (2,13), (2,11), (2,9), (2,7), (2,5), (2,3), -- -21 to -15
   (1,15), (1,13), (1,11), (1,9), (1,7), (1,5), (1,3), -- -14 to -8
   (0,15), (0,13), (0,11), (0,9), (0,7), (0,5), (0,3), (0,0), -- -7 to 0
   (0,2), (0,4), (0,6), (0,8), (0,10), (0,12), (0,14), -- 1 to 7
   (1,2), (1,4), (1,6), (1,8), (1,10), (1,12), (1,14), -- 8 to 14
   (2,2), (2,4), (2,6), (2,8), (2,10), (2,12), (2,14), -- 15 to 21
   (3,2), (3,4), (3,6), (3,8), (3,10), (3,12), (3,14), -- 22 to 28
   (4,2), (4,4), (4,6), (4,8), (4,10), (4,12), (4,14), -- 29 to 35
   (5,2), (5,4), (5,6), (5,8), (5,10), (5,12), (5,14)  -- 36 to 42
  ),
 -- ddr_g = 2
 ( (2,31), (2,29), (2,27), (2,25), (2,23), (2,21), (2,19), -- -42 to -36
   (2,15), (2,13), (2,11), (2,9),  (2,7),  (2,5),  (2,3),  -- -35 to -29
   (1,31), (1,29), (1,27), (1,25), (1,23), (1,21), (1,19), -- -28 to -22
   (1,15), (1,13), (1,11), (1,9),  (1,7),  (1,5),  (1,3),  -- -21 to -15
   (0,31), (0,29), (0,27), (0,25), (0,23), (0,21), (0,19), -- -14 to -8
   (0,15), (0,13), (0,11), (0,9),  (0,7),  (0,5),  (0,3), (0,0), -- -7 to 0
   (0,2),  (0,4),  (0,6),  (0,8),  (0,10), (0,12), (0,14), -- 1 to 7
   (0,18), (0,20), (0,22), (0,24), (0,26), (0,28), (0,30), -- 8 to 14
   (1,2),  (1,4),  (1,6),  (1,8),  (1,10), (1,12), (1,14), -- 15 to 21
   (1,18), (1,20), (1,22), (1,24), (1,26), (1,28), (1,30), -- 22 to 28
   (2,2),  (2,4),  (2,6),  (2,8),  (2,10), (2,12), (2,14), -- 29 to 35
   (2,18), (2,20), (2,22), (2,24), (2,26), (2,28), (2,30)  -- 36 to 42
  ),
 -- ddr_g = 3
 ( (1,47), (1,45), (1,43), (1,41), (1,39), (1,37), (1,35), -- -42 to -36
   (1,31), (1,29), (1,27), (1,25), (1,23), (1,21), (1,19), -- -35 to -29
   (1,15), (1,13), (1,11), (1,9),  (1,7),  (1,5),  (1,3),  -- -28 to -22
   (0,47), (0,45), (0,43), (0,41), (0,39), (0,37), (0,35), -- -21 to -15
   (0,31), (0,29), (0,27), (0,25), (0,23), (0,21), (0,19), -- -14 to -8
   (0,15), (0,13), (0,11), (0,9),  (0,7),  (0,5),  (0,3), (0,0), -- -7 to 0
   (0,2),  (0,4),  (0,6),  (0,8),  (0,10), (0,12), (0,14), -- 1 to 7
   (0,18), (0,20), (0,22), (0,24), (0,26), (0,28), (0,30), -- 8 to 14
   (0,34), (0,36), (0,38), (0,40), (0,42), (0,44), (0,46), -- 15 to 21
   (1,2),  (1,4),  (1,6),  (1,8),  (1,10), (1,12), (1,14), -- 22 to 28
   (1,18), (1,20), (1,22), (1,24), (1,26), (1,28), (1,30), -- 29 to 35
   (1,34), (1,36), (1,38), (1,40), (1,42), (1,44), (1,46)  -- 36 to 42
  )
);

-- Mapping of row number to HPSEL config value.
type hpsel_map_t is array(-42 to 42) of natural;
constant hpsel_map_c : hpsel_map_t := (
  95, 93, 91, 89, 87, 85, 83, -- -42 to -34
  79, 77, 75, 73, 71, 69, 67, -- -35 to -29
  63, 61, 59, 57, 55, 53, 51, -- -28 to -22
  47, 45, 43, 41, 39, 37, 35, -- -21 to -15
  31, 29, 27, 25, 23, 22, 21, -- -14 to -8
  15, 13, 11, 9,  7,  5,  3,  -- -7 to -1
  0, 2, 4, 6, 8, 10, 12, 14,  -- 0 to 7
  18, 20, 22, 24, 26, 28, 30, -- 8 to 14
  34, 36, 38, 40, 42, 44, 46, -- 15 to 21
  50, 52, 54, 56, 58, 60, 62, -- 22 to 28
  66, 68, 70, 72, 74, 76, 78, -- 29 to 35
  82, 84, 86, 88, 90, 92, 94  -- 36 to 42
  );

component hsum is
  generic (
    ddr_g           : natural range 1 to 3;  -- Number of DDR interfaces.
    summer_g        : natural range 1 to 3;  -- Number of SUMMER sub-blocks to instantiate.
    adder_latency_g : natural range 1 to 7;  -- Latency of IEEE-754 adder function.
    harmonic_g      : natural range 8 to 16  -- Max number of harmonics that may be processed.
  );
  port (
    -- Control inputs.
    hsum_page    : in  std_logic_vector(31 downto 0); -- Offset for DDR address.
    hsum_trigger : in  std_logic; -- Triggers analysis run(s).
    hsum_enable  : in  std_logic; -- Qualifies hsum_trigger and can also pause analysis run.

    -- Control outputs.
    hsum_done    : out std_logic;

    -- DDR Interface.
    wait_request : in  std_logic;
    data_valid   : in  std_logic;
    ddr_data     : in  std_logic_vector(512*ddr_g-1 downto 0);
    ddr_addr     : out std_logic_vector(31 downto 0);
    ddr_read     : out std_logic;

    -- Micro interface (Covnetics standard interface).
    mcaddr       : in  std_logic_vector(17 downto 0);
    mcdatain     : in  std_logic_vector(31 downto 0);
    mcrwn        : in  std_logic;
    mcms         : in  std_logic;
    mcdataout    : out std_logic_vector(31 downto 0);

    -- Clock and reset.
    clk_sys      : in  std_logic;
    rst_sys_n    : in  std_logic;
    clk_mc       : in  std_logic;
    rst_mc_n     : in  std_logic
  );
end component hsum;


-- Control inputs.
signal hsum_page : std_logic_vector(31 downto 0); -- Offset for DDR address.
signal hsum_trigger : std_logic; -- Triggers analysis run(s).
signal hsum_enable : std_logic; -- Qualifies hsum_trigger and can also pause analysis run.

-- Control outputs.
signal hsum_done : std_logic;

-- DDR Interface.
signal wait_request : std_logic;
signal data_valid : std_logic;
signal ddr_data : std_logic_vector(512*ddr_g-1 downto 0);
signal ddr_addr : std_logic_vector(31 downto 0);
signal ddr_read : std_logic;

-- Micro interface (Covnetics standard interface).
signal mcaddr : std_logic_vector(17 downto 0);
signal mcdatain : std_logic_vector(31 downto 0);
signal mcrwn : std_logic;
signal mcms : std_logic;
signal mcdataout : std_logic_vector(31 downto 0);

    -- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;
signal clk_mc : std_logic;
signal rst_mc_n : std_logic;

-- Testbench signals.
type threshold_t is array(1 to 8) of std_logic_vector(31 downto 0);
signal threshold_s : threshold_t;
shared variable testbench_passed : boolean := true;
type addr_list_t is array(1 to 40*6) of natural;
signal addr_list_s : addr_list_t;
signal num_of_addresses_s : natural range 1 to 40*60;
type ddr_addr_mult_t is array(1 to 3) of natural;
constant ddr_addr_mult_c : ddr_addr_mult_t := (512, 256, 128);
type summer_data_t is array(0 to 39, 0 to 85/2) of integer;
signal summer_data_s : summer_data_t;
signal last_harmonic_s : natural;
signal fop_rows_s : natural range 1 to 85;
type result_t is record
  pwr : natural;
  col : natural;
  row : natural;
  valid : std_logic;
end record result_t;
type results_t is array(0 to 7, 0 to max_results_c-1) of result_t;
type excess_t is record
  t : natural;
  p : natural;
  s : natural;
end record excess_t;
type exc_t is array(0 to 7) of excess_t;

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

----------------------------------------------------------------------------
-- Less generic check procedure.
----------------------------------------------------------------------------
procedure check(n   : natural;
                i   : integer;
                msg : string) is
begin
  check(n = i, msg & ", expected " & natural'image(n) & ", got " &
    integer'image(i) & ".");
end procedure check;

----------------------------------------------------------------------------
-- Function to convert integer to IEEE-754 format.
----------------------------------------------------------------------------
function to_ieee754(num : integer) return std_logic_vector is
  variable sign : std_logic := '0';
  variable exp  : natural := 127;
  variable mantissa : unsigned(23 downto 0) := (others => '0');
begin
  if num < 0 then
    sign := '1';
    mantissa := to_unsigned(-num,24);
  elsif num = 0 then
    return X"00000000";
  else
    mantissa := to_unsigned(num,24);
  end if;

  -- Find where MSB is.
  for i in 23 downto 0 loop
    if mantissa(i) = '1' then
      exp      := exp + i;
      mantissa := shift_left(mantissa, 23-i);
      exit;
    end if;
  end loop;

  return sign & std_logic_vector(to_unsigned(exp, 8)) & std_logic_vector(mantissa(22 downto 0));

end function to_ieee754;

----------------------------------------------------------------------------
-- Function to convert IEEE-754 format to integer.
----------------------------------------------------------------------------
function ieee754_to_int(num : std_logic_vector(31 downto 0)) return integer is
  variable exp  : integer;
  variable mantissa : natural;
  variable int : integer;
begin
  if unsigned(num) = 0 then
    return 0;
  end if;
  mantissa := to_integer(unsigned('1' & num(22 downto 0)));
  exp := to_integer(unsigned(num(30 downto 23))) - 127 - 23;

  int := integer(real(mantissa)*(2.0**exp));

  if num(31) = '1' then
    return -int;
  else
    return int;
  end if;

end function ieee754_to_int;

begin

dut : hsum
  generic map (
    ddr_g           => ddr_g,
    summer_g        => summer_g,
    adder_latency_g => adder_latency_g,
    harmonic_g      => harmonic_g
  )
  port map (
    -- Control inputs.
    hsum_page    => hsum_page,
    hsum_trigger => hsum_trigger,
    hsum_enable  => hsum_enable,

    -- Control outputs.
    hsum_done    => hsum_done,

    -- DDR Interface.
    wait_request => wait_request,
    data_valid   => data_valid,
    ddr_data     => ddr_data,
    ddr_addr     => ddr_addr,
    ddr_read     => ddr_read,

    -- Micro interface (Covnetics standard interface).
    mcaddr       => mcaddr,
    mcdatain     => mcdatain,
    mcrwn        => mcrwn,
    mcms         => mcms,
    mcdataout    => mcdataout,

    -- Clock and reset.
    clk_sys      => clk_sys,
    rst_sys_n    => rst_sys_n,
    clk_mc       => clk_mc,
    rst_mc_n     => rst_mc_n
  );

----------------------------------------------------------------------------
-- Function:  Clock generator.
----------------------------------------------------------------------------
clk_gen_p : process
begin
  clk_sys  <= '0', '1' after clk_per_c/2;
  clk_mc   <= '0', '1' after clk_per_c/2;
  wait for clk_per_c;
end process clk_gen_p;



----------------------------------------------------------------------------
-- Function:  Generate the read data from DDR.
--            We shall put values at particular spots in the FOP.
--            Column numbers are 0 based.
--            Col   Row   Value
--             99   0     10
--            100   0     1234
--            200   1     1234
--            300   2     1000
--            400   3     2000
----------------------------------------------------------------------------
gen_ddr_data_p : process
  variable rowi_v  : natural;
  variable column_v: natural;
begin
  wait until rising_edge(clk_sys);

  if (ddr_read = '1' and wait_request = '0') then
    -- Send in a word of data.
    ddr_data   <= (others => '0');
    data_valid <= '1';

    -- Extract column number from address.
    column_v := to_integer(unsigned(ddr_addr(ddr_addr'left downto 10-ddr_g)));
    rowi_v   := to_integer(unsigned(ddr_addr(9-ddr_g downto 6)));

    case column_v is
      when 99 =>
        if rowi_v = ddr_map_c(ddr_g,0).rowi then
          ddr_data(ddr_map_c(ddr_g,0).word*32+31 downto ddr_map_c(ddr_g,0).word*32) <=
            to_ieee754(10);
        end if;
      when 100 =>
        if rowi_v = ddr_map_c(ddr_g,0).rowi then
          ddr_data(ddr_map_c(ddr_g,0).word*32+31 downto ddr_map_c(ddr_g,0).word*32) <=
            to_ieee754(1234);
        end if;
      when 200 =>
        if rowi_v = ddr_map_c(ddr_g,1).rowi then
          ddr_data(ddr_map_c(ddr_g,1).word*32+31 downto ddr_map_c(ddr_g,1).word*32) <=
            to_ieee754(1234);
        end if;
      when 300 =>
        if rowi_v = ddr_map_c(ddr_g,2).rowi then
          ddr_data(ddr_map_c(ddr_g,2).word*32+31 downto ddr_map_c(ddr_g,2).word*32) <=
            to_ieee754(1000);
        end if;
      when 400 =>
        if rowi_v = ddr_map_c(ddr_g,3).rowi then
          ddr_data(ddr_map_c(ddr_g,3).word*32+31 downto ddr_map_c(ddr_g,3).word*32) <=
            to_ieee754(2000);
        end if;
      when 795 =>
        if rowi_v = ddr_map_c(ddr_g,4).rowi then
          ddr_data(ddr_map_c(ddr_g,4).word*32+31 downto ddr_map_c(ddr_g,4).word*32) <=
            to_ieee754(8888);
        end if;
      when others =>
        null;
    end case;

  else
    data_valid <= '0';
  end if;
end process gen_ddr_data_p;

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
    if (rand_v < 0.93) then
      wait_request <= '0';
    else
      wait_request <= '1';
    end if;
  end loop;
end process gen_wait_request_p;


----------------------------------------------------------------------------
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process

  variable seed1_v, seed2_v : positive;
  variable rand_v : real;
  variable rand_int_v : integer;
  variable results_v : results_t;
  variable excs_v : exc_t;
  variable start_v : time;

  -- Generic micro write.
  procedure mcwrite(address : natural range 0 to 2**18-1;
                    data    : std_logic_vector(31 downto 0)) is
  begin
    mcaddr   <= std_logic_vector(to_unsigned(address, 18));
    mcdatain <= data;
    mcrwn    <= '0';
    mcms     <= '1', '0' after clk_per_c;
    wait for clk_per_c*2;
  end procedure mcwrite;

  -- Generic micro read.
  procedure mcread(address : natural range 0 to 2**18-1;
                   data    : out std_logic_vector(31 downto 0)) is
  begin
    mcaddr   <= std_logic_vector(to_unsigned(address, 18));
    mcrwn    <= '1';
    if address >= 16#10000# then
      -- Extend access when reading from results RAM.
      mcms     <= '1', '0' after clk_per_c*7;
      wait for clk_per_c*7;
    else
      mcms     <= '1', '0' after clk_per_c*4;
      wait for clk_per_c*4;
    end if;
    data     := mcdataout;
  end procedure mcread;

  -- Procedure to write to HPSEL RAM.
  procedure write_hpsel(harmonic     : natural range 0 to 15;
                        analysis_run : natural range 0 to 1;
                        seed         : natural range 0 to 20;
                        ambiguity    : natural range 0 to 10;
                        fop_row      : natural range 0 to 127;
                        summer_inst  : natural range 0 to 2 := 0) is
  begin
    mcwrite(summer_inst*16384 + analysis_run*8192 + seed*256 + ambiguity*16 + harmonic,
            std_logic_vector(to_unsigned(fop_row,32)));
  end procedure write_hpsel;

  -- Procedure to read from HPSEL RAM.
  procedure read_hpsel(harmonic     : natural range 0 to 15;
                       analysis_run : natural range 0 to 1;
                       seed         : natural range 0 to 20;
                       ambiguity    : natural range 0 to 10;
                       fop_row      : natural range 0 to 127;
                       summer_inst  : natural range 0 to 2 := 0) is
    variable hpsel_rd_v : std_logic_vector(31 downto 0);
  begin
    mcread(summer_inst*16384 + analysis_run*8192 + seed*256 + ambiguity*16 + harmonic,
      hpsel_rd_v);
    check(unsigned(hpsel_rd_v) = fop_row, "Error: HPSEL read back data is incorrect. Expected "
     & natural'image(fop_row) & ", got " & natural'image(to_integer(unsigned(hpsel_rd_v)))
     & ".");
  end procedure read_hpsel;

  -- Procedure to write to TSEL RAM.
  procedure write_tsel(harmonic    : natural range 0 to 15;
                       t_set       : natural range 0 to 1;
                       seed        : natural range 0 to 20;
                       threshold   : natural;
                       summer_inst : natural range 0 to 2 := 0) is
  begin
    mcwrite(16#C000# + summer_inst*1024 + t_set*512 + seed*16 + harmonic, to_ieee754(threshold));
  end procedure write_tsel;

  -- Procedure to read from TSEL RAM.
  procedure read_tsel(harmonic    : natural range 0 to 15;
                      t_set       : natural range 0 to 1;
                      seed        : natural range 0 to 20;
                      threshold   : natural;
                      summer_inst : natural range 0 to 2 := 0) is
    variable tsel_rd_v : std_logic_vector(31 downto 0);
  begin
    mcread(16#C000# + summer_inst*1024 + t_set*512 + seed*16 + harmonic, tsel_rd_v);
    check(threshold, ieee754_to_int(tsel_rd_v), "Error: TSEL read back data is incorrect");
  end procedure read_tsel;

  -- Procedure to check the stored results.
  -- All column numbers are 0-based.
  procedure check_results (
    run      : natural range 0 to 1
  ) is
    variable addr_v : natural;
    variable read_v : std_logic_vector(31 downto 0);
    variable result_v : result_t;
  begin
    for harmonic in 0 to 7 loop
      for result in 0 to 24 loop
        addr_v := 16#10000# + run*2048 + harmonic*128 + result*4;
        mcread(addr_v, read_v);
        result_v := results_v(harmonic,result);
        check(read_v(8) = result_v.valid,
          "VALID incorrect for result #" & natural'image(result) &
          ", harmonic = " & natural'image(harmonic));
        check(unsigned(read_v(2 downto 0)) = harmonic,
          "HARMONIC incorrect for result #" & natural'image(result) &
          ", harmonic = " & natural'image(harmonic));
        if read_v(8) = '1' then
          addr_v := addr_v + 1;
          mcread(addr_v, read_v);
          check(result_v.col, to_integer(unsigned(read_v)),
            "FOPCOL incorrect for result #" & natural'image(result) &
            ", harmonic = " & natural'image(harmonic));
          addr_v := addr_v + 1;
          mcread(addr_v, read_v);
          check(result_v.row, to_integer(unsigned(read_v)),
            "FOPROW incorrect for result #" & natural'image(result) &
            ", harmonic = " & natural'image(harmonic));
          addr_v := addr_v + 1;
          mcread(addr_v, read_v);
          check(result_v.pwr, ieee754_to_int(read_v),
            "PWR incorrect for result #" & natural'image(result) &
            ", harmonic = " & natural'image(harmonic));
        end if;
      end loop;
    end loop;
  end procedure check_results;

  -- Procedure to check the overflow results.
  procedure check_overflow(
    run      : natural range 0 to 1
  ) is
    variable addr_v : natural;
    variable read_v : std_logic_vector(31 downto 0);
    variable exc_v  : excess_t;
  begin
    for harmonic in 0 to 7 loop
      exc_v := excs_v(harmonic);
      addr_v := 16#20000# + run*64 + harmonic*4;
      mcread(addr_v, read_v);
      check(exc_v.t = unsigned(read_v),
        "T_EXC incorrect for harmonic " & natural'image(harmonic));
      if exc_v.t > 0 then
        addr_v := addr_v + 1;
        mcread(addr_v, read_v);
        check(exc_v.p = unsigned(read_v),
          "P_EXC incorrect for harmonic " & natural'image(harmonic));
        addr_v := addr_v + 1;
        mcread(addr_v, read_v);
        check(exc_v.s = unsigned(read_v),
          "S_EXC incorrect for harmonic " & natural'image(harmonic));
      end if;
    end loop;
  end procedure check_overflow;

  procedure run is
  begin
    -- Start analysis run.
    puts("Run triggered ...");
    hsum_trigger <= '1', '0' after clk_per_c;

    -- Wait for run to complete.
    while hsum_done = '0' loop
      wait for clk_per_c;
    end loop;
    puts("Run complete.");

    check_results(0);
    check_overflow(0);
  end procedure run;

begin
  -- Initialise input.
  rst_sys_n    <= '0';
  rst_mc_n     <= '0';
  hsum_page    <= (others => '0');
  hsum_trigger <= '0';
  hsum_enable  <= '1';

  -- Micro interface (Covnetics standard interface).
  mcaddr       <= (others => '0');
  mcdatain     <= (others => '0');
  mcrwn        <= '1';
  mcms         <= '0';

  -- Initialise expected results.
  results_v := (others => (others => (0, 1, 0, '0')));
  excs_v    := (others => (0,0,0));

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n  <= '1';
  rst_mc_n   <= '1';

  assert ieee754_to_int(to_ieee754(1000)) = 1000
    report "IEEE754 conversion error!"
      severity failure;

  --------------------------------------------------------------------------
  -- Initialise RAMs with test data.
  seed1_v := 1;
  seed2_v := 2;
  for harmonic in 0 to 7 loop
    for run in 0 to 1 loop
      for seed in 0 to 20 loop
        for ambiguity in 0 to 10 loop
          uniform(seed1_v, seed2_v, rand_v);
          rand_int_v := integer(trunc(rand_v*128.0));
          write_hpsel(harmonic, run, seed, ambiguity, rand_int_v);
        end loop;
        write_tsel(harmonic, run, seed, harmonic*65536 + run*256 + seed);
      end loop;
    end loop;
  end loop;

  -- Initialise config.
  mcwrite(16#D000#, X"00000000"); -- B_START_1
  mcwrite(16#D001#, X"00000105"); -- B_STOP_1
  mcwrite(16#D002#, X"00001000"); -- B_START_2
  mcwrite(16#D003#, X"00001000"); -- B_STOP_2
  mcwrite(16#D004#, X"00000707"); -- H_1 & H_2
  last_harmonic_s <= 7;
  mcwrite(16#D005#, X"00005555"); -- FOP_ROW_1 & FOP_ROW_2
  mcwrite(16#D008#, X"00000000"); -- A_SET
  mcwrite(16#D009#, X"0000FFFF"); -- THRESH_SET
  mcwrite(16#D00A#, X"12345678"); -- M
  mcwrite(16#D00C#, X"00000000"); -- T_FILTER_EN
  mcwrite(16#D010#, X"00001414"); -- SUMMER #0 P_EN_1 & P_EN_2
  mcwrite(16#D011#, X"00000A0A"); -- SUMMER #0 A_1 & A_2
  mcwrite(16#D030#, X"00000002"); -- DEBUG_READ - Enable micro access to results.

  --------------------------------------------------------------------------
  puts("RAM Test", header => true);

  -- Check read back from RAMs.
  seed1_v := 1;
  seed2_v := 2;
  for harmonic in 0 to 7 loop
    for run in 0 to 1 loop
      for seed in 0 to 20 loop
        for ambiguity in 0 to 10 loop
          uniform(seed1_v, seed2_v, rand_v);
          rand_int_v := integer(trunc(rand_v*128.0));
          read_hpsel(harmonic, run, seed, ambiguity, rand_int_v);
        end loop;
        read_tsel(harmonic, run, seed, harmonic*65536 + run*256 + seed);
      end loop;
    end loop;
  end loop;

  --------------------------------------------------------------------------
  puts("Max run time", header => true);
  -- Start analysis run.
  puts("Run triggered ...");
  hsum_trigger <= '1', '0' after clk_per_c;
  start_v := now;

  -- Wait for run to complete.
  while hsum_done = '0' loop
    wait for clk_per_c;
  end loop;
  puts("Run complete.");
  puts("Time for 262 columns " & time'image(now-start_v) & ".");

  --------------------------------------------------------------------------
  puts("Analysis tests", header => true);
  mcwrite(16#D000#, X"00000008"); -- B_START_1
  mcwrite(16#D001#, X"00000064"); -- B_STOP_1
  mcwrite(16#D010#, X"00000707"); -- SUMMER #0 P_EN_1 & P_EN_2
  mcwrite(16#D011#, X"00000000"); -- SUMMER #0 A_1 & A_2

  -- Clear config RAMs.
  for harmonic in 0 to 7 loop
    for run in 0 to 1 loop
      for seed in 0 to 20 loop
        for ambiguity in 0 to 10 loop
          write_hpsel(harmonic, run, seed, ambiguity, 0);
        end loop;
        write_tsel(harmonic, run, seed, 9999);
      end loop;
    end loop;
  end loop;

  -- Configure scanning 8 seed rows, with flat ambiguity.
  for harmonic in 0 to 7 loop
    for seed in 0 to 7 loop
      write_hpsel(harmonic,0,seed,0,hpsel_map_c(seed));
    end loop;
  end loop;
  write_tsel(0,0,0,1000); -- Only harmonic 0 should detect a result.

  -- Set expected results.
  results_v(0,0) := (pwr => 1234, col => 100, row => 0, valid => '1');
  run;

  -- Make last seed row fit a curve through additional spots.
  write_hpsel(0, 0, 7, 0, hpsel_map_c(0));
  write_hpsel(1, 0, 7, 0, hpsel_map_c(1));
  write_hpsel(2, 0, 7, 0, hpsel_map_c(2));
  write_hpsel(3, 0, 7, 0, hpsel_map_c(3));
  -- Set threshold of 4th harmonic to detect accumulated values.
  write_tsel(3, 0, 7, 4000);

  results_v(3,0) := (pwr => 5468, col => 400, row => hpsel_map_c(3), valid => '1');
  run;

  -- Add a detection on harmonic 7 of last seed row.
  write_hpsel(7, 0, 7, 0, hpsel_map_c(4));
  write_tsel(7, 0, 7, 8000);

  results_v(7,0) := (pwr => 8898, col => 795, row => hpsel_map_c(4), valid => '1');
  run;

  --------------------------------------------------------------------------
  puts("T_SET tests", header => true);
  puts("Column below:");
  mcwrite(16#D000#, X"00000063"); -- B_START_1
  mcwrite(16#D001#, X"00000063"); -- B_STOP_1
  mcwrite(16#D002#, X"00000063"); -- B_START_2
  mcwrite(16#D003#, X"00000063"); -- B_STOP_2
  mcwrite(16#D010#, X"00000000"); -- SUMMER #0 P_EN_1 & P_EN_2
  mcwrite(16#D011#, X"00000000"); -- SUMMER #0 A_1 & A_2
  mcwrite(16#D004#, X"00000000"); -- H_1 & H_2
  mcwrite(16#D008#, X"00000001"); -- A_SET
  mcwrite(16#D009#, X"00000064"); -- THRESH_SET
  write_hpsel(0, 0, 0, 0, hpsel_map_c(0)); -- Run 1
  write_hpsel(0, 1, 0, 0, hpsel_map_c(0)); -- Run 2
  write_tsel(0, 0, 0, 1000);               -- LO set
  write_tsel(0, 1, 0, 0);                  -- HI set
  results_v := (others => (others => (pwr => 0, col => 0, row => 0, valid => '0')));
  run;
  puts("Check run 2 ...");
  check_results(1); -- Check run 2 results.

  puts("Column equal:");
  mcwrite(16#D000#, X"00000064"); -- B_START_1
  mcwrite(16#D001#, X"00000064"); -- B_STOP_1
  mcwrite(16#D002#, X"00000064"); -- B_START_2
  mcwrite(16#D003#, X"00000064"); -- B_STOP_2
  results_v(0,0) := (pwr => 1234, col => 100, row => 0, valid => '1');
  run;
  puts("Check run 2 ...");
  check_results(1); -- Check run 2 results.

  puts("Column transition:");
  mcwrite(16#D000#, X"00000063"); -- B_START_1
  mcwrite(16#D002#, X"00000063"); -- B_START_2
  run;
  puts("Check run 2 ...");
  check_results(1); -- Check run 2 results.

  -- As a final check make run 1 have no result and run 2 have a result.
  puts("Run 1 no, run 2 yes:");
  mcwrite(16#D001#, X"00000063"); -- B_STOP_1
  results_v(0,0) := (pwr => 0, col => 0, row => 0, valid => '0');
  run;
  puts("Check run 2 ...");
  results_v(0,0) := (pwr => 1234, col => 100, row => 0, valid => '1');
  check_results(1); -- Check run 2 results.

  puts("");
  if testbench_passed then
    puts("*** PASSED ***", header => true);
  else
    puts("!!! FAILED !!!", header => true);
  end if;
  puts("");

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

