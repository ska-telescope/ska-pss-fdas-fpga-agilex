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
-- VHDL Entity cld_lib.cld_fifo_wag.symbol
--
-- Created:
--          by - droogm.UNKNOWN (COVNETICSDT7)
--          at - 13:26:51 13/11/2017
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY cld_fifo_wag IS
  GENERIC( 
    fifo_waddr_width_g   : integer;
    fft_count_width_g    : integer;
    sample_count_width_g : integer;
    fft_g                : integer;
    ddr_g                : integer
  );
  PORT( 
    cld_enable            : IN     std_logic;
    cld_trigger           : IN     std_logic;
    clk_sys               : IN     std_logic;
    completed_read_sample : IN     std_logic_vector (sample_count_width_g -1 DOWNTO 0);
    data_valid            : IN     std_logic;
    ddr_done              : IN     std_logic;
    fop_sample_num        : IN     std_logic_vector (22 DOWNTO 0);
    rst_sys_n             : IN     std_logic;
    ddr_en                : OUT    std_logic;
    ddr_reading_finished  : OUT    std_logic;
    fifo_waddr            : OUT    std_logic_vector (fifo_waddr_width_g -1  DOWNTO 0);
    write_sample          : OUT    std_logic_vector (sample_count_width_g -1 DOWNTO 0)
  );

-- Declarations

END ENTITY cld_fifo_wag ;

