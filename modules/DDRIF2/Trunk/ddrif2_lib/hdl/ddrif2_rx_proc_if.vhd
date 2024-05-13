----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_proc_if
--
-- Source Path:  ddrif2_lib/hdl/ddrif2_rx_proc_if.vhd
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

entity ddrif2_rx_proc_if is
  port( 
    clk_sys             : in     std_logic;
    ddr_wr_addr         : in     std_logic_vector (31 downto 0);
    ddr_wr_data         : in     std_logic_vector (511 downto 0);
    ddr_wr_en           : in     std_logic;
    fifo_ready          : in     std_logic;
    fifo_ready_in_1     : in     std_logic;
    fifo_ready_in_2     : in     std_logic;
    rst_sys_n           : in     std_logic;
    ddr_wr_wait_request : out    std_logic;
    rx_addr_proc        : out    std_logic_vector (31 downto 0);
    rx_data_proc        : out    std_logic_vector (511 downto 0);
    valid               : out    std_logic
  );

-- Declarations

end entity ddrif2_rx_proc_if ;
