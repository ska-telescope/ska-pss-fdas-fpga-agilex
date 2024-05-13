----------------------------------------------------------------------------
-- Module Name: ram_mux
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Mux for RAM 
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  8/6/2017   Initial revision.
-- 0.2  RMD  11/8/2017  Correction to ensure the data is set to 0 when
--                      padding is required
-- 0.3  RMD  06/9/2017  Renamed resetn to rst_sys_n
-- 0.4  RMD  27/9/2017  Correction to side_s and conv_data_sel_s since
--                      vector width is dependent on ddr_g
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

architecture synth of ram_mux is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------

-- retime process
signal read_addr_ret_1_s             :       std_logic_vector(ddr_g + 1 downto 0);

-- edge_det process
signal wait_req_ret_1_s              :       std_logic; -- retime of wait req
signal side_s                        :       std_logic_vector((ddr_g*512) -1 downto 0);


-- sel process
signal conv_data_sel_s               :       std_logic_vector((ddr_g*512) -1 downto 0); -- selected information from RAM or siding

-- out_en process
signal conv_data_s                   :       std_logic_vector(63 downto 0); 



begin


------------------------------------------------------------------------------
-- Process: retime
-- Retime the address so it is pipelined to match the data from the RAM
-- 
-----------------------------------------------------------------------------
retime: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
      read_addr_ret_1_s <= (others => '0');
  elsif rising_edge(clk_sys) then
    if WAIT_REQ = '0' then
      read_addr_ret_1_s <= READ_ADDR;
    end if;
  end if;
    
    
end process retime;


------------------------------------------------------------------------------
-- Process: egde_det
-- Detect the rising edge of wait_req
-- And at the rising edge of wait req, capture the data out of the RAM in the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
edge_det: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    wait_req_ret_1_s <= '0';
    side_s <= (others => '0');
  elsif rising_edge(clk_sys) then
    wait_req_ret_1_s <= WAIT_REQ;
    if wait_req_ret_1_s = '0' and WAIT_REQ = '1' then  
        side_s <= RAM_DATA;
    end if;      
      
  end if;
end process edge_det;    


------------------------------------------------------------------------------
-- Process: sel
-- Select either the data from the RAM or the siding or zeros if padding is required
-- which has further selection and retime
-----------------------------------------------------------------------------
sel: process(wait_req_ret_1_s, FFT_ZEROS, RAM_DATA, side_s)


begin

  if wait_req_ret_1_s = '0' then
    conv_data_sel_s <= RAM_DATA;
  else 
    conv_data_sel_s <= side_s;
  end if;
  
  if FFT_ZEROS = '1' then
    conv_data_sel_s <= (others => '0');
  end if;

end process sel;     


------------------------------------------------------------------------------
-- Process: out_en
-- At the rising edge of wait request, capture the data out of the RAM in the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
out_en: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
      conv_data_s <= (others => '0');
  elsif rising_edge(clk_sys) then
    if WAIT_REQ = '0' then
      conv_data_s <= conv_data_sel_s(64*(TO_INTEGER(UNSIGNED(read_addr_ret_1_s))) + 63 downto 64*(TO_INTEGER(UNSIGNED(read_addr_ret_1_s))));
    end if;                 
  end if;
end process out_en;    


-- Concurrent assignments
assign_conv_data : CONV_DATA <= conv_data_s; 

end architecture synth;


