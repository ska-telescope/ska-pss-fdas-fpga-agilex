----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_mux
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- receive mux 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  05/09/2015   Renamed resetn to rst_ddr_n
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

architecture synth of ddrif2_rx_mux is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- sel process
signal data_sel_s                    :       std_logic_vector(511 downto 0); -- selected data
signal addr_sel_s                    :       std_logic_vector(31 downto 0); -- selected address
signal write_sel_s                   :       std_logic; -- selected Write request
signal read_sel_s                    :       std_logic; -- selected Read request


begin


------------------------------------------------------------------------------
-- Process: sel
-- Select the Address and Data to be written to DDR memory
--
-----------------------------------------------------------------------------
sel: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    data_sel_s <= (others => '0');
    addr_sel_s <= (others => '0');
    write_sel_s <= '0';
    read_sel_s <= '0';    
  elsif rising_edge(clk_ddr) then
    
    if WAIT_REQ  = '0' then
      if PCIE_PROC_SEL = '1' then
        data_sel_s <= RX_DATA_PCIE;
        addr_sel_s <= RX_ADDR_PCIE;
        write_sel_s <= RX_WRITE_PCIE and RX_PCIE_REQ; -- write qaulified by PX_PCIE_REQ
        read_sel_s <= RX_READ_PCIE and RX_PCIE_REQ; -- read qaulified by PX_PCIE_REQ
      else
        data_sel_s <= RX_DATA_PROC;
        addr_sel_s <= RX_ADDR_PROC;
        write_sel_s <= RX_WRITE_PROC and RX_PROC_REQ;-- write qaulified by PX_PROC_REQ
        read_sel_s <= RX_READ_PROC and RX_PROC_REQ; -- read qaulified by PX_PROC_REQ
      end if; 
    end if;       
      
    
  end if;
end process sel;    
 
 
 


-- Concurrent assignments
assign_data  : DDR_DATA_OUT <= data_sel_s;
assign_addr  : DDR_ADDR_OUT <= addr_sel_s;
assign_write : WRITE_OUT <= write_sel_s;
assign_read  : READ_OUT <= read_sel_s;

end architecture synth;


