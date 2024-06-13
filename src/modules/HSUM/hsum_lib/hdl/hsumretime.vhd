----------------------------------------------------------------------------
-- Module Name:  hsumretime
--
-- Source Path:  hsum_lib/hdl/hsumretime.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     14/05/20 Initial revision.
--
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

entity hsumretime is
  generic (
    delay_g : natural; -- Number of retimes.
    width_g : natural  -- Width of data ports.
  );
  port (
    din  : in  unsigned(width_g - 1 downto 0); -- Data input.
    dout : out unsigned(width_g - 1 downto 0); -- Reimed data output.

    -- Clock and reset.
    clk_sys   : in  std_logic;
    rst_sys_n : in std_logic
  );
end entity hsumretime;


