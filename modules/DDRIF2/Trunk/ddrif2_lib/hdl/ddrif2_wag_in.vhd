----------------------------------------------------------------------------
-- Module Name:  ddrif2_wag_in
--
-- Source Path:  ddrif2_lib/hdl/ddrif2_wag_in.vhd
--
-- Created:
--          by - droogm (COVNETICSDT17)
--          at - 10:08:15 25/01/2023
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
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ddrif2_wag_in is
  port( 
    clk            : in     std_logic;
    rcode          : in     std_logic_vector (5 downto 0);
    resetn         : in     std_logic;
    valid          : in     std_logic;
    fifo_ready     : out    std_logic;
    fifo_ready_out : out    std_logic;
    waddr          : out    std_logic_vector (5 downto 0);
    wcode          : out    std_logic_vector (5 downto 0)
  );

-- Declarations

end entity ddrif2_wag_in ;
