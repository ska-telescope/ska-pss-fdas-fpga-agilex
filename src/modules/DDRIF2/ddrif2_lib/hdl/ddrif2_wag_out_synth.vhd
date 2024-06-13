----------------------------------------------------------------------------
-- Module Name:  ddrif_wag_out
--
-- Source Path:
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Write Address Generator.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  30/5/2017   Initial revision.
-- 0.2  RMD  05/09/2017  Renamed resetn to rst_ddr_n
-- 0.3  RJH  24/03/2020  Removed unused signal 'fifo_ready_s'. Tidied code.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of ddrif2_wag_out is

--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------
-- waddr_gen process
signal waddr_s : unsigned(8 downto 0); -- Write address.
signal wcode_s : unsigned(8 downto 0); -- Gray code representation of the write address.

begin


------------------------------------------------------------------------------
-- Process: waddr_gen
-- Write Address Generator
-- Generates the FIFO write address and a gray code representation of the
-- write address.
-----------------------------------------------------------------------------
waddr_gen: process(clk_ddr, rst_ddr_n)
-- Use a variable so we can generate the new write address and gray code
-- representation of the write address simultaneously from D-type output.
variable waddr_v : unsigned(8 downto 0);

begin

  if rst_ddr_n  = '0' then
    -- Initialise.
    waddr_s <= (others => '0');
    wcode_s <= (others => '0');

  elsif rising_edge(clk_ddr) then
    -- Assign the variable before using it.
    waddr_v := waddr_s;

    -- Increment the write address if there is data to be stored.
    if VALID = '1' then
      waddr_v := waddr_v + 1;
    end if;

    -- Assign the variable to the new write address and gray code.
    waddr_s    <= waddr_v;
    wcode_s(8) <= waddr_v(8);
    wcode_s(7) <= waddr_v(8) XOR waddr_v(7);
    wcode_s(6) <= waddr_v(7) XOR waddr_v(6);
    wcode_s(5) <= waddr_v(6) XOR waddr_v(5);
    wcode_s(4) <= waddr_v(5) XOR waddr_v(4);
    wcode_s(3) <= waddr_v(4) XOR waddr_v(3);
    wcode_s(2) <= waddr_v(3) XOR waddr_v(2);
    wcode_s(1) <= waddr_v(2) XOR waddr_v(1);
    wcode_s(0) <= waddr_v(1) XOR waddr_v(0);

  end if;
end process waddr_gen;

-- Concurrent assignments
assign_waddr : WADDR <= STD_LOGIC_VECTOR(waddr_s);
assign_wcode : WCODE <= STD_LOGIC_VECTOR(wcode_s);

end architecture synth;

