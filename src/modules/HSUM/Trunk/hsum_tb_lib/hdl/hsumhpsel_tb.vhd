----------------------------------------------------------------------------
-- Module Name:  hsumhpsel_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumhpsel_tb.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     24/05/18 Initial revision.
-- 0.2  RJH     04/06/19 Updated for increase to 16 harmonics.
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

entity hsumhpsel_tb is
  generic(
    harmonic_g : natural range 8 to 16 := 8
  );
end entity hsumhpsel_tb;


