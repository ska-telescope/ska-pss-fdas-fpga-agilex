----------------------------------------------------------------------------
-- Module Name:  CONV_COEF_STR
--
-- Source Path:  conv_coef_str.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    18/05/2017  Initial revision.
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
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library ieee, std, conv_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use conv_lib.cmplx_pkg.all;

entity conv_coef_str is
  generic( 
    dbits_g     : natural;
    depth_g     : natural;
    abits_g     : natural;
    loop_g      : natural
  );
  port( 
    CLK_SYS      : in     std_logic;
    RST_SYS_N    : in     std_logic;
    RDATAOUT     : out    std_logic_vector (dbits_g-1 downto 0);
    IDATACONJOUT : out    std_logic_vector (dbits_g-1 downto 0);
    RDATACONJOUT : out    std_logic_vector (dbits_g-1 downto 0);
    IDATAOUT     : out    std_logic_vector (dbits_g-1 downto 0);
    RDEN         : in     std_logic_vector (loop_g-1 downto 0);
    RDADDR       : in     std_logic_vector (abits_g-1 downto 0);
    CLK_MC       : in     std_logic;
    RST_MC_N     : in     std_logic;
    MCADDR       : in     std_logic_vector (abits_g downto 0);
    MCRDEN       : in     std_logic_vector (loop_g-1 downto 0);
    MCDATAOUT    : out    std_logic_vector (dbits_g-1 downto 0);
    MCWREN       : in     std_logic_vector (loop_g-1 downto 0);
    MCDATA       : in     std_logic_vector (dbits_g-1 downto 0)
  );

-- Declarations

end entity conv_coef_str ;

