----------------------------------------------------------------------------
-- Module Name:  hsumadder
--
-- Source Path:  hsum_lib/hdl/hsumadder.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     08/05/18 Initial revision.
--
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2018 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;

entity hsumadder is
  port (
    -- Data inputs.
    a         : in  std_logic_vector(31 downto 0);
    b         : in  std_logic_vector(31 downto 0);

    -- Sum output.
    sum       : out std_logic_vector(31 downto 0);

    -- Clock and reset.
    clk_sys   : in  std_logic;
    rst_sys_n : in std_logic
  );
end entity hsumadder;


