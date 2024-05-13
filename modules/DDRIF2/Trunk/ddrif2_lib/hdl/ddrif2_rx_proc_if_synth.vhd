----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_proc_if
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- FDAS Core Processing Rx Termination (for write to DDR SDRAM)
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   03/07/2017   Initial revision.
-- 0.2  RMD   05/09/2017   Renamed resetn to rst_sys_n
-- 0.3  RMD   02/09/2022   Remove the dependence of DDR_WR_WAIT_REQUEST on
--                         DDR_WR_EN. Include FIFO_READY_IN_1 and 
--                         FIFO_READY_IN_2 to control DDR_WR_WAIT_REQUEST
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

architecture synth of ddrif2_rx_proc_if is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- wait_request_gen process
signal ddr_wr_wait_request_s         :       std_logic; -- Wait request indication 

-- address_data_to_fifo process
signal valid_s                       :       std_logic; -- Indication the address/data to DDR memory is valid
signal rx_data_proc_s                :       std_logic_vector(511 downto 0); --  Data to DDR SDRAM memory 
signal rx_addr_proc_s                :       std_logic_vector(31 downto 0); --  Address of DDR SDRAM memory  (byte address for 4 Gibi-byte memory)


begin


------------------------------------------------------------------------------
-- Process: wait_request_gen
-- Generate the wait request
--
-----------------------------------------------------------------------------
wait_request_gen: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    ddr_wr_wait_request_s <= '1';
  elsif rising_edge(clk_sys) then
      
    -- default  
    ddr_wr_wait_request_s <= '1';
    
    
    
    -- Check that the RX_FIFO is ready to accept information (i.e. has spare capacity)
    -- Include the FIFO_READY_IN signals from the up to other two DDRIF2 modules that may
    -- be acting in unision with this DDRIF2 module.
    if FIFO_READY  = '1' and FIFO_READY_IN_1 = '1' and FIFO_READY_IN_2 = '1' then
      ddr_wr_wait_request_s <= '0';
    end if;
    
        
  end if;
end process wait_request_gen;
   

------------------------------------------------------------------------------
-- Process: address_data_to_fifo
-- Transfers the incoming DDR memory address and data to the RX_FIFO
--
-----------------------------------------------------------------------------
address_data_to_fifo: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    valid_s <= '0';
    rx_data_proc_s <= (others => '0');
    rx_addr_proc_s <= (others => '0');
    
  elsif rising_edge(clk_sys) then
 
    -- default  
    valid_s <= '0';  
   
    
    -- if the wait request is low and the write enable is active
    -- then store the address/data as it arrives, asserting valid_s to
    -- the RX_FIFO to indicate there is information to store
    if ddr_wr_wait_request_s = '0' and DDR_WR_EN = '1' then
      rx_data_proc_s <= DDR_WR_DATA;
      rx_addr_proc_s <= DDR_WR_ADDR;
      valid_s <= '1';
    end if;
   
  end if;

end process address_data_to_fifo;

-- Concurrent assignments
assign_ddr_wr_wait_request : DDR_WR_WAIT_REQUEST <= ddr_wr_wait_request_s; 
assign_valid : VALID <= valid_s; 
assign_rx_data_proc : RX_DATA_PROC <= rx_data_proc_s;
assign_rx_addr_proc : RX_ADDR_PROC <= rx_addr_proc_s;


end architecture synth;

