----------------------------------------------------------------------------
-- Module Name:  CONV_MULT_CTRL
--
-- Source Path:  conv_mult_ctrl.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    22/05/2017  Initial revision.
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conv_mult_ctrl is
  generic( 
    abits_g         : natural;
    rptnum_g        : natural;    -- number of output frame repeats
    rptbits_g       : natural;
    depth_g         : natural
  );
  port( 
    CLK_SYS            : in  std_logic;
    RST_SYS_N          : in  std_logic;
    RDADDROUT          : out std_logic_vector (abits_g-1 downto 0);
    RDENOUT            : out std_logic;
    VALIDOUT           : out std_logic;
    FIRSTOUT           : out std_logic;
    LASTOUT            : out std_logic;
    RPT_ADDROUT        : out std_logic_vector (rptbits_g-1 downto 0);
    READY              : in  std_logic;
    READYOUT           : out std_logic;
    VALID              : in  std_logic;
    FIRST              : in  std_logic;
    LAST               : in  std_logic;
    RPT_ADDR           : in  std_logic_vector (rptbits_g-1 downto 0);
    DM_TRIGGER         : in  std_logic
  );

end entity conv_mult_ctrl ;

