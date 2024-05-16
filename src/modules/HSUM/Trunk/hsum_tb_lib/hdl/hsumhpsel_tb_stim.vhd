----------------------------------------------------------------------------
-- Module Name:  hsumhpsel_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumhpsel_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumtsel and hsumhpsel sub-modules.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     24/05/18 Initial revision.
-- 0.2  RJH     04/06/19 Updated for increase to 16 harmonics.
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
use hsum_lib.hsummci_pkg.all;

architecture stim of hsumhpsel_tb is

constant clk_per_c : time := 5 ns;
constant adder_latency_c : natural range 1 to 8 := 3;
constant summer_inst_c   : natural range 0 to 2 := 0;

component hsumhpsel is
  generic (
    summer_inst_g   : natural range 0 to 2;  -- SUMMER instance number (used for mci address decoding).
    adder_latency_g : natural range 1 to 8;  -- Number of cycles to perform one summation.
    harmonic_g      : natural range 8 to 16  -- Maximum number of harmonics to be processed.
  );
  port (
    -- Control and configuation inputs.
    new_sum       : in  std_logic;                     -- Trigger to start summing.
    analysis_run  : in  std_logic;                     -- Indicates the analysis run number.
    h             : in  std_logic_vector(3 downto 0);  -- Number of harmonics to process.
    p_en          : in  std_logic_vector(4 downto 0);  -- Number of orbital acceleration values to process.
    a             : in  std_logic_vector(3 downto 0);  -- Number of orbital acceleration ambiguity slopes to process.

    -- Data select to DDRIN.
    hpsel         : out std_logic_vector(harmonic_g*7-1 downto 0);
    hpsel_en      : out std_logic_vector(harmonic_g-1 downto 0);

    -- Micro signals for the configuration RAMs.
    hpsel_mci     : in  hsel_out_t;
    hpsel_rd      : out std_logic_vector(6 downto 0);

    -- Control response to TGEN.
    done_sum      : out std_logic;

    -- Information to TREP.
    row_info      : out std_logic_vector(harmonic_g*7-1 downto 0); -- Row number for each harmonic.
    last_result   : out std_logic;

    -- Comparator enables to SUMMER_TREE.
    comp_en       : out std_logic_vector(harmonic_g-1 downto 0);
    msel          : out std_logic_vector(harmonic_g-1 downto 0);   -- Indication to feed msel instead of data_sum into summer.

    -- Threshold selection controls to HP_SEL (per harmonic).
    seed_num      : out std_logic_vector(harmonic_g*5-1 downto 0); -- Seed numbers being processed.
    t_en          : out std_logic_vector(harmonic_g-1 downto 0);   -- Read enables for threshold RAMs.

    -- Clocks and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic;
    clk_mc        : in  std_logic
  );
end component hsumhpsel;

component hsumtsel is
  generic (
    summer_inst_g   : natural range 0 to 2;  -- SUMMER instance number (used for mci address decoding).
    adder_latency_g : natural range 1 to 8;  -- Number of cycles to perform one summation.
    harmonic_g      : natural range 8 to 16  -- Maximum number of harmonics to be processed.
  );
  port (
    -- Seed row number from HPSEL (per harmonic).
    seed_num      : in  std_logic_vector(harmonic_g*5-1 downto 0);
    t_en          : in  std_logic_vector(harmonic_g-1 downto 0); -- Read enables for threshold RAMs.
    t_set         : in  std_logic;                               -- Threshold set select.

    -- Micro signals for the configuration RAMs.
    tsel_mci      : in  tsel_out_t;
    tsel_rd       : out std_logic_vector(31 downto 0);

    -- Thresholds to SUMMER (per harmonic).
    t             : out std_logic_vector(harmonic_g*32-1 downto 0);

    -- Clocks and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic;
    clk_mc        : in  std_logic
  );
end component hsumtsel;

-- Control and configuation inputs.
signal new_sum : std_logic; -- Trigger to start new summation run.
signal analysis_run : std_logic; -- Indicates the analysis run number.
signal h : std_logic_vector(3 downto 0); -- Number of harmonics to process.
signal p_en : std_logic_vector(4 downto 0); -- Number of orbital acceleration values to process.
signal a : std_logic_vector(3 downto 0); -- Number of ambiguity slopes to process.

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
signal last_result : std_logic;
signal comp_en : std_logic_vector(harmonic_g-1 downto 0);

signal msel : std_logic_vector(harmonic_g-1 downto 0); -- Indication to feed msel instead of data_sum into summer.
signal seed_num : std_logic_vector(harmonic_g*5-1 downto 0); -- Seed number being processed (to select thresholds).
signal t_en : std_logic_vector(harmonic_g-1 downto 0); -- Read enables for threshold RAMs.
signal t_set : std_logic; -- Threshold set select.

-- Thresholds to SUMMER (per harmonic).
signal t : std_logic_vector(harmonic_g*32-1 downto 0);

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;
signal clk_mc : std_logic;

-- Testbench signals.
type threshold_t is array(1 to harmonic_g) of std_logic_vector(31 downto 0);
signal threshold_s : threshold_t;
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

dut1 : hsumhpsel
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

    -- Data select to DDRIN.
    hpsel         => hpsel,
    hpsel_en      => hpsel_en,

    -- Micro signals for the configuration RAMs.
    hpsel_mci     => hpsel_mci,
    hpsel_rd      => hpsel_rd,

    -- Control response to TGEN.
    done_sum      => done_sum,

    -- Information to TREP.
    row_info      => row_info,
    last_result   => last_result,

    -- Comparator enables to SUMMER_TREE.
    comp_en       => comp_en,
    msel          => msel,

    seed_num      => seed_num,
    t_en          => t_en,

    -- Clocks and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n,
    clk_mc        => clk_mc
  );

dut2 : hsumtsel
  generic map (
    summer_inst_g   => summer_inst_c,
    adder_latency_g => adder_latency_c,
    harmonic_g      => harmonic_g
  )
  port map (
    -- Seed row number from HPSEL (per harmonic).
    seed_num      => seed_num,
    t_en          => t_en,
    t_set         => t_set,

    -- Micro signals for the configuration RAMs.
    tsel_mci      => tsel_mci,
    tsel_rd       => tsel_rd,

    -- Thresholds to SUMMER (per harmonic).
    t             => t,

    -- Clocks and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n,
    clk_mc        => clk_mc
  );

----------------------------------------------------------------------------
-- Function:  Split threshold bus into an array.
----------------------------------------------------------------------------
split : for i in 1 to 8 generate
  threshold_s(i) <= t(i*32-1 downto i*32-32);
end generate split;

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
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process

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
    wait for clk_per_c;
  end procedure write_hpsel;

  -- Procedure to read from HPSEL RAM.
  procedure read_hpsel(harmonic : natural range 0 to 15;
                       analysis_run : natural range 0 to 1;
                       seed : natural range 0 to 20;
                       ambiguity : natural range 0 to 10;
                       fop_row : natural range 0 to 127) is
  begin
    hpsel_mci.addr <= std_logic_vector(to_unsigned(
      summer_inst_c*16384 + analysis_run*8192 + seed*256 + ambiguity*16 + harmonic,16));
    hpsel_mci.rden <= '1', '0' after clk_per_c;
    wait for clk_per_c*2;
    check(unsigned(hpsel_rd) = fop_row, "Error: HPSEL read back data is incorrect. Expected "
     & natural'image(fop_row) & ", got " & natural'image(to_integer(unsigned(hpsel_rd)))
     & ".");
  end procedure read_hpsel;

  -- Procedure to write to TSEL RAM.
  procedure write_tsel(harmonic  : natural range 0 to 15;
                       t_set     : natural range 0 to 1;
                       seed      : natural range 0 to 20;
                       threshold : natural) is
  begin
    tsel_mci.addr <= std_logic_vector(to_unsigned(
      summer_inst_c*1024 + t_set*512 + seed*16 + harmonic, 12));
    tsel_mci.wr   <= std_logic_vector(to_unsigned(threshold,32));
    tsel_mci.wren <= '1', '0' after clk_per_c;
    wait for clk_per_c;
  end procedure write_tsel;

  -- Procedure to read from TSEL RAM.
  procedure read_tsel(harmonic  : natural range 0 to 15;
                      t_set     : natural range 0 to 1;
                      seed      : natural range 0 to 20;
                      threshold : natural) is
  begin
    tsel_mci.addr <= std_logic_vector(to_unsigned(
      summer_inst_c*1024 + t_set*512 + seed*16 + harmonic, 12));
    tsel_mci.rden <= '1', '0' after clk_per_c;
    wait for clk_per_c*2;
    check(unsigned(tsel_rd) = threshold, "Error: TSEL read back data is incorrect. Expected "
     & natural'image(threshold) & ", got " & natural'image(to_integer(unsigned(tsel_rd)))
     & ".");
  end procedure read_tsel;

  -- Procedure to check the counters run for the expected time.
  procedure check_run_time(harmonics : natural range 1 to harmonic_g;
                           seeds     : natural range 1 to 21;
                           slopes    : natural range 1 to 11) is
    variable harmonics_v  : natural := 1;
    variable start_time_v : time;
    variable exp_cycles_v : natural;
    variable run_cycles_v : natural;
  begin
    puts("Harmonics = " & natural'image(harmonics) & ", seeds = " & natural'image(seeds) &
      ", Slopes = " & natural'image(slopes));
    new_sum <= '1', '0' after clk_per_c;
    start_time_v := now;
    wait until done_sum = '1';
    wait for clk_per_c/2;
    run_cycles_v := (now - start_time_v)/clk_per_c;
    if harmonics > 1 then
      harmonics_v := harmonics - 1;
    end if;
    exp_cycles_v := (adder_latency_c * harmonics_v) + (seeds * slopes) + 4 + extra_delay_c(harmonic_g-1);
    check(exp_cycles_v = run_cycles_v,
      "Run time is incorrect: expected " & natural'image(exp_cycles_v) & ", got " & natural'image(run_cycles_v));
  end procedure check_run_time;

  variable seed1_v, seed2_v : positive;
  variable rand_v : real;
  variable rand_int_v : integer;

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

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n <= '1';


  -- Initialise RAMs.
  seed1_v := 1;
  seed2_v := 2;
  for harmonic in 0 to harmonic_g-1 loop
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

  puts("RAM Test", header => true);

  -- Check read back from RAMs.
  seed1_v := 1;
  seed2_v := 2;
  for harmonic in 0 to harmonic_g-1 loop
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

  puts("Counter tests", header => true);

  -- Test corner values for config parameters.
  -- First all minimum.
  check_run_time(1,1,1);

  -- Now with all harmonics.
  h <= std_logic_vector(to_unsigned(harmonic_g-1,4));
  wait for clk_per_c;
  check_run_time(harmonic_g,1,1);

  -- Now with 21 seeds.
  h <= "0000";
  p_en <= "10100";
  wait for clk_per_c;
  check_run_time(1,21,1);

  -- Now with 11 ambiguity values.
  h <= "0000";
  p_en <= "00000";
  a <= "1010";
  wait for clk_per_c;
  check_run_time(1,1,11);

  -- Now with 11 ambiguity values & all harmonics.
  h <= std_logic_vector(to_unsigned(harmonic_g-1,4));
  p_en <= "00000";
  a <= "1010";
  wait for clk_per_c;
  check_run_time(harmonic_g,1,11);

  -- Now with 11 ambiguity values & all harmonics * 21 seeds.
  h <= std_logic_vector(to_unsigned(harmonic_g-1,4));
  p_en <= "10100";
  a <= "1010";
  wait for clk_per_c;
  check_run_time(harmonic_g,21,11);

  -- Now mid values on run 2.
  h <= std_logic_vector(to_unsigned(harmonic_g/2,4));
  p_en <= "01010";
  a <= "0101";
  analysis_run <= '1';
  wait for clk_per_c;
  check_run_time(harmonic_g/2+1,11,6);

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

