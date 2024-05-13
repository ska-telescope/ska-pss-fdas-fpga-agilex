----------------------------------------------------------------------------
-- Module Name:  mci_top_dataor
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- OR's the data from the MCI Modules within FDAS to deliver to PCIF
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  25/03/2022  Initial revision.
--
---------------------------------------------------------------------------
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of mci_top_dataor is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- dataor process
signal mcdataout_pcif_s                     :       std_logic_vector(31 downto 0); -- MC Data to PCIF


begin


------------------------------------------------------------------------------
-- Process: dataor
-- Check the upper address bits
--
-----------------------------------------------------------------------------
dataor: process(mcdataout_mci_top,mcdataout_ctrl, mcdataout_conv, mcdataout_hsum, mcdataout_msix)
begin

  mcdataout_pcif_s <= mcdataout_mci_top or mcdataout_ctrl or mcdataout_conv or mcdataout_hsum or mcdataout_msix;

  
end process dataor;
   
-- Concurrent assignments
assign_mcdataout_pcif : MCDATAOUT_PCIF <= mcdataout_pcif_s;

end architecture synth;