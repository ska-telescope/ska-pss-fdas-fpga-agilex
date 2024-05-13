----------------------------------------------------------------------------
-- Module Name:  hsumhpsel
--
-- Source Path:  hsum_lib/hdl/hsumhpsel.vhd
--
-- Created:
--          by - droogm (COVNETICSDT17)
--          at - 10:27:05 31/01/2024
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
-- Copyright (c) Covnetics Limited 2024 All Rights Reserved. The information
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

entity hsumhpsel is
  generic( 
    summer_inst_g   : natural range 0 to 2;
    adder_latency_g : natural range 1 to 7;
    harmonic_g      : natural range 8 to 16
  );
  port( 
    -- Control and configuration inputs.
    new_sum      : in     std_logic;                                   -- Trigger to start summing.
    analysis_run : in     std_logic;                                   -- Indicates the analysis run number.
    h            : in     std_logic_vector (3 downto 0);               -- Number of harmonics to process.
    p_en         : in     std_logic_vector (4 downto 0);               -- Number of orbital acceleration values to process.
    a            : in     std_logic_vector (3 downto 0);               -- Number of orbital acceleration ambiguity slopes to process.
    -- Data select to DDRIN.
    hpsel        : out    std_logic_vector (harmonic_g*7-1 downto 0);
    hpsel_en     : out    std_logic_vector (harmonic_g-1 downto 0);
    -- Micro signals for the configuration RAMs.
    hpsel_mci    : in     hsel_out_t;
    hpsel_rd     : out    std_logic_vector (6 downto 0);
    -- Control response to TGEN.
    done_sum     : out    std_logic;
    -- Information to TREP.
    row_info     : out    std_logic_vector (harmonic_g*7-1 downto 0);  -- Row number for each harmonic.
    last_result  : out    std_logic;                                   -- Indicates last result from SUMMER for last ambiguity slope.
    -- Comparator enables to SUMMER_TREE.
    comp_en      : out    std_logic_vector (harmonic_g-1 downto 0);
    msel         : out    std_logic_vector (harmonic_g-1 downto 0);    -- Indication to feed msel instead of data_sum into summer.
    -- Threshold selection controls to T_SEL (per harmonic).
    seed_num     : out    std_logic_vector (harmonic_g*5-1 downto 0);  -- Seed numbers being processed.
    t_en         : out    std_logic_vector (harmonic_g-1 downto 0);    -- Read enables for threshold RAMs.
    -- Clocks and reset.
    clk_sys      : in     std_logic;
    rst_sys_n    : in     std_logic;
    clk_mc       : in     std_logic
  );

-- Declarations

end entity hsumhpsel ;
