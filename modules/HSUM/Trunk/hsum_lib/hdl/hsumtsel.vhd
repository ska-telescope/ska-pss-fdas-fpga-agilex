----------------------------------------------------------------------------
-- Module Name:  hsumtsel
--
-- Source Path:  hsum_lib/hdl/hsumtsel.vhd
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

entity hsumtsel is
  generic( 
    summer_inst_g   : natural range 0 to 2;
    adder_latency_g : natural range 1 to 7;
    harmonic_g      : natural range 8 to 16
  );
  port( 
    -- Seed row number from HPSEL (per harmonic).
    seed_num  : in     std_logic_vector (harmonic_g*5-1 downto 0);
    t_en      : in     std_logic_vector (harmonic_g-1 downto 0);     -- Read enables for threshold RAMs.
    t_set     : in     std_logic;                                    -- Threshold set select.
    -- Micro signals for the configuration RAMs.
    tsel_mci  : in     tsel_out_t;
    tsel_rd   : out    std_logic_vector (31 downto 0);
    -- Thresholds to SUMMER (per harmonic).
    t         : out    std_logic_vector (harmonic_g*32-1 downto 0);
    -- Clocks and reset.
    clk_sys   : in     std_logic;
    rst_sys_n : in     std_logic;
    clk_mc    : in     std_logic
  );

-- Declarations

end entity hsumtsel ;
