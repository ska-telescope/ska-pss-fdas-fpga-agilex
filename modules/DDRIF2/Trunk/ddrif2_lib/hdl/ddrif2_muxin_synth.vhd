----------------------------------------------------------------------------
-- Module Name:  ddrif2_muxin
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Selection of Direction of Interface for DDR memory access
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   03/07/2017   Initial revision.
-- 0.2  RMD   04/09/2017   Ensured all output signals are assigned to avoid latches.
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

architecture synth of ddrif2_muxin is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------




begin


------------------------------------------------------------------------------
-- Process: sel
-- Select the direction of the interface
--
-----------------------------------------------------------------------------

sel: process(VALID_READ, VALID_WRITE, READ_ADDRESS, WRITE_ADDRESS, WRITE_DATA)

begin
  
  -- default
  DDR_ADDR <= (others => '0');
  DDR_DATA <= (others => '0');
  DDR_WRITE <= '0';
  DDR_READ <= '0';
  VALID <= '0';
  
  if VALID_WRITE = '1' then
    DDR_ADDR <= WRITE_ADDRESS;
    DDR_DATA <= WRITE_DATA;
    DDR_WRITE <= '1';
    DDR_READ <= '0';
    VALID <= '1';
  end if;

  
  if VALID_READ = '1' then  -- Read takes priority
    DDR_ADDR <= READ_ADDRESS;
    DDR_DATA <= (others => '0');
    DDR_WRITE <= '0';
    DDR_READ <= '1';   
    VALID <= '1';
  end if;

end process sel;
 
  
end architecture synth;  


