----------------------------------------------------------------------------
-- Module Name:  hsummax
--
-- Source Path:  hsum_lib/hdl/hsummax.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH  14/05/2020  Initial revision.
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

library ieee, hsum_lib;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;
use     hsum_lib.hsum_pkg.all;

entity hsummax is
  generic (
    size_g : natural range 2 to 32  -- Number of values to compare.
  );
  port (
    values    : in  unsigned32array_t(size_g-1 downto 0); -- Values to compare.
    maxval    : out unsigned(31 downto 0);                -- Maximum value.

    clk_sys   : in  std_logic;
    rst_sys_n : in  std_logic
  );
end entity hsummax;

