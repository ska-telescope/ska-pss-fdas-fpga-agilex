----------------------------------------------------------------------------
-- Module Name:  FDAS_CLKGEN
--
-- Source Path:  fdas_clkgen.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    25/09/2017  Initial revision.
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
library IEEE;
library fdas_top_lib;
use IEEE.std_logic_1164.all;

entity fdas_clkgen is
  port( 
    CLK_OUT : out    std_logic;          --       ctrl_amm_0.waitrequest_n
    CLK_REF : in     std_logic  := '0';  --                 .read
    RST     : in     std_logic  := '0'   --                 .read
  );

-- Declarations

end entity fdas_clkgen ;
