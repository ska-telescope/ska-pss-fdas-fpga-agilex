----------------------------------------------------------------------------
-- Module Name:  cld_ddr_rag
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- DDR Read Address Generator for the CLD module
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  23/5/2017   Initial revision.
-- 0.2  RMD  3/7/2017    Changed generic names to make more meaningful
--                       Changed ddr_addr_num signal to fop_ddr_addr_num 
--                       to make more meaningful
-- 0.3  RMD  6/9/2017    Renamed resetn to rst_sys_n
-- 0.4  RMD  13/11/2017  FOP_DDR_ADDR_NUM no longer required
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

architecture synth of cld_ddr_rag is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_trigger process
signal cld_trigger_ret_1_s           :       std_logic; -- Retime 1 CLD_TRIGGER from the ctrl module
signal cld_trigger_s                 :       std_logic; -- Trigger pulse
  
-- ddr_addr_gen process
signal count_enable_s                :       std_logic; -- Enable the incrementing of addresses to DDRIF for an FFT
signal count_valid_s                 :       unsigned(fft_ddr_addr_num_width_g -1 downto 0); -- Count of Valid 512-bit words from DDRIF for a FFT
signal ddr_num_s                     :       unsigned(fft_ddr_addr_num_width_g -1 downto 0); -- Count of Read requests to DDRIF for an FFT
signal ddr_addr_s                    :       unsigned(25 downto 0); -- Upper 26 bits of the address to DDRIF 
signal ddr_read_s                    :       std_logic; -- Read request indication to DDRIF
signal ddr_count_s                   :       unsigned(fop_ddr_addr_max_width_g -1 downto 0); -- Count of Read requests to DDRIF for the DM
signal ddr_done_s                    :       std_logic; -- Indication that all the required samples have been received from DDRIF






begin


------------------------------------------------------------------------------
-- Process: retime_trigger
-- Retime the Trigger signals from the PCIe
--
-----------------------------------------------------------------------------
retime_trigger: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    cld_trigger_ret_1_s <= '0';
    cld_trigger_s <= '0';
  elsif rising_edge(clk_sys) then
    --Default
    cld_trigger_s <= '0';
    
    cld_trigger_ret_1_s <= CLD_TRIGGER;
    
    -- only process if CLD is enabled
    if CLD_ENABLE = '1' then
      if CLD_TRIGGER = '1' and cld_trigger_ret_1_s = '0' then
        cld_trigger_s <= '1';
      end if;
    end if;
 
  end if;
end process retime_trigger;
   

------------------------------------------------------------------------------
-- Process: ddr_addr_gen
-- DDR Read Address Generator 
--
-----------------------------------------------------------------------------
ddr_addr_gen: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    count_enable_s <= '0';
    count_valid_s <= (others => '0');
    ddr_num_s <= (others => '0');
    ddr_addr_s <= (others => '0');  
    ddr_read_s <= '0';
    ddr_count_s <= (others => '0');
    ddr_done_s <= '0';
  elsif rising_edge(clk_sys) then
    --default
    ddr_read_s <='0';
    ddr_done_s <= '0';
   
    -- DDR_EN pulse from FIFO WAG enables the reading of a batch of DDR addresses
    if DDR_EN = '1' then
      count_enable_s <= '1';
      count_valid_s <= (others => '0');
      ddr_num_s <= (others => '0');   
    end if;
      
    -- Enabled to read a batch of DDR addresses
    if count_enable_s = '1' then
      -- finish if we have read the required number of addressess for an FFT
      if ddr_num_s = TO_UNSIGNED(fft_ddr_addr_num_g -1, fft_ddr_addr_num_width_g) and WAIT_REQUEST = '0' then
        -- increment the DDR address ready for the next FFT since the last one has been used
        ddr_addr_s <= ddr_addr_s + 1;  -- upper bits of address to DDRIF
        ddr_count_s <= ddr_count_s + 1; -- count of addresses read for the DM
        count_enable_s <= '0';
        ddr_num_s <= (others => '0');
      else
        -- request to read data
        ddr_read_s <= '1';
        -- Always respect the WAIT signal from DDRIF
        if ddr_read_s = '1' and WAIT_REQUEST = '0' then
          -- keep incrementing the counters if DDRIF is able to accept a read request
          ddr_addr_s <= ddr_addr_s + 1;  -- upper bits of address to DDRIF 
          ddr_count_s <= ddr_count_s + 1; -- count of addresses read for the DM
          ddr_num_s <= ddr_num_s + 1;  -- count of addresses read for an FFT
        end if;
      end if;
    end if;
         
    if DATA_VALID = '1' then
      if count_valid_s = TO_UNSIGNED(fft_ddr_addr_num_g -1, fft_ddr_addr_num_width_g) then
        ddr_done_s <= '1';
      else
        count_valid_s <= count_valid_s + 1;
      end if;
    end if;     
      
    if cld_trigger_s = '1' then
      -- reset the address to the base address for the page as indicated by the CTRL module.
      -- only assign the part of the address to CLD_PAGE that is actually incrementing
      ddr_addr_s <= UNSIGNED(CLD_PAGE(31 downto 6));  
      ddr_count_s <= (others => '0');
    end if;
  
  end if;

end process ddr_addr_gen;

-- Concurrent assignments
assign_ddr_read: DDR_READ <= ddr_read_s; -- request data from DDR
assign_ddr_address : DDR_ADDR <= STD_LOGIC_VECTOR(ddr_addr_s) & "000000"; -- 32-bit address with the lower 6-bits unused since the data bus is 512-bits (64 bytes)
assign_ddr_done : DDR_DONE <= ddr_done_s; -- Indication read data has arrived for the addresses for an FFT

end architecture synth;





