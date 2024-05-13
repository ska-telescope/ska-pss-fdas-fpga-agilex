----------------------------------------------------------------------------
-- Module Name:  hsumselseed
--
-- Source Path:  hsum_lib/hdl/hsumselseed_rtl.vhd
--
-- Functional Description:
--
-- Select SEED_COL from the FILTER module with the lowest A (ambiguity slopes).
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH  10/06/2019  Initial revision.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2019 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of hsumselseed is
begin

g0 : if summer_g = 1 generate
  sel : seed_col_out <= seed_col_in;
end generate g0;

g1 : if summer_g = 2 generate
  sel : seed_col_out <= seed_col_in(21 downto 0) when unsigned(a(0)) < unsigned(a(1)) else
                        seed_col_in(43 downto 22);
end generate g1;

g2 : if summer_g = 3 generate
  sel : seed_col_out <= seed_col_in(21 downto 0) when
                          (unsigned(a(0)) < unsigned(a(1))) and (unsigned(a(0)) < unsigned(a(1))) else
                        seed_col_in(43 downto 22) when unsigned(a(1)) < unsigned(a(2)) else
                        seed_col_in(65 downto 44);
end generate g2;

end architecture synth;

