----------------------------------------------------------------------------
-- Module Name:  ddrif2_tx_proc_if
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- FDAS Core Processing Tx Termination (for read from DDR SDRAM)
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   03/07/2017   Initial revision.
-- 0.2  RMD   05/09/2017   Renamed resetn to rst_sys_n
-- 0.3  RMD   02/09/2022   Remove the dependence of DDR_RD_WAIT_REQUEST on
--                         DDR_RC_EN. Include FIFO_READY_IN_1, 
--                         FIFO_READY_IN_2, FIFO_FULL_IN_1 and FIFO_FULL_IN_2 
--                         to control DDR_RD_WAIT_REQUEST
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

architecture synth of ddrif2_tx_proc_if is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- wait_request_gen process
signal ddr_rd_wait_request_s         :       std_logic; -- Wait request indication 

-- address_to_fifo process
signal valid_s                       :       std_logic; -- Indication the address to DDR memory is valid
signal tx_addr_proc_s                :       std_logic_vector(31 downto 0); --  Address of DDR SDRAM memory  (byte address for 4 Gibi-byte memory)


-- data_from_fifo process
signal ddr_read_data_valid_s         :       std_logic; -- Indication to the FDAS Core that the data from DDR memory is valid
signal ddr_read_data_s               :       std_logic_vector(511 downto 0); -- Data from DDR memory to FDAS core


begin


------------------------------------------------------------------------------
-- Process: wait_request_gen
-- Generate the wait request
--
-----------------------------------------------------------------------------
wait_request_gen: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    ddr_rd_wait_request_s <= '1';
  elsif rising_edge(clk_sys) then
      
    -- default  
    ddr_rd_wait_request_s <= '1';
    
   
    
    -- Check that the RX FIFO is ready to accept information (i.e. has spare capacity)
    -- and that the DATA_FIFO for the data from DDR memory to the FDAS Core
    -- is not getting too full
    -- Include the FIFO_READY_IN and FIFO_FULL_IN signals from the up to other 
    -- two DDRIF2 modules that may be acting in unision with this DDRIF2 module.    
    if (FIFO_READY  = '1' and FIFO_READY_IN_1 = '1' and FIFO_READY_IN_2  = '1') and
       (FIFO_FULL = '0' and FIFO_FULL_IN_1 = '0' and FIFO_FULL_IN_2  = '0') then
      ddr_rd_wait_request_s <= '0';
    end if;
   
        
  end if;
end process wait_request_gen;
   

------------------------------------------------------------------------------
-- Process: address_to_fifo
-- Transfers the incoming data to the RX_FIFO
--
-----------------------------------------------------------------------------
address_to_fifo: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    valid_s <= '0';
    tx_addr_proc_s <= (others => '0');
  elsif rising_edge(clk_sys) then
 
    -- default  
    valid_s <= '0';  
 
    -- if the wait request is low and the read enable is active
    -- then store the address as it arrives, asserting valid_s to
    -- the RX_FIFO to indicate there is information to store
    if ddr_rd_wait_request_s = '0' and DDR_RD_EN = '1' then
      --tx_addr_proc_s <= (others => '1');
      tx_addr_proc_s <= DDR_RD_ADDR;
      valid_s <= '1';
    end if;
   
  end if;

end process address_to_fifo;


------------------------------------------------------------------------------
-- Process: data_from_fifo
-- Transfers the incoming DDR memory address to the ADDR_FIFO
--
-----------------------------------------------------------------------------
data_from_fifo: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    ddr_read_data_valid_s <= '0';
    ddr_read_data_s <= (others => '0');
  elsif rising_edge(clk_sys) then
 
    -- default  
    ddr_read_data_valid_s <= '0';  
  
    if VALID_DATA  = '1'  then
      ddr_read_data_valid_s <= '1';
      ddr_read_data_s <= TX_DATA;
    end if;
   
  end if;

end process data_from_fifo;


-- Concurrent assignments
assign_ddr_rd_wait_request : DDR_RD_WAIT_REQUEST <= ddr_rd_wait_request_s; 
assign_valid : VALID <= valid_s; 
assign_tx_addr_proc : TX_ADDR_PROC <= tx_addr_proc_s;
assign_ddr_read_data_valid: DDR_RD_DATA_VALID <= ddr_read_data_valid_s;
assign_ddr_read_data: DDR_RD_DATA <= ddr_read_data_s;


end architecture synth;


