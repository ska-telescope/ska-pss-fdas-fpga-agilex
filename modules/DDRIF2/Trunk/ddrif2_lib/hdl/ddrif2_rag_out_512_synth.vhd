----------------------------------------------------------------------------
-- Module Name:  ddrif_rag_out_512
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
-- 0.1  RMD  30/5/2017   Initial revision.
-- 0.2  RMD  05/09/2017  Changed clock and reset names
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

architecture synth of ddrif2_rag_out_512 is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_code process
signal wcode_rt_1_s                  :       std_logic_vector(8 downto 0); -- retime 1 of write address gray code
signal wcode_rt_2_s                  :       std_logic_vector(8 downto 0); -- retime 2 of write address gray code


-- waddr_decode process
signal waddr_s                       :       unsigned(8 downto 0); -- Write address

-- raddr_gen process
signal fifo_full_s                   :       std_logic;
signal valid_data_s                  :       std_logic;
signal raddr_s                       :       unsigned(8 downto 0); -- Read address

-- retime_valid process
signal valid_data_rt_1_s             :       std_logic;

begin


------------------------------------------------------------------------------
-- Process: retime_code
-- Retime the gray code representation of the Write Address
--
-----------------------------------------------------------------------------
retime_code: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    wcode_rt_1_s <= (others => '0');
    wcode_rt_2_s <= (others => '0');
  elsif rising_edge(clk_sys) then
    
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

  waddr_s(8) <= wcode_rt_2_s(8);
  waddr_s(7) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7); -- waddr_s(8) XOR wcode_rt_2_s(7)
  waddr_s(6) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6); -- waddr_s(7) XOR wcode_rt_2_s(6)
  waddr_s(5) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5); -- waddr_s(6) XOR wcode_rt_2_s(5)
  waddr_s(4) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5) 
                XOR wcode_rt_2_s(4); -- waddr_s(5) XOR wcode_rt_2_s(4)  
  waddr_s(3) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5) 
                XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3); -- waddr_s(4) XOR wcode_rt_2_s(3)   
  waddr_s(2) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5) 
                XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3)  XOR wcode_rt_2_s(2); -- waddr_s(3) XOR wcode_rt_2_s(2)   
  waddr_s(1) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5) 
                XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3)  XOR wcode_rt_2_s(2) XOR wcode_rt_2_s(1); -- waddr_s(2) XOR wcode_rt_2_s(1)   
  waddr_s(0) <= wcode_rt_2_s(8) XOR wcode_rt_2_s(7) XOR wcode_rt_2_s(6) XOR wcode_rt_2_s(5) 
                XOR wcode_rt_2_s(4) XOR wcode_rt_2_s(3)  XOR wcode_rt_2_s(2) XOR wcode_rt_2_s(1) 
                XOR wcode_rt_2_s(0); -- waddr_s(1) XOR wcode_rt_2_s(0)  

  end process waddr_gray_decode;  



------------------------------------------------------------------------------
-- Process: raddr_gen
-- Read Address Generator
-- Generates the FIFO read address 
-----------------------------------------------------------------------------
raddr_gen: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    valid_data_s <= '0';
    fifo_full_s <= '0';
    raddr_s <= (others => '1');
  elsif rising_edge(clk_sys) then
   
    -- default
    valid_data_s <= '0';
    fifo_full_s <= '0';
   
   
    -- Increment read address until it reaches the write address
    if raddr_s /= waddr_s - 1 then
      raddr_s <= raddr_s + 1;
      valid_data_s <= '1';
    end if;
    
    if waddr_s - raddr_s > 256 then
     fifo_full_s <= '1';
    end if;
     
   
     
  end if;
end process raddr_gen;    


------------------------------------------------------------------------------
-- Process: retime_valid
-- Retime the request to match the pipeline delays 
--
-----------------------------------------------------------------------------
retime_valid: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    valid_data_rt_1_s <= '0';
   
  elsif rising_edge(clk_sys) then  
    valid_data_rt_1_s <= valid_data_s;  
  end if;
  
end process retime_valid;    




-- Concurrent assignments
assign_valid_data : VALID_DATA <= valid_data_rt_1_s;
assign_fifo_full : FIFO_FULL <= fifo_full_s;
assign_raddr : RADDR <= STD_LOGIC_VECTOR(raddr_s);

end architecture synth;




