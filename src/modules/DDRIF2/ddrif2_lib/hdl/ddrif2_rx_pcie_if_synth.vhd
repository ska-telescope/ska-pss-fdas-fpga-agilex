----------------------------------------------------------------------------
-- Module Name:  ddrif2_rx_pcie_if
--
-- Source Path:
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- PCIe Rx Termination (for write to DDR SDRAM)
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   03/07/2017   Initial revision.
-- 0.2  RMD   05/07/2017   Renamed resetn to rst_pcie_n
-- 0.3  RMD   17/11/2017   Fix by JT to allow odd size bursts with the overall
--                         number of tranfers being even. Also removed the
--                         dependency on the rising edge of RD_DMA_WRITE
-- 0.4  RJH   24/03/2020   Removed 256 d-types from data pipeline to reduce
--                         fanout on enable signal to help timing.
--                         Changed burst counter to a down counter, and
--                         allowed design to work with burst of 1.
-- 0.4  RMD   01/04/2022   Data interface to PCIe Hard IP Macro now 512-bit
--                         with 4-bit Burst Count
-- 0.5  RMD   16/01/2023   Removed the rd_dma_wait_request_s qualification
--                         for taking data from the PCIe as the PCIe
--                         Hard IP Macro can send data after WaitRequest
--                         has de-asserted.
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

architecture synth of ddrif2_rx_pcie_if is

--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------

-- wait_request_gen process
signal rd_dma_wait_request_s : std_logic; -- Wait request indication 

-- address_data_to_fifo process
signal valid_s               : std_logic; -- Indication the address/data to DDR memory is valid.
signal rx_data_pcie_s        : std_logic_vector(511 downto 0); -- Data to DDR SDRAM memory.
signal rx_addr_pcie_s        : std_logic_vector(31 downto 0);  -- Address of DDR SDRAM memory (byte address for 4 Gibi-byte memory).
signal burst_counter_s       : unsigned(3 downto 0);           -- Counter for the burst.

begin

------------------------------------------------------------------------------
-- Process: wait_request_gen
-- Generate the wait request.
--
-----------------------------------------------------------------------------
wait_request_gen: process(clk_pcie, rst_pcie_n)
begin

  if rst_pcie_n  = '0' then
    -- Initialise.
    rd_dma_wait_request_s <= '1';

  elsif rising_edge(clk_pcie) then

    -- Default wait request to active, i.e. not ready.
    rd_dma_wait_request_s <= '1';

    -- Check that the RX_FIFO is ready to accept information (i.e. has spare capacity),
    if FIFO_READY = '1' then
      rd_dma_wait_request_s <= '0'; -- Indicate ready to receive data.
    end if;

  end if;
end process wait_request_gen;


------------------------------------------------------------------------------
-- Process: address_data_to_fifo
-- Transfers the incoming DDR memory address and data to the RX_FIFO
--
-----------------------------------------------------------------------------
address_data_to_fifo: process(clk_pcie, rst_pcie_n)
begin

  if rst_pcie_n = '0' then
    -- Initialise.
    valid_s             <= '0';
    rx_data_pcie_s      <= (others => '0');
    rx_addr_pcie_s      <= (others => '0');
    burst_counter_s     <= (others => '0');

  elsif rising_edge(clk_pcie) then

    -- Default.
    valid_s <= '0';

    -- If the write enable is active
    -- then store the address/data as it arrives, asserting valid_s to
    -- the RX_FIFO to indicate there is information to store.
    if RD_DMA_WRITE = '1' then
      -- At the start of a burst, or when the previous burst has finished and
      -- RD_DMA_WRITE remains asserted capture the address and set burst counter.
      if burst_counter_s = 0 then
        rx_addr_pcie_s      <= RD_DMA_ADDRESS(31 downto 0);
        burst_counter_s     <= unsigned(RD_DMA_BURST_COUNT) - 1;       
        valid_s             <= '1';
      else
        -- Decrement the burst counter for each 512-bit PCIe access.
        burst_counter_s <= burst_counter_s - 1;
        -- Increment the next address by 512-bit/1-byte = 64 byte locations.
        rx_addr_pcie_s <= STD_LOGIC_VECTOR(UNSIGNED(rx_addr_pcie_s) + 64);       
        valid_s        <= '1';
      end if; -- burst_counter_s = 0

      -- Shift write data.
      rx_data_pcie_s <= RD_DMA_WRITE_DATA;

    end if; -- RD_DMA_WRITE = '1'

  end if;

end process address_data_to_fifo;

-- Concurrent assignments.
assign_wait_request : RD_DMA_WAIT_REQUEST <= rd_dma_wait_request_s;
assign_valid        : VALID               <= valid_s;
assign_rx_data_pcie : RX_DATA_PCIE        <= rx_data_pcie_s;
assign_rx_addr_pcie : RX_ADDR_PCIE        <= rx_addr_pcie_s;

end architecture synth;

