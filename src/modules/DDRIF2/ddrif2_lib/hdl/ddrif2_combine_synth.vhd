----------------------------------------------------------------------------
-- Module Name:  ddrif2_combine
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
--  combine data ahf address
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
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

architecture synth of ddrif2_combine is
begin
-- Concurrent assignments
assign_write : AI(545) <= DDR_WRITE_IN;
assign_read : AI(544) <= DDR_READ_IN;
assign_data : AI(543 downto 32) <= DDR_DATA_IN;
assign_addr : AI(31 downto 0) <= DDR_ADDR_IN;


end architecture synth;



