----------------------------------------------------------------------------
-- Module Name:  hsum
--
-- Source Path:  hsum_lib/hdl/hsum_scm.vhd
--
-- Created:
--          by - droogm (COVNETICSDT17)
--          at - 10:27:06 31/01/2024
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2024 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
library hsum_lib;
use hsum_lib.hsummci_pkg.all;
use hsum_lib.hsum_pkg.all;


architecture scm of hsum is

  -- Architecture declarations
  type hpsel_rd_t is array(0 to summer_g) of std_logic_vector(6 downto 0);
  type tsel_rd_t is array(0 to summer_g) of std_logic_vector(31 downto 0);

  -- Internal signal declarations
  signal analysis_run_s   : std_logic;                                                              -- Indicates run 1 or run 2.
  signal new_sum_s        : std_logic;                                                              -- Starts a summing run.
  signal h_s              : std_logic_vector(3 downto 0);                                           -- Number of harmonics to process for current run.
  signal a_s              : vector_4_array_t(0 to summer_g-1);                                      -- Number of orbital slopes for current run.
  signal p_en_s           : vector_5_array_t(0 to summer_g-1);                                      -- Number of orbital acceleration values for current run.
  signal t_set_s          : std_logic;                                                              -- Threshold set to use.
  signal m_s              : std_logic_vector(31 downto 0);
  signal hsel_s           : hsel_out_t;
  signal tsel_s           : tsel_out_t;
  signal hpsel_s          : std_logic_vector(summer_g*harmonic_g*7-1 downto 0);
  signal hpsel_en_s       : std_logic_vector(summer_g*harmonic_g-1 downto 0);
  signal tc_s             : std_logic_vector(summer_g*last_column_c(harmonic_g-1)-1 downto 0);      -- Indication threshold has been crossed for each column.
  signal row_info_s       : std_logic_vector(summer_g*harmonic_g*7-1 downto 0);                     -- Row number for each harmonic.
  signal pwr_s            : std_logic_vector(summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);   -- Summed power for each column.
  signal last_result_s    : std_logic_vector(summer_g-1 downto 0);                                  -- Indicates last result of last ambiguity slope.
  signal tsel_rd_s        : tsel_rd_t;
  signal t_filter_en_s    : std_logic;
  signal hpsel_rd_s       : hpsel_rd_t;
  signal hpsel_rd_or_s    : std_logic_vector(6 downto 0);
  signal tsel_rd_or_s     : std_logic_vector(31 downto 0);
  signal new_col_s        : std_logic;                                                              -- Starts reading a new set of columns.
  signal save_done_s      : std_logic;                                                              -- Indicates saving of results is complete.
  signal clear_results_s  : std_logic;                                                              -- Indicates to clear results at start of run.
  signal save_results_s   : std_logic;                                                              -- Indicates to store results at end of analysis run.
  signal triggered_s      : std_logic;                                                              -- Indicates rising edge on hsum_trigger input.
  signal done_sum_s       : std_logic_vector(summer_g-1 downto 0);                                  -- SUMMER has completed processing FOP.
  signal dm_cnt_reset_s   : std_logic;
  signal exc_s            : exc_out_t;
  signal results_s        : results_out_t;
  signal exc_rd_s         : std_logic_vector(31 downto 0);
  signal dm_cnt_s         : std_logic_vector(31 downto 0);
  signal results_rd_s     : std_logic_vector(31 downto 0);
  signal done_read_s      : std_logic;
  signal fop_row_s        : std_logic_vector(6 downto 0);                                           -- Number of harmonics to process for current run.
  signal a_set_s          : std_logic;
  signal b_start_1_s      : std_logic_vector(21 downto 0);
  signal b_stop_1_s       : std_logic_vector(21 downto 0);
  signal b_start_2_s      : std_logic_vector(21 downto 0);
  signal b_stop_2_s       : std_logic_vector(21 downto 0);
  signal h_1_s            : std_logic_vector(3 downto 0);
  signal h_2_s            : std_logic_vector(3 downto 0);
  signal a_1_s            : vector_4_array_t(0 to summer_g-1);
  signal a_2_s            : vector_4_array_t(0 to summer_g-1);
  signal p_en_1_s         : vector_5_array_t(0 to summer_g-1);
  signal p_en_2_s         : vector_5_array_t(0 to summer_g-1);
  signal thresh_set_s     : std_logic_vector(21 downto 0);
  signal fop_row_1_s      : std_logic_vector(6 downto 0);
  signal fop_row_2_s      : std_logic_vector(6 downto 0);
  signal fop_col_offset_s : std_logic_vector(8 downto 0);
  signal done_req_s       : std_logic;
  signal ddrin_rd_page_s  : std_logic_vector(1 downto 0);                                           -- RAM page to use when SUMMER is reading FOP data.
  signal seed_col_read_s  : std_logic_vector(21 downto 0);                                          -- First column of a set to read.
  signal seed_col_sum_s   : std_logic_vector(21 downto 0);                                          -- First column of a set being summed.
  -- Data to SUMMER.
  signal data_sum_s       : std_logic_vector(summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);
  signal rst_sys_n_1_s    : std_logic_vector(0 to summer_g-1);
  signal rst_sys_n_2_s    : std_logic_vector(0 to summer_g-1);
  signal rst_sys_n_0_s    : std_logic_vector(0 to summer_g-1);
  signal rst_sys_n_3_s    : std_logic_vector(0 to summer_g-1);
  signal rst_sys_n_4_s    : std_logic_vector(0 to summer_g-1);
  signal rst_sys_n_5_s    : std_logic_vector(0 to summer_g-1);

  -- Implicit buffer signal declarations
  signal hsum_done_internal : std_logic;


  -- Component Declarations
  component hsumddrin
  generic (
    summer_g   : natural range 1 to 3;
    ddr_g      : natural range 1 to 3;
    harmonic_g : natural range 8 to 16    -- Max number of harmonics that may be processed (including fundamental).
  );
  port (
    -- Control and configuration inputs.
    hsum_page      : in     std_logic_vector (31 downto 0);                                      -- Offset of data in DDR memory.
    new_col        : in     std_logic ;                                                          -- Trigger to start reading new set of column data.
    seed_col       : in     std_logic_vector (21 downto 0);                                      -- First column of a set to read.
    h              : in     std_logic_vector (3 downto 0);                                       -- Number of harmonics to process.
    fop_row        : in     std_logic_vector (6 downto 0);                                       -- Number of FOP rows to read.
    fop_col_offset : in     std_logic_vector (8 downto 0);                                       -- Offset to first valid FOP column.
    triggered      : in     std_logic ;                                                          -- Initialises write address at start of new run.
    ddrin_rd_page  : in     std_logic_vector (1 downto 0);                                       -- RAM page to use when SUMMER is reading FOP data.
    -- Data select from SUMMER.
    hpsel          : in     std_logic_vector (summer_g*harmonic_g*7-1 downto 0);
    hpsel_en       : in     std_logic_vector (summer_g*harmonic_g-1 downto 0);
    -- Control & Data from DDR interface.
    ddr_data       : in     std_logic_vector (ddr_g*512-1 downto 0);
    data_valid     : in     std_logic ;
    wait_request   : in     std_logic ;
    -- Read request to DDR interface.
    ddr_addr       : out    std_logic_vector (31 downto 0);
    ddr_read       : out    std_logic ;
    -- Data to SUMMER.
    data_sum       : out    std_logic_vector (summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);
    -- Control response to TGEN.
    done_req       : out    std_logic ;
    done_read      : out    std_logic ;
    -- Clock and reset.
    clk_sys        : in     std_logic ;
    rst_sys_n      : in     std_logic_vector (0 to summer_g-1)
  );
  end component hsumddrin;
  component hsummci
  generic (
    summer_g : integer range 1 to 3 := 3
  );
  port (
    mcaddr         : in     std_logic_vector (17 downto 0);
    mcdatain       : in     std_logic_vector (31 downto 0);
    mcdataout      : out    std_logic_vector (31 downto 0);
    mcrwn          : in     std_logic ;
    mcms           : in     std_logic ;
    clk            : in     std_logic ;
    rst_n          : in     std_logic ;
    hsel           : out    hsel_out_t ;
    hsel_rd        : in     std_logic_vector (6 downto 0);
    tsel           : out    tsel_out_t ;
    tsel_rd        : in     std_logic_vector (31 downto 0);
    b_start_1      : out    std_logic_vector (21 downto 0);
    b_stop_1       : out    std_logic_vector (21 downto 0);
    b_start_2      : out    std_logic_vector (21 downto 0);
    b_stop_2       : out    std_logic_vector (21 downto 0);
    h_1            : out    std_logic_vector (3 downto 0);
    h_2            : out    std_logic_vector (3 downto 0);
    a_set          : out    std_logic ;
    thresh_set     : out    std_logic_vector (21 downto 0);
    m              : out    std_logic_vector (31 downto 0);
    t_filter_en    : out    std_logic ;
    fop_row_1      : out    std_logic_vector (6 downto 0);
    fop_row_2      : out    std_logic_vector (6 downto 0);
    p_en_1         : out    vector_5_array_t (0 to summer_g-1);
    p_en_2         : out    vector_5_array_t (0 to summer_g-1);
    a_1            : out    vector_4_array_t (0 to summer_g-1);
    a_2            : out    vector_4_array_t (0 to summer_g-1);
    dm_cnt         : in     std_logic_vector (31 downto 0);
    dm_cnt_reset   : out    std_logic ;
    results        : out    results_out_t ;
    results_rd     : in     std_logic_vector (31 downto 0);
    exc            : out    exc_out_t ;
    exc_rd         : in     std_logic_vector (31 downto 0);
    fop_col_offset : out    std_logic_vector (8 downto 0)
  );
  end component hsummci;
  component hsumreset_sync
  generic (
    summer_g : natural range 1 to 3
  );
  port (
    RST_N       : in     std_logic ;
    CLK         : in     std_logic ;
    RST_OUT_0_N : out    std_logic_vector (0 to summer_g-1);
    RST_OUT_1_N : out    std_logic_vector (0 to summer_g-1);
    RST_OUT_2_N : out    std_logic_vector (0 to summer_g-1);
    RST_OUT_3_N : out    std_logic_vector (0 to summer_g-1);
    RST_OUT_4_N : out    std_logic_vector (0 to summer_g-1);
    RST_OUT_5_N : out    std_logic_vector (0 to summer_g-1)
  );
  end component hsumreset_sync;
  component hsumsummer
  generic (
    summer_inst_g   : natural range 0 to 2;
    adder_latency_g : natural range 1 to 7;
    harmonic_g      : natural range 8 to 16
  );
  port (
    -- Control and configuration inputs.
    new_sum      : in     std_logic ;                                                   -- Trigger to start summing.
    analysis_run : in     std_logic ;                                                   -- Indicates the analysis run number.
    h            : in     std_logic_vector (3 downto 0);                                -- Number of harmonics to process.
    p_en         : in     std_logic_vector (4 downto 0);                                -- Number of orbital acceleration values to process.
    a            : in     std_logic_vector (3 downto 0);                                -- Number of orbital acceleration ambiguity slopes to process.
    t_set        : in     std_logic ;                                                   -- Selects low or high frequency threshold sets.
    m            : in     std_logic_vector (31 downto 0);                               -- Value to use instead of FOP value.
    -- Data from DDRIN.
    data_sum     : in     std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);
    -- Data select to DDRIN.
    hpsel        : out    std_logic_vector (harmonic_g*7-1 downto 0);
    hpsel_en     : out    std_logic_vector (harmonic_g-1 downto 0);
    -- Micro signals for the configuration RAMs.
    hpsel_mci    : in     hsel_out_t ;
    hpsel_rd     : out    std_logic_vector (6 downto 0);
    tsel_mci     : in     tsel_out_t ;
    tsel_rd      : out    std_logic_vector (31 downto 0);
    -- Control response to TGEN.
    done_sum     : out    std_logic ;
    -- Information to TREP.
    row_info     : out    std_logic_vector (harmonic_g*7-1 downto 0);                   -- Row number for each harmonic.
    pwr          : out    std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0); -- Summed power for each column.
    tc           : out    std_logic_vector (last_column_c(harmonic_g-1)-1 downto 0);    -- Indication threshold has been crossed for each column.
    last_result  : out    std_logic ;                                                   -- Indicates last result of last ambiguity slope.
    -- Clocks and reset.
    clk_sys      : in     std_logic ;
    clk_mc       : in     std_logic ;
    rst_sys_a_n  : in     std_logic ;
    rst_sys_b_n  : in     std_logic ;
    rst_sys_c_n  : in     std_logic 
  );
  end component hsumsummer;
  component hsumtgen
  generic (
    summer_g        : natural range 1 to 3;
    adder_latency_g : natural range 1 to 7
  );
  port (
    -- Control and configuration inputs.
    hsum_trigger  : in     std_logic ;                             -- Triggers processing a new FOP.
    hsum_enable   : in     std_logic ;                             -- Allows processing to be paused.
    a_set         : in     std_logic ;                             -- Indicates number of analysis runs to perform.
    b_start_1     : in     std_logic_vector (21 downto 0);         -- FOP start column (run 1).
    b_stop_1      : in     std_logic_vector (21 downto 0);         -- FOP stop column (run 1).
    b_start_2     : in     std_logic_vector (21 downto 0);         -- FOP start column (run 2).
    b_stop_2      : in     std_logic_vector (21 downto 0);         -- FOP stop column (run 2).
    h_1           : in     std_logic_vector (3 downto 0);          -- Number of harmonics to process (run 1).
    h_2           : in     std_logic_vector (3 downto 0);          -- Number of harmonics to process (run 2).
    a_1           : in     vector_4_array_t (0 to summer_g-1);     -- Number of orbital acceleration ambiguity slopes to process (run 1).
    a_2           : in     vector_4_array_t (0 to summer_g-1);     -- Number of orbital acceleration ambiguity slopes to process (run 2).
    p_en_1        : in     vector_5_array_t (0 to summer_g-1);     -- Number of orbital acceleration values to process (run 1).
    p_en_2        : in     vector_5_array_t (0 to summer_g-1);     -- Number of orbital acceleration values to process (run 2).
    fop_row_1     : in     std_logic_vector (6 downto 0);          -- Number of FOP rows to read from DDR (run 1).
    fop_row_2     : in     std_logic_vector (6 downto 0);          -- Number of FOP rows to read from DDR (run 2).
    thresh_set    : in     std_logic_vector (21 downto 0);         -- Column at which to swap threshold sets.
    t_filter_en   : in     std_logic ;                             -- Result filter enable.
    -- Selected configuration.
    h             : out    std_logic_vector (3 downto 0);          -- Number of harmonics to process for current run.
    a             : out    vector_4_array_t (0 to summer_g-1);     -- Number of orbital slopes for current run.
    p_en          : out    vector_5_array_t (0 to summer_g-1);     -- Number of orbital acceleration values for current run.
    fop_row       : out    std_logic_vector (6 downto 0);          -- Number of FOP rows to read from DDR for current run.
    -- Sub-block done signals.
    done_req      : in     std_logic ;                             -- DDRIN has finished requesting FOP data.
    done_read     : in     std_logic ;                             -- DDRIN has finished loading FOP data.
    done_sum      : in     std_logic_vector (summer_g-1 downto 0); -- SUMMER has completed processing FOP.
    -- Control to DDRIN.
    new_col       : out    std_logic ;                             -- Starts reading a new set of columns.
    ddrin_rd_page : out    std_logic_vector (1 downto 0);          -- RAM page to use when SUMMER is reading FOP data.
    seed_col_read : out    std_logic_vector (21 downto 0);         -- First column of a set to read.
    -- Control to SUMMER.
    new_sum       : out    std_logic ;                             -- Starts a summing run.
    seed_col_sum  : out    std_logic_vector (21 downto 0);         -- First column of a set being summed.
    t_set         : out    std_logic ;                             -- Threshold set to use.
    -- Control to DDRIN, SUMMER and TREP.
    analysis_run  : out    std_logic ;                             -- Indicates run 1 or run 2.
    -- Control to/from TREP.
    clear_results : out    std_logic ;                             -- Indicates to clear results at start of run.
    save_results  : out    std_logic ;                             -- Indicates to store results at end of analysis run.
    save_done     : in     std_logic ;                             -- Indicates saving of results is complete.
    triggered     : out    std_logic ;                             -- Indicates rising edge on hsum_trigger input.
    -- Response to high level.
    hsum_done     : out    std_logic ;                             -- Analysis run(s) complete.
    -- Clock and reset.
    clk_sys       : in     std_logic ;
    rst_sys_n     : in     std_logic 
  );
  end component hsumtgen;
  component hsumtrep
  generic (
    summer_g        : natural range 1 to 3;
    adder_latency_g : natural range 1 to 7;
    harmonic_g      : natural range 8 to 16
  );
  port (
    -- Inputs from TGEN.
    seed_col_sum  : in     std_logic_vector (21 downto 0);
    analysis_run  : in     std_logic ;                                                            -- Run number.
    clear_results : in     std_logic ;                                                            -- Indicates to clear results at start of run.
    save_results  : in     std_logic ;                                                            -- Indicates analysis run is complete.
    hsum_done     : in     std_logic ;                                                            -- Indicates all analysis runs are complete.
    -- -- Output to TGEN.
    save_done     : out    std_logic ;
    -- Configuration.
    h             : in     std_logic_vector (3 downto 0);                                         -- Number of harmonics to process.
    a             : in     vector_4_array_t (0 to summer_g-1);                                    -- Number of orbital acceleration ambiguity slopes to process.
    t_filter_en   : in     std_logic ;                                                            -- Filter enable.
    -- Inputs from SUMMER.
    tc            : in     std_logic_vector (summer_g*last_column_c(harmonic_g-1)-1 downto 0);    -- Indicates threshold has been crossed.
    pwr           : in     std_logic_vector (summer_g*last_column_c(harmonic_g-1)*32-1 downto 0); -- Summed power values.
    row_info      : in     std_logic_vector (summer_g*harmonic_g*7-1 downto 0);                   -- Row number for each harmonic.
    last_result   : in     std_logic_vector (summer_g-1 downto 0);                                -- Indicates last result of last ambiguity slope.
    -- DM Counter controls.
    triggered     : in     std_logic ;
    dm_cnt_reset  : in     std_logic ;
    -- Micro read back of results.
    results       : in     results_out_t ;
    results_rd    : out    std_logic_vector (31 downto 0);
    exc           : in     exc_out_t ;
    exc_rd        : out    std_logic_vector (31 downto 0);
    dm_cnt        : out    std_logic_vector (31 downto 0);
    -- Clocks and reset.
    clk_sys       : in     std_logic ;
    rst_sys_n     : in     std_logic_vector (0 to summer_g-1);
    clk_mc        : in     std_logic 
  );
  end component hsumtrep;

  -- Optional embedded configurations
  -- pragma synthesis_off
  for all : hsumddrin use entity hsum_lib.hsumddrin;
  for all : hsummci use entity hsum_lib.hsummci;
  for all : hsumreset_sync use entity hsum_lib.hsumreset_sync;
  for all : hsumtgen use entity hsum_lib.hsumtgen;
  for all : hsumtrep use entity hsum_lib.hsumtrep;
  -- pragma synthesis_on


begin
  -- Architecture concurrent statements
  -- HDL Embedded Text Block 1 eb1
  -- eb1 1
  -- OR together the micro read back buses from the SUMMER modules.
  or1 : if summer_g = 1 generate
    hpsel : hpsel_rd_or_s <= hpsel_rd_s(0);
    tsel  : tsel_rd_or_s  <= tsel_rd_s(0);
  end generate or1;
  or2 : if summer_g = 2 generate
    hpsel : hpsel_rd_or_s <= hpsel_rd_s(0) or hpsel_rd_s(1);
    tsel  : tsel_rd_or_s  <= tsel_rd_s(0) or tsel_rd_s(1);
  end generate or2;
  or3 : if summer_g = 3 generate
    hpsel : hpsel_rd_or_s <= hpsel_rd_s(0) or hpsel_rd_s(1) or hpsel_rd_s(2);
    tsel  : tsel_rd_or_s  <= tsel_rd_s(0) or tsel_rd_s(1) or tsel_rd_s(2);
  end generate or3;


  -- Instance port mappings.
  ddrin : hsumddrin
    generic map (
      summer_g   => summer_g,
      ddr_g      => ddr_g,
      harmonic_g => harmonic_g      -- Max number of harmonics that may be processed (including fundamental).
    )
    port map (
      hsum_page => hsum_page,
      new_col => new_col_s,
      seed_col => seed_col_read_s,
      h => h_s,
      fop_row => fop_row_s,
      fop_col_offset => fop_col_offset_s,
      triggered => triggered_s,
      ddrin_rd_page => ddrin_rd_page_s,
      hpsel => hpsel_s,
      hpsel_en => hpsel_en_s,
      ddr_data => ddr_data,
      data_valid => data_valid,
      wait_request => wait_request,
      ddr_addr => ddr_addr,
      ddr_read => ddr_read,
      data_sum => data_sum_s,
      done_req => done_req_s,
      done_read => done_read_s,
      clk_sys => clk_sys,
      rst_sys_n => rst_sys_n_0_s
    );
  mci : hsummci
    generic map (
      summer_g => summer_g
    )
    port map (
      mcaddr         => mcaddr,
      mcdatain       => mcdatain,
      mcdataout      => mcdataout,
      mcrwn          => mcrwn,
      mcms           => mcms,
      clk            => clk_mc,
      rst_n          => rst_mc_n,
      hsel           => hsel_s,
      hsel_rd        => hpsel_rd_or_s,
      tsel           => tsel_s,
      tsel_rd        => tsel_rd_or_s,
      b_start_1      => b_start_1_s,
      b_stop_1       => b_stop_1_s,
      b_start_2      => b_start_2_s,
      b_stop_2       => b_stop_2_s,
      h_1            => h_1_s,
      h_2            => h_2_s,
      a_set          => a_set_s,
      thresh_set     => thresh_set_s,
      m              => m_s,
      t_filter_en    => t_filter_en_s,
      fop_row_1      => fop_row_1_s,
      fop_row_2      => fop_row_2_s,
      p_en_1         => p_en_1_s,
      p_en_2         => p_en_2_s,
      a_1            => a_1_s,
      a_2            => a_2_s,
      dm_cnt         => dm_cnt_s,
      dm_cnt_reset   => dm_cnt_reset_s,
      results        => results_s,
      results_rd     => results_rd_s,
      exc            => exc_s,
      exc_rd         => exc_rd_s,
      fop_col_offset => fop_col_offset_s
    );
  reset_sync : hsumreset_sync
    generic map (
      summer_g => summer_g
    )
    port map (
      RST_N       => rst_sys_n,
      CLK         => clk_sys,
      RST_OUT_0_N => rst_sys_n_0_s,
      RST_OUT_1_N => rst_sys_n_1_s,
      RST_OUT_2_N => rst_sys_n_2_s,
      RST_OUT_3_N => rst_sys_n_3_s,
      RST_OUT_4_N => rst_sys_n_4_s,
      RST_OUT_5_N => rst_sys_n_5_s
    );
  tgen : hsumtgen
    generic map (
      summer_g        => summer_g,
      adder_latency_g => adder_latency_g
    )
    port map (
      hsum_trigger  => hsum_trigger,
      hsum_enable   => hsum_enable,
      a_set         => a_set_s,
      b_start_1     => b_start_1_s,
      b_stop_1      => b_stop_1_s,
      b_start_2     => b_start_2_s,
      b_stop_2      => b_stop_2_s,
      h_1           => h_1_s,
      h_2           => h_2_s,
      a_1           => a_1_s,
      a_2           => a_2_s,
      p_en_1        => p_en_1_s,
      p_en_2        => p_en_2_s,
      fop_row_1     => fop_row_1_s,
      fop_row_2     => fop_row_2_s,
      thresh_set    => thresh_set_s,
      t_filter_en   => t_filter_en_s,
      h             => h_s,
      a             => a_s,
      p_en          => p_en_s,
      fop_row       => fop_row_s,
      done_req      => done_req_s,
      done_read     => done_read_s,
      done_sum      => done_sum_s,
      new_col       => new_col_s,
      ddrin_rd_page => ddrin_rd_page_s,
      seed_col_read => seed_col_read_s,
      new_sum       => new_sum_s,
      seed_col_sum  => seed_col_sum_s,
      t_set         => t_set_s,
      analysis_run  => analysis_run_s,
      clear_results => clear_results_s,
      save_results  => save_results_s,
      save_done     => save_done_s,
      triggered     => triggered_s,
      hsum_done     => hsum_done_internal,
      clk_sys       => clk_sys,
      rst_sys_n     => rst_sys_n_1_s(0)
    );
  trep : hsumtrep
    generic map (
      summer_g        => summer_g,
      adder_latency_g => adder_latency_g,
      harmonic_g      => harmonic_g
    )
    port map (
      seed_col_sum  => seed_col_sum_s,
      analysis_run  => analysis_run_s,
      clear_results => clear_results_s,
      save_results  => save_results_s,
      hsum_done     => hsum_done_internal,
      save_done     => save_done_s,
      h             => h_s,
      a             => a_s,
      t_filter_en   => t_filter_en_s,
      tc            => tc_s,
      pwr           => pwr_s,
      row_info      => row_info_s,
      last_result   => last_result_s,
      triggered     => triggered_s,
      dm_cnt_reset  => dm_cnt_reset_s,
      results       => results_s,
      results_rd    => results_rd_s,
      exc           => exc_s,
      exc_rd        => exc_rd_s,
      dm_cnt        => dm_cnt_s,
      clk_sys       => clk_sys,
      rst_sys_n     => rst_sys_n_2_s,
      clk_mc        => clk_mc
    );

  sumg: FOR s IN 0 TO summer_g-1 GENERATE
  -- Optional embedded configurations
  -- pragma synthesis_off
  for all : hsumsummer use entity hsum_lib.hsumsummer;
  -- pragma synthesis_on

  begin
    summer : hsumsummer
      generic map (
        summer_inst_g   => s,
        adder_latency_g => adder_latency_g,
        harmonic_g      => harmonic_g
      )
      port map (
        new_sum => new_sum_s,
        analysis_run => analysis_run_s,
        h => h_s,
        t_set => t_set_s,
        m => m_s,
        hpsel_mci => hsel_s,
        tsel_mci => tsel_s,
        clk_sys => clk_sys,
        clk_mc => clk_mc,
        rst_sys_a_n => rst_sys_n_3_s(s),
        rst_sys_b_n => rst_sys_n_4_s(s),
        rst_sys_c_n => rst_sys_n_5_s(s),
        p_en => p_en_s(s),
        a => a_s(s),
        data_sum => data_sum_s((s+1)*last_column_c(harmonic_g-1)*32-1
                                                 downto s*last_column_c(harmonic_g-1)*32),
        hpsel => hpsel_s((s+1)*harmonic_g*7-1 downto s*harmonic_g*7),
        hpsel_en => hpsel_en_s((s+1)*harmonic_g-1 downto s*harmonic_g),
        hpsel_rd => hpsel_rd_s(s),
        tsel_rd => tsel_rd_s(s),
        done_sum => done_sum_s(s),
        row_info => row_info_s((s+1)*harmonic_g*7-1 downto s*harmonic_g*7),
        pwr => pwr_s((s+1)*last_column_c(harmonic_g-1)*32-1
                              downto s*last_column_c(harmonic_g-1)*32),
        tc => tc_s((s+1)*last_column_c(harmonic_g-1)-1 downto s*last_column_c(harmonic_g-1)),
        last_result => last_result_s(s)
      );
  end generate sumg;

  -- Implicit buffered output assignments
  hsum_done <= hsum_done_internal;

end architecture scm;
