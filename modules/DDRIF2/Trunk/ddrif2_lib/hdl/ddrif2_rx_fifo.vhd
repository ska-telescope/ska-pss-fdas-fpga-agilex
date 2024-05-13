----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_fifo
--
-- Source Path:  ddrif2_lib/hdl/ddrif2_rx_fifo.vhd
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

entity ddrif2_rx_fifo is
  port( 
    clk_ddr       : in     std_logic;
    clk_in        : in     std_logic;
    ddr_addr_in   : in     std_logic_vector (31 downto 0);
    ddr_data_in   : in     std_logic_vector (511 downto 0);
    ddr_read_in   : in     std_logic;
    ddr_write_in  : in     std_logic;
    raddr         : in     std_logic_vector (5 downto 0);
    rst_ddr_n     : in     std_logic;
    valid         : in     std_logic;
    waddr         : in     std_logic_vector (5 downto 0);
    wait_req      : in     std_logic;
    ddr_addr_out  : out    std_logic_vector (31 downto 0);
    ddr_data_out  : out    std_logic_vector (511 downto 0);
    ddr_read_out  : out    std_logic;
    ddr_write_out : out    std_logic
  );

-- Declarations

end entity ddrif2_rx_fifo ;
