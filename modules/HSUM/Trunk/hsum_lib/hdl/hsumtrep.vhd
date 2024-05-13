----------------------------------------------------------------------------
-- Module Name:  hsumtrep
--
-- Source Path:  hsum_lib/hdl/hsumtrep.vhd
--
-- Created:
--          by - hastierj (COVNETICSDT15)
--          at - 10:24:27 23/05/2019
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2019 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library hsum_lib;
use hsum_lib.hsummci_pkg.all;
use hsum_lib.hsum_pkg.all;

entity hsumtrep is
  generic( 
    summer_g        : natural range 1 to 3;
    adder_latency_g : natural range 1 to 7;
    harmonic_g      : natural range 8 to 16
  );
  port( 
    -- Inputs from TGEN.
    seed_col_sum  : in     std_logic_vector (21 downto 0);
    analysis_run  : in     std_logic;                                                              -- Run number.
    clear_results : in     std_logic;                                                              -- Indicates to clear results at start of run.
    save_results  : in     std_logic;                                                              -- Indicates analysis run is complete.
    hsum_done     : in     std_logic;                                                              -- Indicates all analysis runs are complete.
    -- -- Output to TGEN.
    save_done     : out    std_logic;
    -- Configuration.
    h             : in     std_logic_vector (3 downto 0);                                          -- Number of harmonics to process.
    a             : in     vector_4_array_t (0 to summer_g-1);                                     -- Number of orbital acceleration ambiguity slopes to process.
    t_filter_en   : in     std_logic;                                                              -- Filter enable.
    -- Inputs from SUMMER.
    tc            : in     std_logic_vector (summer_g*last_column_c(harmonic_g-1)-1 downto 0);     -- Indicates threshold has been crossed.
    pwr           : in     std_logic_vector (summer_g*last_column_c(harmonic_g-1)*32-1 downto 0);  -- Summed power values.
    row_info      : in     std_logic_vector (summer_g*harmonic_g*7-1 downto 0);                    -- Row number for each harmonic.
    last_result   : in     std_logic_vector (summer_g-1 downto 0);                                 -- Indicates last result of last ambiguity slope.
    -- DM Counter controls.
    triggered     : in     std_logic;
    dm_cnt_reset  : in     std_logic;
    -- Micro read back of results.
    results       : in     results_out_t;
    results_rd    : out    std_logic_vector (31 downto 0);
    exc           : in     exc_out_t;
    exc_rd        : out    std_logic_vector (31 downto 0);
    dm_cnt        : out    std_logic_vector (31 downto 0);
    -- Clocks and reset.
    clk_sys       : in     std_logic;
    rst_sys_n     : in     std_logic_vector (0 to summer_g-1);
    clk_mc        : in     std_logic
  );

-- Declarations

end entity hsumtrep ;