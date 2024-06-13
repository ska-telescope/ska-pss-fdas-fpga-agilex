----------------------------------------------------------------------------
-- Module Name:  CONV_STR
--
-- Source Path:  conv_str.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    25/01/2016  Initial revision.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2016 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY conv_str IS
  GENERIC( 
    ddr_g : natural;    -- number of external DDR interfaces
    fop_g : natural     -- total number of frequency bins
  );
  PORT( 
    DATA        : IN     std_logic_vector (63 DOWNTO 0);
    VALID       : IN     std_logic;
    SOP         : IN     std_logic;
    EOP         : IN     std_logic;
    READYOUT    : OUT    std_logic;                                --       .sink_ready
    DM_TRIGGER  : IN     std_logic;
    CONV_ENABLE : IN     std_logic;
    DDR_ADDROUT : OUT    std_logic_vector (26-ddr_g+1 DOWNTO 0);
    DDR_DATAOUT : OUT    std_logic_vector (ddr_g*512-1 DOWNTO 0);
    DDR_VALID   : OUT    std_logic;
    DDR_WREQOUT : OUT    std_logic;
    DDR_READY   : IN     std_logic;
    CLK_SYS     : IN     std_logic;
    RST_SYS_N   : IN     std_logic
  );

-- Declarations

END ENTITY conv_str ;

