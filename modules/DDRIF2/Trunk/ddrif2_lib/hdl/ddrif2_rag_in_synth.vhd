----------------------------------------------------------------------------
-- Module Name:  ddrif2_rag_in
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Read Address Generator 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  05/09/2017   Renamed resetn to rst_ddr_n
-- 0.2  RMD  13/01/2023   Addressing increased to support a 64 location FIFO
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

architecture synth of ddrif2_rag_in is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_code process
signal wcode_rt_1_s                  :       std_logic_vector(5 downto 0); -- retime 1 of write address gray code
signal wcode_rt_2_s                  :       std_logic_vector(5 downto 0); -- retime 2 of write address gray code


-- waddr_decode process
signal waddr_s                       :       unsigned(5 downto 0); -- Write address

-- raddr_gen process
signal req_s                         :       std_logic; -- request (Read or Write)
signal raddr_s                       :       unsigned(5 downto 0); -- Read address
signal rcode_s                       :       unsigned(5 downto 0); -- Gray code represenation of the Read address


-- retime_request process
signal req_rt_1_s                    :       std_logic; -- retime 1 of request (Read or Write)
signal req_rt_2_s                    :       std_logic; -- retime 2 of request (Read or Write)
signal req_rt_3_s                    :       std_logic; -- retime 3 of request (Read or Write)


begin


------------------------------------------------------------------------------
-- Process: retime_code
-- Retime the gray code representation of the Write Address
--
-----------------------------------------------------------------------------
retime_code: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    wcode_rt_1_s <= (others => '0');
    wcode_rt_2_s <= (others => '0');
  elsif rising_edge(clk_ddr) then
    
    -- retime  Read Pointer gray code onto the Read Clock domain
    wcode_rt_1_s <= WCODE;
    wcode_rt_2_s <= wcode_rt_1_s;
    
end if;
end process retime_code;    
 
------------------------------------------------------------------------------
-- Process: waddr_gray_decode
-- Decode of the gray code representation of the Write Address
--
-----------------------------------------------------------------------------
waddr_gray_decode: process(wcode_rt_2_s)
begin

  waddr_s(5) <= wcode_rt_2_s(5);
  waddr_s(4) <= wcode_rt_2_s(5) XOR wcode_rt_2_s(4); -- waddr_s(5) XOR wcode_rt_2_s(4)
  waddr_s(3) <= wcode_rt_2_s(5) XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3); -- waddr_s(4) XOR wcode_rt_2_s(3)
  waddr_s(2) <= wcode_rt_2_s(5) XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3) XOR wcode_rt_2_s(2); -- waddr_s(3) XOR wcode_rt_2_s(2)
  waddr_s(1) <= wcode_rt_2_s(5) XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3) XOR wcode_rt_2_s(2) XOR wcode_rt_2_s(1); -- waddr_s(2) XOR wcode_rt_2_s(1)
  waddr_s(0) <= wcode_rt_2_s(5) XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3) XOR wcode_rt_2_s(2) XOR wcode_rt_2_s(1) XOR wcode_rt_2_s(0); -- waddr_s(1) XOR wcode_rt_2_s(0)


    
end process waddr_gray_decode;  



------------------------------------------------------------------------------
-- Process: raddr_gen
-- Read Address Generator
-- Generates the FIFO read address and a gray code representation of the
-- read address.
-----------------------------------------------------------------------------
raddr_gen: process(clk_ddr, rst_ddr_n)
-- Use a variable so we can generate the new read address and gray code
-- representation of the read address simultaneously from D-type output
variable raddr_v : unsigned(5 downto 0);

begin

  if rst_ddr_n  = '0' then
    req_s <= '0';
    raddr_s <= (others => '1');
    rcode_s <= (others => '0');
  elsif rising_edge(clk_ddr) then
   -- assign the variable before using it
   raddr_v := raddr_s;
   
   -- Only increment if the DDR SDRAM is not requesting a wait
   -- Increment read address until it reaches the write address   
   if WAIT_REQ = '0' then 
     if raddr_s /= (waddr_s - 1)  then
       raddr_v := raddr_v + 1;
       req_s <= '1';
     else
       req_s <= '0';      
     end if;
   end if;
   
   -- assign the variable to the new read address and gray code
   raddr_s <= raddr_v;
   rcode_s(5) <= raddr_v(5);
   rcode_s(4) <= raddr_v(5) XOR raddr_v(4);
   rcode_s(3) <= raddr_v(4) XOR raddr_v(3);
   rcode_s(2) <= raddr_v(3) XOR raddr_v(2);     
   rcode_s(1) <= raddr_v(2) XOR raddr_v(1);       
   rcode_s(0) <= raddr_v(1) XOR raddr_v(0);       
     
end if;
end process raddr_gen;    


------------------------------------------------------------------------------
-- Process: retime_request
-- Retime the request to match the pipeline delays in the muxing
--
-----------------------------------------------------------------------------
retime_request: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    req_rt_1_s <= '0';
    req_rt_2_s <= '0';
    req_rt_3_s <= '0';
  elsif rising_edge(clk_ddr) then
    
    if WAIT_REQ = '0' then
      req_rt_1_s <= req_s;
      req_rt_2_s <= req_rt_1_s;
      req_rt_3_s <= req_rt_2_s;
    end if;
    
end if;
end process retime_request;    



-- Concurrent assignments
assign_write : REQ <= req_rt_2_s;
assign_raddr : RADDR <= STD_LOGIC_VECTOR(raddr_s);
assign_rcode : RCODE <= STD_LOGIC_VECTOR(rcode_s);

end architecture synth;


