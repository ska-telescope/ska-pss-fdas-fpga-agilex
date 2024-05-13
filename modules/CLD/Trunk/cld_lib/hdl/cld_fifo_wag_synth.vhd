----------------------------------------------------------------------------
-- Module Name:  cld_fifo_wag
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- FIFO Write Address Generator for the CLD module
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  24/5/2017   Initial revision.
-- 0.2  RMD  06/9/2017   Renamed resetn to rst_sys_n
-- 0.3  RMD  09/11/2017  Ensure all the requested data is stored in the FIFO
--                       regardless of whether the write_sample_count_s has
--                       reached its limit.
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

architecture synth of cld_fifo_wag is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_trigger process
signal cld_trigger_ret_1_s           :       std_logic; -- Retime 1 CLD_TRIGGER from the ctrl module
signal cld_trigger_s                 :       std_logic; -- Trigger pulse
  
-- fifo_waddr_gen process
signal ddr_en_s                      :       std_logic; -- Enable the requesting of samples from DDRIF
signal difference_check_s            :       std_logic; -- Enable the checking of the difference between the read and write sample counts
signal fifo_waddr_s                  :       unsigned(fifo_waddr_width_g -1 downto 0); -- FIFO write address
signal write_sample_count_s          :       unsigned(sample_count_width_g -1 downto 0); -- Write sample count
signal ddr_reading_finished_s        :       std_logic; -- Flag to indicate the reading of samples from DDR memory for the DM has finished     


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
-- Process: fifo_waddr_gen
-- FIFO Write Address Generator 
--
-----------------------------------------------------------------------------
fifo_waddr_gen: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    ddr_en_s <='0';
    difference_check_s <= '0';
    fifo_waddr_s <= (others => '0');
    write_sample_count_s <= (others => '0'); 
    ddr_reading_finished_s <= '0';
  elsif rising_edge(clk_sys) then
    --default
    ddr_en_s <='0';
    
       
    -- if CLD is enabled
    -- if the read sample counter has not reached it's limit and it's value is less than two FFTs worth of samples greater than the write sample count value
   if (write_sample_count_s < UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)))  and 
      (UNSIGNED(COMPLETED_READ_SAMPLE) + TO_UNSIGNED(2*fft_g, sample_count_width_g) > write_sample_count_s) and 
       difference_check_s = '1' and CLD_ENABLE = '1' then
      -- stop checking the difference between read and write sample while we get more samples
      difference_check_s <= '0';
      -- Enable the requesting of more samples from DDRIF
      ddr_en_s <='1';
    end if;
    
    
   if (write_sample_count_s = UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)))  then
      ddr_reading_finished_s <= '1';
    end if;    
    
      
    -- if the correct number of reads from DDR have occurred re-enable checking of sample counters
    if DDR_DONE = '1' then
      difference_check_s <= '1';
    end if;
    
    
    if DATA_VALID = '1' then
      -- increment the FIFO address to store the data
      fifo_waddr_s <= fifo_waddr_s + 1;
      -- increment the sample counter, based on the number of DDR interfaces there are
      case ddr_g is 
        when 1 =>  -- 512-bit data bus from DDRIF containing 8-off 64-bit samples
          if write_sample_count_s < TO_UNSIGNED(TO_INTEGER(UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)) - 7), sample_count_width_g)  then  
            write_sample_count_s <= write_sample_count_s + 8;
          else
            write_sample_count_s <= UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0));
          end if;
        when 2 =>  -- 1024-bit data bus from DDRIF containing 16-off 64-bit samples
          if write_sample_count_s < TO_UNSIGNED(TO_INTEGER(UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)) - 15), sample_count_width_g)  then  
            write_sample_count_s <= write_sample_count_s + 16;   
          else
            write_sample_count_s <= UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0));
          end if;
        when 3 => -- 1536-bit data bus from DDRIF containing 24-off 64-bit samples
          if write_sample_count_s < TO_UNSIGNED(TO_INTEGER(UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)) - 23), sample_count_width_g)  then       
            write_sample_count_s <= write_sample_count_s + 24; 
          else
            write_sample_count_s <= UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0));
          end if;
        when others =>
           null; 
      end case;     
      
      
      
      
    end if;
   
    if cld_trigger_s = '1' then
      -- reset the FIFO write address and the sample counter
      fifo_waddr_s <= (others => '0');  
      write_sample_count_s <= (others => '0');
      -- enable the checking of the difference between the read and write sample values.
      difference_check_s <= '1';
      -- Set the ddr reading finished flag to 0
      ddr_reading_finished_s <= '0';
    end if;
  
  end if;

end process fifo_waddr_gen;

-- Concurrent assignments
assign_fifo_waddr : FIFO_WADDR <= STD_LOGIC_VECTOR(fifo_waddr_s); 
assign_write_sample_count : WRITE_SAMPLE <= STD_LOGIC_VECTOR(write_sample_count_s);
assign_ddr_en : DDR_EN <= ddr_en_s; 
assign_ddr_reading_finished : DDR_READING_FINISHED <= ddr_reading_finished_s; 


end architecture synth;





