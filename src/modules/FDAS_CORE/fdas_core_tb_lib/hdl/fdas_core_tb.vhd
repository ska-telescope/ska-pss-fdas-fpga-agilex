----------------------------------------------------------------------------
-- Module Name:  FDAS_CORE_TB
--
-- Source Path:  fdas_core_tb.vhd
--
-- Description:  FDAS_CORE Testbench
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     18/08/2022  Initial revision.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL 2008
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.fixed_float_types.all;
use ieee.float_pkg.all;
use ieee.std_logic_textio.all;
use std.textio.all;
library ddrif2_lib;
library ctrl_lib;
library conv_lib;
library cld_lib;
library fdas_core_lib;
library fdas_core_tb_lib;
library fdas_top_lib;
library ed_sim_mem;
library fdas_ddr_controller;
library fdas_emif_calibration;
use conv_lib.cmplx_pkg.all;

entity fdas_core_tb is
end fdas_core_tb;