----------------------------------------------------------------------------
-- Module Name:  hsumfilt_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumfilt_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumfilt sub-module.
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

library hsum_lib;
use     hsum_lib.hsummci_pkg.all;
use     hsum_lib.hsum_pkg.all;

architecture stim of hsumfilt_tb is

constant clk_per_c : time := 5 ns;
constant adder_latency_c : natural range 1 to 7 := 2;

component hsumfilt is
  generic (
    adder_latency_g : natural range 1 to 7;           -- Latency of IEEE-754 adder function.
    harmonic_g      : natural range 8 to 16 := 8
  );
  port (
    -- Configuration.
    h             : in  std_logic_vector(3 downto 0); -- Number of harmonics to process.
    a             : in  std_logic_vector(3 downto 0); -- Number of orbital acceleration ambiguity slopes to process.
    t_filter_en   : in  std_logic; -- Filter enable.

    -- Inputs from SUMMER.
    tc_in         : in     std_logic_vector (last_column_c(harmonic_g-1)-1 downto 0);
    pwr_in        : in     std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);
    row_info_in   : in     std_logic_vector (harmonic_g*7-1 downto 0);
    last_result   : in  std_logic;

    -- Inputs from TGEN.
    seed_col      : in     std_logic_vector (21 downto 0);
    clear_results : in  std_logic; -- Initialise filter.

    -- Outputs to result store.
    tc_out        : out    std_logic_vector (last_column_c(harmonic_g-1)-1 downto 0);
    pwr_out       : out    std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);
    row_info_out  : out    std_logic_vector (harmonic_g*7-1 downto 0);
    seed_col_out  : out std_logic_vector (21 downto 0);

    -- Clock and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic
  );
end component hsumfilt;

signal h : std_logic_vector(3 downto 0); -- Number of harmonics to process.
signal a : std_logic_vector(3 downto 0); -- Number of orbital acceleration ambiguity slopes to process.
signal t_filter_en : std_logic; -- Filter enable.

signal tc_in : std_logic_vector(last_column_c(harmonic_g-1)-1 downto 0);
signal pwr_in : std_logic_vector(last_column_c(harmonic_g-1)*32-1 downto 0);
signal row_info_in : std_logic_vector(harmonic_g*7-1 downto 0);
signal last_result : std_logic;

signal seed_col : std_logic_vector(21 downto 0);
signal clear_results : std_logic; -- Initialise filter.

signal tc_out : std_logic_vector(last_column_c(harmonic_g-1)-1 downto 0);
signal pwr_out : std_logic_vector(last_column_c(harmonic_g-1)*32-1 downto 0);
signal row_info_out : std_logic_vector(harmonic_g*7-1 downto 0);
signal seed_col_out : std_logic_vector(21 downto 0);

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;

-- Create some array signals for ease of driving.
type pwr_t is array(0 to last_column_c(harmonic_g-1)-1) of std_logic_vector(31 downto 0);
signal pwr_in_s, pwr_out_s : pwr_t;
type row_info_t is array(0 to harmonic_g-1) of std_logic_vector(6 downto 0);
signal row_info_in_s, row_info_out_s : row_info_t;

type slope_t is record
  tc : std_logic_vector(last_column_c(harmonic_g-1)-1 downto 0);
  pwr : pwr_t;
  row : row_info_t;
end record slope_t;
type slope_array_t is array(natural range <>) of slope_t;

-- Monitor signals.
signal expected_s : slope_array_t(0 to 15);
signal num_expected_s : natural range 1 to 16;
signal check_en_s : std_logic;

shared variable testbench_failed : boolean := false;

----------------------------------------------------------------------------
-- Procedures:
----------------------------------------------------------------------------
-- Procedure to output a message.
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

-- Procedure to check values and output message if they don't match.
procedure check(good : boolean;
                msg  : string) is
begin
  if not good then
    puts("ERROR: " & msg);
    testbench_failed := true;
  end if;
end procedure check;

-- Procedure to check the stored results.
procedure check_result (
  tc  : std_logic_vector(last_column_c(harmonic_g-1)-1 downto 0);
  pwr : pwr_t;
  row : row_info_t) is
begin
  for i in 0 to last_column_c(harmonic_g-1)-1 loop
    check(tc_out(i) = tc(i), "TC(" & natural'image(i) & ") is incorrect!");
    if tc(i) = '1' then
      check(pwr_out_s(i) = pwr(i), "PWR(" & natural'image(i) & ") is incorrect!");
    end if;
  end loop;
  for i in 0 to harmonic_g-1 loop
    if unsigned(tc(last_column_c(i)-1 downto first_res_c(i))) > 0 then
      check(row_info_out_s(i) = row(i), "ROW_INFO(" & natural'image(i) & ") is incorrect!");
    end if;
  end loop;
end procedure check_result;

begin

dut : hsumfilt
  generic map (
    adder_latency_g => adder_latency_c,
    harmonic_g      => harmonic_g
  )
  port map (
    -- Configuration.
    h             => h,
    a             => a,
    t_filter_en   => t_filter_en,

    -- Inputs from SUMMER.
    tc_in         => tc_in,
    pwr_in        => pwr_in,
    row_info_in   => row_info_in,
    last_result   => last_result,

    -- Inputs from TGEN.
    seed_col      => seed_col,
    clear_results => clear_results,

    -- Outputs to result store.
    tc_out        => tc_out,
    pwr_out       => pwr_out,
    row_info_out  => row_info_out,
    seed_col_out  => seed_col_out,

    -- Clocks and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n
  );

-- Connect array signals to vectors.
g1 : for h in 0 to harmonic_g-1 generate
  rowi : row_info_in(h*7+6 downto h*7) <= row_info_in_s(h);
  rowo : row_info_out_s(h) <= row_info_out(h*7+6 downto h*7);
end generate g1;
g2 : for r in 0 to last_column_c(harmonic_g-1)-1 generate
  powi : pwr_in(r*32+31  downto r*32) <= pwr_in_s(r);
  powo : pwr_out_s(r) <= pwr_out(r*32+31  downto r*32);
end generate g2;

----------------------------------------------------------------------------
-- Function:  Clock generator.
----------------------------------------------------------------------------
clk_gen_p : process
begin
  clk_sys <= '0', '1' after clk_per_c/2;
  wait for clk_per_c;
end process clk_gen_p;

----------------------------------------------------------------------------
-- Function:  Output Monitor.
----------------------------------------------------------------------------
monitor : process
  variable count_v : natural;
  variable last_check_en_v : std_logic;
begin
  wait until falling_edge(clk_sys);

  if check_en_s = '1' then
    if last_check_en_v = '0' then
      count_v := 0;
    end if;
    if tc_out /= (0 to last_column_c(harmonic_g-1)-1 => '0') then
      if count_v < num_expected_s then
        check_result(expected_s(count_v).tc, expected_s(count_v).pwr,expected_s(count_v).row);
        count_v := count_v + 1;
        check(seed_col_out = seed_col, "Seed column is incorrect!");
      else
        check(false, "Too many results output!");
      end if;
    end if;
  else
    if last_check_en_v = '1' then
      check(count_v >= num_expected_s, "Too few results output!");
    end if;
    check(tc_out = (0 to last_column_c(harmonic_g-1)-1 => '0'), "Result detected outside of checking period!");
  end if;

  last_check_en_v := check_en_s;

end process monitor;

----------------------------------------------------------------------------
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process
  variable slope_results_v : slope_array_t(0 to 10);

  -- Procedure to generate the output from the SUMMER block.
  procedure gen_results(
    harmonics : natural range 0 to 15;
    slopes    : natural range 0 to 10;
    last      : integer range -1 to 15 := -1
  ) is
    variable delay_v : time; -- Delay for signal change.
  begin
    for s in 0 to slopes loop
      for h in 0 to harmonics loop
        delay_v := clk_per_c*(s+adder_latency_c*h + extra_delay_c(h));
        for i in first_res_c(h) to last_column_c(h)-1 loop
          tc_in(i)    <= transport slope_results_v(s).tc(i) after delay_v, '0' after delay_v + clk_per_c - 1 ns;
          pwr_in_s(i) <= transport slope_results_v(s).pwr(i) after delay_v;
        end loop;
        row_info_in_s(h) <= transport slope_results_v(s).row(h) after delay_v;
      end loop;
    end loop;
    if last = -1 then
      -- Generate last_result in the correct place.
      delay_v := clk_per_c*(slopes + adder_latency_c*harmonics + extra_delay_c(harmonics));
    else
      -- Generate last_result in the specified place.
      delay_v := clk_per_c*(slopes + adder_latency_c*last + extra_delay_c(last));
    end if;
    last_result <= '1' after delay_v, '0' after delay_v + clk_per_c;
  end procedure gen_results;

begin
  -- Initialise inputs.
  h             <= std_logic_vector(to_unsigned(harmonic_g-1,4));
  a             <= "0000"; -- 1 slope.
  t_filter_en   <= '0';
  row_info_in_s <= (others => (others => '0'));
  pwr_in_s      <= (others => (others => '0'));
  tc_in         <= (others => '0');
  seed_col      <= (others => '0');
  clear_results <= '0';
  last_result   <= '0';
  rst_sys_n     <= '0';
  check_en_s    <= '0';

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n <= '1';


  slope_results_v := (others => ((others => '0'), (others => (others => '0')), (others => (others => '0'))));

  --------------------------------------------------------------------------
  puts("Filter disabled tests", true);

  -- Send in one slope worth of results. They should all be detected.
  -- At least one active result per harmonic.
  for i in 0 to last_column_c(harmonic_g-1)-1 loop
    slope_results_v(0).pwr(i) := std_logic_vector(to_unsigned(i+1,32));
  end loop;
  for i in 0 to harmonic_g-1 loop
    slope_results_v(0).row(i) := std_logic_vector(to_unsigned(i+40,7));
  end loop;
  slope_results_v(0).tc := (others => '0');
  for h in 0 to harmonic_g-1 loop
    slope_results_v(0).tc(last_column_c(h)-1 downto first_res_c(h)) :=
      std_logic_vector(to_unsigned(last_column_c(h),last_column_c(h) - first_res_c(h)));
  end loop;
  num_expected_s <= harmonic_g;
  for h in 0 to harmonic_g-1 loop
    expected_s(h).tc <= (others => '0');
    expected_s(h).tc(last_column_c(h)-1 downto first_res_c(h)) <= slope_results_v(0).tc(last_column_c(h)-1 downto first_res_c(h));
    for i in first_res_c(h) to last_column_c(h)-1 loop
      expected_s(h).pwr(i) <= std_logic_vector(to_unsigned(i+1, 32));
    end loop;
    expected_s(h).row(h) <= std_logic_vector(to_unsigned(h+40,7));
  end loop;

  check_en_s <= '1';
  gen_results(harmonic_g-1, 0);
  seed_col <= std_logic_vector(to_unsigned(45, 22));
  wait for clk_per_c*harmonic_g*4;
  check_en_s <= '0';

  wait for clk_per_c*10;

  --------------------------------------------------------------------------
  puts("Filter stage 1 tests", true);

  -- Send in one slope worth of results, same as above.
  -- Only highest harmonic results should be seen.
  expected_s <= (others => ((others => '0'), (others => (others => '0')), (others => (others => '0'))));
  expected_s(0).tc(last_column_c(harmonic_g-1)-1 downto first_res_c(harmonic_g-1)) <=
    slope_results_v(0).tc(last_column_c(harmonic_g-1)-1 downto first_res_c(harmonic_g-1));
  for i in first_res_c(harmonic_g-1) to last_column_c(harmonic_g-1)-1 loop
    expected_s(0).pwr(i) <= std_logic_vector(to_unsigned(i+1, 32));
  end loop;
  expected_s(0).row(harmonic_g-1) <= std_logic_vector(to_unsigned(harmonic_g+39,7));
  num_expected_s <= 1;

  clear_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*2;
  t_filter_en   <= '1';

  check_en_s <= '1';
  gen_results(harmonic_g-1, 0);
  seed_col <= std_logic_vector(to_unsigned(12345, 22));
  wait for clk_per_c*(harmonic_g*2 + 4 + extra_delay_c(harmonic_g-1));
  check_en_s <= '0';

  wait for clk_per_c*10;

  puts("Selection");
  -- Send in the same data, but change h input.
  -- Check that the correct harmonic stage is selected.
  for i in harmonic_g-2 downto 0 loop
    h <= std_logic_vector(to_unsigned(i, 4));
    expected_s(0).tc <= (others => '0');
    expected_s(0).tc(last_column_c(i)-1 downto first_res_c(i)) <= slope_results_v(0).tc(last_column_c(i)-1 downto first_res_c(i));
    expected_s(0).pwr <= (others => (others => '0'));
    expected_s(0).row <= (others => (others => '0'));
    for j in first_res_c(i) to last_column_c(i)-1 loop
      expected_s(0).pwr(j) <= std_logic_vector(to_unsigned(j+1, 32));
    end loop;
    expected_s(0).row(i) <= std_logic_vector(to_unsigned(40+i,7));

    clear_results <= '1', '0' after clk_per_c;
    wait for clk_per_c*2;
    check_en_s <= '1';
    gen_results(harmonic_g-1, 0, i);
    seed_col <= (others => '1');
    wait for clk_per_c*(harmonic_g*2 + 4 + extra_delay_c(harmonic_g-1));
    check_en_s <= '0';
    wait for clk_per_c*10;
  end loop;

  puts("Propagation");
  -- Generate a result at only one harmonic stage for each slope run and check it
  -- propagates through.
  h <= std_logic_vector(to_unsigned(harmonic_g-1,4));
  for h in 0 to harmonic_g-1 loop
    puts("  " & natural'image(h));
    slope_results_v(0).tc := (others => '0');
    slope_results_v(0).tc(last_column_c(h)-1 downto first_res_c(h)) := (others => '1');
    slope_results_v(0).pwr := (others => (others => '0'));
    for i in last_column_c(h)-1 downto first_res_c(h) loop
      slope_results_v(0).pwr(i) := std_logic_vector(unsigned'(X"FF000000") + i);
    end loop;
    slope_results_v(0).row := (others => (others => '0'));
    slope_results_v(0).row(h) := std_logic_vector(to_unsigned(127-h,7));

    expected_s(0) <= slope_results_v(0);

    clear_results <= '1', '0' after clk_per_c;
    wait for clk_per_c*2;
    check_en_s <= '1';
    gen_results(harmonic_g-1, 0);
    seed_col <= std_logic_vector(to_unsigned(4000000, 22));
    wait for clk_per_c*(harmonic_g*2 + 4 + extra_delay_c(harmonic_g-1));
    check_en_s <= '0';
    wait for clk_per_c*10;

    -- Check each higher harmonic can override it.
    for hh in h+1 to harmonic_g-1 loop
      puts("    " & natural'image(hh));
      slope_results_v(0).tc(first_res_c(hh)) := '1';
      slope_results_v(0).pwr(first_res_c(hh)) := X"AAAAAAAA";
      slope_results_v(0).row(hh) := "1010101";
      expected_s(0) <= slope_results_v(0);
      expected_s(0).tc(first_res_c(hh)-1 downto 0) <= (others => '0');

      clear_results <= '1', '0' after clk_per_c;
      wait for clk_per_c*2;
      check_en_s <= '1';
      gen_results(harmonic_g-1, 0);
      seed_col <= std_logic_vector(to_unsigned(hh, 22));
      wait for clk_per_c*(harmonic_g*2 + 4 + extra_delay_c(harmonic_g-1));
      check_en_s <= '0';
      wait for clk_per_c*10;

    end loop;

  end loop;

  --------------------------------------------------------------------------
  puts("Filter stage 2 tests", true);
  -- Enable all slopes.
  a <= "1010"; -- 10 = 11 slopes.

  -- Set unique data in all pwr/row values.
  for s in 0 to 10 loop
    for p in 0 to last_column_c(harmonic_g-1)-1 loop
      slope_results_v(s).pwr(p) := std_logic_vector(to_unsigned(s*1000+p*54,32));
    end loop;
    for h in 0 to harmonic_g-1 loop
      slope_results_v(s).row(h) := std_logic_vector(to_unsigned(s*7+h*3, 7));
    end loop;
    slope_results_v(s).tc := (others => '0');
  end loop;
  -- Enable one result for one harmonic of each slope.
  for s in 0 to 10 loop
    slope_results_v(s).tc(first_res_c(s mod harmonic_g)) := '1';
  end loop;

  if harmonic_g < 12 then
    expected_s(0)  <= slope_results_v(harmonic_g-1);
  else
    expected_s(0)  <= slope_results_v(10);
  end if;

  num_expected_s <= 1;

  clear_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*2;
  check_en_s <= '1';
  gen_results(harmonic_g-1, 10);
  seed_col <= std_logic_vector(to_unsigned(9999, 22));
  wait for clk_per_c*(harmonic_g*2 +24 + extra_delay_c(harmonic_g-1));
  check_en_s <= '0';
  wait for clk_per_c*10;

  -- Create a slope run with all results with the same harmonic level.
  -- Check we can get 11 results through.
  -- Repeat for each harmonic.
  puts("11 results");
  num_expected_s <= 11;
  for h in 0 to harmonic_g-1 loop
    puts("  " & natural'image(h));
    for s in 0 to 10 loop
      slope_results_v(s).tc := (others => '0');
      slope_results_v(s).tc(last_column_c(h)-1) := '1';
      expected_s(s) <= slope_results_v(s);
    end loop;

    check_en_s <= '1';
    gen_results(harmonic_g-1, 10);
    seed_col <= std_logic_vector(to_unsigned(h, 22));
    wait for clk_per_c*(harmonic_g*2 +24 + extra_delay_c(harmonic_g-1));
    check_en_s <= '0';
    wait for clk_per_c*10;

  end loop;

  -- Check first result of slope is passed.
  puts("first result");
  for s in 0 to 10 loop
    slope_results_v(s).tc := (others => '0');
    expected_s(s).tc      <= (others => '0');
  end loop;
  slope_results_v(0).tc(0) := '1';
  num_expected_s <= 1;
  expected_s(0) <= slope_results_v(0);

  check_en_s <= '1';
  gen_results(harmonic_g-1, 10);
  seed_col <= std_logic_vector(to_unsigned(1, 22));
  wait for clk_per_c*(harmonic_g*2 +24 + extra_delay_c(harmonic_g-1));
  check_en_s <= '0';
  wait for clk_per_c*10;

  -- Check last result of slope is passed.
  puts("last result");
  for s in 0 to 10 loop
    slope_results_v(s).tc := (others => '0');
    expected_s(s).tc      <= (others => '0');
  end loop;
  slope_results_v(10).tc(last_column_c(harmonic_g-1)-1) := '1';
  num_expected_s <= 1;
  expected_s(0) <= slope_results_v(10);

  check_en_s <= '1';
  gen_results(harmonic_g-1, 10);
  seed_col <= std_logic_vector(to_unsigned(2, 22));
  wait for clk_per_c*(harmonic_g*2 +24 + extra_delay_c(harmonic_g-1));
  check_en_s <= '0';
  wait for clk_per_c*10;


  if testbench_failed then
    puts("!!! FAILED !!!", true);
  else
    puts("*** PASSED ***", true);
  end if;

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

