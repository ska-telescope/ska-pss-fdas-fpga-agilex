----------------------------------------------------------------------------
-- Module Name:  hsumhres_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumhres_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumhres sub-module.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     04/06/19 Generic harmonic_g renamed harmonic_num_g.
--                       Modified for increase to 16 harmonics.
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

architecture stim of hsumhres_tb is

constant clk_per_c : time := 5 ns;

-- Define a constant for the number of results generated by the harmonic being processed.
constant results_c : natural := res_per_h_c(harmonic_num_g);

component hsumhres is
  generic (
    summer_g       : natural range 1 to 3; -- Number of summers.
    harmonic_num_g : natural range 0 to 15  -- Harmonic number.
  );
  port (
    analysis_run  : in  std_logic;                                         -- Run number.
    row_info      : in  std_logic_vector(summer_g*7-1 downto 0);           -- Row number.
    pwr           : in  std_logic_vector (summer_g*res_per_h_c(harmonic_num_g)*32-1 downto 0);  -- Summed power values.
    tc            : in  std_logic_vector (summer_g*res_per_h_c(harmonic_num_g)-1 downto 0);     -- Indicates threshold has been crossed.
    seed_col      : in  std_logic_vector(21 downto 0);                     -- FOP seed column.
    clear_results : in  std_logic;  -- Clears working results store.
    save_results  : in  std_logic;  -- Saves working results to RAM.
    working_page  : in  std_logic;  -- Indicates working page of RAM result store.
    dm_count      : in  std_logic_vector(31 downto 0); -- DM number being processed.
    save_done     : out std_logic;  -- Indicates save of results is complete.

    -- Micro read back of results.
    results       : in  results_out_t;
    results_rd    : out std_logic_vector(31 downto 0);
    exc           : in  exc_out_t;
    exc_rd        : out std_logic_vector(31 downto 0);

    -- Clocks and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic;
    clk_mc        : in  std_logic
  );
end component hsumhres;

signal analysis_run  : std_logic; -- Run number.
signal row_info      : std_logic_vector(summer_g*7-1 downto 0); -- Row number.
signal pwr           : std_logic_vector(summer_g*res_per_h_c(harmonic_num_g)*32-1 downto 0);-- Summed power values.
signal tc            : std_logic_vector(summer_g*res_per_h_c(harmonic_num_g)-1 downto 0); -- Indicates threshold has been crossed.
signal seed_col      : std_logic_vector(21 downto 0); -- FOP seed column.
signal clear_results : std_logic; -- Clears working results store.
signal save_results  : std_logic; -- Saves working results to RAM.
signal working_page  : std_logic; -- Indicates working page of RAM result store.
signal dm_count      : unsigned(31 downto 0); -- DM number being processed.
signal save_done     : std_logic; -- Indictes save of results is complete.
signal results       : results_out_t;
signal results_rd    : std_logic_vector(31 downto 0);
signal exc           : exc_out_t;
signal exc_rd        : std_logic_vector(31 downto 0);

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;
signal clk_mc  : std_logic;

-- Create some array signals for ease of driving.
type pwr_t is array(0 to summer_g*results_c-1) of std_logic_vector(31 downto 0);
signal pwr_s : pwr_t;
type row_info_t is array(0 to summer_g-1) of std_logic_vector(6 downto 0);
signal row_info_s : row_info_t;

shared variable testbench_failed : boolean := false;

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

begin

dut : hsumhres
  generic map (
    summer_g       => summer_g,
    harmonic_num_g => harmonic_num_g
  )
  port map (
    analysis_run  => analysis_run,
    row_info      => row_info,
    pwr           => pwr,
    tc            => tc,
    seed_col      => seed_col,
    clear_results => clear_results,
    save_results  => save_results,
    working_page  => working_page,
    dm_count      => std_logic_vector(dm_count),
    save_done     => save_done,

    -- Micro read back of results.
    results       => results,
    results_rd    => results_rd,
    exc           => exc,
    exc_rd        => exc_rd,

    -- Clocks and reset.
    clk_sys       => clk_sys,
    rst_sys_n     => rst_sys_n,
    clk_mc        => clk_mc
  );

-- Connect array signals to vectors.
g1 : for s in 0 to summer_g-1 generate
  row : row_info(s*7+6 downto s*7) <= row_info_s(s);
  g2 : for r in 0 to results_c-1 generate
    pow : pwr((s*results_c + r)*32+31  downto (s*results_c + r)*32) <= pwr_s(s*results_c + r);
  end generate g2;
end generate g1;

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
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process
  variable input_v : natural;
  variable summer_v : natural;
  variable results_v : natural;
  variable readdata_v : std_logic_vector(31 downto 0);

  -- Procedure to check values and output message if they don't match.
  procedure check(expected : natural;
                  actual   : std_logic_vector;
                  msg      : string) is
    variable actual_v : natural := to_integer(unsigned(actual));
  begin
    if actual_v /= expected then
      puts("ERROR: " & msg & ", expected " & natural'image(expected) & ", got " &
        natural'image(actual_v));
      testbench_failed := true;
    end if;
  end procedure check;

  -- Procedure to read result.
  procedure read_result(
    run      : natural range 0 to 1;
    result   : natural range 0 to 24;
    harmonic : natural range 0 to 15;
    offset   : natural range 0 to 3
  ) is
    variable addr_v : natural;
    variable result_v : std_logic_vector(63 downto 0);
  begin
    addr_v := run*2048 + harmonic*128 + result*4 + offset;
    results.addr <= std_logic_vector(to_unsigned(addr_v, 16));
    results.rden <= '1', '0' after clk_per_c;
    wait for clk_per_c;
    readdata_v := results_rd;
  end procedure read_result;

  -- Procedure to read exceeded report.
  procedure read_exceed(
    run      : natural range 0 to 1;
    harmonic : natural range 0 to 15;
    offset   : natural range 0 to 3
  ) is
    variable addr_v : natural;
  begin
    exc.addr <= (others => '0');
    if run = 1 then
      exc.addr(6) <= '1';
    end if;
    exc.addr(5 downto 2) <= std_logic_vector(to_unsigned(harmonic,4));
    exc.addr(1 downto 0) <= std_logic_vector(to_unsigned(offset, 2));
    exc.rden <= '1', '0' after clk_per_c;
    wait for clk_per_c;
    readdata_v := exc_rd;
  end procedure read_exceed;


  -- Procedure to check the stored results.
  procedure check_store(
    run      : natural range 0 to 1;
    result   : natural range 0 to 24;
    pwr      : natural;
    row      : natural range 0 to 127;
    col      : natural range 0 to 4194303;
    harmonic : natural range 0 to 15;
    valid    : natural := 1
  ) is
    variable addr_v : natural;
  begin
    read_result(run, result, harmonic, 0);
    check(valid*256 + harmonic, readdata_v, "VALID/HARMONIC incorrect for result #" & natural'image(result));
    if valid = 1 then
      read_result(run, result, harmonic, 1);
      check(col , readdata_v, "FOPCOL incorrect for result #" & natural'image(result));
      read_result(run, result, harmonic, 2);
      check(row, readdata_v, "FOPROW incorrect for result #" & natural'image(result));
      read_result(run, result, harmonic, 3);
      check(pwr, readdata_v, "PWR incorrect for result #" & natural'image(result));
    end if;
  end procedure check_store;

  -- Procedure to check the overflow results.
  procedure check_overflow(
    run      : natural range 0 to 1;
    t        : natural;
    p        : natural range 0 to 127;
    s        : natural range 0 to 4194303;
    harmonic : natural range 0 to 15
  ) is
  begin
    read_exceed(run, harmonic, 0);
    check(t, readdata_v, "T_EXC incorrect");
    if t > 0 then
      read_exceed(run, harmonic, 2);
      check(p, readdata_v, "P_EXC incorrect");
      read_exceed(run, harmonic, 1);
      check(s, readdata_v, "S_EXC incorrect");
    end if;
  end procedure check_overflow;

begin
  -- Initialise input.
  analysis_run  <= '0';
  row_info_s    <= (others => (others => '0'));
  pwr_s         <= (others => (others => '0'));
  tc            <= (others => '0');
  seed_col      <= (others => '0');
  clear_results <= '0';
  save_results  <= '0';
  working_page  <= '0';
  rst_sys_n     <= '0';
  results       <= results_out_init_c;
  exc           <= exc_out_init_c;

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n <= '1';


  puts("Test 1: Store 30 results one at a time.", true);
  input_v := 0;
  summer_v := 0;
  seed_col <= std_logic_vector(to_unsigned(100,22));
  for i in 1 to 30 loop
    pwr_s(input_v) <= std_logic_vector(to_unsigned(i*10, 32));
    row_info_s(summer_v) <= std_logic_vector(to_unsigned(i+summer_v*30,7));
    tc(input_v) <= '1', '0' after clk_per_c;
    if i mod 10 = 0 then
      wait for clk_per_c;
    end if;
    wait for clk_per_c;
    pwr_s(input_v) <= (others => '0');
    row_info_s(summer_v) <= (others => '0');
    input_v := input_v + 1;
    if input_v mod results_c = 0 then
      summer_v := summer_v + 1;
      if summer_v >= summer_g then
        input_v := 0;
        summer_v := 0;
      end if;
    end if;
  end loop;
  wait for clk_per_c*2;

  -- Save results and check.
  save_results <= '1', '0' after clk_per_c;
  while save_done = '0' loop
    wait for clk_per_c;
  end loop;
  working_page <= not working_page;
  input_v := 0;
  summer_v := 0;
  for i in 1 to 25 loop
    check_store(
      run      => 0,
      result   => i-1,
      pwr      => i*10,
      row      => i + summer_v*30,
      col      => to_integer(unsigned(seed_col))*(harmonic_num_g+1) + input_v - res_per_h_c(harmonic_num_g)/2,
      harmonic => harmonic_num_g
    );
    input_v := input_v + 1;
    if input_v >= results_c then
      input_v := 0;
      summer_v := summer_v + 1;
      if summer_v >= summer_g then
        summer_v := 0;
      end if;
    end if;
  end loop;
  check_overflow(
    run      => 0,
    t        => 5,
    p        => 26+summer_v*30,
    s        => to_integer(unsigned(seed_col)),
    harmonic => harmonic_num_g
  );


  -- Clear results.
  clear_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*2;

  puts("Test 2: Store at least 30 results using as many inputs as possible.", true);
  input_v := 0;
  summer_v := 0;
  results_v := 1;
  seed_col <= std_logic_vector(to_unsigned(1234,22));
  analysis_run <= '1';
  for s in 0 to summer_g-1 loop
    row_info_s(s) <= std_logic_vector(to_unsigned(s*11,7));
  end loop;
  while results_v < 30 loop
    for i in 0 to summer_g*results_c-1 loop
      pwr_s(i) <= std_logic_vector(to_unsigned(results_v*9, 32));
      results_v := results_v + 1;
    end loop;
    tc <= (others => '1'), (others => '0') after clk_per_c;
    wait for clk_per_c;
  end loop;
  wait for clk_per_c*2;

  -- Save results and check.
  save_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*55;
  working_page <= not working_page;
  wait for clk_per_c;
  for i in 0 to 24 loop
    check_store(
      run      => 1,
      result   => i,
      pwr      => (i+1)*9,
      row      => ((i / results_c) mod summer_g) * 11,
      col      => to_integer(unsigned(seed_col))*(harmonic_num_g+1) + (i mod results_c)  - results_c/2,
      harmonic => harmonic_num_g
    );
  end loop;
  check_overflow(
    run      => 1,
    t        => results_v - 26,
    p        => ((25 / results_c) mod summer_g) * 11,
    s        => to_integer(unsigned(seed_col)),
    harmonic => harmonic_num_g
  );

  -- Clear results.
  clear_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*2;

  puts("Test 3: Store 2 results using the highest input only.", true);
  input_v := results_c-1;
  summer_v := input_v / results_c;
  seed_col <= std_logic_vector(to_unsigned(243816,22));
  analysis_run <= '0';
  for i in 1 to 2 loop
    pwr_s(input_v) <= std_logic_vector(to_unsigned(i*37, 32));
    row_info_s(summer_v) <= std_logic_vector(to_unsigned(i*19,7));
    tc(input_v) <= '1', '0' after clk_per_c;
    wait for clk_per_c;
  end loop;
  wait for clk_per_c*2;

  -- Save results and check.
  save_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*55;
  working_page <= not working_page;
  wait for clk_per_c;
  for i in 1 to 2 loop
    check_store(
      run      => 0,
      result   => i-1,
      pwr      => i*37,
      row      => i*19,
      col      => to_integer(unsigned(seed_col))*(harmonic_num_g+1) + input_v - results_c/2,
      harmonic => harmonic_num_g
    );
  end loop;
  for i in 3 to 25 loop
    check_store(
      run      => 0,
      result   => i-1,
      pwr      => 0,
      row      => 0,
      col      => 0,
      harmonic => harmonic_num_g,
      valid    => 0
    );
  end loop;
  check_overflow(
    run      => 0,
    t        => 0,
    p        => 0,
    s        => 0,
    harmonic => harmonic_num_g
  );

  -- Clear results.
  clear_results <= '1', '0' after clk_per_c;
  wait for clk_per_c*2;

  if testbench_failed then
    puts("!!! FAILED !!!", true);
  else
    puts("*** PASSED ***", true);
  end if;

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

