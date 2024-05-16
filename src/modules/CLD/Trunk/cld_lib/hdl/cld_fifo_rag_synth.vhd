----------------------------------------------------------------------------
-- Module Name:  cld_fifo_rag
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- FIFO Read Address Generator for the CLD module
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  25/5/2017   Initial revision.
-- 0.2  RMD  02/7/2017   CLD_DONE now qaulified by wait_req_s do that it always
--                       aligns with the EOF
-- 0.3  RMD  06/09/2017  Renamed resetn to rst_sys_n
-- 0.4  RMD  27/09/2017  Corrected the FIFO read address generation when ddr_g = 3
--                       due to the fact that it is not a natural rollover
-- 0.5  RMD  09/11/2017  Ensure the sample counters and fifo addresses increment
--                       for the next read, even when the overlap is being 
--                       calculated
-- 0.6  RMD  01/10/2018  Correction to the test to determine if another FFT
--                       should be started.
--                       Line 158 was:- 
--                       if (completed_read_sample_count_s < UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0))) and
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

architecture synth of cld_fifo_rag is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime_trigger process
signal cld_trigger_ret_1_s           :       std_logic; -- Retime 1 CLD_TRIGGER from the ctrl module
signal cld_trigger_s                 :       std_logic; -- Trigger pulse
  
-- fifo_raddr_gen process
signal difference_check_s            :       std_logic; -- Enable the checking of the difference between the read and write sample counts
signal conv_req_s                    :       std_logic; -- Covolution Request Flag to CONV
signal valid_s                       :       std_logic; -- Valid indication of samples to CONV
signal sof_s                         :       std_logic; -- Start of FFT Flag to CONV
signal eof_s                         :       std_logic; -- End of FFT Flag to CONV
signal fifo_raddr_s                  :       unsigned(fifo_raddr_width_g -1 downto 0); -- FIFO Read address
signal fft_sample_count_s            :       unsigned(fft_count_width_g -1 downto 0); -- FFT sample count
signal read_sample_count_s           :       unsigned(sample_count_width_g -1 downto 0); -- Read sample count
signal completed_read_sample_count_s :       unsigned(sample_count_width_g -1 downto 0); -- Completed read sample count
signal cld_done_s                    :       std_logic; -- CLD_DONE Pulse
signal done_sent_s                   :       std_logic; -- Indication CLD_DONE pulse has been sent
signal pad_needed_s                  :       std_logic; -- Zeros padding required
signal pad_count_s                   :       unsigned(fft_count_width_g -1 downto 0); -- Count for the first FFT to contain zeros
signal pad_limit_s                   :       unsigned(fft_count_width_g -1 downto 0);
signal fft_zeros_s                   :       std_logic; -- Flag to Insert 0's in the FFT        
signal fft_start_en_early_s          :       std_logic; -- FFT Start flag
signal fft_start_en_s                :       std_logic; -- Early FFT Start flag



-- retime_flags process
signal conv_req_rt1_s                :       std_logic; -- Retime of Covolution Request Flag to CONV
signal valid_rt1_s                   :       std_logic; -- Retime of Valid indication of samples to CONV
signal sof_rt1_s                     :       std_logic; -- Retime of Start of FFT Flag to CONV
signal eof_rt1_s                     :       std_logic; -- Retime of End of FFT Flag to CONV
signal fft_sample_count_ret_1_s      :       unsigned(fft_count_width_g -1 downto 0); -- First retime of Read sample count
signal fft_sample_count_ret_2_s      :       unsigned(fft_count_width_g -1 downto 0); -- Second retime of Read sample count 


-- wait_gen process
signal wait_req_s                    :       std_logic; -- Wait request

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
-- Process: fifo_raddr_gen
-- FIFO Read Address Generator 
--
-----------------------------------------------------------------------------
fifo_raddr_gen: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    difference_check_s <= '0';           
    conv_req_s  <= '0';    
    valid_s <= '0';
    sof_s  <= '0';                       
    eof_s  <= '0';                       
    fifo_raddr_s <= (others => '0');                 
    fft_sample_count_s <= (others => '0');             
    read_sample_count_s <= (others => '0');            
    completed_read_sample_count_s <= (others => '0');
    cld_done_s <= '0';
    done_sent_s <= '0';
    pad_needed_s <= '0';
    pad_count_s <= (others => '0');
    pad_limit_s <= (others => '0');
    fft_zeros_s <= '0';
    fft_start_en_early_s <= '0';
    fft_start_en_s <= '0';
  elsif rising_edge(clk_sys) then
    
    -- default
    cld_done_s <= '0';

  
    -- if CLD is enabled
    -- if there are enough samples to perform an FFT
    -- raise the conv request and stop checking the difference between samples
    if (UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)) - completed_read_sample_count_s >= TO_UNSIGNED(fft_g, sample_count_width_g)) and 
       (completed_read_sample_count_s + TO_UNSIGNED(fft_g, sample_count_width_g) <= UNSIGNED(WRITE_SAMPLE)) and 
       difference_check_s = '1' and  CLD_ENABLE = '1' and fft_start_en_s = '1' then -- fft_start_en_s is purely to 
       -- keep the data in a contiguous block if CONV were to negate READY when EOF is negated
       -- for fastet response omit fft_start_en_s = '1'from this IF statement
      conv_req_s <= '1';
      difference_check_s <= '0';
      fft_start_en_s <= '0';
      fft_sample_count_s <= (others => '0');
    end if;
      
    -- set DONE flag when all samples for the DM have been passed to CONV
    -- Not that if it is no possible to provide a full FFTs worth of data the final samples of the DM will not be processed
    -- (i.e if we have a 1024 point FFT and there are up to 1023 samples remaining for the DM they will not be processed)
    if DDR_READING_FINISHED = '1' and difference_check_s = '1' and wait_req_s = '0' then
      if ((UNSIGNED(fop_sample_num(sample_count_width_g-1 downto 0)) - completed_read_sample_count_s) < TO_UNSIGNED(fft_g, sample_count_width_g)) and done_sent_s = '0' then
        cld_done_s <= '1';
        done_sent_s <= '1';
      end if;
    end if;
      
    -- CONV ready to take samples for an FFT
    if wait_req_s = '0' then
      -- defaults which only take affect if wait request is low
      valid_s <= '0';
      sof_s <= '0';
      eof_s <= '0';
      fft_start_en_early_s <= '0';
      --if difference_check_s = '0'  then
      if conv_req_s = '1' then

        -- if zeros padding is complete
        -- increment the FIFO address and DM sample number
        -- ensure that FIFO contents continue to be used from now on
        if (pad_needed_s = '0') or ((pad_needed_s = '1') and (pad_count_s = pad_limit_s)) then 
            read_sample_count_s <= read_sample_count_s + 1;
            fifo_raddr_s <= fifo_raddr_s + 1;
            pad_needed_s <= '0';
            fft_zeros_s <= '0';
            -- if the ddr_g = 3 we don't have a natural rollover
            -- 24 samples are stored in each location of the fifo RAM
            if ddr_g = 3 then
              if fifo_raddr_s(4 downto 0) = "10111" then -- rollover 
                fifo_raddr_s(fifo_raddr_width_g -1 downto 5) <= fifo_raddr_s(fifo_raddr_width_g -1 downto 5) + 1;
                fifo_raddr_s(4 downto 0) <= "00000";
              end if;
            end if;
        -- If  padding with zeros is needed
        else
            pad_count_s <= pad_count_s + 1;
            fft_zeros_s <= '1';
        end if;
      
        -- always increment the FFT sample number
        fft_sample_count_s <= fft_sample_count_s + 1;
        valid_s <= '1';
      
        -- For the first sample of an FFT assert the SOF 
        if fft_sample_count_s = 0 then
          sof_s <= '1';
        end if;   
        -- The number of samples for the FFT have been delivered to CONV
        -- Hence checking the difference between read and write pointers of the FIFO can re-commence
        -- The Completed Sample count and FIFO read pointer are determined by taking into account the FFT overlap.
        -- For the last sample of an FFT assert the EOF 
        if fft_sample_count_s = TO_UNSIGNED(fft_g-1, fft_count_width_g) then
          -- set conv_req_s to 0 since the request has been granted.
          conv_req_s <= '0';
          eof_s <= '1';
          difference_check_s <= '1';
          fft_start_en_early_s <= '1';
          -- overlap is greater than half the FFT so we still need to pad with zeros
          if read_sample_count_s < UNSIGNED(OVERLAP_SIZE) then
            read_sample_count_s <= (others => '0');
            completed_read_sample_count_s <= (others => '0');
            fifo_raddr_s <= (others => '0');
            pad_needed_s <= '1';
            pad_count_s <= (others => '0');
            pad_limit_s <= (UNSIGNED(OVERLAP_SIZE(fft_count_width_g -1 downto 0))) - read_sample_count_s(fft_count_width_g -1 downto 0);
          -- overlap is less than or equal to the FFT so we don't need to pad with zeros any more
          else
            read_sample_count_s <= read_sample_count_s + 1 - UNSIGNED(OVERLAP_SIZE); 
            completed_read_sample_count_s <= read_sample_count_s - UNSIGNED(OVERLAP_SIZE); 
            fifo_raddr_s <= fifo_raddr_s + 1 - UNSIGNED(OVERLAP_SIZE(fft_count_width_g -1 downto 0));
            -- if the ddr_g = 3 we don't have a natural rollover
            -- 24 samples are stored in each location of the fifo RAM
            if ddr_g = 3 then
              if (fifo_raddr_s(4 downto 0) + 1 >= UNSIGNED(OVERLAP_REM)) and (fifo_raddr_s(4 downto 0) /= "10111") then
                fifo_raddr_s(fifo_raddr_width_g -1 downto 5) <= fifo_raddr_s(fifo_raddr_width_g -1 downto 5) - UNSIGNED(OVERLAP_INT(fft_count_width_g -6 downto 0));  
                fifo_raddr_s(4 downto 0) <= fifo_raddr_s(4 downto 0) + 1 - UNSIGNED(OVERLAP_REM);
              end if;             
              if (fifo_raddr_s(4 downto 0) + 1 >= UNSIGNED(OVERLAP_REM)) and (fifo_raddr_s(4 downto 0) = "10111") then
                if UNSIGNED(OVERLAP_REM) = 0 then
                  fifo_raddr_s(fifo_raddr_width_g -1 downto 5) <= fifo_raddr_s(fifo_raddr_width_g -1 downto 5) - UNSIGNED(OVERLAP_INT(fft_count_width_g -6 downto 0)) + 1;  
                  fifo_raddr_s(4 downto 0) <= "00000";
                else  
                  fifo_raddr_s(fifo_raddr_width_g -1 downto 5) <= fifo_raddr_s(fifo_raddr_width_g -1 downto 5) - UNSIGNED(OVERLAP_INT(fft_count_width_g -6 downto 0));  
                  fifo_raddr_s(4 downto 0) <= fifo_raddr_s(4 downto 0) + 1 - UNSIGNED(OVERLAP_REM);                
                end if; 
              end if;

              if fifo_raddr_s(4 downto 0) + 1 < UNSIGNED(OVERLAP_REM) then
                fifo_raddr_s(fifo_raddr_width_g -1 downto 5) <= fifo_raddr_s(fifo_raddr_width_g -1 downto 5) - UNSIGNED(OVERLAP_INT(fft_count_width_g -6 downto 0)) - 1;  
                fifo_raddr_s(4 downto 0) <= 24 - (UNSIGNED(OVERLAP_REM) - fifo_raddr_s(4 downto 0)) + 1;
              end if;    
            end if;  
              
          end if;
        end if;  
      end if;
    end if;

    if fft_start_en_early_s = '1' then
      fft_start_en_s <= '1';
    end if;
       
    if cld_trigger_s = '1' then
      -- reset the FIFO write address and the sample counter
      fifo_raddr_s <= (others => '0');  
      read_sample_count_s <= (others => '0');
      fft_sample_count_s <= (others => '0');
      completed_read_sample_count_s <= (others => '0');
      fft_start_en_s <= '1';
      pad_needed_s <= '1';
      pad_count_s <= (others => '0');
      pad_limit_s <= UNSIGNED(OVERLAP_SIZE(fft_count_width_g -1 downto 0));
      fft_zeros_s <= '0';
      -- enable the checking of the difference between the read and write sample values.
      difference_check_s <= '1';
      -- Ensure no convolution is currently requested
      conv_req_s <= '0';
      -- reset the DONE sent flag
      done_sent_s <= '0';
    end if;
  
  end if;

end process fifo_raddr_gen;



------------------------------------------------------------------------------
-- Process: retime_flags
-- FIFO Read Address Generator 
--
-----------------------------------------------------------------------------
retime_flags: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
               
    conv_req_rt1_s  <= '0';    
    valid_rt1_s <= '0';
    sof_rt1_s  <= '0';                       
    eof_rt1_s  <= '0'; 
    fft_sample_count_ret_1_s <= (others => '0');
    fft_sample_count_ret_2_s <= (others => '0');                       
  elsif rising_edge(clk_sys) then
    -- retime to keep in phase with CONV_DATA
    if wait_req_s = '0' then
      conv_req_rt1_s  <= conv_req_s;
      valid_rt1_s <= valid_s;
      sof_rt1_s <= sof_s;
      eof_rt1_s <= eof_s;
      fft_sample_count_ret_1_s <= fft_sample_count_s;
      fft_sample_count_ret_2_s <= fft_sample_count_ret_1_s; 
    end if; 
   
  end if;

end process retime_flags;


------------------------------------------------------------------------------
-- Process: wait_gen
-- FIFO Read Address Generator 
--
-----------------------------------------------------------------------------
wait_gen: process(READY, valid_rt1_s)

begin

  if READY = '0' and valid_rt1_s = '1' then
    wait_req_s <= '1';
  else
    wait_req_s <= '0'; 
  end if;         
 
end process wait_gen;




-- Concurrent assignments
assign_completed_read_sample_count : COMPLETED_READ_SAMPLE <= STD_LOGIC_VECTOR(completed_read_sample_count_s); 
assign_conv_req : CONV_REQ <= conv_req_rt1_s;
assign_valid : VALID <= valid_rt1_s;
assign_sof : SOF <= sof_rt1_s;
assign_eof : EOF <= eof_rt1_s;
assign_fifo_rddr : FIFO_RADDR <= STD_LOGIC_VECTOR(fifo_raddr_s); 
assign_fft_sample_number : FFT_SAMPLE <= STD_LOGIC_VECTOR(fft_sample_count_ret_2_s);
assign_cld_done : CLD_DONE <= cld_done_s;
assign_fft_zeros : FFT_ZEROS <= fft_zeros_s;
assign_wait_req : WAIT_REQ <= wait_req_s;

end architecture synth;


