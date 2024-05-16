----------------------------------------------------------------------------
-- Module Name:  RESET_RELEASE
--
-- Source Path:  fdas_reset_release_struc.vhd
--
-- Description:  Instantiates RESET_RELEASE IP block.
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD   09/06/2022  Initial revision.
--
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library RESET_RELEASE;

architecture struc of fdas_reset_release is
begin

  reset_release_i : entity RESET_RELEASE.RESET_RELEASE
   	port  map (
      ninit_done              => NINIT_DONE   -- ninit_done
   	);

end architecture struc; -- of fdas_reset_release
