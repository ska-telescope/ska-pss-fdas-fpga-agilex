----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2017 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Entity cld_lib.ram_mux.symbol
--
-- Created:
--          by - droogm.UNKNOWN (COVNETICSDT7)
--          at - 13:26:50 13/11/2017
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library cld_lib;
use cld_lib.all;

ENTITY ram_mux IS
  GENERIC( 
    ddr_g : integer
  );
  PORT( 
    clk_sys   : IN     std_logic;
    fft_zeros : IN     std_logic;
    ram_data  : IN     std_logic_vector (512*ddr_g-1 DOWNTO 0);
    read_addr : IN     std_logic_vector (ddr_g +1 DOWNTO 0);
    rst_sys_n : IN     std_logic;
    wait_req  : IN     std_logic;
    conv_data : OUT    std_logic_vector (63  DOWNTO 0)
  );

-- Declarations

END ENTITY ram_mux ;
