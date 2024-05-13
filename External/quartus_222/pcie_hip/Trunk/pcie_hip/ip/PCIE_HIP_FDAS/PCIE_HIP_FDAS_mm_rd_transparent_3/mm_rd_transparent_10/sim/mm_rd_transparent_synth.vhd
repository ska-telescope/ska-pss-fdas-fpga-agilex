----------------------------------------------------------------------------
-- Module Name:  MM_RD_TRANSPARENT
--
-- Source Path:  mm_rd_transparent.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/09/2017  Initial revision.
-- 0.1  RMD   14/03/2022  Added response[1:0] (required by Agilex PCIe Hard IP Macro)
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

architecture synth of mm_rd_transparent is

begin

    m0_burstcount    <= s0_burstcount;
    m0_address       <= s0_address;
    m0_read          <= s0_read;
    s0_waitrequest   <= m0_waitrequest;
    s0_readdata      <= m0_readdata;
    s0_readdatavalid <= m0_readdatavalid;
    s0_response      <= m0_response;
end architecture synth; -- of mm_rd_transparent
