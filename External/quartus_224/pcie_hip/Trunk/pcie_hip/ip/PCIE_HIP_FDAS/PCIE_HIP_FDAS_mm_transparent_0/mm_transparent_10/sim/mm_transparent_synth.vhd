----------------------------------------------------------------------------
-- Module Name:  MM_TRANSPARENT
--
-- Source Path:  mm_transparent.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/09/2017  Initial revision.
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

architecture synth of mm_transparent is

begin

    m0_burstcount    <= s0_burstcount;
    m0_writedata     <= s0_writedata;
    m0_address       <= s0_address;
    m0_write         <= s0_write;
    m0_read          <= s0_read;
    m0_byteenable    <= s0_byteenable;
    s0_waitrequest   <= m0_waitrequest;
    s0_readdata      <= m0_readdata;
    s0_readdatavalid <= m0_readdatavalid;
  
end architecture synth; -- of mm_transparent
