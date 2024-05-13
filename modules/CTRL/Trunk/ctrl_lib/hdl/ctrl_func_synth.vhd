----------------------------------------------------------------------------
-- Module Name:  ctrl_func
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Control module for FDAS
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  11/07/2017   Initial revision.
-- 0.2  RMD  07/09/2017   Changed the name of the reset to rst_sys_n
--                        Addded meta stability to allow the Micro Configuration
--                        clock to be lower than CLK_SYS (future proofing).
-- 0.3  RMD  17/11/2017   Added Processing Timers.
-- 0.4  RMD  12/06/2023   Added Counts for CONV and HSUM DDR Acesses
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

architecture synth of ctrl_func is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- retime process
signal dm_trigger_ret_1_s            :       std_logic; -- Retime 1 of DM trigger from PCIe
signal dm_trigger_ret_2_s            :       std_logic; -- Retime 2 of DM trigger from PCIe
signal dm_trigger_ret_3_s            :       std_logic; -- Retime 3 of DM trigger from PCIe
signal man_cld_dm_trigger_ret_1_s    :       std_logic; -- Retime 1 of Manual CLD DM trigger from PCIe
signal man_cld_dm_trigger_ret_2_s    :       std_logic; -- Retime 2 of Manual CLD DM trigger from PCIe
signal man_cld_dm_trigger_ret_3_s    :       std_logic; -- Retime 3 of Manual CLD DM trigger from PCIe
signal man_conv_dm_trigger_ret_1_s   :       std_logic; -- Retime 1 of Manual CONV DM trigger from PCIe
signal man_conv_dm_trigger_ret_2_s   :       std_logic; -- Retime 2 of Manual CONV DM trigger from PCIe
signal man_conv_dm_trigger_ret_3_s   :       std_logic; -- Retime 3 of Manual CONV DM trigger from PCIe
signal man_hsum_dm_trigger_ret_1_s   :       std_logic; -- Retime 1 of Manual HSUM DM trigger from PCIe
signal man_hsum_dm_trigger_ret_2_s   :       std_logic; -- Retime 2 of Manual HSUM DM trigger from PCIe
signal man_hsum_dm_trigger_ret_3_s   :       std_logic; -- Retime 3 of Manual HSUM DM trigger from PCIe
signal man_cld_pause_rst_ret_1_s     :       std_logic; -- Retime 1 of Manual CLD Pause Reset from PCIe
signal man_cld_pause_rst_ret_2_s     :       std_logic; -- Retime 2 of Manual CLD Pause Reset from PCIe
signal man_cld_pause_rst_ret_3_s     :       std_logic; -- Retime 3 of Manual CLD Pause Reset from PCIe
signal man_conv_pause_rst_ret_1_s    :       std_logic; -- Retime 1 of Manual CONV Pause Reset from PCIe
signal man_conv_pause_rst_ret_2_s    :       std_logic; -- Retime 2 of Manual CONV Pause Reset from PCIe
signal man_conv_pause_rst_ret_3_s    :       std_logic; -- Retime 3 of Manual CONV Pause Reset from PCIe
signal man_hsum_pause_rst_ret_1_s    :       std_logic; -- Retime 1 of Manual HSUM Pause Reset from PCIe
signal man_hsum_pause_rst_ret_2_s    :       std_logic; -- Retime 2 of Manual HSUM Pause Reset from PCIe
signal man_hsum_pause_rst_ret_3_s    :       std_logic; -- Retime 3 of Manual HSUM Pause Reset from PCIe
signal cld_done_ret_1_s              :       std_logic; -- Retime 1 of CLD_DONE from CLD
signal conv_done_ret_1_s             :       std_logic; -- Retime 1 of CONV_DONE from CONV
signal hsum_done_ret_1_s             :       std_logic; -- Retime 1 of HSUM_DONE from HSUM


-- function_control process
signal cld_dm_trigger_s              :       std_logic; -- CLD function trigger
signal conv_dm_trigger_s             :       std_logic; -- CONV function trigger
signal hsum_dm_trigger_s             :       std_logic; -- HSUM function trigger
signal cld_dm_trigger_ret_1_s        :       std_logic; -- CLD function trigger pipeline retime
signal conv_dm_trigger_ret_1_s       :       std_logic; -- CONV function trigger pipeline retime
signal hsum_dm_trigger_ret_1_s       :       std_logic; -- HSUM function trigger pipeline retime
signal cld_pause_cnt_s               :       unsigned(31 downto 0); -- CLD Pause counter
signal conv_pause_cnt_s              :       unsigned(31 downto 0); -- CONV Pause counter
signal hsum_pause_cnt_s              :       unsigned(31 downto 0); -- HSUM Pause counter
signal latched_cld_done_s            :       std_logic; -- Latched indication that CLD has finished
signal latched_conv_done_s           :       std_logic; -- Latched indication that CONV has finished
signal latched_hsum_done_s           :       std_logic; -- Latched indication that HSUM has finished
signal cld_enable_s                  :       std_logic; -- CLD processing enable
signal conv_enable_s                 :       std_logic; -- CONV processing enable
signal hsum_enable_s                 :       std_logic; -- HSUM processing enable
signal cld_enable_ret_1_s            :       std_logic; -- CLD processing enable pipeline retime
signal conv_enable_ret_1_s           :       std_logic; -- CONV processing enable pipeline retime
signal hsum_enable_ret_1_s           :       std_logic; -- HSUM processing enable pipeline retime
signal cld_pause_cnt_mature_s        :       std_logic; -- Indication the CLD pause counter has matured
signal conv_pause_cnt_mature_s       :       std_logic; -- Indication the CONV pause counter has matured
signal hsum_pause_cnt_mature_s       :       std_logic; -- Indication the HSUM pause counter has matured    

--proc_time process
signal cld_timer_enable_s            :       std_logic; -- CLD Processing Time counter enable
signal cld_proc_time_s               :       unsigned(31 downto 0); -- CLD Processing time
signal conv_timer_enable_s           :       std_logic; -- CONV Processing Time counter enable
signal conv_proc_time_s              :       unsigned(31 downto 0); -- CONV Processing time
signal hsum_timer_enable_s           :       std_logic; -- HSUM Processing Time counter enable    
signal hsum_proc_time_s              :       unsigned(31 downto 0); -- HSUM Processing time

-- page_select_process
signal cld_page_s                    :       std_logic_vector(31 downto 0); -- CLD page base address
signal conv_page_s                   :       std_logic_vector(31 downto 0); -- CONV page base address  
signal hsum_page_s                   :       std_logic_vector(31 downto 0); -- HSUM page base address  

-- DDR Access Counts
signal conv_req_cnt_s                :       unsigned(31 downto 0); -- HSUM DDR Access Request Count
signal hsum_req_cnt_s                :       unsigned(31 downto 0); -- HSUM DDR Access Request Count
signal hsum_rec_cnt_s                :       unsigned(31 downto 0); -- HSUM DDR Access Receive Count

begin


------------------------------------------------------------------------------
-- Process: retime
-- Retime signals to allow subsequent rising edge detection
--
-----------------------------------------------------------------------------
retime: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    dm_trigger_ret_1_s <= '0';
    dm_trigger_ret_2_s <= '0';
    man_cld_dm_trigger_ret_1_s <= '0'; 
    man_cld_dm_trigger_ret_2_s <= '0'; 
    man_cld_dm_trigger_ret_3_s <= '0'; 
    man_conv_dm_trigger_ret_1_s <= '0';
    man_conv_dm_trigger_ret_2_s <= '0';
    man_conv_dm_trigger_ret_3_s <= '0';
    man_hsum_dm_trigger_ret_1_s <= '0';
    man_hsum_dm_trigger_ret_2_s <= '0';
    man_hsum_dm_trigger_ret_3_s <= '0';
    man_cld_pause_rst_ret_1_s <= '0';
    man_cld_pause_rst_ret_2_s <= '0';
    man_cld_pause_rst_ret_3_s <= '0';
    man_conv_pause_rst_ret_1_s <= '0';
    man_conv_pause_rst_ret_2_s <= '0';
    man_conv_pause_rst_ret_3_s <= '0';
    man_hsum_pause_rst_ret_1_s <= '0';
    man_hsum_pause_rst_ret_2_s <= '0';
    man_hsum_pause_rst_ret_3_s <= '0';
    cld_done_ret_1_s <= '0';
    conv_done_ret_1_s <= '0';
    hsum_done_ret_1_s <= '0';
  elsif rising_edge(clk_sys) then
   
 
    --DM_TRIGGER is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    dm_trigger_ret_1_s <= DM_TRIG;
    dm_trigger_ret_2_s <= dm_trigger_ret_1_s;
    dm_trigger_ret_3_s <= dm_trigger_ret_2_s;


    --MAN_CLD_DM_TRIGGER_CFG  is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_cld_dm_trigger_ret_1_s <= MAN_CLD_TRIG;
    man_cld_dm_trigger_ret_2_s <= man_cld_dm_trigger_ret_1_s;
    man_cld_dm_trigger_ret_3_s <= man_cld_dm_trigger_ret_2_s;

    --MAN_CONV_DM_TRIGGER_CFG  is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_conv_dm_trigger_ret_1_s <= MAN_CONV_TRIG;
    man_conv_dm_trigger_ret_2_s <= man_conv_dm_trigger_ret_1_s;
    man_conv_dm_trigger_ret_3_s <= man_conv_dm_trigger_ret_2_s;

    --MAN_HSUM_DM_TRIGGER_CFG  is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_hsum_dm_trigger_ret_1_s <= MAN_HSUM_TRIG;
    man_hsum_dm_trigger_ret_2_s <= man_hsum_dm_trigger_ret_1_s;
    man_hsum_dm_trigger_ret_3_s <= man_hsum_dm_trigger_ret_2_s;
    
    -- MAN_CLD_PAUSE_RST is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_cld_pause_rst_ret_1_s <= MAN_CLD_PAUSE_RST;    
    man_cld_pause_rst_ret_2_s <= man_cld_pause_rst_ret_1_s; 
    man_cld_pause_rst_ret_3_s <= man_cld_pause_rst_ret_2_s; 
    
    -- MAN_CONV_PAUSE_RST is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_conv_pause_rst_ret_1_s <= MAN_CONV_PAUSE_RST; 
    man_conv_pause_rst_ret_2_s <= man_conv_pause_rst_ret_1_s; 
    man_conv_pause_rst_ret_3_s <= man_conv_pause_rst_ret_2_s; 
    
    -- MAN_HSUM_PAUSE_RST is from the payload of a TLP via the PCIe Interface.
    --Micro Configuration on the CLK_MC domain so meta-protection required.
    man_hsum_pause_rst_ret_1_s <= MAN_HSUM_PAUSE_RST;
    man_hsum_pause_rst_ret_2_s <= man_hsum_pause_rst_ret_1_s;
    man_hsum_pause_rst_ret_3_s <= man_hsum_pause_rst_ret_2_s;
    
    -- retime of DONE signals
    cld_done_ret_1_s <= CLD_DONE;
    conv_done_ret_1_s <= CONV_DONE;
    hsum_done_ret_1_s <= HSUM_DONE;
 
  end if;
end process retime;
   

------------------------------------------------------------------------------
-- Process: function_control
-- FDAS Control Function
--
-----------------------------------------------------------------------------
function_control: process(clk_sys, rst_sys_n)

begin

  if rst_sys_n  = '0' then
    cld_dm_trigger_s <= '0';
    conv_dm_trigger_s <= '0';
    hsum_dm_trigger_s <= '0';
    cld_pause_cnt_s <= (others => '0');
    conv_pause_cnt_s <= (others => '0');
    hsum_pause_cnt_s <= (others => '0');
    latched_cld_done_s <= '1';
    latched_conv_done_s <= '1';
    latched_hsum_done_s <= '1';
    cld_enable_s <= '0';
    cld_pause_cnt_mature_s  <= '0';
    conv_enable_s <= '0';
    conv_pause_cnt_mature_s  <= '0';    
    hsum_enable_s <= '0';
    hsum_pause_cnt_mature_s  <= '0';      
  elsif rising_edge(clk_sys) then
    -- defaults  
    cld_dm_trigger_s <= '0';
    conv_dm_trigger_s <= '0';
    hsum_dm_trigger_s <= '0';
    
    --Done signals from the modules to the PCIe. Latch the Done Signal and disable the function
    if cld_done_ret_1_s = '0' and CLD_DONE = '1' then
      latched_cld_done_s <= '1';
      cld_enable_s <= '0';
    end if;
    
    if conv_done_ret_1_s = '0' and CONV_DONE = '1' then
      latched_conv_done_s <= '1';
      conv_enable_s <='0';
    end if;
    
    if hsum_done_ret_1_s = '0' and HSUM_DONE = '1' then
      latched_hsum_done_s <= '1';
      hsum_enable_s <= '0';
    end if;  
    
 
    
    --either manually control the functions or allow automatic control
    
    -- manual control
    if MAN_OVERRIDE = '1' then
 
	    --enable the functions and increment the pause counter until it matures
     if MAN_CLD_EN = '1'  and latched_cld_done_s = '0' then
        cld_enable_s <= '1'; -- level
        if MAN_CLD_PAUSE_EN = '1' then
          if std_logic_vector(cld_pause_cnt_s)= MAN_CLD_PAUSE_CNT then
            cld_enable_s <= '0'; -- level
            cld_pause_cnt_mature_s <= '1';
            if man_cld_pause_rst_ret_2_s = '1'  and man_cld_pause_rst_ret_3_s = '0' then
              cld_enable_s <= '1'; -- level
              cld_pause_cnt_s <= (others => '0');
              cld_pause_cnt_mature_s <= '0';
            end if;
          else
            cld_pause_cnt_s <= cld_pause_cnt_s + 1;
          end if;
        end if;
      else
        cld_enable_s <= '0'; -- level
      end if;	    
	    
     if MAN_CONV_EN = '1'  and latched_conv_done_s = '0' then
        conv_enable_s <= '1'; -- level
        if MAN_CONV_PAUSE_EN = '1' then
          if std_logic_vector(conv_pause_cnt_s)= MAN_CONV_PAUSE_CNT then
            conv_enable_s <= '0'; -- level
            conv_pause_cnt_mature_s <= '1';
            if man_conv_pause_rst_ret_2_s = '1'  and man_conv_pause_rst_ret_3_s = '0' then
              conv_enable_s <= '1'; -- level
              conv_pause_cnt_s <= (others => '0');
              conv_pause_cnt_mature_s <= '0';
            end if;
          else
            conv_pause_cnt_s <= conv_pause_cnt_s + 1;
          end if;
        end if;
      else
        conv_enable_s <= '0'; -- level
      end if;	    

     if MAN_HSUM_EN = '1'  and latched_hsum_done_s = '0' then
        hsum_enable_s <= '1'; -- level
        if MAN_HSUM_PAUSE_EN = '1' then
          if std_logic_vector(hsum_pause_cnt_s)= MAN_HSUM_PAUSE_CNT then
            hsum_enable_s <= '0'; -- level
            hsum_pause_cnt_mature_s <= '1';
            if man_hsum_pause_rst_ret_2_s = '1'  and man_hsum_pause_rst_ret_3_s = '0' then
              hsum_enable_s <= '1'; -- level
              hsum_pause_cnt_s <= (others => '0');
              hsum_pause_cnt_mature_s <= '0';
            end if;
          else
            hsum_pause_cnt_s <= hsum_pause_cnt_s + 1;
          end if;
        end if;
      else
        hsum_enable_s <= '0'; -- level
      end if;	          
      
          
	    --trigger the functions, initialise the pause counts and clear the Done signals from the previous DM (highest Priority)
      if man_cld_dm_trigger_ret_2_s = '1' and man_cld_dm_trigger_ret_3_s = '0' then
        if MAN_CLD_EN = '1' then
          cld_enable_s <= '1'; -- level
        end if;
        cld_dm_trigger_s <= '1'; --pulse
        cld_pause_cnt_s <= (others => '0');
        cld_pause_cnt_mature_s <= '0';
        latched_cld_done_s <= '0';
	    end if;

      if man_conv_dm_trigger_ret_2_s = '1' and man_conv_dm_trigger_ret_3_s = '0' then
        if MAN_CONV_EN = '1' then
          conv_enable_s <= '1'; -- level
        end if;
        conv_dm_trigger_s <= '1'; --pulse
        conv_pause_cnt_s <= (others => '0');
        conv_pause_cnt_mature_s <= '0';
        latched_conv_done_s <= '0';
	    end if;
	    
      if man_hsum_dm_trigger_ret_2_s = '1' and man_hsum_dm_trigger_ret_3_s = '0' then
        if MAN_HSUM_EN = '1' then
          hsum_enable_s <= '1'; -- level
        end if;
        hsum_dm_trigger_s <= '1'; --pulse
        hsum_pause_cnt_s <= (others => '0');
        hsum_pause_cnt_mature_s <= '0';
        latched_hsum_done_s <= '0';
	    end if;	          
    
    else -- automatic mode
      -- Start the Convolution Process
      if dm_trigger_ret_2_s = '1' and dm_trigger_ret_3_s = '0' then
        cld_dm_trigger_s <= '1'; --pulse
        cld_enable_s <= '1'; -- level
        latched_cld_done_s <= '0';
        conv_dm_trigger_s <= '1'; --pulse
        conv_enable_s <= '1'; -- level
        latched_conv_done_s <= '0';   
        hsum_dm_trigger_s <= '0'; --pulse
        hsum_enable_s <= '0'; -- level
        latched_hsum_done_s <= '0';   
      end if; 

      -- Start the Harmonic Summming Process when Convolution has finished
      if CONV_DONE = '1' then      
        hsum_dm_trigger_s <= '1'; --pulse
        hsum_enable_s <= '1'; -- level       
      end if; 
    end if; 
    
    
    -- Pipeline the trigger and enable signals so that they will align with the page information
    cld_dm_trigger_ret_1_s <= cld_dm_trigger_s;
    conv_dm_trigger_ret_1_s <= conv_dm_trigger_s;
    hsum_dm_trigger_ret_1_s <= hsum_dm_trigger_s;
    cld_enable_ret_1_s <= cld_enable_s;
    conv_enable_ret_1_s <= conv_enable_s;     
    hsum_enable_ret_1_s <= hsum_enable_s;
      
  end if;

end process function_control;


------------------------------------------------------------------------------
-- Process: proc_time
-- Measure the processing time of the FDAS functions in CLK_SYS cycles
--
-----------------------------------------------------------------------------
proc_time: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    cld_timer_enable_s <= '0';
    cld_proc_time_s <= (others => '0');
    conv_timer_enable_s <= '0';
    conv_proc_time_s <= (others => '0'); 
    hsum_timer_enable_s <= '0';   
    hsum_proc_time_s <= (others => '0');   
  elsif rising_edge(clk_sys) then
       
    -- When CLD has finished processing stop the timer
    if CLD_DONE = '1' then
      cld_timer_enable_s <= '0';
    end if;
    
     -- Increment the CLD timer, holding at the max value
    if cld_timer_enable_s = '1' then
      if cld_proc_time_s /= "11111111111111111111111111111111" then
        cld_proc_time_s <= cld_proc_time_s + 1;
      end if;
    end if;

    -- On a triggering of CLD reset the CLD processing time to 0 and enable the timer
    if cld_dm_trigger_s = '1' then
      cld_proc_time_s <= (others => '0');
      cld_timer_enable_s <= '1';
    end if;


    
    -- When CONV has finished processing stop the timer
    if CONV_DONE = '1' then
      conv_timer_enable_s <= '0';
    end if;
    
     -- Increment the CONV timer, holding at the max value
    if conv_timer_enable_s = '1' then
      if conv_proc_time_s /= "11111111111111111111111111111111" then
        conv_proc_time_s <= conv_proc_time_s + 1;
      end if;
    end if;      

    -- On a triggering of CONV reset the CONV processing time to 0 and enable the timer
    if conv_dm_trigger_s = '1' then
      conv_proc_time_s <= (others => '0');
      conv_timer_enable_s <= '1';
    end if;

   
    -- When CLD has finished processing stop the timer
    if HSUM_DONE = '1' then
      hsum_timer_enable_s <= '0';
    end if;
    
     -- Increment the CLD timer, holding at the max value
    if hsum_timer_enable_s = '1' then
      if hsum_proc_time_s /= "11111111111111111111111111111111" then
        hsum_proc_time_s <= hsum_proc_time_s + 1;
      end if;
    end if;  

    -- On a triggering of HSUM reset the HSUM processing time to 0 and enable the timer
    if hsum_dm_trigger_s = '1' then
      hsum_proc_time_s <= (others => '0');
      hsum_timer_enable_s <= '1';
    end if;


   
  end if;
end process proc_time;


------------------------------------------------------------------------------
-- Process: access_count
-- Count the number of DDR access requests and the number 
-- of received words
-----------------------------------------------------------------------------
access_count: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    conv_req_cnt_s <= (others => '1');
    hsum_req_cnt_s <= (others => '1');
    hsum_rec_cnt_s <= (others => '1');
  elsif rising_edge(clk_sys) then
  
    if conv_wr_en = '1' and conv_waitreq = '0' then -- DDRIF2s will have accepted a request
      conv_req_cnt_s <= conv_req_cnt_s + 1;
    end if;
           
    if hsum_rd_en = '1' and hsum_waitreq = '0' then -- DDRIF2s will have accepted a request
      hsum_req_cnt_s <= hsum_req_cnt_s + 1;
    end if;
        
    if hsum_valid = '1' then -- DDRIF2s will have provided a data word which HSUM has to accept
      hsum_rec_cnt_s <= hsum_rec_cnt_s + 1;
    end if;    
    
 
    -- When CONV is triggered, clear the counts
    if conv_dm_trigger_s = '1' then  -- this is a pulse
      conv_req_cnt_s <= (others => '0');
    end if;        
    
    -- When HSUM is triggered, clear the counts
    if hsum_dm_trigger_s = '1' then  -- this is a pulse
      hsum_req_cnt_s <= (others => '0');
      hsum_rec_cnt_s <= (others => '0');
    end if;    
    
  end if;
end process access_count;



------------------------------------------------------------------------------
-- Process: page_select
-- Select the memory pages based on the information from the PCIe
--
-----------------------------------------------------------------------------
page_select: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    cld_page_s <= (others => '0');
    conv_page_s <= (others => '0');    
    hsum_page_s <= (others => '0');   
  elsif rising_edge(clk_sys) then
    
    -- in this implementation the pages are fixed at the start of the DDR memory
    if cld_dm_trigger_s = '1' then
      if PAGE = '0' then
        cld_page_s <= (others => '0');
      else
        cld_page_s <= (others => '0');             
      end if;
    end if;

    if conv_dm_trigger_s = '1' then
      if PAGE = '0' then
        conv_page_s <= (others => '0');
      else
        conv_page_s <= (others => '0');             
      end if;
    end if;    
    
    if hsum_dm_trigger_s = '1' then
     if PAGE = '0' then
        hsum_page_s <= (others => '0');
      else
        hsum_page_s <= (others => '0');             
      end if;
    end if;        
    
  end if;
end process page_select;
   



-- concurrent assignments
assign_cld_page:        CLD_PAGE           <=   cld_page_s;
assign_conv_page:       CONV_PAGE          <=   conv_page_s;
assign_hsum_page:       HSUM_PAGE          <=   hsum_page_s;
assign_cld_enable:      CLD_ENABLE         <=   cld_enable_ret_1_s;
assign_conv_enable:     CONV_ENABLE        <=   conv_enable_ret_1_s;
assign_hsum_enable:     HSUM_ENABLE        <=   hsum_enable_ret_1_s;
assign_cld_trigger:     CLD_TRIGGER        <=   cld_dm_trigger_ret_1_s;
assign_conv_trigger:    CONV_TRIGGER       <=   conv_dm_trigger_ret_1_s;
assign_hsum_trigger:    HSUM_TRIGGER       <=   hsum_dm_trigger_ret_1_s;
assign_cld_paused:      CLD_PAUSED         <=   cld_pause_cnt_mature_s;
assign_conv_paused:     CONV_PAUSED        <=   conv_pause_cnt_mature_s;
assign_hsum_paused:     HSUM_PAUSED        <=   hsum_pause_cnt_mature_s;
assign_cld_done:        LATCHED_CLD_DONE   <=   latched_cld_done_s;
assign_conv_done:       LATCHED_CONV_DONE  <=   latched_conv_done_s;
assign_hsum_done:       LATCHED_HSUM_DONE  <=   latched_hsum_done_s;
assign_cld_proc_time:   CLD_PROC_TIME      <=   std_logic_vector(cld_proc_time_s);
assign_conv_proc_time:  CONV_PROC_TIME     <=   std_logic_vector(conv_proc_time_s); 
assign_hsum_proc_time:  HSUM_PROC_TIME     <=   std_logic_vector(hsum_proc_time_s);
assign_conv_req_cnt:    CONV_REQ_CNT       <=   std_logic_vector(conv_req_cnt_s); 
assign_hsum_req_cnt:    HSUM_REQ_CNT       <=   std_logic_vector(hsum_req_cnt_s); 
assign_hsum_rec_cnt:    HSUM_REC_CNT       <=   std_logic_vector(hsum_rec_cnt_s);

end architecture synth;


