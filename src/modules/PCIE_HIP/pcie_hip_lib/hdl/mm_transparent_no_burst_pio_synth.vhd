----------------------------------------------------------------------------
-- Module Name:  MM_TRANSPARENT_NO_BURST_PIO
--
-- Source Path:  mm_transparent_no_burst_pio.vhd
--
-- Description:  Memory Mapped Transparent Bridge for the PCIe Macro PIO interface
--               with no Burstcount signal
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD    18/11/2022  Initial revision.
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

architecture synth of mm_transparent_no_burst_pio is

begin

    m0_writedata          <= s0_writedata;
    m0_address            <= s0_address;
    m0_write              <= s0_write;
    m0_read               <= s0_read;
    m0_byteenable         <= s0_byteenable;
    s0_waitrequest        <= m0_waitrequest;
    s0_readdata           <= m0_readdata;
    s0_readdatavalid      <= m0_readdatavalid;
    s0_writeresponsevalid <= m0_writeresponsevalid;
    s0_response           <= m0_response;
  
end architecture synth; -- of mm_transparent_no_burst_pio
