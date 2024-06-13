----------------------------------------------------------------------------
-- Module Name:  hsumtgen_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumtgen_tb_stim.vhd
--
-- Functional Description:
--
-- Testbench for hsumtgen sub-module.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     15/04/19 Updated for increase of up to 16 harmonics.
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

architecture stim of hsumtgen_tb is

constant clk_per_c : time := 5 ns;
constant summer_c  : natural range 1 to 3 := 1;
constant req_cycles_c : natural := 20;
constant read_cycles_c : natural := 30;

component hsumtgen is
  generic (
    summer_g : natural range 1 to 3;       -- Number of SUMMER modules instantiated.
    adder_latency_g : natural range 1 to 7 -- Latency of IEEE-754 adder function.
  );
  port (
    -- Control and configuation inputs.
    hsum_trigger  : in  std_logic;                     -- Triggers processing a new FOP.
    hsum_enable   : in  std_logic;                     -- Allows processing to be paused.
    a_set         : in  std_logic;                     -- Indicates number of analysis runs to perform.
    b_start_1     : in  std_logic_vector(21 downto 0); -- FOP start column (run 1).
    b_stop_1      : in  std_logic_vector(21 downto 0); -- FOP stop column (run 1).
    b_start_2     : in  std_logic_vector(21 downto 0); -- FOP start column (run 2).
    b_stop_2      : in  std_logic_vector(21 downto 0); -- FOP stop column (run 2).
    h_1           : in  std_logic_vector(3 downto 0);  -- Number of harmonics to process (run 1).
    h_2           : in  std_logic_vector(3 downto 0);  -- Number of harmonics to process (run 2).
    a_1           : in  vector_4_array_t(0 to summer_g-1);  -- Number of orbital acceleration ambiguity slopes to process (run 1).
    a_2           : in  vector_4_array_t(0 to summer_g-1);  -- Number of orbital acceleration ambiguity slopes to process (run 2).
    p_en_1        : in  vector_5_array_t(0 to summer_g-1);  -- Number of orbital acceleration values to process (run 1).
    p_en_2        : in  vector_5_array_t(0 to summer_g-1);  -- Number of orbital acceleration values to process (run 2).
    fop_row_1     : in  std_logic_vector (6 downto 0); -- Number of FOP rows to read from DDR (run 1).
    fop_row_2     : in  std_logic_vector (6 downto 0); -- Number of FOP rows to read from DDR (run 2).
    thresh_set    : in  std_logic_vector(21 downto 0); -- Column at which to swap threshold sets.
    t_filter_en   : in  std_logic;                     -- Result filter enable.

    -- Selected configuration.
    h             : out std_logic_vector(3 downto 0);  -- Number of harmonics to process for current run.
    a             : out vector_4_array_t(0 to summer_g-1); -- Number of orbital slopes for current run.  
    p_en          : out vector_5_array_t(0 to summer_g-1); -- Number of orbital acceleration values for current run.
    fop_row       : out std_logic_vector (6 downto 0);     -- Number of FOP rows to read from DDR for current run.

    -- Sub-block done signals.
    done_req      : in  std_logic;                     -- DDRIN has finished requesting FOP data.
    done_read     : in  std_logic;                     -- DDRIN has finished loading FOP data.
    done_sum      : in  std_logic_vector(summer_g-1 downto 0); -- SUMMER has completed processing FOP.

    -- Control to DDRIN.
    new_col       : out std_logic;                      -- Starts reading a new set of columns.
    ddrin_rd_page : out std_logic_vector (1 downto 0);  -- RAM page to use when SUMMER is reading FOP data.
    seed_col_read : out std_logic_vector (21 downto 0); -- First column of a set to read.

    -- Control to SUMMER.
    new_sum       : out std_logic;                     -- Starts a summing run.
    seed_col_sum  : out std_logic_vector (21 downto 0);-- First column of a set being summed.
    t_set         : out std_logic;                     -- Threshold set to use.

    -- Control to DDRIN, SUMMER and TREP.
    analysis_run  : out std_logic;                     -- Indicates run 1 or run 2.

    -- Control to/from TREP.
    clear_results : out std_logic;                     -- Indicates to clear results at start of run.
    save_results  : out std_logic;                     -- Indicates to store results at end of analysis run.
    save_done     : in  std_logic;                     -- Indicates saving of results is complete.
    triggered     : out std_logic;                     -- Indicates rising edge on hsum_trigger input.

    -- Response to high level.
    hsum_done     : out std_logic;                     -- Analysis run(s) complete.

    -- Clock and reset.
    clk_sys       : in  std_logic;
    rst_sys_n     : in  std_logic
  );
end component hsumtgen;

-- Control and configuation inputs.
signal hsum_trigger : std_logic; -- Triggers processing a new FOP.
signal hsum_enable : std_logic; -- Allows processing to be paused.
signal a_set : std_logic; -- Indicates number of analysis runs to perform.
signal b_start_1 : std_logic_vector(21 downto 0); -- FOP start column (run 1).
signal b_stop_1 : std_logic_vector(21 downto 0); -- FOP stop column (run 1).
signal b_start_2 : std_logic_vector(21 downto 0); -- FOP start column (run 2).
signal b_stop_2 : std_logic_vector(21 downto 0); -- FOP stop column (run 2).
signal h_1 : std_logic_vector(3 downto 0); -- Number of harmonics to process (run 1).
signal h_2 : std_logic_vector(3 downto 0); -- Number of harmonics to process (run 2).
signal a_1 : vector_4_array_t(0 to summer_c-1); -- Number of orbital acceleration ambiguity slopes to process (run 1).
signal a_2 : vector_4_array_t(0 to summer_c-1); -- Number of orbital acceleration ambiguity slopes to process (run 2).
signal p_en_1 : vector_5_array_t(0 to summer_c-1); -- Number of orbital acceleration values to process (run 1).
signal p_en_2 : vector_5_array_t(0 to summer_c-1); -- Number of orbital acceleration values to process (run 2).
signal fop_row_1 : std_logic_vector(6 downto 0); -- Number of FOP rows to read from DDR (run 1).
signal fop_row_2 : std_logic_vector(6 downto 0); -- Number of FOP rows to read from DDR (run 2).
signal fop_row : std_logic_vector(6 downto 0); -- Number of FOP rows to read from DDR for current run.
signal thresh_set : std_logic_vector(21 downto 0); -- Column at which to swap threshold sets.
signal t_filter_en : std_logic; -- Result filter enable.

-- Sub-block done signals.
signal done_req : std_logic; -- DDRIN has finished requesting from DDR.
signal done_read : std_logic; -- DDRIN has finished loading FOP data.
signal done_sum : std_logic_vector(summer_c-1 downto 0); -- SUMMER has completed processing FOP.

-- Control to DDRIN.
signal new_col : std_logic; -- Starts reading a new set of columns.
signal ddrin_rd_page : std_logic_vector (1 downto 0); -- RAM page to use when SUMMER is reading FOP data.
signal seed_col_read : std_logic_vector (21 downto 0); -- First column of a set to read.

-- Control to SUMMER.
signal new_sum : std_logic; -- Starts a summing run.
signal seed_col_sum : std_logic_vector (21 downto 0);-- First column of a set being summed.
signal t_set : std_logic; -- Threshold set to use.

-- Control to DDRIN, SUMMER and TREP.
signal analysis_run : std_logic; -- Indicates run 1 or run 2.

-- Control to/from TREP.
signal clear_results : std_logic; -- Indicates to clear results at start of run.
signal save_results : std_logic; -- Indicates to store results at end of analysis run.
signal save_done : std_logic := '0'; -- Indicates saving of results is complete.
signal triggered : std_logic; -- Indicates rising edge on hsum_trigger input.


-- Response to high level.
signal hsum_done : std_logic; -- Analysis run(s) complete.

-- Clock and reset.
signal clk_sys : std_logic;
signal rst_sys_n : std_logic;

----------------------------------------------------------------------------
-- Procedure to output a message.
----------------------------------------------------------------------------
procedure puts(msg : string) is
  variable l : line;
begin
  write(l, now, right, 12, ns);
  write(l, ' ');
  write(l, msg);
  writeline(output, l);
end procedure puts;

begin

dut : hsumtgen
  generic map(
    summer_g        => summer_c,
    adder_latency_g => 2
  )
  port map (
    -- Control and configuation inputs.
    hsum_trigger  => hsum_trigger,
    hsum_enable   => hsum_enable,
    a_set         => a_set,
    b_start_1     => b_start_1,
    b_stop_1      => b_stop_1,
    b_start_2     => b_start_2,
    b_stop_2      => b_stop_2,
    h_1           => h_1,
    h_2           => h_2,
    a_1           => a_1,
    a_2           => a_2,
    p_en_1        => p_en_1,
    p_en_2        => p_en_2,
    fop_row_1     => fop_row_1,
    fop_row_2     => fop_row_2,
    thresh_set    => thresh_set,
    t_filter_en   => t_filter_en,

    -- Sub-block done signals.
    done_req      => done_req,
    done_read     => done_read,
    done_sum      => done_sum,

    -- Control to DDRIN.
    new_col       => new_col,
    fop_row       => fop_row,
    ddrin_rd_page => ddrin_rd_page,
    seed_col_read => seed_col_read,

    -- Control to SUMMER.
    new_sum       => new_sum,
    t_set         => t_set,
    seed_col_sum  => seed_col_sum,

    -- Control to DDRIN, SUMMER and TREP.
    analysis_run  => analysis_run,

    -- Control to/from TREP.
    clear_results => clear_results,
    save_results  => save_results,
    save_done     => save_done,
    triggered     => triggered,

    -- Response to high level.
    hsum_done     => hsum_done,

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
-- Function:  Emulates DDRIN
----------------------------------------------------------------------------
ddrin_p : process
begin
  done_read <= '0';
  done_req  <= '0';
  wait for clk_per_c;
  loop
    -- Wait for trigger.
    while (new_col = '0') loop
      wait until falling_edge(clk_sys);
    end loop;
    puts("DDRIN : Started reading. Seed col = " & integer'image(to_integer(unsigned(seed_col_read))));
    -- Signal request complete.
    done_req <= transport '1' after clk_per_c*req_cycles_c, '0' after clk_per_c*(req_cycles_c+1);
    -- Signal read complete.
    done_read <= transport '1' after clk_per_c*read_cycles_c, '0' after clk_per_c*(read_cycles_c+1);
    wait until falling_edge(clk_sys);
  end loop;
end process ddrin_p;

----------------------------------------------------------------------------
-- Function:  Emulates SUMMER
----------------------------------------------------------------------------
summer_p : process
begin
  done_sum <= (others => '0');
  wait for clk_per_c;
  loop
    -- Wait for trigger.
    while (new_sum = '0') loop
      wait until falling_edge(clk_sys);
    end loop;
    puts("SUMMER : Started summing. Seed col = " & integer'image(to_integer(unsigned(seed_col_sum))));
    -- Wait while processing takes place.
    wait for clk_per_c*30;
    -- Signal sum complete.
    for i in done_sum'range loop
      done_sum(i) <= '1' after clk_per_c*i, '0' after clk_per_c*(i+1);
    end loop;
    puts("SUMMER : Finished summing");
  end loop;
end process summer_p;

----------------------------------------------------------------------------
-- Function:  Emulates TREP
----------------------------------------------------------------------------
gensavedone : save_done <= transport save_results after clk_per_c*25;

----------------------------------------------------------------------------
-- Function:  Main stimulus process.
----------------------------------------------------------------------------
stimulus : process
begin
  -- Initialise input.
  hsum_trigger <= '0';
  hsum_enable  <= '0';
  a_set        <= '0';
  b_start_1    <= (others => '0');
  b_start_2    <= (others => '0');
  b_stop_1     <= (others => '0');
  b_stop_2     <= (others => '0');
  h_1          <= (others => '0');
  h_2          <= (others => '0');
  a_1          <= (others => (others => '0'));
  a_2          <= (others => (others => '0'));
  p_en_1       <= (others => (others => '0'));
  p_en_2       <= (others => (others => '0'));
  fop_row_1    <= (others => '0');
  fop_row_2    <= (others => '0');
  thresh_set   <= (others => '0');
  rst_sys_n    <= '0';
  t_filter_en  <= '0';

  -- Reset.
  wait for clk_per_c*2;
  rst_sys_n <= '1';

  puts("Analysis 1 : start=0, stop=5.");
  b_start_1 <= std_logic_vector(to_unsigned(0, 22));
  b_stop_1  <= std_logic_vector(to_unsigned(5, 22));
  hsum_trigger <= '1';
  for i in 1 to 10 loop
    wait for clk_per_c;
    assert new_col = '0'
      report "Trigger not ignored!"
        severity error;
  end loop;
  hsum_trigger <= '0', '1' after clk_per_c;
  hsum_enable <= '1';
  wait for clk_per_c*10;

  wait until hsum_done = '1';
  wait until falling_edge(clk_sys);
  hsum_trigger <= '0';
  wait for clk_per_c;

  puts("Analysis 2 : start=10, stop=25, start=8, stop=11.");
  b_start_1 <= std_logic_vector(to_unsigned(10, 22));
  b_stop_1  <= std_logic_vector(to_unsigned(25, 22));
  b_start_2 <= std_logic_vector(to_unsigned(8, 22));
  b_stop_2  <= std_logic_vector(to_unsigned(11, 22));
  a_set    <= '1';
  hsum_trigger <= '1', '0' after clk_per_c;
  wait until unsigned(seed_col_read) = 20;
  hsum_enable <= '0';
  wait for clk_per_c*100;
  hsum_enable <= '1';

  wait until hsum_done = '1';
  wait until falling_edge(clk_sys);
  wait for clk_per_c;

  puts("Analysis 3 : start=90, stop=90, start=44, stop=44.");
  b_start_1 <= std_logic_vector(to_unsigned(90, 22));
  b_stop_1  <= std_logic_vector(to_unsigned(90, 22));
  b_start_2 <= std_logic_vector(to_unsigned(44, 22));
  b_stop_2  <= std_logic_vector(to_unsigned(44, 22));
  a_set    <= '1';
  hsum_trigger <= '1', '0' after clk_per_c;

  wait until hsum_done = '1';
  wait until falling_edge(clk_sys);
  wait for clk_per_c;

  report "*** End of Simulation ***"
    severity failure;

end process stimulus;

end architecture stim;

