----------------------------------------------------------------------------
-- Module Name:  FDAS_CLKGEN
--
-- Source Path:  fdas_clkgen_struc.vhd
--
-- Description:  Instantiates CLKGEN IP block.
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/09/2017  Initial revision.
-- 0.2  RJH   23/10/2018  Changed architecture to struc.
--                        Changed library for clkgen.
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
library clkgen;

architecture struc of fdas_clkgen is
begin

  clkgen_macro : entity clkgen.clkgen
    port map (
      locked   => open,        --  locked.export
      outclk_0 => CLK_OUT,     -- outclk0.clk
      refclk   => CLK_REF,     --  refclk.clk
      rst      => RST          --   reset.reset
    );


end architecture struc; -- of fdas_clkgen
