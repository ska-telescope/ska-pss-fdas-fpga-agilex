----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_ram_en
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
--  Rx RAM Enable 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  05/09/2017   Renamed resetn to rst_ddr_n

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

architecture synth of ddrif2_rx_ram_en is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- edge_det process
signal wait_req_ret_1_s              :       std_logic; -- retime of wait req


-- siding process
signal side_s                        :       std_logic_vector(545 downto 0); -- information from RAM in siding


-- sel process
signal bo_sel_s                      :       std_logic_vector(545 downto 0); -- selected information from RAM or siding


-- out_en process
signal ddr_data_out_s                :       std_logic_vector(511 downto 0); -- enabled output data
signal ddr_addr_out_s                :       std_logic_vector(31 downto 0); -- enabled output address
signal ddr_write_out_s               :       std_logic; -- enabled write indication
signal ddr_read_out_s                :       std_logic; -- enabled read indication

             

begin


------------------------------------------------------------------------------
-- Process: egde_det
-- Detect the rising edge of wait_req
-- And at the rising edge of wait req, capture the data out of the RAM in the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
edge_det: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    wait_req_ret_1_s <= '0';
    side_s <= (others => '0');
  elsif rising_edge(clk_ddr) then
    
    
    wait_req_ret_1_s <= WAIT_REQ;
    if wait_req_ret_1_s = '0' and WAIT_REQ = '1' then
     side_s <= BO;
    end if;       
      
  end if;
end process edge_det;    
 
 
------------------------------------------------------------------------------
-- Process: sel
-- Select either the data from the RAM or the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
sel: process(wait_req_ret_1_s, BO, side_s)


begin

  if wait_req_ret_1_s = '0' then
    bo_sel_s <= BO;
  else 
    bo_sel_s <= side_s;
  end if;
  

end process sel;     


------------------------------------------------------------------------------
-- Process: out_en
-- At teh rising edge of wait request, capture the data out of the RAM in the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
out_en: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
      ddr_data_out_s <= (others => '0');
      ddr_addr_out_s <= (others => '0');
      ddr_write_out_s <= '0';
      ddr_read_out_s <= '0';
  elsif rising_edge(clk_ddr) then
    
    if WAIT_REQ = '0' then
      ddr_data_out_s <= bo_sel_s(543 downto 32);
      ddr_addr_out_s <= bo_sel_s(31 downto 0);
      ddr_write_out_s <= bo_sel_s(545);
      ddr_read_out_s <= bo_sel_s(544);
    end if;        
             
  end if;
end process out_en;    

-- Concurrent assignments
assign_data : DDR_DATA_OUT <= ddr_data_out_s;
assign_addr : DDR_ADDR_OUT <= ddr_addr_out_s;
assign_write : DDR_WRITE_OUT <= ddr_write_out_s;
assign_read : DDR_READ_OUT <= ddr_read_out_s;

end architecture synth;


