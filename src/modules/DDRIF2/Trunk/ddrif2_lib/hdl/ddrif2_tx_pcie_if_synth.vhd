----------------------------------------------------------------------------
-- Module Name:  ddrif2_tx_pcie_if
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- PCIe Tx Termination (for read from DDR SDRAM)
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   03/07/2017   Initial revision.
-- 0.2  RMD   05/09/2017   Renamed resetn to rst_pcie_n
-- 0.3  RMD   17/11/2017   Fix by JT to allow odd size bursts with the overall
--                         number of tranfers being even. Also removed the
--                         dependency on the rising edge of WR_DMA_READ
-- 0.4  RMD   28/03/2022   Data interface to PCIe Hard IP Macro now 512-bit
--                         with 4-bit Burst Count
-- 0.5  RMD   07/09/2022   Removed the dependence of WR_DMA_WAIT_REQUEST
--                         on WR_DMA_ADDRESS[33:32]. 
--                         WR_DMA_ADDRESS is now only 32 bits
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of ddrif2_tx_pcie_if is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- wait_request_gen process
signal wr_dma_wait_request_internal_s  :       std_logic; -- Internal Wait request indication 

-- address_data_to_fifo process
signal valid_s                         :       std_logic; -- Indication the address/data to DDR memory is valid
signal tx_addr_pcie_s                  :       std_logic_vector(31 downto 0); --  Address of DDR SDRAM memory  (byte address for 4 Gibi-byte memory)
signal burst_counter_s                 :       unsigned(3 downto 0); -- Counter for the burst
signal wr_dma_wait_request_s           :       std_logic; -- Wait request indication 
 
-- data_from_fifo process
signal wr_dma_read_data_valid_s        :       std_logic; -- Indication to the PCIe Hard IP macro that the data from DDR memory is valid
signal wr_dma_read_data_s              :       std_logic_vector(511 downto 0); -- Data from DDR memory to the PCIe Hard IP macro


begin


------------------------------------------------------------------------------
-- Process: wait_request_gen
-- Generate the wait request
--
-----------------------------------------------------------------------------
wait_request_gen: process(clk_pcie, rst_pcie_n)
begin

  if rst_pcie_n  = '0' then
    wr_dma_wait_request_internal_s <= '0';
  elsif rising_edge(clk_pcie) then
      
    -- default  
    wr_dma_wait_request_internal_s <= '1';
    
    -- Check that the RX_FIFO is ready to accept information (i.e. has spare capacity) 
    -- and that the data FIFO is not full
    if FIFO_READY = '1' and  FIFO_FULL = '0'  then
      wr_dma_wait_request_internal_s <= '0';
    end if;      
      
  end if;
end process wait_request_gen;
   

------------------------------------------------------------------------------
-- Process: address_to_fifo
-- Transfers the incoming DDR memory address and data to the ADDR_FIFO
--
-----------------------------------------------------------------------------
address_to_fifo: process(clk_pcie, rst_pcie_n)

begin

  if rst_pcie_n  = '0' then
    valid_s <= '0';
    tx_addr_pcie_s <= (others => '0');
    burst_counter_s <= (others => '0');
    wr_dma_wait_request_s <= '1';
  elsif rising_edge(clk_pcie) then
   
    -- default  
    valid_s <= '0';
    wr_dma_wait_request_s <= '1';
   
    -- if the wait request is low and the read enable is active
    -- then store the address as it arrives, asserting valid_s to
    -- the ADDR_FIFO to indicate there is information to store
    if wr_dma_wait_request_internal_s = '0' then
      -- at the start of a burst, or when the previous burst has finished and WR_DMA_READ remains asserted
      -- de-assert wr_dma_wait_request_s to allow capture the address, burst size and first data word.
      -- burst_counter_s: 0 = parked position of burst with a sinble beat, 
      --                  1 = last access of the burst with more than one beat
      if burst_counter_s = 0 or burst_counter_s = 1 then 
        wr_dma_wait_request_s <= '0';
      end if;
    end if;
      
    -- only keep wr_dma_wait_request_s low until the information for the burst is captured
    if wr_dma_wait_request_s = '0' then
      if WR_DMA_READ = '1' then
        tx_addr_pcie_s <= WR_DMA_ADDRESS;
        burst_counter_s <= UNSIGNED(WR_DMA_BURST_COUNT) -1;
        -- only if the burst is greater than 1 stop further accesses as internally generating further read accesses of the burst
        -- and no more information from the PCIe Hard IP Macro is needed
        if UNSIGNED(WR_DMA_BURST_COUNT) > 1 then
          wr_dma_wait_request_s <= '1';     
        end if;
        valid_s <= '1';         
      end if;
    elsif burst_counter_s /= 0 and wr_dma_wait_request_internal_s = '0' then
      -- decrement the burst counter for each 512-bit PCIe access
      burst_counter_s <= burst_counter_s - 1;

      -- increment the next address by 512-bit/ 1-byte = 64  byte locations
      tx_addr_pcie_s <= STD_LOGIC_VECTOR(UNSIGNED(tx_addr_pcie_s) + 64);       
      valid_s <= '1';
    end if;
  
   
  end if;

end process address_to_fifo;


------------------------------------------------------------------------------
-- Process: data_from_fifo
-- Transfers the incoming DDR memory address to the ADDR_FIFO
--
-----------------------------------------------------------------------------
data_from_fifo: process(clk_pcie, rst_pcie_n)

begin

  if rst_pcie_n  = '0' then
    wr_dma_read_data_valid_s <= '0';
    wr_dma_read_data_s <= (others => '0');
  elsif rising_edge(clk_pcie) then
 
    -- default  
    wr_dma_read_data_valid_s <= '0';  
  
    if VALID_DATA  = '1'  then
      wr_dma_read_data_valid_s <= '1';
      wr_dma_read_data_s <= TX_DATA;
    end if;
   
  end if;

end process data_from_fifo;



-- Concurrent assignments
assign_wr_dma_wait_request : WR_DMA_WAIT_REQUEST <= wr_dma_wait_request_s; 
assign_valid : VALID <= valid_s; 
assign_tx_addr_pcie : TX_ADDR_PCIE <= tx_addr_pcie_s;
assign_wr_dma_read_data_valid: WR_DMA_READ_DATA_VALID <= wr_dma_read_data_valid_s;
assign_wr_dma_read_data: WR_DMA_READ_DATA <= wr_dma_read_data_s;


end architecture synth;


