----------------------------------------------------------------------------
-- Module Name:  ddrif2_rag_out_512
--
-- Source Path:  ddrif2_lib/hdl/ddrif2_rag_out_512.vhd
--
-- Created:
--          by - droogm (COVNETICSDT17)
--          at - 10:08:14 25/01/2023
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

entity ddrif2_rag_out_512 is
  port( 
    clk_sys    : in     std_logic;
    rst_sys_n  : in     std_logic;
    wcode      : in     std_logic_vector (8 downto 0);
    fifo_full  : out    std_logic;
    raddr      : out    std_logic_vector (8 downto 0);
    valid_data : out    std_logic
  );

-- Declarations

end entity ddrif2_rag_out_512 ;
