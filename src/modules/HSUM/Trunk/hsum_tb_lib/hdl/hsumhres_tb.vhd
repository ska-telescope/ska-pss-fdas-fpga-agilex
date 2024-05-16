----------------------------------------------------------------------------
-- Module Name:  hsumhres_tb
--
-- Source Path:  hsum_tb_lib/hdl/hsumhres_tb.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     24/05/18 Initial revision.
-- 0.2  RJH     04/06/19 Generic harmonic_g renamed harmonic_num_g.
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

entity hsumhres_tb is
  generic (
    summer_g       : natural range 1 to 3; -- Number of summers.
    harmonic_num_g : natural range 0 to 15 -- Harmonic number.
  );
end entity hsumhres_tb;

