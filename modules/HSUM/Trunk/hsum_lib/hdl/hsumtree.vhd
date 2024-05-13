----------------------------------------------------------------------------
-- Module Name:  hsumtree
--
-- Source Path:  hsum_lib/hdl/hsumtree.vhd
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
use hsum_lib.hsum_pkg.all;

entity hsumtree is
  generic( 
    harmonic_g : natural range 8 to 16
  );
  port( 
    data_sum    : in     std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);  -- FOP data to sum.
    t           : in     std_logic_vector (harmonic_g*32-1 downto 0);                   -- Thresholds (per harmonic).
    comp_en     : in     std_logic_vector (harmonic_g-1 downto 0);                      -- Indicates when to perform comparison.
    -- Outputs to TREP.
    pwr         : out    std_logic_vector (last_column_c(harmonic_g-1)*32-1 downto 0);  -- Summed power values.
    tc          : out    std_logic_vector (last_column_c(harmonic_g-1)-1 downto 0);     -- Indicates threshold has been crossed.
    -- Clocks and reset.
    clk_sys     : in     std_logic;
    rst_sys_1_n : in     std_logic;
    rst_sys_2_n : in     std_logic
  );

-- Declarations

end entity hsumtree ;