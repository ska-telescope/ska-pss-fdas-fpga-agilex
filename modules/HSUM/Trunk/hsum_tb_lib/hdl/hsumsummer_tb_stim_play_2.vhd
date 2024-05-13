----------------------------------------------------------------------------
-- Module Name:  hsumsummer_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumsummer_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumsummer sub-module which contains the following sub-modules:
--   hsumhpsel, hsummins, hsumtree, hsumtsel
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     16/08/18 Initial revision.
-- 0.2  RJH     03/06/19 Updated to test up to 16 harmonics.
-- 0.3  RJH     28/05/20 Added procedure to determine expected results for
--                       new summing tree structure.
--                       Added test for max functions.
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
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
use std.textio.all;
use hsum_lib.hsummci_pkg.all;
use hsum_lib.hsum_pkg.all;

architecture stim of hsumsummer_tb is

constant clk_per_c : time := 5 ns;
constant adder_latency_c : natural range 1 to 8 := 2;
constant summer_inst_c   : natural range 0 to 2 := 0;

-- Define the harmonic each comparator belongs to.
constant harmonic_c : natural_array_t(1 to 144) := ram_harmonic_c;

component hsumsummer is
  generic (
    summer_inst_g   : natural range 0 to 2;  -- SUMMER instance number (used for mci address decoding).
    adder_latency_g : natural range 1 to 7;  -- Number of cycles to perform one summation.
    harmonic_g      : natural range 8 to 16  -- Maximum number of harmonics to be processed.
  );
  port (
    -- Control and configuration inputs.
    new_sum      : in     std_logic;                                                     -- Trigger to start summing.
    analysis_run : in     std_logic;                                                     -- Indicates the analysis run number.
    h            : in     std_logic_vector (3 downto 0);                                 -- Number of harmonics to process.
    p_en         : in     std_logic_vector (4 downto 0);                                 -- Number of orbital acceleration values to process.
    a            : in     std_logic_vector (3 downto 0);                                 -- Number of orbital acceleration ambiguity slopes to process.
    t_set        : in     std_logic;                                                     -- Selects low or high frequency threshold sets.
    m            : in     std_logic_vector (31 downto 0);                                -- Value to use instead of FOP value.

    -- Data from DDRIN.
    data_sum     : in     std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);

    -- Data select to DDRIN.
    hpsel        : out    std_logic_vector (harmonic_g*7-1 downto 0);
    hpsel_en     : out    std_logic_vector (harmonic_g-1 downto 0);

    -- Micro signals for the configuration RAMs.
    hpsel_mci    : in     hsel_out_t;
    hpsel_rd     : out    std_logic_vector (6 downto 0);
    tsel_mci     : in     tsel_out_t;
    tsel_rd      : out    std_logic_vector (31 downto 0);

    -- Control response to TGEN.
    done_sum     : out    std_logic;

    -- Information to TREP.
    row_info     : out    std_logic_vector (harmonic_g*7-1 downto 0);                    -- Row number for each harmonic.
    pwr          : out    std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);  -- Summed power for each column.
    tc           : out    std_logic_vector (last_column_c(harmonic_g-1)-1 downto 0);     -- Indication threshold has been crossed for each column.
    last_result  : out    std_logic;                                                     -- Indicates last result of last ambiguity slope.

    -- Clocks and reset.
    clk_sys      : in     std_logic;
    rst_sys_n    : in     std_logic;
    clk_mc       : in     std_logic
  );
end component hsumsummer;


-- Control and configuation inputs.
signal new_sum : std_logic; -- Trigger to start new summation run.
signal analysis_run : std_logic; -- Indicates the analysis run number.
signal h : std_logic_vector(3 downto 0); -- Number of harmonics to process.
signal p_en : std_logic_vector(4 downto 0); -- Number of orbital acceleration values to process.
signal a : std_logic_vector(3 downto 0); -- Number of ambiguity slopes to process.
signal t_set : std_logic; -- Threshold set select.
signal m : std_logic_vector(31 downto 0); -- Value to use instead of FOP value.

-- Data from DDRIN.
signal data_sum : std_logic_vector(last_column_c(harmonic_g-1)*32-1 downto 0) := (others => '0');

-- Data select to DDRIN.
signal hpsel : std_logic_vector(harmonic_g*7-1 downto 0);
signal hpsel_en : std_logic_vector(harmonic_g-1 downto 0);

-- Micro signals for the configuration RAMs.
signal hpsel_mci : hsel_out_t;
signal hpsel_rd : std_logic_vector(6 downto 0);
signal tsel_mci : tsel_out_t;
signal tsel_rd : std_logic_vector(31 downto 0);

-- Control response to TGEN.
signal done_sum : std_logic;

-- Information to TREP.
signal row_info : std_logic_vector(harmonic_g*7-1 downto 0); -- Row number for each harmonic.
signal pwr      : std_logic_vector(last_column_c(harmonic_g-1)*32-1 downto 0);-- Summed power for each column.
signal tc       : std_logic_vector(last_column_c(harmonic_g-1)-1 downto 0); -- Indication threshold has been crossed for each column.

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;
signal clk_mc : std_logic;

-- Testbench signals.
type ddrin_store_ram_t is array(0 to 96) of std_logic_vector(31 downto 0);
type ddrin_store_t is array(1 to last_column_c(harmonic_g-1)) of ddrin_store_ram_t;
shared variable ddrin_store_v : ddrin_store_t;
type powers_t is array(1 to last_column_c(harmonic_g-1)) of std_logic_vector(31 downto 0);
shared variable powers_v : powers_t;
type mon_row_info_t is array(1 to last_column_c(harmonic_g-1)) of natural;
shared variable row_info_v : mon_row_info_t;
shared variable tc_v : std_logic_vector(1 to last_column_c(harmonic_g-1));
type row_info_t is array(0 to harmonic_g) of natural;
signal row_info_s : row_info_t;
type pwr_t is array(1 to last_column_c(harmonic_g-1)) of std_logic_vector(31 downto 0);
signal pwr_s : pwr_t;
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
    report msg severity error;
    testbench_passed := false;
  end if;
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

----------------------------------------------------------------------------
-- Function to return maximum of two numbers.
----------------------------------------------------------------------------
-- do some dummy commented out code using VHDL 2008 block method
/*
commented out code
*/

alias fmaxf is maximum[integer, integer return integer];

----------------------------------------------------------------------------
-- Functions to return maximum of n numbers.
----------------------------------------------------------------------------
function fmaxf3(a, b, c : integer) return integer is
begin
  return fmaxf(a, fmaxf(b, c));
end function fmaxf3;

function fmaxf4(a, b, c, d : integer) return integer is
begin
  return fmaxf( fmaxf(a, b), fmaxf(c, d) );
end function fmaxf4;

function fmaxf5(a, b, c, d, e : integer) return integer is
begin
  return fmaxf( fmaxf3(a, b, c), fmaxf(d, e) );
end function fmaxf5;

function fmaxf6(a, b, c, d, e, f : integer) return integer is
begin
  return fmaxf( fmaxf3(a, b, c), fmaxf3(d, e, f) );
end function fmaxf6;

function fmaxf7(a, b ,c ,d, e, f, g : integer) return integer is
begin
  return fmaxf( fmaxf3(a, b, c), fmaxf4(d, e, f, g) );
end function fmaxf7;

function fmaxf8(a, b, c, d, e, f, g, h : integer) return integer is
begin
  return fmaxf( fmaxf4(a, b, c, d), fmaxf4(e, f, g, h) );
end function fmaxf8;

function fmaxf9(a, b, c, d, e, f, g, h, i : integer) return integer is
begin
  return fmaxf( fmaxf4(a, b, c, d), fmaxf5(e, f, g, h, i) );
end function fmaxf9;

function fmaxf10(a, b, c, d, e, f, g, h, i, j : integer) return integer is
begin
  return fmaxf( fmaxf5(a, b, c, d, e), fmaxf5(f, g, h, i, j) );
end function fmaxf10;

function fmaxf11(a, b, c, d, e, f, g, h, i, j, k : integer) return integer is
begin
  return fmaxf( fmaxf5(a, b, c, d, e), fmaxf6(f, g, h, i, j, k) );
end function fmaxf11;

begin

dut : hsumsummer
  generic map(
    summer_inst_g   => summer_inst_c,
    adder_latency_g => adder_latency_c,
    harmonic_g      => harmonic_g
  )
  port map(
    -- Control and configuation inputs.
    new_sum       => new_sum,
    analysis_run  => analysis_run,
    h             => h,
    p_en          => p_en,
    a             => a,
    t_set         => t_set,
    m             => m,

    -- Data from DDRIN.
    data_sum      => data_sum,

    -- Data select to DDRIN.
    hpsel         => hpsel,
    hpsel_en      => hpsel_en,

    -- Micro signals for the configuration RAMs.
    hpsel_mci     => hpsel_mci,
    hpsel_rd      => hpsel_rd,
    tsel_mci      => tsel_mci,
    tsel_rd       => tsel_rd,

    -- Control response to TGEN.
    done_sum      => done_sum,

    -- Information to TREP.
    row_info      => row_info,
    pwr           => pwr,
    tc            => tc,

    -- Clocks and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n,
    clk_mc        => clk_mc
  );

----------------------------------------------------------------------------
-- Function:  Convert long vectors into arrays.
----------------------------------------------------------------------------
convrowinfo : for i in 0 to harmonic_g-1 generate
  row_info_s(i) <= to_integer(unsigned(row_info(i*7+6 downto i*7)));
end generate;
convpwr : for i in 1 to last_column_c(harmonic_g-1) generate
  pwr_s(i) <= pwr(i*32-1 downto i*32-32);
end generate;

----------------------------------------------------------------------------
-- Function:  Clock generator.
----------------------------------------------------------------------------
clk_gen_p : process
begin
  clk_sys <= '0', '1' after clk_per_c/2;
  clk_mc  <= '0', '1' after clk_per_c/2;
  wait for clk_per_c;
end process clk_gen_p;

----------------------------------------------------------------------------
-- Function:  Emulate the DDRIN sub-module.
----------------------------------------------------------------------------
ddrin : process(clk_sys)
  variable sel_v : natural;
begin
  if rising_edge(clk_sys) then
    for i in 1 to last_column_c(harmonic_g-1) loop
      if hpsel_en(harmonic_c(i)) = '1' then
        sel_v := to_integer(unsigned(hpsel(harmonic_c(i)*7+6 downto harmonic_c(i)*7)));
        data_sum(i*32-1 downto i*32-32) <= ddrin_store_v(i)(sel_v);
      end if;
    end loop;
  end if;
end process ddrin;

----------------------------------------------------------------------------
-- Function:  Monitors the summer outputs.
----------------------------------------------------------------------------
monitor : process(clk_sys)
begin
  if rising_edge(clk_sys) then
    for i in 1 to last_column_c(harmonic_g-1) loop
      if tc(i-1) = '1' then
        puts("Comparator " & natural'image(i) & " triggered.");
        tc_v(i) := '1';
        powers_v(i) := pwr(i*32-1 downto i*32-32);
        row_info_v(i) := row_info_s(harmonic_c(i));
      end if;
    end loop;
  end if;
end process monitor;

----------------------------------------------------------------------------
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process

  -- Create variables to store copy of HPSEL and TSEL configuration values.
  type hpsel_t is array(0 to 1, 0 to 20, 0 to 10, 0 to harmonic_g-1) of natural;
  variable hpsel_v : hpsel_t := (others => (others => (others => (others => 0))));
  type tsel_t is array(0 to 1, 0 to 20, 0 to harmonic_g-1) of natural;
  variable tsel_v : tsel_t := (others => (others => (others => 0)));

  -- Procedure to write to HPSEL RAM.
  procedure write_hpsel(harmonic : natural range 0 to 15;
                        analysis_run : natural range 0 to 1;
                        seed : natural range 0 to 20;
                        ambiguity : natural range 0 to 10;
                        fop_row : natural range 0 to 127) is
  begin
    hpsel_mci.addr <= std_logic_vector(to_unsigned(
      summer_inst_c*16384 + analysis_run*8192 + seed*256 + ambiguity*16 + harmonic, 16));
    hpsel_mci.wr   <= std_logic_vector(to_unsigned(fop_row,7));
    hpsel_mci.wren <= '1', '0' after clk_per_c;
    hpsel_v(analysis_run, seed, ambiguity, harmonic) := fop_row;
    wait for clk_per_c;
  end procedure write_hpsel;

  -- Procedure to write to TSEL RAM.
  procedure write_tsel(harmonic  : natural range 0 to 15;
                       t_set     : natural range 0 to 1;
                       seed      : natural range 0 to 20;
                       threshold : natural) is
  begin
    tsel_mci.addr <= std_logic_vector(to_unsigned(
      summer_inst_c*1024 + t_set*512 + seed*16 + harmonic, 12));
    tsel_mci.wr   <= to_ieee754(threshold);
    tsel_mci.wren <= '1', '0' after clk_per_c;
    tsel_v(t_set, seed, harmonic) := threshold;
    wait for clk_per_c;
  end procedure write_tsel;

  -- Procedure to check comparator results.
  procedure check_comparators(
    check_tc : std_logic_vector(1 to last_column_c(harmonic_g-1));
    check_pwr : powers_t;
    check_row : mon_row_info_t
  ) is
  begin
    for i in 1 to last_column_c(harmonic_g-1) loop
      check(check_tc(i) = tc_v(i), "Comparator " & natural'image(i) & " is incorrect.");
      if check_tc(i) = '1' then
        check(check_pwr(i) = powers_v(i), "Power " & natural'image(i) & " is incorrect." &
          " Expected " & natural'image(ieee754_to_int(check_pwr(i))) &
          ", got " & natural'image(ieee754_to_int(powers_v(i))));
        check(check_row(i) = row_info_v(i), "Row " & natural'image(i) & " is incorrect." &
          " Expected " & natural'image(check_row(i)) &
          ", got " & natural'image(row_info_v(i)));
      end if;
    end loop;
  end procedure check_comparators;

  -- Procedure to clear monitor info.
  procedure clear_monitor is
  begin
    tc_v := (others => '0');
    powers_v := (others => (others => '0'));
    row_info_v := (others => 0);
  end procedure clear_monitor;

  -- Procedure to perform analysis run.
  procedure run(
    run_num      : natural range 0 to 1 := 0;
    seeds        : natural range 1 to 21 := 21;
    ambiguities  : natural range 1 to 11 := 11;
    harmonics    : natural range 1 to 16 := harmonic_g
  ) is
  begin
    puts("Running (run = " & natural'image(run_num) & ", harmonics = " &
      natural'image(harmonics) & ", seeds = " & natural'image(seeds) &
      ", ambiguities = " & natural'image(ambiguities) & ") ...");
    h          <= std_logic_vector(to_unsigned(harmonics-1,4));
    a          <= std_logic_vector(to_unsigned(ambiguities-1,4));
    p_en       <= std_logic_vector(to_unsigned(seeds-1,5));
    if run_num = 0 then
      analysis_run <= '0';
    else
      analysis_run <= '1';
    end if;

    clear_monitor;
    new_sum <= '1', '0' after clk_per_c;

    while done_sum = '0' loop
      wait for clk_per_c;
    end loop;
    wait for clk_per_c*2;

  end procedure run;

  variable seed1_v, seed2_v : positive;
  variable rand_v : real;
  variable rand_int_v : integer;
  variable check_tc_v : std_logic_vector(1 to last_column_c(harmonic_g-1));
  variable check_pwr_v : powers_t;
  variable check_row_v : mon_row_info_t;
  variable pwr_v : std_logic_vector(31 downto 0);


  -- Procedure to predict the summer tree outputs.
  -- This is derived from the C model that implements the description in MATLAB file 'newHSUM.m'.
  -- Note: There is only one result stored for each comparator.
  procedure gen_results is
    -- Variables provisioned for upto 12 harmonics.
    type hsumd_array_t is array(1 to 12) of natural_array_t(1 to 73);
    variable sum : natural_array_t(0 to last_column_c(11)-1); -- Summer outputs to feed on to comparator = hsumout in matlab description 'newHSUM.m'.
    variable hsumd : hsumd_array_t; -- Individual adders in new summing tree in 'newHSUM.m'. 1-based indexing.
    variable val : natural_array_t(0 to last_column_c(11)-1); -- DATA_SUM aka bpos in 'newHSUM.m'.
    variable analysis_run_v : natural;
    variable tset_v : natural;
    variable harm_v : natural;
  begin

    if analysis_run = '0' then
      analysis_run_v := 0;
    else
      analysis_run_v := 1;
    end if;
    if t_set = '0' then
      tset_v := 0;
    else
      tset_v := 1;
    end if;

    check_tc_v := (others => '0');

    for i in 0 to to_integer(unsigned(p_en)) loop -- Loop for each seed row.

      for j in 0 to to_integer(unsigned(a)) loop  -- Loop for each ambiguity slope.
        --puts("row, slope = " & natural'image(i) & ", " & natural'image(j));

        -- Fetch the FOP values for the current slope.
        for c in 0 to last_column_c(harmonic_g-1)-1 loop
          val(c) := ieee754_to_int(ddrin_store_v(c+1)(hpsel_v(analysis_run_v, i, j, ram_harmonic_c(c+1))));
          --puts("  val = " & natural'image(val(c)));
        end loop;

        -- Perform summing tree.
        -- Note: hsumd uses 1-based indexing to match 'newHSUM.m'.
        -- 0
        hsumd(1)(1) := val(0);
        sum(0) := hsumd(1)(1);

        -- 1
        hsumd(2)(1) := val(1) + hsumd(1)(1);
        hsumd(2)(2) := val(2) + hsumd(1)(1);
        hsumd(2)(3) := val(3) + hsumd(1)(1);
        sum(1) := hsumd(2)(1);
        sum(2) := hsumd(2)(2);
        sum(3) := hsumd(2)(3);

        -- 2
        hsumd(3)(1) := val(4) + hsumd(2)(1);
        hsumd(3)(2) := val(4) + hsumd(2)(2);
        hsumd(3)(3) := val(5) + hsumd(2)(2);
        hsumd(3)(4) := val(6) + hsumd(2)(2);
        hsumd(3)(5) := val(6) + hsumd(2)(3);
        sum(4) := fmaxf(hsumd(3)(1), hsumd(3)(2));
        sum(5) := hsumd(3)(3);
        sum(6) := fmaxf(hsumd(3)(4), hsumd(3)(5));

        -- 3
        hsumd(4)(1) := val(7) + hsumd(3)(1);
        hsumd(4)(2) := val(8) + hsumd(3)(1);
        hsumd(4)(3) := val(8) + hsumd(3)(2);
        hsumd(4)(4) := val(8) + hsumd(3)(3);
        hsumd(4)(5) := val(9) + hsumd(3)(3);
        hsumd(4)(6) := val(10)+ hsumd(3)(3);
        hsumd(4)(7) := val(10)+ hsumd(3)(4);
        hsumd(4)(8) := val(10)+ hsumd(3)(5);
        hsumd(4)(9) := val(11)+ hsumd(3)(5);
        sum(7) := hsumd(4)(1);
        sum(8) := fmaxf3(hsumd(4)(2), hsumd(4)(3), hsumd(4)(4));
        sum(9) := hsumd(4)(5);
        sum(10):= fmaxf3(hsumd(4)(6), hsumd(4)(7), hsumd(4)(8));
        sum(11):= hsumd(4)(9);

        -- 4
        hsumd(5)(1) := val(12) + hsumd(4)(1);
        hsumd(5)(2) := val(12) + hsumd(4)(2);
        hsumd(5)(3) := val(13) + hsumd(4)(2);
        hsumd(5)(4) := val(13) + hsumd(4)(3);
        hsumd(5)(5) := val(13) + hsumd(4)(4);
        hsumd(5)(6) := val(13) + hsumd(4)(5);
        hsumd(5)(7) := val(14) + hsumd(4)(5);
        hsumd(5)(8) := val(15) + hsumd(4)(5);
        hsumd(5)(9) := val(15) + hsumd(4)(6);
        hsumd(5)(10) := val(15) + hsumd(4)(7);
        hsumd(5)(11) := val(15) + hsumd(4)(8);
        hsumd(5)(12) := val(16) + hsumd(4)(8);
        hsumd(5)(13) := val(16) + hsumd(4)(9);
        sum(12) := fmaxf(hsumd(5)(1), hsumd(5)(2));
        sum(13) := fmaxf4(hsumd(5)(3), hsumd(5)(4), hsumd(5)(5), hsumd(5)(6));
        sum(14) := hsumd(5)(7);
        sum(15) := fmaxf4(hsumd(5)(8), hsumd(5)(9), hsumd(5)(10), hsumd(5)(11));
        sum(16) := fmaxf(hsumd(5)(12), hsumd(5)(13));

        -- 5
        hsumd(6)(1) := val(17) + hsumd(5)(1);
        hsumd(6)(2) := val(18) + hsumd(5)(1);
        hsumd(6)(3) := val(18) + hsumd(5)(2);
        hsumd(6)(4) := val(18) + hsumd(5)(3);
        hsumd(6)(5) := val(18) + hsumd(5)(4);
        hsumd(6)(6) := val(19) + hsumd(5)(4);
        hsumd(6)(7) := val(19) + hsumd(5)(5);
        hsumd(6)(8) := val(19) + hsumd(5)(6);
        hsumd(6)(9) := val(19) + hsumd(5)(7);
        hsumd(6)(10) := val(20)+ hsumd(5)(7);
        hsumd(6)(11) := val(21)+ hsumd(5)(7);
        hsumd(6)(12) := val(21)+ hsumd(5)(8);
        hsumd(6)(13) := val(21)+ hsumd(5)(9);
        hsumd(6)(14) := val(21)+ hsumd(5)(10);
        hsumd(6)(15) := val(22)+ hsumd(5)(10);
        hsumd(6)(16) := val(22)+ hsumd(5)(11);
        hsumd(6)(17) := val(22)+ hsumd(5)(12);
        hsumd(6)(18) := val(22)+ hsumd(5)(13);
        hsumd(6)(19) := val(23)+ hsumd(5)(13);
        sum(17) := hsumd(6)(1);
        sum(18) := fmaxf4(hsumd(6)(2), hsumd(6)(3), hsumd(6)(4), hsumd(6)(5));
        sum(19) := fmaxf4(hsumd(6)(6), hsumd(6)(7), hsumd(6)(8), hsumd(6)(9));
        sum(20) := hsumd(6)(10);
        sum(21) := fmaxf4(hsumd(6)(11), hsumd(6)(12), hsumd(6)(13), hsumd(6)(14));
        sum(22) := fmaxf4(hsumd(6)(15), hsumd(6)(16), hsumd(6)(17), hsumd(6)(18));
        sum(23) := hsumd(6)(19);

        -- 6
        hsumd(7)(1) := val(24) + hsumd(6)(1);
        hsumd(7)(2) := val(24) + hsumd(6)(2);
        hsumd(7)(3) := val(24) + hsumd(6)(3);
        hsumd(7)(4) := val(25) + hsumd(6)(3);
        hsumd(7)(5) := val(25) + hsumd(6)(4);
        hsumd(7)(6) := val(25) + hsumd(6)(5);
        hsumd(7)(7) := val(25) + hsumd(6)(6);
        hsumd(7)(8)  := val(26) + hsumd(6)(6);
        hsumd(7)(9)  := val(26) + hsumd(6)(7);
        hsumd(7)(10) := val(26) + hsumd(6)(8);
        hsumd(7)(11) := val(26) + hsumd(6)(9);
        hsumd(7)(12) := val(26) + hsumd(6)(10);
        hsumd(7)(13) := val(27) + hsumd(6)(10);
        hsumd(7)(14) := val(28) + hsumd(6)(10);
        hsumd(7)(15) := val(28) + hsumd(6)(11);
        hsumd(7)(16) := val(28) + hsumd(6)(12);
        hsumd(7)(17) := val(28) + hsumd(6)(13);
        hsumd(7)(18) := val(28) + hsumd(6)(14);
        hsumd(7)(19) := val(29) + hsumd(6)(14);
        hsumd(7)(20) := val(29) + hsumd(6)(15);
        hsumd(7)(21) := val(29) + hsumd(6)(16);
        hsumd(7)(22) := val(29) + hsumd(6)(17);
        hsumd(7)(23) := val(30) + hsumd(6)(17);
        hsumd(7)(24) := val(30) + hsumd(6)(18);
        hsumd(7)(25) := val(30) + hsumd(6)(19);
        sum(24) := fmaxf3(hsumd(7)(1), hsumd(7)(2), hsumd(7)(3));
        sum(25) := fmaxf4(hsumd(7)(4), hsumd(7)(5), hsumd(7)(6), hsumd(7)(7));
        sum(26) := fmaxf5(hsumd(7)(8), hsumd(7)(9), hsumd(7)(10), hsumd(7)(11), hsumd(7)(12));
        sum(27) := hsumd(7)(13);
        sum(28) := fmaxf5(hsumd(7)(14), hsumd(7)(15), hsumd(7)(16), hsumd(7)(17), hsumd(7)(18));
        sum(29) := fmaxf4(hsumd(7)(19), hsumd(7)(20), hsumd(7)(21), hsumd(7)(22));
        sum(30) := fmaxf3(hsumd(7)(23), hsumd(7)(24), hsumd(7)(25));

        -- 7
        hsumd(8)(1) := val(31) + hsumd(7)(1);
        hsumd(8)(2) := val(32) + hsumd(7)(1);
        hsumd(8)(3) := val(32) + hsumd(7)(2);
        hsumd(8)(4) := val(32) + hsumd(7)(3);
        hsumd(8)(5) := val(32) + hsumd(7)(4);
        hsumd(8)(6) := val(33) + hsumd(7)(4);
        hsumd(8)(7) := val(33) + hsumd(7)(5);
        hsumd(8)(8) := val(33) + hsumd(7)(6);
        hsumd(8)(9) := val(33) + hsumd(7)(7);
        hsumd(8)(10) := val(33) + hsumd(7)(8);
        hsumd(8)(11) := val(34) + hsumd(7)(8);
        hsumd(8)(12) := val(34) + hsumd(7)(9);
        hsumd(8)(13) := val(34) + hsumd(7)(10);
        hsumd(8)(14) := val(34) + hsumd(7)(11);
        hsumd(8)(15) := val(34) + hsumd(7)(12);
        hsumd(8)(16) := val(34) + hsumd(7)(13);
        hsumd(8)(17) := val(35) + hsumd(7)(13);
        hsumd(8)(18) := val(36) + hsumd(7)(13);
        hsumd(8)(19) := val(36) + hsumd(7)(14);
        hsumd(8)(20) := val(36) + hsumd(7)(15);
        hsumd(8)(21) := val(36) + hsumd(7)(16);
        hsumd(8)(22) := val(36) + hsumd(7)(17);
        hsumd(8)(23) := val(36) + hsumd(7)(18);
        hsumd(8)(24) := val(37) + hsumd(7)(18);
        hsumd(8)(25) := val(37) + hsumd(7)(19);
        hsumd(8)(26) := val(37) + hsumd(7)(20);
        hsumd(8)(27) := val(37) + hsumd(7)(21);
        hsumd(8)(28) := val(37) + hsumd(7)(22);
        hsumd(8)(29) := val(38) + hsumd(7)(22);
        hsumd(8)(30) := val(38) + hsumd(7)(23);
        hsumd(8)(31) := val(38) + hsumd(7)(24);
        hsumd(8)(32) := val(38) + hsumd(7)(25);
        hsumd(8)(33) := val(39) + hsumd(7)(25);
        sum(31) := hsumd(8)(1);
        sum(32) := fmaxf4(hsumd(8)(2), hsumd(8)(3), hsumd(8)(4), hsumd(8)(5));
        sum(33) := fmaxf5(hsumd(8)(6), hsumd(8)(7), hsumd(8)(8), hsumd(8)(9), hsumd(8)(10));
        sum(34) := fmaxf6(hsumd(8)(11), hsumd(8)(12), hsumd(8)(13), hsumd(8)(14), hsumd(8)(15), hsumd(8)(16));
        sum(35) := hsumd(8)(17);
        sum(36) := fmaxf6(hsumd(8)(18), hsumd(8)(19), hsumd(8)(20), hsumd(8)(21), hsumd(8)(22), hsumd(8)(23));
        sum(37) := fmaxf5(hsumd(8)(24), hsumd(8)(25), hsumd(8)(26), hsumd(8)(27), hsumd(8)(28));
        sum(38) := fmaxf4(hsumd(8)(29), hsumd(8)(30), hsumd(8)(31), hsumd(8)(32));
        sum(39) := hsumd(8)(33);

        -- 8
        hsumd(9)(1) := val(40) + hsumd(8)(1);
        hsumd(9)(2) := val(40) + hsumd(8)(2);

        hsumd(9)(3) := val(41) + hsumd(8)(2);
        hsumd(9)(4) := val(41) + hsumd(8)(3);
        hsumd(9)(5) := val(41) + hsumd(8)(4);
        hsumd(9)(6) := val(41) + hsumd(8)(5);
        hsumd(9)(7) := val(41) + hsumd(8)(6);

        hsumd(9)(8) := val(42) + hsumd(8)(6);
        hsumd(9)(9) := val(42) + hsumd(8)(7);
        hsumd(9)(10) := val(42) + hsumd(8)(8);
        hsumd(9)(11) := val(42) + hsumd(8)(9);
        hsumd(9)(12) := val(42) + hsumd(8)(10);
        hsumd(9)(13) := val(42) + hsumd(8)(11);

        hsumd(9)(14) := val(43) + hsumd(8)(11);
        hsumd(9)(15) := val(43) + hsumd(8)(12);
        hsumd(9)(16) := val(43) + hsumd(8)(13);
        hsumd(9)(17) := val(43) + hsumd(8)(14);
        hsumd(9)(18) := val(43) + hsumd(8)(15);
        hsumd(9)(19) := val(43) + hsumd(8)(16);
        hsumd(9)(20) := val(43) + hsumd(8)(17);

        hsumd(9)(21) := val(44) + hsumd(8)(17);

        hsumd(9)(22) := val(45) + hsumd(8)(17);
        hsumd(9)(23) := val(45) + hsumd(8)(18);
        hsumd(9)(24) := val(45) + hsumd(8)(19);
        hsumd(9)(25) := val(45) + hsumd(8)(20);
        hsumd(9)(26) := val(45) + hsumd(8)(21);
        hsumd(9)(27) := val(45) + hsumd(8)(22);
        hsumd(9)(28) := val(45) + hsumd(8)(23);

        hsumd(9)(29) := val(46) + hsumd(8)(23);
        hsumd(9)(30) := val(46) + hsumd(8)(24);
        hsumd(9)(31) := val(46) + hsumd(8)(25);
        hsumd(9)(32) := val(46) + hsumd(8)(26);
        hsumd(9)(33) := val(46) + hsumd(8)(27);
        hsumd(9)(34) := val(46) + hsumd(8)(28);

        hsumd(9)(35) := val(47) + hsumd(8)(28);
        hsumd(9)(36) := val(47) + hsumd(8)(29);
        hsumd(9)(37) := val(47) + hsumd(8)(30);
        hsumd(9)(38) := val(47) + hsumd(8)(31);
        hsumd(9)(39) := val(47) + hsumd(8)(32);

        hsumd(9)(40) := val(48) + hsumd(8)(32);
        hsumd(9)(41) := val(48) + hsumd(8)(33);

        sum(40) := fmaxf(hsumd(9)(1), hsumd(9)(2));
        sum(41) := fmaxf5(hsumd(9)(3), hsumd(9)(4), hsumd(9)(5), hsumd(9)(6), hsumd(9)(7));
        sum(42) := fmaxf6(hsumd(9)(8), hsumd(9)(9), hsumd(9)(10), hsumd(9)(11), hsumd(9)(12), hsumd(9)(13));
        sum(43) := fmaxf7(hsumd(9)(14), hsumd(9)(15), hsumd(9)(16), hsumd(9)(17), hsumd(9)(18), hsumd(9)(19), hsumd(9)(20));
        sum(44) := hsumd(9)(21);
        sum(45) := fmaxf7(hsumd(9)(22), hsumd(9)(23), hsumd(9)(24), hsumd(9)(25), hsumd(9)(26), hsumd(9)(27), hsumd(9)(28));
        sum(46) := fmaxf6(hsumd(9)(29), hsumd(9)(30), hsumd(9)(31), hsumd(9)(32), hsumd(9)(33), hsumd(9)(34));
        sum(47) := fmaxf5(hsumd(9)(35), hsumd(9)(36), hsumd(9)(37), hsumd(9)(38), hsumd(9)(39));
        sum(48) := fmaxf(hsumd(9)(40), hsumd(9)(41));

        -- 9
        hsumd(10)(1) := val(49) + hsumd(9)(1);

        hsumd(10)(2) := val(50) + hsumd(9)(1);
        hsumd(10)(3) := val(50) + hsumd(9)(2);
        hsumd(10)(4) := val(50) + hsumd(9)(3);
        
        hsumd(10)(5) := val(51) + hsumd(9)(3);
        hsumd(10)(6) := val(51) + hsumd(9)(4);
        hsumd(10)(7) := val(51) + hsumd(9)(5);
        hsumd(10)(8) := val(51) + hsumd(9)(6);
        hsumd(10)(9) := val(51) + hsumd(9)(7);
        hsumd(10)(10) := val(51) + hsumd(9)(8);
        
        hsumd(10)(11) := val(52) + hsumd(9)(8);
        hsumd(10)(12) := val(52) + hsumd(9)(9);
        hsumd(10)(13) := val(52) + hsumd(9)(10);
        hsumd(10)(14) := val(52) + hsumd(9)(11);
        hsumd(10)(15) := val(52) + hsumd(9)(12);
        hsumd(10)(16) := val(52) + hsumd(9)(13);
        hsumd(10)(17) := val(52) + hsumd(9)(14);

        hsumd(10)(18) := val(53) + hsumd(9)(14);
        hsumd(10)(19) := val(53) + hsumd(9)(15);
        hsumd(10)(20) := val(53) + hsumd(9)(16);
        hsumd(10)(21) := val(53) + hsumd(9)(17);
        hsumd(10)(22) := val(53) + hsumd(9)(18);
        hsumd(10)(23) := val(53) + hsumd(9)(19);
        hsumd(10)(24) := val(53) + hsumd(9)(20);
        hsumd(10)(25) := val(53) + hsumd(9)(21);
        
        hsumd(10)(26) := val(54) + hsumd(9)(21);

        hsumd(10)(27) := val(55) + hsumd(9)(21);
        hsumd(10)(28) := val(55) + hsumd(9)(22);
        hsumd(10)(29) := val(55) + hsumd(9)(23);
        hsumd(10)(30) := val(55) + hsumd(9)(24);
        hsumd(10)(31) := val(55) + hsumd(9)(25);
        hsumd(10)(32) := val(55) + hsumd(9)(26);
        hsumd(10)(33) := val(55) + hsumd(9)(27);
        hsumd(10)(34) := val(55) + hsumd(9)(28);
        
        hsumd(10)(35) := val(56) + hsumd(9)(28);
        hsumd(10)(36) := val(56) + hsumd(9)(29);
        hsumd(10)(37) := val(56) + hsumd(9)(30);
        hsumd(10)(38) := val(56) + hsumd(9)(31);
        hsumd(10)(39) := val(56) + hsumd(9)(32);
        hsumd(10)(40) := val(56) + hsumd(9)(33);
        hsumd(10)(41) := val(56) + hsumd(9)(34);

        hsumd(10)(42) := val(57) + hsumd(9)(34);
        hsumd(10)(43) := val(57) + hsumd(9)(35);
        hsumd(10)(44) := val(57) + hsumd(9)(36);
        hsumd(10)(45) := val(57) + hsumd(9)(37);
        hsumd(10)(46) := val(57) + hsumd(9)(38);
        hsumd(10)(47) := val(57) + hsumd(9)(39);

        hsumd(10)(48) := val(58) + hsumd(9)(39);
        hsumd(10)(49) := val(58) + hsumd(9)(40);
        hsumd(10)(50) := val(58) + hsumd(9)(41);

        hsumd(10)(51) := val(59) + hsumd(9)(41);

        sum(49) := hsumd(10)(1);
        sum(50) := fmaxf3(hsumd(10)(2), hsumd(10)(3), hsumd(10)(4));
        sum(51) := fmaxf6(hsumd(10)(5), hsumd(10)(6), hsumd(10)(7), hsumd(10)(8), hsumd(10)(9), hsumd(10)(10));
        sum(52) := fmaxf7(hsumd(10)(11), hsumd(10)(12), hsumd(10)(13), hsumd(10)(14), hsumd(10)(15), hsumd(10)(16), hsumd(10)(17));
        sum(53) := fmaxf8(hsumd(10)(18), hsumd(10)(19), hsumd(10)(20), hsumd(10)(21), hsumd(10)(22), hsumd(10)(23), hsumd(10)(24), hsumd(10)(25));
        sum(54) := hsumd(10)(26);
        sum(55) := fmaxf8(hsumd(10)(27), hsumd(10)(28), hsumd(10)(29), hsumd(10)(30), hsumd(10)(31), hsumd(10)(32), hsumd(10)(33), hsumd(10)(34));
        sum(56) := fmaxf7(hsumd(10)(35), hsumd(10)(36), hsumd(10)(37), hsumd(10)(38), hsumd(10)(39), hsumd(10)(40), hsumd(10)(41));
        sum(57) := fmaxf6(hsumd(10)(42), hsumd(10)(43), hsumd(10)(44), hsumd(10)(45), hsumd(10)(46), hsumd(10)(47));
        sum(58) := fmaxf3(hsumd(10)(48), hsumd(10)(49), hsumd(10)(50));
        sum(59) := hsumd(10)(51);


        -- 10
        hsumd(11)(1) := val(60) + hsumd(10)(1);
        hsumd(11)(2) := val(60) + hsumd(10)(2);

        hsumd(11)(3) := val(61) + hsumd(10)(2);
        hsumd(11)(4) := val(61) + hsumd(10)(3);
        hsumd(11)(5) := val(61) + hsumd(10)(4);
        hsumd(11)(6) := val(61) + hsumd(10)(5);
        
        hsumd(11)(7) := val(62) + hsumd(10)(5);
        hsumd(11)(8) := val(62) + hsumd(10)(6);
        hsumd(11)(9) := val(62) + hsumd(10)(7);
        hsumd(11)(10) := val(62) + hsumd(10)(8);
        hsumd(11)(11) := val(62) + hsumd(10)(9);
        hsumd(11)(12) := val(62) + hsumd(10)(10);
        hsumd(11)(13) := val(62) + hsumd(10)(11);
        
        hsumd(11)(14) := val(63) + hsumd(10)(11);
        hsumd(11)(15) := val(63) + hsumd(10)(12);
        hsumd(11)(16) := val(63) + hsumd(10)(13);
        hsumd(11)(17) := val(63) + hsumd(10)(14);
        hsumd(11)(18) := val(63) + hsumd(10)(15);
        hsumd(11)(19) := val(63) + hsumd(10)(16);
        hsumd(11)(20) := val(63) + hsumd(10)(17);
        hsumd(11)(21) := val(63) + hsumd(10)(18);

        hsumd(11)(22) := val(64) + hsumd(10)(18);
        hsumd(11)(23) := val(64) + hsumd(10)(19);
        hsumd(11)(24) := val(64) + hsumd(10)(20);
        hsumd(11)(25) := val(64) + hsumd(10)(21);
        hsumd(11)(26) := val(64) + hsumd(10)(22);
        hsumd(11)(27) := val(64) + hsumd(10)(23);
        hsumd(11)(28) := val(64) + hsumd(10)(24);
        hsumd(11)(29) := val(64) + hsumd(10)(25);
        hsumd(11)(30) := val(64) + hsumd(10)(26);
        
        hsumd(11)(31) := val(65) + hsumd(10)(26);

        hsumd(11)(32) := val(66) + hsumd(10)(26);
        hsumd(11)(33) := val(66) + hsumd(10)(27);
        hsumd(11)(34) := val(66) + hsumd(10)(28);
        hsumd(11)(35) := val(66) + hsumd(10)(29);
        hsumd(11)(36) := val(66) + hsumd(10)(30);
        hsumd(11)(37) := val(66) + hsumd(10)(31);
        hsumd(11)(38) := val(66) + hsumd(10)(32);
        hsumd(11)(39) := val(66) + hsumd(10)(33);
        hsumd(11)(40) := val(66) + hsumd(10)(34);
        
        hsumd(11)(41) := val(67) + hsumd(10)(34);
        hsumd(11)(42) := val(67) + hsumd(10)(35);
        hsumd(11)(43) := val(67) + hsumd(10)(36);
        hsumd(11)(44) := val(67) + hsumd(10)(37);
        hsumd(11)(45) := val(67) + hsumd(10)(38);
        hsumd(11)(46) := val(67) + hsumd(10)(39);
        hsumd(11)(47) := val(67) + hsumd(10)(40);
        hsumd(11)(48) := val(67) + hsumd(10)(41);

        hsumd(11)(49) := val(68) + hsumd(10)(41);
        hsumd(11)(50) := val(68) + hsumd(10)(42);
        hsumd(11)(51) := val(68) + hsumd(10)(43);
        hsumd(11)(52) := val(68) + hsumd(10)(44);
        hsumd(11)(53) := val(68) + hsumd(10)(45);
        hsumd(11)(54) := val(68) + hsumd(10)(46);
        hsumd(11)(55) := val(68) + hsumd(10)(47);

        hsumd(11)(56) := val(69) + hsumd(10)(47);
        hsumd(11)(57) := val(69) + hsumd(10)(48);
        hsumd(11)(58) := val(69) + hsumd(10)(49);
        hsumd(11)(59) := val(69) + hsumd(10)(50);

        hsumd(11)(60) := val(70) + hsumd(10)(50);
        hsumd(11)(61) := val(70) + hsumd(10)(51);

        sum(60) := fmaxf(hsumd(11)(1), hsumd(11)(2));
        sum(61) := fmaxf4(hsumd(11)(3), hsumd(11)(4), hsumd(11)(5), hsumd(11)(6));
        sum(62) := fmaxf7(hsumd(11)(7), hsumd(11)(8), hsumd(11)(9), hsumd(11)(10), hsumd(11)(11), hsumd(11)(12), hsumd(11)(13));
        sum(63) := fmaxf8(hsumd(11)(14), hsumd(11)(15), hsumd(11)(16), hsumd(11)(17), hsumd(11)(18), hsumd(11)(19), hsumd(11)(20), hsumd(11)(21));
        sum(64) := fmaxf9(hsumd(11)(22), hsumd(11)(23), hsumd(11)(24), hsumd(11)(25), hsumd(11)(26), hsumd(11)(27), hsumd(11)(28), hsumd(11)(29), hsumd(11)(30));
        sum(65) := hsumd(11)(31);
        sum(66) := fmaxf9(hsumd(11)(32), hsumd(11)(33), hsumd(11)(34), hsumd(11)(35), hsumd(11)(36), hsumd(11)(37), hsumd(11)(38), hsumd(11)(39), hsumd(11)(40));
        sum(67) := fmaxf8(hsumd(11)(41), hsumd(11)(42), hsumd(11)(43), hsumd(11)(44), hsumd(11)(45), hsumd(11)(46), hsumd(11)(47), hsumd(11)(48));
        sum(68) := fmaxf7(hsumd(11)(49), hsumd(11)(50), hsumd(11)(51), hsumd(11)(52), hsumd(11)(53), hsumd(11)(54), hsumd(11)(55));
        sum(69) := fmaxf4(hsumd(11)(56), hsumd(11)(57), hsumd(11)(58), hsumd(11)(59));
        sum(70) := fmaxf(hsumd(11)(60), hsumd(11)(61));


        -- 11
        hsumd(12)(1) := val(71) + hsumd(11)(1);

        hsumd(12)(2) := val(72) + hsumd(11)(1);
        hsumd(12)(3) := val(72) + hsumd(11)(2);
        hsumd(12)(4) := val(72) + hsumd(11)(3);

        hsumd(12)(5) := val(73) + hsumd(11)(3);
        hsumd(12)(6) := val(73) + hsumd(11)(4);
        hsumd(12)(7) := val(73) + hsumd(11)(5);
        hsumd(12)(8) := val(73) + hsumd(11)(6);
        hsumd(12)(9) := val(73) + hsumd(11)(7);

        hsumd(12)(10) := val(74) + hsumd(11)(7);
        hsumd(12)(11) := val(74) + hsumd(11)(8);
        hsumd(12)(12) := val(74) + hsumd(11)(9);
        hsumd(12)(13) := val(74) + hsumd(11)(10);
        hsumd(12)(14) := val(74) + hsumd(11)(11);
        hsumd(12)(15) := val(74) + hsumd(11)(12);
        hsumd(12)(16) := val(74) + hsumd(11)(13);
        hsumd(12)(17) := val(74) + hsumd(11)(14);

        hsumd(12)(18) := val(75) + hsumd(11)(14);
        hsumd(12)(19) := val(75) + hsumd(11)(15);
        hsumd(12)(20) := val(75) + hsumd(11)(16);
        hsumd(12)(21) := val(75) + hsumd(11)(17);
        hsumd(12)(22) := val(75) + hsumd(11)(18);
        hsumd(12)(23) := val(75) + hsumd(11)(19);
        hsumd(12)(24) := val(75) + hsumd(11)(20);
        hsumd(12)(25) := val(75) + hsumd(11)(21);
        hsumd(12)(26) := val(75) + hsumd(11)(22);

        hsumd(12)(27) := val(76) + hsumd(11)(22);
        hsumd(12)(28) := val(76) + hsumd(11)(23);
        hsumd(12)(29) := val(76) + hsumd(11)(24);
        hsumd(12)(30) := val(76) + hsumd(11)(25);
        hsumd(12)(31) := val(76) + hsumd(11)(26);
        hsumd(12)(32) := val(76) + hsumd(11)(27);
        hsumd(12)(33) := val(76) + hsumd(11)(28);
        hsumd(12)(34) := val(76) + hsumd(11)(29);
        hsumd(12)(35) := val(76) + hsumd(11)(30);
        hsumd(12)(36) := val(76) + hsumd(11)(31);

        hsumd(12)(37) := val(77) + hsumd(11)(31);

        hsumd(12)(38) := val(78) + hsumd(11)(31);
        hsumd(12)(39) := val(78) + hsumd(11)(32);
        hsumd(12)(40) := val(78) + hsumd(11)(33);
        hsumd(12)(41) := val(78) + hsumd(11)(34);
        hsumd(12)(42) := val(78) + hsumd(11)(35);
        hsumd(12)(43) := val(78) + hsumd(11)(36);
        hsumd(12)(44) := val(78) + hsumd(11)(37);
        hsumd(12)(45) := val(78) + hsumd(11)(38);
        hsumd(12)(46) := val(78) + hsumd(11)(39);
        hsumd(12)(47) := val(78) + hsumd(11)(40);

        hsumd(12)(48) := val(79) + hsumd(11)(40);
        hsumd(12)(49) := val(79) + hsumd(11)(41);
        hsumd(12)(50) := val(79) + hsumd(11)(42);
        hsumd(12)(51) := val(79) + hsumd(11)(43);
        hsumd(12)(52) := val(79) + hsumd(11)(44);
        hsumd(12)(53) := val(79) + hsumd(11)(45);
        hsumd(12)(54) := val(79) + hsumd(11)(46);
        hsumd(12)(55) := val(79) + hsumd(11)(47);
        hsumd(12)(56) := val(79) + hsumd(11)(48);

        hsumd(12)(57) := val(80) + hsumd(11)(48);
        hsumd(12)(58) := val(80) + hsumd(11)(49);
        hsumd(12)(59) := val(80) + hsumd(11)(50);
        hsumd(12)(60) := val(80) + hsumd(11)(51);
        hsumd(12)(61) := val(80) + hsumd(11)(52);
        hsumd(12)(62) := val(80) + hsumd(11)(53);
        hsumd(12)(63) := val(80) + hsumd(11)(54);
        hsumd(12)(64) := val(80) + hsumd(11)(55);

        hsumd(12)(65) := val(81) + hsumd(11)(55);
        hsumd(12)(66) := val(81) + hsumd(11)(56);
        hsumd(12)(67) := val(81) + hsumd(11)(57);
        hsumd(12)(68) := val(81) + hsumd(11)(58);
        hsumd(12)(69) := val(81) + hsumd(11)(59);

        hsumd(12)(70) := val(82) + hsumd(11)(59);
        hsumd(12)(71) := val(82) + hsumd(11)(60);
        hsumd(12)(72) := val(82) + hsumd(11)(61);

        hsumd(12)(73) := val(83) + hsumd(11)(61);

        sum(71) := hsumd(12)(1);
        sum(72) := fmaxf3(hsumd(12)(2), hsumd(12)(3), hsumd(12)(4));
        sum(73) := fmaxf5(hsumd(12)(5), hsumd(12)(6), hsumd(12)(7), hsumd(12)(8), hsumd(12)(9));
        sum(74) := fmaxf8(hsumd(12)(10), hsumd(12)(11), hsumd(12)(12), hsumd(12)(13), hsumd(12)(14), hsumd(12)(15), hsumd(12)(16), hsumd(12)(17));
        sum(75) := fmaxf9(hsumd(12)(18), hsumd(12)(19), hsumd(12)(20), hsumd(12)(21), hsumd(12)(22), hsumd(12)(23), hsumd(12)(24), hsumd(12)(25), hsumd(12)(26));
        sum(76) := fmaxf10(hsumd(12)(27), hsumd(12)(28), hsumd(12)(29), hsumd(12)(30), hsumd(12)(31), hsumd(12)(32), hsumd(12)(33), hsumd(12)(34), hsumd(12)(35), hsumd(12)(36));
        sum(77) := hsumd(12)(37);
        sum(78) := fmaxf10(hsumd(12)(38), hsumd(12)(39), hsumd(12)(40), hsumd(12)(41), hsumd(12)(42), hsumd(12)(43), hsumd(12)(44), hsumd(12)(45), hsumd(12)(46), hsumd(12)(47));
        sum(79) := fmaxf9(hsumd(12)(48), hsumd(12)(49), hsumd(12)(50), hsumd(12)(51), hsumd(12)(52), hsumd(12)(53), hsumd(12)(54), hsumd(12)(55), hsumd(12)(56));
        sum(80) := fmaxf8(hsumd(12)(57), hsumd(12)(58), hsumd(12)(59), hsumd(12)(60), hsumd(12)(61), hsumd(12)(62), hsumd(12)(63), hsumd(12)(64));
        sum(81) := fmaxf5(hsumd(12)(65), hsumd(12)(66), hsumd(12)(67), hsumd(12)(68), hsumd(12)(69));
        sum(82) := fmaxf3(hsumd(12)(70), hsumd(12)(71), hsumd(12)(72));
        sum(83) := hsumd(12)(73);


        -- Now check thresholds.
        for colnum in 1 to last_column_c(harmonic_g-1) loop
          harm_v := ram_harmonic_c(colnum);
          if harm_v > unsigned(h) then
            exit;
          end if;
          --puts("  sum, thresh " & natural'image(colnum) & " = " & natural'image(sum(colnum-1)) &
          --     ", " & natural'image(tsel_v(tset_v, i, harm_v)));
          if sum(colnum-1) >= tsel_v(tset_v, i, harm_v) then
            check_tc_v(colnum) := '1';
            check_row_v(colnum) := hpsel_v(analysis_run_v, i, j, harm_v);
            check_pwr_v(colnum) := to_ieee754(sum(colnum-1));
          end if;
        end loop;

      end loop; -- j

    end loop; -- i
  end procedure gen_results;

begin
  -- Initialise input.
  new_sum      <= '0';
  analysis_run <= '0';
  a            <= (others => '0');
  h            <= (others => '0');
  p_en         <= (others => '0');
  rst_sys_n    <= '0';
  hpsel_mci    <= hsel_out_init_c;
  tsel_mci     <= tsel_out_init_c;
  t_set        <= '0';
  m            <= (others => '0');

  puts("Initialising ...", true);

  -- Initialise FOP data to all zeros.
  for i in 1 to last_column_c(harmonic_g-1) loop
    ddrin_store_v(i) := (others => (others => '0'));
  end loop;

  -- Set all thresholds to 200.
  for harmonic in 0 to harmonic_g-1 loop
    for set in 0 to 1 loop
      for seed in 0 to 20 loop
        write_tsel(harmonic, set, seed, 200);
      end loop;
    end loop;
  end loop;

  -- Configure acceleration curves to be flat lines, with FOP row equal to
  -- seed row number + ambiguity number.
  for harmonic in 0 to harmonic_g-1 loop
    for run in 0 to 1 loop
      for seed in 0 to 20 loop
        for ambiguity in 0 to 10 loop
          write_hpsel(harmonic, run, seed, ambiguity, seed + ambiguity);
        end loop;
      end loop;
    end loop;
  end loop;

  -- Remove reset.
  rst_sys_n <= '1';

  puts("HP_SEL tests", true);
  puts("No result test ...");
  -- Run a full summation and check nothing is detected.
  check_tc_v := (others => '0');
  check_pwr_v := (others => (others => '0'));
  check_row_v := (others => 0);
  run;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  run(run_num => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  puts("Checking seed runs ...");
  -- Set a value of 10 in row 5 of each column.
  for i in 1 to last_column_c(harmonic_g-1) loop
    ddrin_store_v(i)(5) := to_ieee754(10);
  end loop;
  -- Set threshold for last harmonic to be 10*harmonic_g for seed run 5.
  write_tsel(harmonic_g-1, 0, 5, 10*harmonic_g);

  -- Loop through seed & harmonics only.
  run(ambiguities => 1);

--  check_tc_v(first_res_c(harmonic_g-1)+1 to last_column_c(harmonic_g-1)) := (others => '1');
--  check_pwr_v(first_res_c(harmonic_g-1)+1 to last_column_c(harmonic_g-1)) := (others => to_ieee754(10*harmonic_g));
--  check_row_v(first_res_c(harmonic_g-1)+1 to last_column_c(harmonic_g-1)) := (others => 5);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  -- Check that running 6 seeds causes trigger.
  run(ambiguities => 1, seeds => 6);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  -- Check that running 5 seeds does not cause trigger.
  run(run_num => 1, ambiguities => 1, seeds => 5);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  puts("Checking ambiguity slope runs ...");
  -- Check that we get the same result looping through ambiguities.
  -- Set threshold for last harmonic to be 10*harmonic_g for seed run 0, set 1.
  t_set <= '1';
  write_tsel(harmonic_g-1, 1, 0, 10*harmonic_g);
  run(seeds => 1, ambiguities => 5);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  run(seeds => 1, ambiguities => 6);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  puts("Checking harmonic runs ...");
  -- Now check harmonic loop.
  t_set <= '0';
  run(harmonics => harmonic_g-1);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Lower the threshold for each harmonic in turn to cause a detection.
  for harmonic in harmonic_g-1 downto 0 loop
    write_tsel(harmonic, 0, 5, harmonic*10+10);
    run(harmonics => harmonic+1);
    gen_results;
    check_comparators(check_tc_v, check_pwr_v, check_row_v);
  end loop;

  -- Now change the FOP data to appear only in the central column for each harmonic.
  for i in 1 to last_column_c(harmonic_g-1) loop
    if i = last_column_c(harmonic_c(i)) - cols_per_harmonic_c(harmonic_c(i))/2 then
      null;
    else
      ddrin_store_v(i)(5) := X"00000000";
    end if;
  end loop;
  run;
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  -- Now make different seed rows have different thresholds and for different harmonics.
  for i in 0 to harmonic_g-1 loop
    write_tsel(i, 1, i, i*10);
  end loop;
  run(run_num => 1);
  gen_results;
  check_comparators(check_tc_v, check_pwr_v, check_row_v);

  puts("Check the M insertion.", true);
  -- Initialise FOP data to all zeros.
  for i in 1 to last_column_c(harmonic_g-1) loop
    ddrin_store_v(i) := (others => (others => '0'));
  end loop;
  -- Configure M to be used at two places in the analysis.
  -- write_hpsel(harmonic, run, seed, ambiguity, M);
  write_hpsel(2, 0, 1, 5, 16#60#);
  write_hpsel(6, 0, 4, 2, 16#60#);
  m <= to_ieee754(100);
  t_set <= '1';
  -- Set all thresholds to 1000.
  for harmonic in 0 to harmonic_g-1 loop
    for set in 0 to 1 loop
      for seed in 0 to 20 loop
        write_tsel(harmonic, set, seed, 1000);
      end loop;
    end loop;
  end loop;
  -- Set thresholds to match where M is used.
  write_tsel(2, 1, 1, 100);
  write_tsel(6, 1, 4, 100);
  check_tc_v  := (others => '0');
  check_pwr_v := (others => X"00000000");
  check_row_v := (others => 0);
  check_tc_v(5 to 7)  := (others => '1');
  check_pwr_v(5 to 7) := (others => to_ieee754(100));
  check_row_v(5 to 7) := (others => 16#60#);
  check_tc_v(25 to 31)  := (others => '1');
  check_pwr_v(25 to 31) := (others => to_ieee754(100));
  check_row_v(25 to 31) := (others => 16#60#);
  run(run_num => 0, harmonics => 7, seeds => 5, ambiguities => 6);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Restore all thresholds to 1000.
  write_tsel(2, 1, 1, 1000);
  write_tsel(6, 1, 4, 1000);


  puts("Testing max function connections", true);
  -- Test the max functions are connected correctly.
  -- One seed row and one slope will be run, which means HPSEL will always be 0.
  -- All thresholds are 1000.

  ------------------------------- Harmonic #7 ----------------------------------
  puts("=== Comparator 36 ===");
  ddrin_store_v(36)(0) := to_ieee754(1000);
  check_tc_v      := (others => '0');
  check_tc_v(36)  := '1';
  check_pwr_v(36) := to_ieee754(1000);
  check_row_v(36) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(36)(0) := to_ieee754(0);
  check_tc_v(36)  := '0';

  puts("=== Comparator 35 ===");
  ddrin_store_v(35)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(35)  := '1';
  check_pwr_v(35) := to_ieee754(1000);
  check_row_v(35) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #63 to make adder #91 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(1);
  check_pwr_v(35) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #41 to make adder #90 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(-2);
  ddrin_store_v(21)(0) := to_ieee754(2);
  check_pwr_v(35) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #25 to make adder #89 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(0);
  ddrin_store_v(21)(0) := to_ieee754(-3);
  ddrin_store_v(15)(0) := to_ieee754(3);
  check_pwr_v(35) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #88 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(0);
  ddrin_store_v(15)(0) := to_ieee754(-4);
  ddrin_store_v(10)(0) := to_ieee754(4);
  check_pwr_v(35) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #87 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-5);
  ddrin_store_v(6)(0) := to_ieee754(5);
  check_pwr_v(35) := to_ieee754(1005);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #86 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-6);
  ddrin_store_v(3)(0) := to_ieee754(6);
  check_pwr_v(35) := to_ieee754(1006);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(35)(0):= to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  check_tc_v(35)  := '0';

  puts("=== Comparator 37 ===");
  ddrin_store_v(37)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(37)  := '1';
  check_pwr_v(37) := to_ieee754(1000);
  check_row_v(37) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #63 to make adder #93 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(1);
  check_pwr_v(37) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #41 to make adder #94 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(-2);
  ddrin_store_v(21)(0) := to_ieee754(2);
  check_pwr_v(37) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #25 to make adder #95 the biggest of it's group.
  ddrin_store_v(28)(0) := to_ieee754(0);
  ddrin_store_v(21)(0) := to_ieee754(-3);
  ddrin_store_v(15)(0) := to_ieee754(3);
  check_pwr_v(37) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #96 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(0);
  ddrin_store_v(15)(0) := to_ieee754(-4);
  ddrin_store_v(10)(0) := to_ieee754(4);
  check_pwr_v(37) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #97 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-5);
  ddrin_store_v(6)(0) := to_ieee754(5);
  check_pwr_v(37) := to_ieee754(1005);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #98 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-6);
  ddrin_store_v(3)(0) := to_ieee754(6);
  check_pwr_v(37) := to_ieee754(1006);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(37)(0):= to_ieee754(0);
  check_tc_v(37)  := '0';

  puts("=== Comparator 34 ===");
  ddrin_store_v(34)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(34)  := '1';
  check_pwr_v(34) := to_ieee754(1000);
  check_row_v(34) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #58 to make adder #85 the biggest of it's group.
  ddrin_store_v(27)(0) := to_ieee754(1);
  check_pwr_v(34) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #57 to make adder #84 the biggest of it's group.
  ddrin_store_v(27)(0) := to_ieee754(-2);
  ddrin_store_v(20)(0) := to_ieee754(2);
  check_pwr_v(34) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12->#22->#36->#56) to make adder #83 the biggest of it's group.
  ddrin_store_v(27)(0) := to_ieee754(0);
  ddrin_store_v(20)(0) := to_ieee754(-3);
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(34) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #2 (->#5->#11->#21->#35->#55) to make adder #82 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(20)(0) := to_ieee754(0);
  ddrin_store_v(2)(0)  := to_ieee754(4);
  ddrin_store_v(13)(0) := to_ieee754(-4);
  check_pwr_v(34) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #20 to make adder #81 the biggest of it's group.
  ddrin_store_v(2)(0)  := to_ieee754(0);
  ddrin_store_v(13)(0) := to_ieee754(5);
  check_pwr_v(34) := to_ieee754(1005);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(13)(0) := to_ieee754(0);
  ddrin_store_v(34)(0) := to_ieee754(0);
  check_tc_v(34) := '0';

  puts("=== Comparator 38 ===");
  ddrin_store_v(38)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(38)  := '1';
  check_pwr_v(38) := to_ieee754(1000);
  check_row_v(38) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #68 to make adder #99 the biggest of it's group.
  ddrin_store_v(29)(0) := to_ieee754(1);
  check_pwr_v(38) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #45 to make adder #100 the biggest of it's group.
  ddrin_store_v(29)(0) := to_ieee754(-2);
  ddrin_store_v(22)(0) := to_ieee754(2);
  check_pwr_v(38) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#8->#16->#28->#46->#70) to make adder #101 the biggest of it's group.
  ddrin_store_v(29)(0) := to_ieee754(0);
  ddrin_store_v(22)(0) := to_ieee754(-3);
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(38) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #4 (->#9->#17->#29->#46->#70) to make adder #102 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(22)(0) := to_ieee754(0);
  ddrin_store_v(4)(0)  := to_ieee754(4);
  ddrin_store_v(17)(0) := to_ieee754(-4);
  check_pwr_v(38) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #30 to make adder #103 the biggest of it's group.
  ddrin_store_v(4)(0)  := to_ieee754(0);
  ddrin_store_v(17)(0) := to_ieee754(5);
  check_pwr_v(38) := to_ieee754(1005);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(17)(0) := to_ieee754(0);
  ddrin_store_v(38)(0) := to_ieee754(0);
  check_tc_v(38) := '0';

  puts("=== Comparator 33 ===");
  ddrin_store_v(33)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(33)  := '1';
  check_pwr_v(33) := to_ieee754(1000);
  check_row_v(33) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #54 to make adder #80 the biggest of it's group.
  ddrin_store_v(26)(0) := to_ieee754(1);
  check_pwr_v(33) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #11 (->#20->#34->#53) to make adder #79 the biggest of it's group.
  ddrin_store_v(26)(0) := to_ieee754(-2);
  ddrin_store_v(9)(0) := to_ieee754(2);
  check_pwr_v(33) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #10 (->#19->#33->#52) to make adder #78 the biggest of it's group.
  ddrin_store_v(26)(0):= to_ieee754(0);
  ddrin_store_v(9)(0) := to_ieee754(0);
  ddrin_store_v(18)(0):= to_ieee754(-3);
  ddrin_store_v(8)(0) := to_ieee754(3);
  check_pwr_v(33) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #32 (->#51) to make adder #77 the biggest of it's group.
  ddrin_store_v(8)(0)  := to_ieee754(0);
  ddrin_store_v(18)(0) := to_ieee754(4);
  check_pwr_v(33) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(18)(0) := to_ieee754(0);
  ddrin_store_v(33)(0) := to_ieee754(0);
  check_tc_v(33) := '0';

  puts("=== Comparator 39 ===");
  ddrin_store_v(39)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(39)  := '1';
  check_pwr_v(39) := to_ieee754(1000);
  check_row_v(39) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #72 to make adder #104 the biggest of it's group.
  ddrin_store_v(30)(0) := to_ieee754(1);
  check_pwr_v(39) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #17 (->#30->#48->#73) to make adder #105 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(2);
  ddrin_store_v(30)(0) := to_ieee754(-2);
  check_pwr_v(39) := to_ieee754(1002);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #18 (->#31->#49->#74) to make adder #106 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(0);
  ddrin_store_v(30)(0) := to_ieee754(0);
  ddrin_store_v(24)(0):= to_ieee754(-3);
  ddrin_store_v(12)(0) := to_ieee754(3);
  check_pwr_v(39) := to_ieee754(1003);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #50 (->#75) to make adder #107 the biggest of it's group.
  ddrin_store_v(12)(0)  := to_ieee754(0);
  ddrin_store_v(24)(0) := to_ieee754(4);
  check_pwr_v(39) := to_ieee754(1004);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(24)(0) := to_ieee754(0);
  ddrin_store_v(39)(0) := to_ieee754(0);
  check_tc_v(39) := '0';

  puts("=== Comparator 32 ===");
  ddrin_store_v(32)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(32)  := '1';
  check_pwr_v(32) := to_ieee754(1000);
  check_row_v(32) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #32 (->#51->#76).
  ddrin_store_v(18)(0) := to_ieee754(1);
  check_pwr_v(32) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(32)(0) := to_ieee754(0);
  ddrin_store_v(18)(0) := to_ieee754(0);
  check_tc_v(32) := '0';

  puts("=== Comparator 40 ===");
  ddrin_store_v(40)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(40)  := '1';
  check_pwr_v(40) := to_ieee754(1000);
  check_row_v(40) := 0;
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #50 (->#75->#106).
  ddrin_store_v(24)(0) := to_ieee754(1);
  check_pwr_v(40) := to_ieee754(1001);
  run(run_num => 0, harmonics => 8, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(24)(0) := to_ieee754(0);
  ddrin_store_v(40)(0) := to_ieee754(0);
  check_tc_v(40) := '0';


  ------------------------------- Harmonic #6 ----------------------------------
  puts("=== Comparator 28 ===");
  ddrin_store_v(28)(0) := to_ieee754(1000);
  check_tc_v      := (others => '0');
  check_tc_v(28)  := '1';
  check_pwr_v(28) := to_ieee754(1000);
  check_row_v(28) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(28)(0) := to_ieee754(0);
  check_tc_v(28)  := '0';

  puts("=== Comparator 27 ===");
  ddrin_store_v(27)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(27)  := '1';
  check_pwr_v(27) := to_ieee754(1000);
  check_row_v(27) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #41 to make adder #62 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(1);
  check_pwr_v(27) := to_ieee754(1001);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #41 to make adder #61 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(-2);
  ddrin_store_v(15)(0) := to_ieee754(2);
  check_pwr_v(27) := to_ieee754(1002);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 (->#24->#39) to make adder #60 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(0);
  ddrin_store_v(15)(0) := to_ieee754(-3);
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(27) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 (->#13->#23->#38) to make adder #59 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(27) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12->#22->#37) to make adder #58 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(27) := to_ieee754(1005);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(27)(0):= to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  check_tc_v(27)  := '0';

  puts("=== Comparator 29 ===");
  ddrin_store_v(29)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(29)  := '1';
  check_pwr_v(29) := to_ieee754(1000);
  check_row_v(29) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #41 to make adder #64 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(1);
  check_pwr_v(29) := to_ieee754(1001);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #25 to make adder #65 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(-2);
  ddrin_store_v(15)(0) := to_ieee754(2);
  check_pwr_v(29) := to_ieee754(1002);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #66 the biggest of it's group.
  ddrin_store_v(21)(0) := to_ieee754(0);
  ddrin_store_v(15)(0) := to_ieee754(-3);
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(29) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #67 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(29) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #68 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(29) := to_ieee754(1005);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(29)(0):= to_ieee754(0);
  check_tc_v(29)  := '0';

  puts("=== Comparator 26 ===");
  ddrin_store_v(26)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(26)  := '1';
  check_pwr_v(26) := to_ieee754(1000);
  check_row_v(26) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #37 to make adder #57 the biggest of it's group.
  ddrin_store_v(20)(0) := to_ieee754(1);
  check_pwr_v(26) := to_ieee754(1001);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12->#22->#36) to make adder #56 the biggest of it's group.
  ddrin_store_v(20)(0) := to_ieee754(-3);
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(26) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #2 (->#5->#11->#21->#35) to make adder #55 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(20)(0) := to_ieee754(0);
  ddrin_store_v(2)(0)  := to_ieee754(4);
  ddrin_store_v(13)(0) := to_ieee754(-4);
  check_pwr_v(26) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #20 to make adder #54 the biggest of it's group.
  ddrin_store_v(2)(0)  := to_ieee754(0);
  ddrin_store_v(13)(0) := to_ieee754(5);
  check_pwr_v(26) := to_ieee754(1005);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(13)(0) := to_ieee754(0);
  ddrin_store_v(26)(0) := to_ieee754(0);
  check_tc_v(26) := '0';

  puts("=== Comparator 30 ===");
  ddrin_store_v(30)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(30)  := '1';
  check_pwr_v(30) := to_ieee754(1000);
  check_row_v(30) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #45 to make adder #69 the biggest of it's group.
  ddrin_store_v(22)(0) := to_ieee754(2);
  check_pwr_v(30) := to_ieee754(1002);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#8->#16->#28->#46) to make adder #70 the biggest of it's group.
  ddrin_store_v(22)(0) := to_ieee754(-3);
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(30) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #4 (->#9->#17->#29->#47) to make adder #71 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(22)(0) := to_ieee754(0);
  ddrin_store_v(4)(0)  := to_ieee754(4);
  ddrin_store_v(17)(0) := to_ieee754(-4);
  check_pwr_v(30) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #30 (->#48) to make adder #72 the biggest of it's group.
  ddrin_store_v(4)(0)  := to_ieee754(0);
  ddrin_store_v(17)(0) := to_ieee754(5);
  check_pwr_v(30) := to_ieee754(1005);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(17)(0) := to_ieee754(0);
  ddrin_store_v(30)(0) := to_ieee754(0);
  check_tc_v(30) := '0';

  puts("=== Comparator 25 ===");
  ddrin_store_v(25)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(25)  := '1';
  check_pwr_v(25) := to_ieee754(1000);
  check_row_v(25) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #11 (->#20->#34) to make adder #53 the biggest of it's group.
  ddrin_store_v(9)(0) := to_ieee754(2);
  check_pwr_v(25) := to_ieee754(1002);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #10 (->#19->#33) to make adder #52 the biggest of it's group.
  ddrin_store_v(9)(0) := to_ieee754(0);
  ddrin_store_v(18)(0):= to_ieee754(-3);
  ddrin_store_v(8)(0) := to_ieee754(3);
  check_pwr_v(25) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #32 to make adder #51 the biggest of it's group.
  ddrin_store_v(8)(0)  := to_ieee754(0);
  ddrin_store_v(18)(0) := to_ieee754(4);
  check_pwr_v(25) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(18)(0) := to_ieee754(0);
  ddrin_store_v(25)(0) := to_ieee754(0);
  check_tc_v(25) := '0';

  puts("=== Comparator 31 ===");
  ddrin_store_v(31)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(31)  := '1';
  check_pwr_v(31) := to_ieee754(1000);
  check_row_v(31) := 0;
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #17 (->#30->#48) to make adder #73 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(2);
  check_pwr_v(31) := to_ieee754(1002);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #18 (->#31->#49) to make adder #74 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(0);
  ddrin_store_v(24)(0):= to_ieee754(-3);
  ddrin_store_v(12)(0) := to_ieee754(3);
  check_pwr_v(31) := to_ieee754(1003);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #50 to make adder #75 the biggest of it's group.
  ddrin_store_v(12)(0)  := to_ieee754(0);
  ddrin_store_v(24)(0) := to_ieee754(4);
  check_pwr_v(31) := to_ieee754(1004);
  run(run_num => 0, harmonics => 7, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(24)(0) := to_ieee754(0);
  ddrin_store_v(31)(0) := to_ieee754(0);
  check_tc_v(31) := '0';

  ------------------------------- Harmonic #5 ----------------------------------
  puts("=== Comparator 21 ===");
  ddrin_store_v(21)(0) := to_ieee754(1000);
  check_tc_v      := (others => '0');
  check_tc_v(21)  := '1';
  check_pwr_v(21) := to_ieee754(1000);
  check_row_v(21) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(21)(0) := to_ieee754(0);
  check_tc_v(21)  := '0';

  puts("=== Comparator 20 ===");
  ddrin_store_v(20)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(20)  := '1';
  check_pwr_v(20) := to_ieee754(1000);
  check_row_v(20) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #25 to make adder #40 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(2);
  check_pwr_v(20) := to_ieee754(1002);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 (->#24) to make adder #39 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(-3);
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(20) := to_ieee754(1003);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 (->#13->#23) to make adder #38 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(20) := to_ieee754(1004);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12->#22) to make adder #37 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(20) := to_ieee754(1005);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(20)(0):= to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  check_tc_v(20)  := '0';

  puts("=== Comparator 22 ===");
  ddrin_store_v(22)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(22)  := '1';
  check_pwr_v(22) := to_ieee754(1000);
  check_row_v(22) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #25 to make adder #42 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(2);
  check_pwr_v(22) := to_ieee754(1002);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #43 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(-3);
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(22) := to_ieee754(1003);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #44 the biggest of it's group.
  ddrin_store_v(15)(0) := to_ieee754(0);
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(22) := to_ieee754(1004);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #45 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(22) := to_ieee754(1005);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(22)(0):= to_ieee754(0);
  check_tc_v(22)  := '0';

  puts("=== Comparator 19 ===");
  ddrin_store_v(19)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(19)  := '1';
  check_pwr_v(19) := to_ieee754(1000);
  check_row_v(19) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12->#22) to make adder #36 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(19) := to_ieee754(1003);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #2 (->#5->#11->#21) to make adder #35 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(2)(0)  := to_ieee754(4);
  ddrin_store_v(13)(0) := to_ieee754(-4);
  check_pwr_v(19) := to_ieee754(1004);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #11 (->#20) to make adder #34 the biggest of it's group.
  ddrin_store_v(2)(0)  := to_ieee754(0);
  ddrin_store_v(13)(0) := to_ieee754(0);
  ddrin_store_v(9)(0) := to_ieee754(5);
  ddrin_store_v(14)(0) := to_ieee754(-5);
  check_pwr_v(19) := to_ieee754(1005);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #10 (->#19) to make adder #33 the biggest of it's group.
  ddrin_store_v(9)(0) := to_ieee754(0);
  ddrin_store_v(14)(0):= to_ieee754(0);
  ddrin_store_v(8)(0) := to_ieee754(1);
  check_pwr_v(19) := to_ieee754(1001);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(8)(0) := to_ieee754(0);
  ddrin_store_v(19)(0):= to_ieee754(0);
  check_tc_v(19) := '0';

  puts("=== Comparator 23 ===");
  ddrin_store_v(23)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(23)  := '1';
  check_pwr_v(23) := to_ieee754(1000);
  check_row_v(23) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#8->#16->#28) to make adder #46 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(3);
  check_pwr_v(23) := to_ieee754(1003);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #4 (->#9->#17->#29) to make adder #47 the biggest of it's group.
  ddrin_store_v(3)(0)  := to_ieee754(0);
  ddrin_store_v(4)(0)  := to_ieee754(4);
  ddrin_store_v(17)(0) := to_ieee754(-4);
  check_pwr_v(23) := to_ieee754(1004);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #23 to make adder #48 the biggest of it's group.
  ddrin_store_v(4)(0)  := to_ieee754(0);
  ddrin_store_v(17)(0) := to_ieee754(0);
  ddrin_store_v(11)(0) := to_ieee754(5);
  ddrin_store_v(16)(0) := to_ieee754(-5);
  check_pwr_v(23) := to_ieee754(1005);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #18 (->#31) to make adder #49 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(0);
  ddrin_store_v(16)(0) := to_ieee754(0);
  ddrin_store_v(12)(0) := to_ieee754(1);
  check_pwr_v(23) := to_ieee754(1001);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(12)(0) := to_ieee754(0);
  ddrin_store_v(23)(0) := to_ieee754(0);
  check_tc_v(23) := '0';

  puts("=== Comparator 18 ===");
  ddrin_store_v(18)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(18)  := '1';
  check_pwr_v(18) := to_ieee754(1000);
  check_row_v(18) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #13.
  ddrin_store_v(13)(0) := to_ieee754(2);
  check_pwr_v(18) := to_ieee754(1002);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(13)(0) := to_ieee754(0);
  ddrin_store_v(18)(0) := to_ieee754(0);
  check_tc_v(18) := '0';

  puts("=== Comparator 24 ===");
  ddrin_store_v(24)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(24)  := '1';
  check_pwr_v(24) := to_ieee754(1000);
  check_row_v(24) := 0;
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #31.
  ddrin_store_v(17)(0) := to_ieee754(2);
  check_pwr_v(24) := to_ieee754(1002);
  run(run_num => 0, harmonics => 6, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(17)(0) := to_ieee754(0);
  ddrin_store_v(24)(0) := to_ieee754(0);
  check_tc_v(24) := '0';

  ------------------------------- Harmonic #4 ----------------------------------
  puts("=== Comparator 15 ===");
  ddrin_store_v(15)(0) := to_ieee754(1000);
  check_tc_v      := (others => '0');
  check_tc_v(15)  := '1';
  check_pwr_v(15) := to_ieee754(1000);
  check_row_v(15) := 0;
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(15)(0) := to_ieee754(0);
  check_tc_v(15)  := '0';

  puts("=== Comparator 14 ===");
  ddrin_store_v(14)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(14)  := '1';
  check_pwr_v(14) := to_ieee754(1000);
  check_row_v(14) := 0;
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #24 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(14) := to_ieee754(1003);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 (->#13) to make adder #23 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(14) := to_ieee754(1004);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6->#12) to make adder #22 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(14) := to_ieee754(1005);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#2->#5->#11) to make adder #21 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(-2);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(14) := to_ieee754(1002);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(14)(0):= to_ieee754(0);
  check_tc_v(14)  := '0';

  puts("=== Comparator 16 ===");
  ddrin_store_v(16)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(16)  := '1';
  check_pwr_v(16) := to_ieee754(1000);
  check_row_v(16) := 0;
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #14 to make adder #26 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(3);
  check_pwr_v(16) := to_ieee754(1003);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #27 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(-4);
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(16) := to_ieee754(1004);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #28 the biggest of it's group.
  ddrin_store_v(10)(0) := to_ieee754(0);
  ddrin_store_v(6)(0) := to_ieee754(-5);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(16) := to_ieee754(1005);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#4->#9->#17) to make adder #29 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(-2);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(16) := to_ieee754(1002);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(16)(0):= to_ieee754(0);
  check_tc_v(16)  := '0';

  puts("=== Comparator 13 ===");
  ddrin_store_v(13)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(13)  := '1';
  check_pwr_v(13) := to_ieee754(1000);
  check_row_v(13) := 0;
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #11 to make adder #20 the biggest of it's group.
  ddrin_store_v(9)(0) := to_ieee754(5);
  check_pwr_v(13) := to_ieee754(1005);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #10 to make adder #19 the biggest of it's group.
  ddrin_store_v(9)(0) := to_ieee754(0);
  ddrin_store_v(8)(0) := to_ieee754(1);
  check_pwr_v(13) := to_ieee754(1001);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(8)(0) := to_ieee754(0);
  ddrin_store_v(13)(0):= to_ieee754(0);
  check_tc_v(13) := '0';

  puts("=== Comparator 17 ===");
  ddrin_store_v(17)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(17)  := '1';
  check_pwr_v(17) := to_ieee754(1000);
  check_row_v(17) := 0;
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #17 to make adder #30 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(5);
  check_pwr_v(17) := to_ieee754(1005);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #18 to make adder #31 the biggest of it's group.
  ddrin_store_v(11)(0) := to_ieee754(0);
  ddrin_store_v(12)(0) := to_ieee754(1);
  check_pwr_v(17) := to_ieee754(1001);
  run(run_num => 0, harmonics => 5, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(12)(0) := to_ieee754(0);
  ddrin_store_v(17)(0) := to_ieee754(0);
  check_tc_v(17) := '0';


  ------------------------------- Harmonic #3 ----------------------------------
  puts("=== Comparator 10 ===");
  ddrin_store_v(10)(0) := to_ieee754(1000);
  check_tc_v      := (others => '0');
  check_tc_v(10)  := '1';
  check_pwr_v(10) := to_ieee754(1000);
  check_row_v(10) := 0;
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(10)(0) := to_ieee754(0);
  check_tc_v(10)  := '0';

  puts("=== Comparator 9 ===");
  ddrin_store_v(9)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(9)  := '1';
  check_pwr_v(9) := to_ieee754(1000);
  check_row_v(9) := 0;
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #13 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(9) := to_ieee754(1004);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (->#6) to make adder #12 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(9) := to_ieee754(1005);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#2->#5) to make adder #11 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(9) := to_ieee754(1002);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(9)(0):= to_ieee754(0);
  check_tc_v(9)  := '0';

  puts("=== Comparator 11 ===");
  ddrin_store_v(11)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(11)  := '1';
  check_pwr_v(11) := to_ieee754(1000);
  check_row_v(11) := 0;
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #7 to make adder #15 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(4);
  check_pwr_v(11) := to_ieee754(1004);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 (=>#8) to make adder #16 the biggest of it's group.
  ddrin_store_v(6)(0) := to_ieee754(0);
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(11) := to_ieee754(1005);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#4->#9) to make adder #17 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(11) := to_ieee754(1002);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(11)(0):= to_ieee754(0);
  check_tc_v(11)  := '0';

  puts("=== Comparator 8 ===");
  ddrin_store_v(8)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(8)  := '1';
  check_pwr_v(8) := to_ieee754(1000);
  check_row_v(8) := 0;
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #5.
  ddrin_store_v(5)(0) := to_ieee754(1);
  check_pwr_v(8) := to_ieee754(1001);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(5)(0) := to_ieee754(0);
  ddrin_store_v(8)(0):= to_ieee754(0);
  check_tc_v(8) := '0';

  puts("=== Comparator 12 ===");
  ddrin_store_v(12)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(12)  := '1';
  check_pwr_v(12) := to_ieee754(1000);
  check_row_v(12) := 0;
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #9.
  ddrin_store_v(7)(0) := to_ieee754(1);
  check_pwr_v(12) := to_ieee754(1001);
  run(run_num => 0, harmonics => 4, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(7)(0) := to_ieee754(0);
  ddrin_store_v(12)(0) := to_ieee754(0);
  check_tc_v(12) := '0';


  ------------------------------- Harmonic #2 ----------------------------------
  puts("=== Comparator 6 ===");
  ddrin_store_v(6)(0) := to_ieee754(1000);
  check_tc_v     := (others => '0');
  check_tc_v(6)  := '1';
  check_pwr_v(6) := to_ieee754(1000);
  check_row_v(6) := 0;
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(6)(0) := to_ieee754(0);
  check_tc_v(6)  := '0';

  puts("=== Comparator 5 ===");
  ddrin_store_v(5)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(5)  := '1';
  check_pwr_v(5) := to_ieee754(1000);
  check_row_v(5) := 0;
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #6 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(5) := to_ieee754(1005);
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#2) to make adder #5 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(5) := to_ieee754(1002);
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(5)(0):= to_ieee754(0);
  check_tc_v(5)  := '0';

  puts("=== Comparator 7 ===");
  ddrin_store_v(7)(0) := to_ieee754(1000); -- All max functions receive same value.
  check_tc_v(7)  := '1';
  check_pwr_v(7) := to_ieee754(1000);
  check_row_v(7) := 0;
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #3 to make adder #8 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(5);
  check_pwr_v(7) := to_ieee754(1005);
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  -- Add a small amount at adder #1 (->#4) to make adder #9 the biggest of it's group.
  ddrin_store_v(3)(0) := to_ieee754(0);
  ddrin_store_v(1)(0) := to_ieee754(2);
  check_pwr_v(7) := to_ieee754(1002);
  run(run_num => 0, harmonics => 3, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);
  ddrin_store_v(7)(0):= to_ieee754(0);
  check_tc_v(7)  := '0';

  -- Feed 1000 in at head of tree and check it propogates throughout tree.
  puts("=== Tree propagation ===");
  ddrin_store_v(1)(0) := to_ieee754(1000);
  check_tc_v  := (others => '1');
  check_pwr_v := (others => to_ieee754(1000));
  run(run_num => 0, harmonics => harmonic_g, seeds => 1, ambiguities => 1);
  check_comparators(check_tc_v, check_pwr_v, check_row_v);
  ddrin_store_v(1)(0) := to_ieee754(0);

  puts("");
  if testbench_passed then
    puts("*** PASSED ***");
  else
    puts("!!! FAILED !!!");
  end if;
  puts("");

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

