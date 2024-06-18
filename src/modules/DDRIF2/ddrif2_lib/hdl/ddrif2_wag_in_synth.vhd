----------------------------------------------------------------------------
-- Module Name:  ddrif2_wag_in
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Write Address Generator 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  02/09/2022   Added FIFO_READY_OUT port
-- 0.3  RMD  13/01/2023   Addressing increased to support a 64 location FIFO
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of ddrif2_wag_in is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_code process
signal rcode_rt_1_s                  :       std_logic_vector(5 downto 0); -- retime 1 of read address gray code
signal rcode_rt_2_s                  :       std_logic_vector(5 downto 0); -- retime 2 of read address gray code


-- raddr_decode process
signal raddr_s                       :       unsigned(5 downto 0); -- Read address

-- waddr_gen process
signal fifo_ready_s                  :       std_logic; -- Indcation the FIFO is able to take data (i.e. is not too full)
signal waddr_s                       :       unsigned(5 downto 0); -- Write address
signal wcode_s                       :       unsigned(5 downto 0); -- Gray code represenation of the Write address

begin


------------------------------------------------------------------------------
-- Process: retime_code
-- Retime the gray code representation of the Read Address
--
-----------------------------------------------------------------------------
retime_code: process(clk, resetn)
begin

  if resetn  = '0' then
    rcode_rt_1_s <= (others => '0');
    rcode_rt_2_s <= (others => '0');
  elsif rising_edge(clk) then
    
    -- retime  Read Pointer gray code onto the Write Clock domain
    rcode_rt_1_s <= RCODE;
    rcode_rt_2_s <= rcode_rt_1_s;
    
end if;
end process retime_code;    
 
------------------------------------------------------------------------------
-- Process: raddr_gray_decode
-- Decode of the gray code representation of the Read Address
--
-----------------------------------------------------------------------------
raddr_gray_decode: process(rcode_rt_2_s)
begin

  raddr_s(5) <= rcode_rt_2_s(5);
  raddr_s(4) <= rcode_rt_2_s(5) XOR rcode_rt_2_s(4); -- raddr_s(5) XOR rcode_rt_2_s(4)
  raddr_s(3) <= rcode_rt_2_s(5) XOR rcode_rt_2_s(4) XOR rcode_rt_2_s(3); -- raddr_s(4) XOR rcode_rt_2_s(3)
  raddr_s(2) <= rcode_rt_2_s(5) XOR rcode_rt_2_s(4) XOR rcode_rt_2_s(3) XOR rcode_rt_2_s(2); -- raddr_s(3) XOR rcode_rt_2_s(2)
  raddr_s(1) <= rcode_rt_2_s(5) XOR rcode_rt_2_s(4) XOR rcode_rt_2_s(3) XOR rcode_rt_2_s(2) XOR rcode_rt_2_s(1); -- raddr_s(2) XOR rcode_rt_2_s(1)
  raddr_s(0) <= rcode_rt_2_s(5) XOR rcode_rt_2_s(4) XOR rcode_rt_2_s(3) XOR rcode_rt_2_s(2) XOR rcode_rt_2_s(1) XOR rcode_rt_2_s(0); -- raddr_s(1) XOR rcode_rt_2_s(0)


    
end process raddr_gray_decode;  



------------------------------------------------------------------------------
-- Process: waddr_gen
-- Write Address Generator
-- Generates the FIFO write address and a gray code representation of the
-- write address.
-----------------------------------------------------------------------------
waddr_gen: process(clk, resetn)
-- Use a variable so we can generate the new write address and gray code
-- representation of the write address simultaneously from D-type output
variable waddr_v     : unsigned(5 downto 0);
variable addr_diff_v : unsigned(5 downto 0);

begin

  if resetn  = '0' then
    fifo_ready_s <= '0';
    waddr_s <= (others => '0');
    wcode_s <= (others => '0');
  elsif rising_edge(clk) then
  -- assign the variable before using it
   waddr_v := waddr_s;
  
   -- check if the FIFO is can accept data
   -- write address
   -- If getting full this will result in upstream requests being paused
   -- There must be a safety gap of 48 locations to allow for the fact 
   -- that the sender of data may not stop immediately when the wait request
   -- is asserted by DDRIF2
   addr_diff_v := raddr_s - waddr_s;
   if addr_diff_v > 48  then
     fifo_ready_s <= '1';
   else 
     fifo_ready_s <= '0'; 
   end if;
    
   -- increment the write address if there is data to be stored
   if VALID = '1' then
     waddr_v := waddr_v + 1;    
   end if;
   
   -- assign the variable to the new write address and gray code 
   waddr_s <= waddr_v;  
   wcode_s(5) <= waddr_v(5);
   wcode_s(4) <= waddr_v(5) XOR waddr_v(4);
   wcode_s(3) <= waddr_v(4) XOR waddr_v(3);
   wcode_s(2) <= waddr_v(3) XOR waddr_v(2);     
   wcode_s(1) <= waddr_v(2) XOR waddr_v(1);    
   wcode_s(0) <= waddr_v(1) XOR waddr_v(0);    
     
end if;
end process waddr_gen;    



-- Concurrent assignments
assign_fifo_ready : FIFO_READY <= fifo_ready_s;
assign_fifo_ready_out : FIFO_READY_OUT <= fifo_ready_s;
assign_waddr : WADDR <= STD_LOGIC_VECTOR(waddr_s);
assign_wcode : WCODE <= STD_LOGIC_VECTOR(wcode_s);

end architecture synth;





