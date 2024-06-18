----------------------------------------------------------------------------
-- Module Name:  dual port RAM dual clocks
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
-- Inferred RAM based on Altera Coding style
-- Simple dual port RAM with dual clocks 

----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  15/6/2017   Initial revision.
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




architecture synth of dual_port_ram_dual_clock is

--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------
-- Build a 2-D array type for the RAM
subtype word_t is  std_logic_vector(dbits_g -1 downto 0);
type memory_t is array((2**(abits_g)-1) downto 0) of word_t;

-- Declare the RAM signal.
signal ram_s   : memory_t;
signal read_address_reg_s : std_logic_vector(abits_g-1 downto 0);


begin 

ram_function_write :process(aclk, awren)

  begin
    if(rising_edge(aclk)) then
      if(awren = '1') then
        ram_s(TO_INTEGER(UNSIGNED(aa))) <= ai;
      end if;
    end if;
end process ram_function_write;


ram_function_read :process(bclk)

  begin
    if(rising_edge(bclk)) then
      bo <= ram_s(TO_INTEGER(UNSIGNED(ba)));
      --bo <= ram_s(TO_INTEGER(UNSIGNED(read_address_reg_s)));
      --read_address_reg_s <= ba;
    end if;
end process ram_function_read;


end synth;

