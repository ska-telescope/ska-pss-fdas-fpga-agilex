----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Entity conv_lib.convreset_sync.symbol
--
-- Created:
--          by - taylorj.UNKNOWN (COVNETICSDT11)
--          at - 17:15:31 11/09/2023
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY convreset_sync IS
  PORT( 
    RST_N       : IN     std_logic;
    CLK         : IN     std_logic;
    RST_OUT_0_N : OUT    std_logic;
    RST_OUT_1_N : OUT    std_logic
  );

-- Declarations

END ENTITY convreset_sync ;
