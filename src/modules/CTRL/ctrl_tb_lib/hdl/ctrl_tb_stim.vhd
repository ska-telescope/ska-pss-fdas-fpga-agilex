----------------------------------------------------------------------------
-- Module Name:  CTRL Test Bench
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the CTRL Module
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  06/07/2017   Initial revision.
-- 0.2  RMD  07/09/2017   Added separate clock domain for micro configuration
--                        Changed the name of the system reset.
-- 0.3  RMD  15/09/2017   Added CONV_FFT_READY
-- 0.4  RMD  13/11/2017   FOP_DDR_ADDR_NUM not required.
-- 0.5  RMD  17/11/2017   Added Processing Timers.
-- 0.6  RMD  06/05/2022   CTRL address now (18:0) to provide address decode space for the MSIX module
-- 0.7  RMD  12/06/2023   Added diagnostic counts for the CONV and HSUM DDR SDRAM Acesses
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






library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;
use std.textio.all;
library ctrl_lib;
use ctrl_lib.ctrl;


architecture stim of ctrl_tb is
  -- Define clock period.
  constant ck_per_c   		: time := 5 ns; -- 200MHz clock
  constant ck_mc_per_c    : time := 8 ns; -- 200MHz clock

  -- Signal declarations.
  -- CTRL Module MCI Interface
  signal mcaddr_s                        : std_logic_vector(18 downto 0);
  signal mcdatain_s 		                 : std_logic_vector(31 downto 0);
  signal mcrwn_s    		                 : std_logic;
  signal mcms_s 		                     : std_logic; 
  signal mcdataout_s 		                 : std_logic_vector(31 downto 0);
  
  
  -- CTRL Module CLD/CONV/HSUM Interface
  signal overlap_size_s                  : std_logic_vector(9 downto 0);
  signal fop_sample_num_s                : std_logic_vector(22 downto 0);
  signal ifft_loop_num_s                 : std_logic_vector(5 downto 0);
  signal cld_page_s                      : std_logic_vector(31 downto 0); 
  signal conv_page_s      		         : std_logic_vector(31 downto 0);
  signal hsum_page_s  		             : std_logic_vector(31 downto 0);
  signal cld_enable_s   		         : std_logic;
  signal conv_enable_s   		         : std_logic;
  signal hsum_enable_s   		         : std_logic;
  signal cld_trigger_s   		         : std_logic;
  signal conv_trigger_s   		         : std_logic;
  signal hsum_trigger_s   		         : std_logic; 
  signal cld_done_s   		             : std_logic;
  signal conv_done_s   		             : std_logic;
  signal hsum_done_s   		             : std_logic;  
  signal conv_fft_ready_s                : std_logic; 
  signal conv_wr_en_s                    : std_logic; 
  signal conv_waitreq_s                  : std_logic; 
  signal hsum_rd_en_s                    : std_logic; 
  signal hsum_waitreq_s                  : std_logic; 
  signal hsum_valid_s                    : std_logic; 
  
  
  -- process: trig_det
  signal trig_det_en_ret_1_s             : std_logic;
  signal cld_done_ret_1_s                : std_logic;
  signal conv_done_ret_1_s               : std_logic;
  signal hsum_done_ret_1_s               : std_logic;  
  signal cld_trig_det_s                  : std_logic;
  signal conv_trig_det_s                 : std_logic;
  signal hsum_trig_det_s                 : std_logic;
  signal cld_end_s                       : std_logic;
  signal conv_end_s                      : std_logic;
  signal hsum_end_s                      : std_logic;
  
  -- process: pause_count
  signal  cld_enable_ret_1_s             : std_logic;
  signal  cld_pause_cnt_s                : unsigned(31 downto 0);
  signal  cld_pause_cnt_en_s             : std_logic;
  signal  conv_enable_ret_1_s            : std_logic;
  signal  conv_pause_cnt_s               : unsigned(31 downto 0);
  signal  conv_pause_cnt_en_s            : std_logic;
  signal  hsum_enable_ret_1_s            : std_logic;
  signal  hsum_pause_cnt_s               : unsigned(31 downto 0);     
  signal  hsum_pause_cnt_en_s            : std_logic;
  
  
  -- process: ddr_count
  signal  enable_conv_access_ret_1_s       : std_logic;
  signal  enable_conv_access_ret_2_s       : std_logic;
  signal  conv_request_cnt_s               : unsigned(31 downto 0);
  signal  conv_wr_en_gap_cnt_s             : unsigned(3 downto 0); 
  signal  conv_waitreq_gap_cnt_s           : unsigned(3 downto 0); 
  signal  conv_count_en_s                  : std_logic;  
  
  signal  enable_hsum_read_access_ret_1_s  : std_logic; 
  signal  enable_hsum_read_access_ret_2_s  : std_logic; 
  signal  hsum_request_cnt_s               : unsigned(31 downto 0);
  signal  hsum_rd_en_gap_cnt_s             : unsigned(3 downto 0); 
  signal  hsum_waitreq_gap_cnt_s           : unsigned(3 downto 0); 
  signal  hsum_read_count_en_s             : std_logic; 

 
  signal enable_hsum_valid_access_ret_1_s  : std_logic; 
  signal enable_hsum_valid_access_ret_2_s  : std_logic; 
  signal hsum_valid_cnt_s                  : unsigned(31 downto 0);
  signal hsum_valid_gap_cnt_s              : unsigned(3 downto 0); 
  signal hsum_valid_count_en_s             : std_logic; 
    
  
  -- Test bench 
  --process: clk_gen
  signal clk_sys_s 		                   : std_logic;
  signal rst_sys_n_s                       : std_logic;
  signal clk_mc_s 		                   : std_logic;
  signal rst_mc_n_s                        : std_logic;  
  signal trig_det_en_s                     : std_logic;
  signal cld_pause_check_s                 : std_logic;  
  signal cld_pause_val_s                   : std_logic_vector(31 downto 0);
  signal conv_pause_check_s                : std_logic;  
  signal conv_pause_val_s                  : std_logic_vector(31 downto 0);  
  signal hsum_pause_check_s                : std_logic;  
  signal hsum_pause_val_s                  : std_logic_vector(31 downto 0);  
  
  signal conv_wr_en_gap_s                  : unsigned(3 downto 0);  
  signal conv_waitreq_gap_s                : unsigned(3 downto 0);  
  signal enable_conv_access_s              : std_logic;
  signal enable_hsum_read_access_s         : std_logic;  
  signal hsum_rd_en_gap_s                  : unsigned(3 downto 0);
  signal hsum_waitreq_gap_s                : unsigned(3 downto 0);
  signal enable_hsum_valid_access_s        : std_logic; 
  signal hsum_valid_gap_s                  : unsigned(3 downto 0);
  
  -- process: stimgen  

  
  -- general
  signal test_finished                   : boolean := false;
  
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  -- Component Declarations
  component ctrl
  PORT( 
    cld_done         : IN     std_logic;
    clk_sys          : IN     std_logic;
    clk_mc           : IN     std_logic;
    conv_done        : IN     std_logic;
    hsum_done        : IN     std_logic;
    mcaddr           : IN     std_logic_vector (18 DOWNTO 0);
    mcdatain         : IN     std_logic_vector (31 DOWNTO 0);
    mcms             : IN     std_logic;
    mcrwn            : IN     std_logic;
    rst_sys_n        : IN     std_logic;
    rst_mc_n         : IN     std_logic;
    conv_fft_ready   : IN     std_logic;
    conv_wr_en       : IN     std_logic;
    conv_waitreq     : IN     std_logic;
    hsum_rd_en       : IN     std_logic;
    hsum_waitreq     : IN     std_logic;
    hsum_valid       : IN    std_logic;     
    cld_enable       : OUT    std_logic;
    cld_page         : OUT    std_logic_vector(31 downto 0);
    cld_trigger      : OUT    std_logic;
    conv_enable      : OUT    std_logic;
    conv_page        : OUT    std_logic_vector(31 downto 0);
    conv_trigger     : OUT    std_logic;
    fop_sample_num   : OUT    std_logic_vector (22 DOWNTO 0);
    hsum_enable      : OUT    std_logic;
    hsum_page        : OUT    std_logic_vector(31 downto 0);
    hsum_trigger     : OUT    std_logic;
    ifft_loop_num    : OUT    std_logic_vector (5 DOWNTO 0);
    mcdataout        : OUT    std_logic_vector (31 DOWNTO 0);
    overlap_size     : OUT    std_logic_vector (9 DOWNTO 0)  
  );
  end component;

  begin
    -- Instance port mappings.
    ctrl_i : ctrl
      port map (
        cld_done         =>     cld_done_s,
        clk_sys          =>     clk_sys_s,
        clk_mc           =>     clk_mc_s,
        conv_done        =>     conv_done_s,
        hsum_done        =>     hsum_done_s,
        mcaddr           =>     mcaddr_s,
        mcdatain         =>     mcdatain_s,
        mcms             =>     mcms_s,
        mcrwn            =>     mcrwn_s,
        rst_sys_n        =>     rst_sys_n_s,
        rst_mc_n         =>     rst_mc_n_s,
        conv_fft_ready   =>     conv_fft_ready_s,
        conv_wr_en       =>     conv_wr_en_s,
        conv_waitreq     =>     conv_waitreq_s,
        hsum_rd_en       =>     hsum_rd_en_s,
        hsum_waitreq     =>     hsum_waitreq_s,
        hsum_valid       =>     hsum_valid_s,                  
        cld_enable       =>     cld_enable_s,
        cld_page         =>     cld_page_s,
        cld_trigger      =>     cld_trigger_s,
        conv_enable      =>     conv_enable_s,
        conv_page        =>     conv_page_s,
        conv_trigger     =>     conv_trigger_s,
        fop_sample_num   =>     fop_sample_num_s,
        hsum_enable      =>     hsum_enable_s,
        hsum_page        =>     hsum_page_s,
        hsum_trigger     =>     hsum_trigger_s,
        ifft_loop_num    =>     ifft_loop_num_s,
        mcdataout        =>     mcdataout_s,
        overlap_size     =>     overlap_size_s      
     );

 
------------------------------------------------------------------------------
-- PROCESS : clkgen1
-- FUNCTION: Generates clk_sys. Main system clock
------------------------------------------------------------------------------
clkgen1 : process
begin
  while not test_finished loop
    clk_sys_s <= '0', '1' after ck_per_c/2;
    wait for ck_per_c;
  end loop;
  wait;
end process clkgen1;

------------------------------------------------------------------------------
-- PROCESS : clkgen2
-- FUNCTION: Generates clk_mc. Micro Configuration clock
------------------------------------------------------------------------------
clkgen2 : process
begin
  while not test_finished loop
    clk_mc_s <= '0', '1' after ck_mc_per_c/2;
    wait for ck_mc_per_c;
  end loop;
  wait;
end process clkgen2;

------------------------------------------------------------------------------
-- Process: trig_det
-- Detect Triggers
--
-----------------------------------------------------------------------------
trig_det: process(clk_sys_s, rst_sys_n_s)
begin

  if rst_sys_n_s  = '0' then
    trig_det_en_ret_1_s <= '0';
    cld_done_ret_1_s <= '0';
    conv_done_ret_1_s <= '0'; 
    hsum_done_ret_1_s <= '0';
    cld_trig_det_s <= '0';
    conv_trig_det_s <= '0'; 
    hsum_trig_det_s <= '0';   
    cld_end_s <= '0';
    conv_end_s <= '0';
    hsum_end_s <= '0';
  elsif rising_edge(clk_sys_s) then
  
    trig_det_en_ret_1_s <= trig_det_en_s;
    cld_done_ret_1_s <= cld_done_s;
    conv_done_ret_1_s <= conv_done_s; 
    hsum_done_ret_1_s <= hsum_done_s;
    
    if cld_done_ret_1_s = '0' and cld_done_s = '1' then
      cld_trig_det_s <= '0';  
      cld_end_s <= '1';
    end if;
    
    if conv_done_ret_1_s = '0' and conv_done_s = '1' then
      conv_trig_det_s <= '0'; 
      conv_end_s <= '1';
    end if;

    if hsum_done_ret_1_s = '0' and hsum_done_s = '1' then
      hsum_trig_det_s <= '0';  
      hsum_end_s <= '1';
    end if;    
    
    
    if (trig_det_en_ret_1_s = '0' and trig_det_en_s = '1') then
      cld_trig_det_s <= '0';
      conv_trig_det_s <= '0'; 
      hsum_trig_det_s <= '0'; 
      cld_end_s <= '0';
      conv_end_s <= '0';
      hsum_end_s <= '0';
     end if;
  
    if cld_trigger_s = '1' then
      cld_trig_det_s <= '1';
    end if;
   
    if conv_trigger_s = '1' then
      conv_trig_det_s <= '1';
    end if;   

    if hsum_trigger_s = '1' then
      hsum_trig_det_s <= '1';
    end if;
    
  end if;
end process trig_det;




------------------------------------------------------------------------------
-- Process: pause_count
-- Pause Counter
--
-----------------------------------------------------------------------------
pause_count: process(clk_sys_s, rst_sys_n_s)
begin

  if rst_sys_n_s  = '0' then
    cld_enable_ret_1_s <= '0';
    cld_pause_cnt_s <= (others => '0');
    cld_pause_cnt_en_s <= '0';
    conv_enable_ret_1_s <= '0';
    conv_pause_cnt_s <= (others => '0'); 
    conv_pause_cnt_en_s <= '0';
    hsum_enable_ret_1_s <= '0';
    hsum_pause_cnt_s <= (others => '0');  
    hsum_pause_cnt_en_s <= '0';
  elsif rising_edge(clk_sys_s) then

    if cld_pause_check_s = '1' and cld_end_s = '0' then
      cld_enable_ret_1_s <= cld_enable_s; 
      if cld_pause_cnt_s = UNSIGNED(cld_pause_val_s) -1  then
        if cld_enable_s = '0' then 
          testbench_passed_v := false;
	      end if; 
	    end if;
	    if cld_pause_cnt_en_s = '1' then
        if cld_pause_cnt_s = UNSIGNED(cld_pause_val_s)  then
          cld_pause_cnt_en_s <= '0';
          if cld_enable_s = '1' then 
            testbench_passed_v := false;
	        end if;
	      else
	        cld_pause_cnt_s <= cld_pause_cnt_s + 1;
	      end if; 
	    end if;
	    if cld_enable_s = '1' and  cld_enable_ret_1_s = '0' then
	      cld_pause_cnt_en_s <= '1';
        cld_pause_cnt_s <= (others => '0');
      end if;
	  end if;
      

    if conv_pause_check_s = '1' and conv_end_s = '0'then
      conv_enable_ret_1_s <= conv_enable_s;  
      if conv_pause_cnt_s = UNSIGNED(conv_pause_val_s) -1  then
        if conv_enable_s = '0' then 
          testbench_passed_v := false;
	      end if; 
	    end if;  
	    if conv_pause_cnt_en_s = '1' then
        if conv_pause_cnt_s = UNSIGNED(conv_pause_val_s) then
          conv_pause_cnt_en_s <= '0'; 
          if conv_enable_s = '1' then 
            testbench_passed_v := false;   
	        end if;
	      else
	        conv_pause_cnt_s <= conv_pause_cnt_s + 1;
	      end if;
	    end if;
      if conv_enable_s = '1' and  conv_enable_ret_1_s = '0' then
        conv_pause_cnt_en_s <= '1';
        conv_pause_cnt_s <= (others => '0');
      end if;	    
	  end if;	  
	  
	  
    if hsum_pause_check_s = '1' and hsum_end_s = '0'then
      hsum_enable_ret_1_s <= hsum_enable_s;
      if hsum_pause_cnt_s = UNSIGNED(hsum_pause_val_s) - 1 then
        if hsum_enable_s = '0' then 
          testbench_passed_v := false;
	      end if; 
	    end if;     
	    if hsum_pause_cnt_en_s = '1' then
        if hsum_pause_cnt_s = UNSIGNED(hsum_pause_val_s) then
          hsum_pause_cnt_en_s <= '0';
          if hsum_enable_s = '1' then 
            testbench_passed_v := false;
	        end if;
	      else
	        hsum_pause_cnt_s <= hsum_pause_cnt_s + 1;
	      end if;
	    end if;
      if hsum_enable_s = '1' and  hsum_enable_ret_1_s = '0' then
        hsum_pause_cnt_en_s <= '1';
        hsum_pause_cnt_s <= (others => '0');
      end if;	    
	    
	    
	  end if;	  
    
  
    
    
  
  end if;
end process pause_count;



------------------------------------------------------------------------------
-- Process: DDR_COUNT
-- Count the number of DDR SDRAM accesses
--
-----------------------------------------------------------------------------
ddr_count: process(clk_sys_s, rst_sys_n_s)
begin

  if rst_sys_n_s  = '0' then
    enable_conv_access_ret_1_s <= '0';
    enable_conv_access_ret_2_s <= '0';
    conv_request_cnt_s <= (others => '0');
    conv_wr_en_gap_cnt_s <= (others => '0');
    conv_waitreq_gap_cnt_s <= (others => '0');
    conv_count_en_s <= '0';
    conv_wr_en_s <= '0';
    conv_waitreq_s <= '0';    
    
    enable_hsum_read_access_ret_1_s <= '0';
    enable_hsum_read_access_ret_2_s <= '0';
    hsum_request_cnt_s <= (others => '0');
    hsum_rd_en_gap_cnt_s <= (others => '0');
    hsum_waitreq_gap_cnt_s <= (others => '0');
    hsum_read_count_en_s <= '0';
    hsum_rd_en_s <= '0';
    hsum_waitreq_s <= '0';   
    
    enable_hsum_valid_access_ret_1_s <= '0';
    enable_hsum_valid_access_ret_2_s <= '0';
    hsum_valid_cnt_s <= (others => '0'); 
    hsum_valid_gap_cnt_s <= (others => '0');
    hsum_valid_count_en_s <= '0';
    hsum_valid_s <= '0';    

    
  elsif rising_edge(clk_sys_s) then
  

    enable_conv_access_ret_1_s <= enable_conv_access_s;
    enable_conv_access_ret_2_s <= enable_conv_access_ret_1_s;

    
    if enable_conv_access_ret_1_s = '0' and enable_conv_access_s = '1' then 
      conv_request_cnt_s <= (others => '0'); 
      conv_wr_en_gap_cnt_s <= (others => '0'); 
      conv_waitreq_gap_cnt_s <= (others => '0');
      conv_wr_en_s <= '0';
      conv_waitreq_s <= '0';
    end if;       
    
    if enable_conv_access_ret_2_s = '0' and enable_conv_access_ret_1_s = '1' then
      conv_count_en_s <= '1';
    end if;
    
    if enable_conv_access_ret_2_s = '1' and enable_conv_access_ret_1_s = '0' then
      conv_count_en_s <= '0';
    end if;   
    
    if conv_count_en_s = '1' then 
      conv_wr_en_gap_cnt_s <=  conv_wr_en_gap_cnt_s + 1;
      if conv_wr_en_gap_cnt_s = conv_wr_en_gap_s then
        conv_wr_en_s <= not(conv_wr_en_s);
        conv_wr_en_gap_cnt_s <= (others => '0'); 
      end if;
        
    
      conv_waitreq_gap_cnt_s <=  conv_waitreq_gap_cnt_s + 1;
      if conv_waitreq_gap_cnt_s = conv_waitreq_gap_s then
        conv_waitreq_s <= not(conv_waitreq_s);
        conv_waitreq_gap_cnt_s <= (others => '0'); 
      end if;  
        
      if conv_wr_en_s = '1' and conv_waitreq_s = '0' then
        conv_request_cnt_s <= conv_request_cnt_s + 1;
      end if;
    end if;
     
    
    enable_hsum_read_access_ret_1_s <= enable_hsum_read_access_s;
    enable_hsum_read_access_ret_2_s <= enable_hsum_read_access_ret_1_s;

    
    if enable_hsum_read_access_ret_1_s = '0' and enable_hsum_read_access_s = '1' then 
      hsum_request_cnt_s <= (others => '0'); 
      hsum_rd_en_gap_cnt_s <= (others => '0'); 
      hsum_waitreq_gap_cnt_s <= (others => '0');
      hsum_rd_en_s <= '0';
      hsum_waitreq_s <= '0';
    end if;       
    
    if enable_hsum_read_access_ret_2_s = '0' and enable_hsum_read_access_ret_1_s = '1' then
      hsum_read_count_en_s <= '1';
    end if;
    
    if enable_hsum_read_access_ret_2_s = '1' and enable_hsum_read_access_ret_1_s = '0' then
      hsum_read_count_en_s <= '0';
    end if;   
    
    if hsum_read_count_en_s = '1' then 
      hsum_rd_en_gap_cnt_s <=  hsum_rd_en_gap_cnt_s + 1;
      if hsum_rd_en_gap_cnt_s = hsum_rd_en_gap_s then
        hsum_rd_en_s <= not(hsum_rd_en_s);
        hsum_rd_en_gap_cnt_s <= (others => '0'); 
      end if;
        
    
      hsum_waitreq_gap_cnt_s <=  hsum_waitreq_gap_cnt_s + 1;
      if hsum_waitreq_gap_cnt_s = hsum_waitreq_gap_s then
        hsum_waitreq_s <= not(hsum_waitreq_s);
        hsum_waitreq_gap_cnt_s <= (others => '0'); 
      end if;  
        
      if hsum_rd_en_s = '1' and hsum_waitreq_s = '0' then
        hsum_request_cnt_s <= hsum_request_cnt_s + 1;
      end if;
    end if;    
    
    
     
    

  
  
    enable_hsum_valid_access_ret_1_s <= enable_hsum_valid_access_s;
    enable_hsum_valid_access_ret_2_s <= enable_hsum_valid_access_ret_1_s;

    
    if enable_hsum_valid_access_ret_1_s = '0' and enable_hsum_valid_access_s = '1' then 
      hsum_valid_cnt_s <= (others => '0'); 
      hsum_valid_gap_cnt_s <= (others => '0'); 
      hsum_valid_s <= '0';
    end if;       
    
    if enable_hsum_valid_access_ret_2_s = '0' and enable_hsum_valid_access_ret_1_s = '1' then
      hsum_valid_count_en_s <= '1';
    end if;
    
    if enable_hsum_valid_access_ret_2_s = '1' and enable_hsum_valid_access_ret_1_s = '0' then
      hsum_valid_count_en_s <= '0';
    end if;   
    
    if hsum_valid_count_en_s = '1' then 
      hsum_valid_gap_cnt_s <=  hsum_valid_gap_cnt_s + 1;
      if hsum_valid_gap_cnt_s = hsum_valid_gap_s then
        hsum_valid_s <= not(hsum_valid_s);
        hsum_valid_gap_cnt_s <= (others => '0'); 
      end if;
        
           
      if hsum_valid_s = '1'  then
        hsum_valid_cnt_s <= hsum_valid_cnt_s + 1;
      end if;
    end if;      
  
  
  
  
    
  end if;
end process ddr_count;





------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- PROCESS : stimgen
-- FUNCTION: Main test process.
------------------------------------------------------------------------------
stimgen : process


  -- stimgen variables.
    variable  test_1_v      : std_logic;
    variable  test_2_v      : std_logic;
    variable  test_3_v      : std_logic;
    variable  test_4_v      : std_logic;
    variable  test_5_v      : std_logic;    
    variable  test_6_v      : std_logic;    
    variable  test_7_v      : std_logic;    
    variable  outline_v 	  : line;
    variable  readdata_v 	: std_logic_vector(31 downto 0);
    
  
--------------------------------------------------------------------------------
-------------------------- PROCEDURES ------------------------------------------
--------------------------------------------------------------------------------
  -- 1) Procedure to perform micro write.
  procedure mcwrite(address : natural;
                    data    : std_logic_vector(31 downto 0) ) is
  begin
    mcaddr_s <= std_logic_vector(to_unsigned(address, mcaddr_s'left + 1));
    mcdatain_s <= data;
    mcrwn_s <= '0';
    mcms_s  <= '1';
    wait for ck_mc_per_c*4;
    mcms_s <= '0';
    wait for ck_mc_per_c;
  end procedure mcwrite;

  
  -- 2) Procedure to perform micro write.
  procedure mcwrite(address : natural;
                    data    : natural) is
  begin
    mcwrite(address, std_logic_vector(to_unsigned(data, 32)));
  end procedure mcwrite;

  
  -- 3) Procedure to perform micro read, and optionally check read data.
  procedure mcread(address : natural;
                   readdata_v: out std_logic_vector(31 downto 0);
                   exp_data: std_logic_vector(31 downto 0) := (others => '-')
                  ) is
  begin
    mcaddr_s <= std_logic_vector(to_unsigned(address, mcaddr_s'left + 1));
    mcrwn_s <= '1';
    mcms_s  <= '1';
    wait for ck_mc_per_c*4;
    mcms_s  <= '0';
    wait for ck_mc_per_c;
    readdata_v := mcdataout_s;
    for i in mcdataout_s'range loop
      if exp_data(i) = '-' then
        next;
      end if;
      if exp_data(i) /= mcdataout_s(i) then
        testbench_passed_v := false;
        write(outline_v, string'("Micro read incorrect:"));
        write(outline_v, string'("expected "));
        hwrite(outline_v, exp_data);
        write(outline_v, string'(", got "));
        hwrite(outline_v, mcdataout_s);
        writeline(OUTPUT,outline_v);
        assert false
          severity error;
        exit;
      end if;
    end loop;
  end procedure mcread;

  
  -- 4) Procedure to perform micro read and check read data (integer argument).
  procedure mcread(address : natural;
                   exp_data: natural
                  ) is
    variable readdata_v : std_logic_vector(31 downto 0);
  begin
    mcread(address, readdata_v, std_logic_vector(to_unsigned(exp_data, 32)));
  end procedure mcread;


  -- 5) Procedure to output a string.
  procedure puts(msg : string) is
  begin
    write(outline_v, msg);
    writeline(output,outline_v);
  end procedure puts;

  
  -- 6) Procedure to generate a heading.
  procedure heading (title : string) is
  begin
    writeline(output,outline_v);
    puts("-------------------------------------------------");
    puts("-- " & title);
    puts("-------------------------------------------------");
  end procedure heading;

  
  -- 3)Procedure to run for a period of time.
  procedure run (clocks : natural) is
  begin
    wait for ck_per_c * clocks;
  end procedure run;

  
 

begin

  heading("Initialisation.");
  -- Initialise signals.
  
  -- Signal declarations.
 
  
  -- CLD/CONV/HSUM Interface
  cld_done_s         <= '0';
  conv_done_s        <= '0';
  hsum_done_s        <= '0';
  conv_fft_ready_s   <= '0';
   
  -- Test bench
  trig_det_en_s <= '0'; 
  rst_sys_n_s 	                <= '0';  
  rst_mc_n_s 	                <= '0';  
  run(2);
  rst_sys_n_s 	                <= '1';  
  rst_mc_n_s 	                <= '1'; 
  cld_pause_check_s             <= '0';
  cld_pause_val_s               <= (others => '0');
  conv_pause_check_s            <= '0';
  conv_pause_val_s              <= (others => '0');
  hsum_pause_check_s            <= '0';
  hsum_pause_val_s              <= (others => '0');
  enable_conv_access_s          <= '0';
  conv_wr_en_gap_s              <= (others => '0');
  conv_waitreq_gap_s            <= (others => '0');
  enable_hsum_read_access_s     <= '0';
  hsum_rd_en_gap_s              <= (others => '0');
  hsum_waitreq_gap_s            <= (others => '0');  
  enable_hsum_valid_access_s    <='0';
  hsum_valid_gap_s              <= (others => '0');  

  
  -- Ensure bitmap is initialised
  mcwrite(16#00#, 0);   -- DM_TRIG
  mcwrite(16#08#, 0);	-- PAGE
  mcwrite(16#10#, 0);	-- OVERLAP_SIZE[9:0]
  mcwrite(16#18#, 0);	-- FOP_SAMPLE_NUM[22:0] 
  mcwrite(16#1A#, 0);	-- IFFT_LOOP_NUM[5:0]
  mcwrite(16#20#, 0);	-- MAN_OVERRIDE
  mcwrite(16#28#, 0);	-- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#30#, 0);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
  mcwrite(16#38#, 0);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#48#, 0);	-- MAN_CLD_PAUSE_CNT[31:0]
  mcwrite(16#49#, 0);	-- MAN_CONV_PAUSE_CNT[31:0]
  mcwrite(16#4A#, 0);	-- MAN_HSUM_PAUSE_CNT[31:0]
  mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	puts("Latched Done Indications are not 1");
  end if;		
  mcread(16#50#, 7); -- check LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE are 1's
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	puts("Latched Pause Indications are not zero");
  end if;		 
  mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED are 0

  mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
  if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
    testbench_passed_v := false;
	puts("CONV DDR SDRAM Request Count not set to All 1's");
  end if;	  
  
  mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
  if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
    testbench_passed_v := false;
	puts("HSUM DDR SDRAM Request Count not set to All 1's");
  end if;	  
  
  mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
  if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
    testbench_passed_v := false;
	puts("HSUM DDR SDRAM Received Count not set to All 1's");
  end if;	  
  
  
	
  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
  test_6_v := '1'; 
  test_7_v := '1'; 
----------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.CTRL.DM.01: Check MCI Access                                                                                                      ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.CTRL.DM.01: Check MCI Access");
  
  mcwrite(16#00#, 1); -- DM_TRIG
  mcread(16#00#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32)) then
    testbench_passed_v := false;
	  puts("DM_TRIG is 0");
	end if;	
  mcwrite(16#00#, 0); -- DM_TRIG
  mcread(16#00#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("DM_TRIG is 1");
	end if;	

  mcwrite(16#08#, 1); -- PAGE
  mcread(16#08#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32)) then
    testbench_passed_v := false;
	  puts("PAGE is 0");
	end if;	
  mcwrite(16#08#, 0); -- PAGE
  mcread(16#08#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("PAGE is 1");
	end if;	
	
	for i in 0 to 9 loop
	  mcwrite(16#10#, 2**i);	-- OVERLAP_SIZE[9:0]
	  mcread(16#10#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("OVERLAP_SIZE is wrong");
	  end if;
	end loop;		  
  mcwrite(16#10#, 0); -- OVERLAP_SIZE[9:0]
  mcread(16#10#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("OVERLAP_SIZE is not zero");
	end if;		 
	
	for i in 0 to 22 loop
	  mcwrite(16#18#, 2**i);	-- FOP_SAMPLE_NUM[22:0]
	  mcread(16#18#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("FOP_SAMPLE_NUM is wrong");
	  end if;
	end loop;		  
  mcwrite(16#18#, 0); -- FOP_SAMPLE_NUM[22:0]
  mcread(16#18#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("FOP_SAMPLE_NUM is not zero");
	end if;		 	
	
	
	for i in 0 to 5 loop
	  mcwrite(16#1A#, 2**i);	-- IFFT_LOOP_NUM[5:0]
	  mcread(16#1A#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("IFFT_LOOP_NUM is wrong");
	  end if;
	end loop;		  
  mcwrite(16#1A#, 0); -- IFFT_LOOP_NUM[5:0]
  mcread(16#1A#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("IFFT_LOOP_NUM is not zero");
	end if;		 	
	
	mcwrite(16#20#, 1); -- MAN_OVERRIDE
  mcread(16#20#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32)) then
    testbench_passed_v := false;
	  puts("MAN_OVERRIDE is 0");
	end if;	
  mcwrite(16#20#, 0); -- MAN_OVERRIDE
  mcread(16#20#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_OVERRIDE is 1");
	end if;	
  
 	for i in 0 to 2 loop
	  mcwrite(16#28#, 2**i);	-- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
	  mcread(16#28#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG is wrong");
	  end if;	
  end loop;	  
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcread(16#28#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG is not zero");
	end if;		 
  
 	for i in 0 to 2 loop
	  mcwrite(16#30#, 2**i);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
	  mcread(16#30#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN is wrong");
	  end if;
	end loop;		  
  mcwrite(16#30#, 0); -- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
  mcread(16#30#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN is not zero");
	end if;		
	
 	for i in 0 to 2 loop
	  mcwrite(16#38#, 2**i);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN
	  mcread(16#38#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN is wrong");
	  end if;	
  end loop;	  
  mcwrite(16#38#, 0); -- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN
  mcread(16#38#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN is not zero");
	end if;		

  for i in 0 to 2 loop
	  mcwrite(16#40#, 2**i);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
	  mcread(16#40#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST is wrong");
	  end if;		
	end loop;
  mcwrite(16#40#, 0); -- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcread(16#40#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST is not zero");
	end if;		 
  
  for i in 0 to 31 loop
    if i < 31 then
	    mcwrite(16#48#, 2**i);	-- MAN_CLD_PAUSE_CNT[31:0]
	    mcread(16#48#, readdata_v);
      if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
        testbench_passed_v := false;
	      puts("MAN_CLD_PAUSE_CNT is wrong");
	    end if;	
	  end if;
	  if i = 31 then
	    mcwrite(16#48#, "10000000000000000000000000000000");	-- MAN_CLD_PAUSE_CNT[31:0]
	    mcread(16#48#, readdata_v);
      if readdata_v(31 downto 0) /= "10000000000000000000000000000000" then
        testbench_passed_v := false;
	      puts("MAN_CLD_PAUSE_CNT is wrong");
	    end if;	
	  end if;	   
	end loop;
  mcwrite(16#48#, 0); -- MAN_CLD_PAUSE_CNT[31:0]
  mcread(16#48#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_CLD_PAUSE_CNT is not zero");
	end if;		 
	
  for i in 0 to 30 loop
    if i < 31 then
	    mcwrite(16#49#, 2**i);	-- MAN_CONV_PAUSE_CNT[31:0]
	    mcread(16#49#, readdata_v);
      if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
        testbench_passed_v := false;
	      puts("MAN_CONV_PAUSE_CNT is wrong");
	    end if;	
	  end if;
	  if i = 31 then
	    mcwrite(16#49#, "10000000000000000000000000000000");	-- MAN_CONV_PAUSE_CNT[31:0]
	    mcread(16#49#, readdata_v);	  
      if readdata_v(31 downto 0) /= "10000000000000000000000000000000" then
        testbench_passed_v := false;
	      puts("MAN_CONV_PAUSE_CNT is wrong");
	    end if;	
	  end if;	   
	end loop;
  mcwrite(16#49#, 0); -- MAN_CONV_PAUSE_CNT[31:0]
  mcread(16#49#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_CONV_PAUSE_CNT is not zero");
	end if;			
	
  for i in 0 to 30 loop
    if i < 31 then
	    mcwrite(16#4A#, 2**i);	-- MAN_HSUM_PAUSE_CNT[31:0]
	    mcread(16#4A#, readdata_v);
      if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
        testbench_passed_v := false;
	      puts("MAN_HSUM_PAUSE_CNT is wrong");
	    end if;	
	  end if;
	  if i = 31 then
	    mcwrite(16#4A#, "10000000000000000000000000000000");	-- MAN_HSUM_PAUSE_CNT[31:0]
	    mcread(16#4A#, readdata_v);	  
      if readdata_v(31 downto 0) /= "10000000000000000000000000000000" then
        testbench_passed_v := false;
	      puts("MAN_HSUM_PAUSE_CNT is wrong");
	    end if;	
	  end if;	   
	end loop;
  mcwrite(16#4A#, 0); -- MAN_HSUM_PAUSE_CNT[31:0]
  mcread(16#4A#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_HSUM_PAUSE_CNT is not zero");
	end if;			
 
  
  run(10000);
 
end if;

 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.CTRL.DM.02: Check MCI signals direct to CLD/CONV & HSUM                                                                           ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 2: TC.CTRL.DM.02: Check MCI signals direct to CLD/CONV & HSUM ");
  

	for i in 0 to 9 loop
	  mcwrite(16#10#, 2**i);	-- OVERLAP_SIZE[9:0]
	  mcread(16#10#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("OVERLAP_SIZE is wrong");
	  end if;
	  if overlap_size_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,10)) then
	    testbench_passed_v := false;
	    puts("OVERLAP_SIZE signal is wrong");
	  end if;
	end loop;		  
  mcwrite(16#10#, 0); -- OVERLAP_SIZE[9:0]
  mcread(16#10#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("OVERLAP_SIZE is not zero");
	end if;		 
	if overlap_size_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,10)) then
	  testbench_passed_v := false;
	  puts("OVERLAP_SIZE signal is not zero");
	end if;
	
	
	for i in 0 to 22 loop
	  mcwrite(16#18#, 2**i);	-- FOP_SAMPLE_NUM[22:0]
	  mcread(16#18#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("FOP_SAMPLE_NUM is wrong");
	  end if;
	  if fop_sample_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,23)) then
	    testbench_passed_v := false;
	    puts("FOP_SAMPLE_NUM signal is wrong");
	  end if;	  
	end loop;		  
  mcwrite(16#18#, 0); -- FOP_SAMPLE_NUM[22:0]
  mcread(16#18#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("FOP_SAMPLE_NUM is not zero");
	end if;		 	
	if fop_sample_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,23)) then
	  testbench_passed_v := false;
	  puts("FOP_SAMPLE_NUM signal is not zero");
	end if;	 

	
	for i in 0 to 5 loop
	  mcwrite(16#1A#, 2**i);	-- IFFT_LOOP_NUM[5:0]
	  mcread(16#1A#, readdata_v);
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,32)) then
      testbench_passed_v := false;
	    puts("IFFT_LOOP_NUM is wrong");
	  end if;
	  if ifft_loop_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i,6)) then
	    testbench_passed_v := false;
	    puts("IFFT_LOOP_NUM signal is wrong");
	  end if;	 
	end loop;		  
  mcwrite(16#1A#, 0); -- IFFT_LOOP_NUM[5:0]
  mcread(16#1A#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("IFFT_LOOP_NUM is not zero");
	end if;		 	
	if ifft_loop_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,6)) then
	  testbench_passed_v := false;
	  puts("IFFT_LOOP_NUM signal is not zero");
	end if;	 


	
  run(10000);
 
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.CTRL.DM.03: Functional test in normal operation                                                                                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.CTRL.DM.03: Functional test in normal operation");
  
  
  -- set the config values for CLD & CONV
  
  -- PAGE
  -- This actually has no effect in this design and the DDR memory Page
  -- offset for CLD, CONV and HSUM should be 0.
  -- This is a place holder for a future implementation
  mcwrite(16#08#, 0); -- PAGE
  mcread(16#08#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("PAGE is not zero");
	end if;	
 
 	-- OVERLAP_SIZE[9:0]
 	-- Set this to 510 which is a likely value
	mcwrite(16#10#, 510);	-- OVERLAP_SIZE[9:0]
	mcread(16#10#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(510,32)) then
    testbench_passed_v := false;
	  puts("OVERLAP_SIZE is wrong");
	end if;
	if overlap_size_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(510,10)) then
	  testbench_passed_v := false;
	  puts("OVERLAP_SIZE signal is wrong");
	end if;	 
	
	
	-- FOP_SAMPLE_NUM[22:0]
	-- set this to 2^21 samples
	mcwrite(16#18#, (2**21) -1 );	-- FOP_SAMPLE_NUM[22:0]
	mcread(16#18#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED((2**21) -1,32)) then
    testbench_passed_v := false;
	  puts("FOP_SAMPLE_NUM is wrong");
	end if;
	if fop_sample_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED((2**21) -1,23)) then
	  testbench_passed_v := false;
	  puts("FOP_SAMPLE_NUM signal is wrong");
	end if;			  
 
		
	-- IFFT_LOOP_NUM[5:0]
	mcwrite(16#1A#, 6);	-- IFFT_LOOP_NUM[5:0]
	mcread(16#1A#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(6,32)) then
    testbench_passed_v := false;
	  puts("IFFT_LOOP_NUM is wrong");
	end if;
	if ifft_loop_num_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(6,6)) then
	  testbench_passed_v := false;
	  puts("IFFT_LOOP_NUM signal is wrong");
	end if;		

  -- MAN_OVERRIDE
  -- Ensure Manual override is disabled
	mcwrite(16#20#, 0); -- MAN_OVERRIDE
  mcread(16#20#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_OVERRIDE is 1");
	end if;	
	
	 -- start from the position where we have finished the previous DM
  cld_done_s <= '1';
  run(1);
  cld_done_s <= '0';
  run(1);
  conv_done_s <= '1';
  run(1);
  conv_done_s <= '0';
  run(1);
  hsum_done_s <= '1';
  run(1);
  hsum_done_s <= '0';
  
  -- check latched done's are asserted and no modules are enabled
  mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched Done Indications are not 1");
	end if;		

  if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is  enabled");
	end if;	
	
  if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;		
	
  if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;				
  
	trig_det_en_s <= '1';
	run(10);
	
  -- DM_TRIG
  -- Apply a rising edge to DM Trigger 
  mcwrite(16#00#, 0); -- DM_TRIG
  mcwrite(16#00#, 1); -- DM_TRIG
  
  -- check latched done's are clear
  mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Done Indications are not zero");
	end if;		
  
  
  -- Check that CLD and CONV are enabled
  -- Check that CLD and CONV are triggered
  -- Check that the Page offsets to CLD and CONV are 0
  if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	
	
  if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;		
	
  if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is  enabled");
	end if;			
	
	if cld_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CLD has not been triggered");
	end if;	

	if conv_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CONV has not been triggered");
	end if;	

	if hsum_trig_det_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM has  been triggered");
	end if;	

	if cld_page_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("CLD Page offset is not zero");
	end if;	

	if conv_page_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("CONV Page offset is not zero");
	end if;	

	
	run(1000);
	
	-- assert CLD_DONE
	cld_done_s <= '1';
	run(1);
	cld_done_s <= '0';
	
	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "001" then
    testbench_passed_v := false;
	  puts("Latched CLD Done not detected");
	end if;		
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;		
	
	run(100);
	-- assert CONV_DONE
	conv_done_s <= '1';
	run(1);
	conv_done_s <= '0';
	
	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "011" then
    testbench_passed_v := false;
	  puts("Latched CONV Done not detected");
	end if;		
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;	
	
	run(100);
	-- check that HSUM is now enabled and triggered with page offset of 0
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;		

	if cld_trig_det_s = '1' then
    testbench_passed_v := false;
	  puts("CLD has been triggered");
	end if;	

  if conv_trig_det_s = '1' then
    testbench_passed_v := false;
	  puts("CONV has been triggered");
	end if;	
	
	if hsum_trig_det_s = '0' then
   testbench_passed_v := false;
	 puts("HSUM has not been triggered");
	end if;	

	if hsum_page_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
  testbench_passed_v := false;
	 puts("HSUM Page offset is not zero");
	end if;		
	
-- assert HSUM_DONE
	hsum_done_s <= '1';
	run(1);
	hsum_done_s <= '0';
	
	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched CONV Done not detected");
	end if;			
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;		
	
  trig_det_en_s <= '0';
  run(10000);
 
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.CTRL.DM.04: Functional test in manual mode with Pause Enabled                                                                     ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.CTRL.DM.04: Functional test in manual mode with Pause Enabled");

	 -- start from the position where we have finished the previous DM
  cld_done_s <= '1';
  run(1);
  cld_done_s <= '0';
  run(1);
  conv_done_s <= '1';
  run(1);
  conv_done_s <= '0';
  run(1);
  hsum_done_s <= '1';
  run(1);
  hsum_done_s <= '0';

  
  -- Enter manual mode
	mcwrite(16#20#, 1); -- MAN_OVERRIDE
  ------------------------------------------------------------------------------
  -- CLD Manual Mode with Pause
	------------------------------------------------------------------------------
  -- CLD set pause cnt to a value
  cld_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(256,32));
  run(1);
  mcwrite(16#48#, cld_pause_val_s);	-- MAN_CLD_PAUSE_CNT[31:0]
  cld_pause_check_s <= '1';
 
  -- Manual enable CLD
  mcwrite(16#30#, 1);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- Manual Pause En for CLD
  mcwrite(16#38#, 1);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger CLD
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 1); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check cld_enable asserted after trigger
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	
	
  -- Check cld is triggered
	if cld_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CLD has not been triggered");
	end if;	
	
  run(256);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "001" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CLD is zero");
	end if;		 
	mcread(16#58#, 1); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for CLD only
	
  -- reset pause count and check CLD re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#, 1);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  
  run(5);
  
  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CLD is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check cld_enable asserted after pause is reset
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	
	
	 run(256);

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "001" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CLD is zero");
	end if;		 
	mcread(16#58#, 1); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for CLD only
	

  -- reset pause count and check CLD re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#, 1);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CLD is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check cld_enable asserted after pause is reset
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	
	
	 -- check latched Done signals
	 mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "110" then
     testbench_passed_v := false;
	   puts("Latched CLD Done  detected");
	end if;	

	
	run(128);
  -- check cld_enable goes low when CONV_DONE
	cld_done_s <= '1';
	run(1);
	cld_done_s <= '0';

	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched CLD Done not detected");
	end if;		
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;		
	
	run(100);
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;			

  run(100);
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;				 
	 
	cld_pause_check_s <= '0';
	 
  trig_det_en_s <= '0';
  
  ------------------------------------------------------------------------------
  -- CONV Manual Mode with Pause
	------------------------------------------------------------------------------
  -- CONV set pause cnt to a value
  conv_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(512,32));
  run(1);
  mcwrite(16#49#, conv_pause_val_s);	-- MAN_CONV_PAUSE_CNT[31:0]
  conv_pause_check_s <= '1';
 
  -- Manual enable CONV
  mcwrite(16#30#, 2);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- Manual Pause En for CONV
  mcwrite(16#38#, 2);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger CONV
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 2); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check conv_enable asserted after trigger
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	
	
  -- Check conv is triggered
	if conv_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CONV has not been triggered");
	end if;	
	
  run(512);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "010" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CONV is zero");
	end if;		 
	mcread(16#58#, 2); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for CONV only
	
  -- reset pause count and check CONV re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#, 2);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  
  run(5);
  
  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CONV is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check conv_enable asserted after pause is reset
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	
	
	run(512);

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "010" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CONV is zero");
	end if;		 
	mcread(16#58#, 2); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for CONV only
	

  -- reset pause count and check CONV re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#, 2);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CONV is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check conv_enable asserted after pause is reset
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	
	
	 -- check latched Done signals
	 mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "101" then
     testbench_passed_v := false;
	   puts("Latched CONV Done  detected");
	end if;	

	
	run(128);
  -- check cld_enable goes low when CLD_DONE
	conv_done_s <= '1';
	run(1);
	conv_done_s <= '0';

	-- check that this has been detected
  mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched CONV Done not detected");
	end if;		
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;		
	
	run(200);
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
  end if;		

	run(200);
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
  end if;		 
	 
	conv_pause_check_s <= '0';
	 
	trig_det_en_s <= '0';


  ------------------------------------------------------------------------------
  -- HSUM Manual Mode with Pause
	------------------------------------------------------------------------------
  -- HSUM set pause cnt to a value
  hsum_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(1024,32));
  run(1);
  mcwrite(16#4A#, hsum_pause_val_s);	-- MAN_HSUM_PAUSE_CNT[31:0]
  hsum_pause_check_s <= '1';
 
  -- Manual enable HSUM
  mcwrite(16#30#, 4);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- Manual Pause En for HSUM
  mcwrite(16#38#, 4);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger HSUM
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 4); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check hsum_enable asserted after trigger
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	
	
  -- Check hsum is triggered
	if hsum_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM has not been triggered");
	end if;	
	
  run(1200);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "100" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for HSUM is zero");
	end if;		 
	mcread(16#58#, 4); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for HSUM only
	
  -- reset pause count and check CONV re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#,4);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  
  run(5);
  
  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for HSUM is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check hsum_enable asserted after pause is reset
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	
	
	run(1200);

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "100" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for HSUM is zero");
	end if;		 
	mcread(16#58#, 4); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is 1 for HSUM only
	

  -- reset pause count and check HSUM re-enabled 
  mcwrite(16#40#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
  mcwrite(16#40#, 4);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST

  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for HSUM is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED zero
	
  -- Check hsum_enable asserted after pause is reset
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	
	
	 -- check latched Done signals
	 mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "011" then
     testbench_passed_v := false;
	   puts("Latched HSUM Done  detected");
	end if;	

	
	run(128);
  -- check cld_enable goes low when HSUM_DONE
	hsum_done_s <= '1';
	run(1);
	hsum_done_s <= '0';

	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
     testbench_passed_v := false;
	   puts("Latched HSUM Done not detected");
	end if;		
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;		
	
	run(400);
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;			

	run(400);
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;		 
	 
	hsum_pause_check_s <= '0';
	 
	trig_det_en_s <= '0';

  
  run(10000);

end if;  
  
  
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 5: TC.CTRL.DM.05: Functional test in manual mode with Pause Disabled                                                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_5_v = '1' then  
  puts("Test 5: TC.CTRL.DM.05: Functional test in manual mode with Pause Disabled");

	 -- start from the position where we have finished the previous DM
  cld_done_s <= '1';
  run(1);
  cld_done_s <= '0';
  run(1);
  conv_done_s <= '1';
  run(1);
  conv_done_s <= '0';
  run(1);
  hsum_done_s <= '1';
  run(1);
  hsum_done_s <= '0';

  
  -- Enter manual mode
	mcwrite(16#20#, 1); -- MAN_OVERRIDE
  ------------------------------------------------------------------------------
  -- CLD Manual Mode 
	------------------------------------------------------------------------------
  -- CLD set pause cnt to a value
  cld_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(256,32));
  run(1);
  mcwrite(16#48#, cld_pause_val_s);	-- MAN_CLD_PAUSE_CNT[31:0]
  cld_pause_check_s <= '0';
 
  -- Manual enable CLD
  mcwrite(16#30#, 1);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- No Manual Pause En for CLD
  mcwrite(16#38#, 0);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger CLD
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 1); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check cld_enable asserted after trigger
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	
	
  -- Check cld is triggered
	if cld_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CLD has not been triggered");
	end if;	
	
  run(256);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CLD is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is zero
	
	-- reconfirm CLD is still enabled.
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	 
  
  run(256);

	-- reconfirm CLD is still enabled.
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	 
	
	-- Disable CLD
    mcwrite(16#30#, 0);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
    
  -- confirm CLD is not enabled 
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;	    
    
  run(256);   

  -- reconfirm CLD is not enabled 
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;	 
   
 	-- Enable CLD
  mcwrite(16#30#, 1);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN  

  -- confirm CLD is enabled.
	if cld_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CLD is not enabled");
	end if;	 
  
  run(256);
  
	-- check latched Done signals
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "110" then
    testbench_passed_v := false;
	  puts("Latched CLD Done  detected");
	end if;	

	
	run(128);
  -- check cld_enable goes low when CONV_DONE
	cld_done_s <= '1';
	run(1);
	cld_done_s <= '0';

	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched CLD Done not detected");
	end if;		
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;		
	
	run(100);
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;			

	run(100);
	
	-- check CLD is now disabled
	if cld_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CLD is enabled");
	end if;				 
	 
	cld_pause_check_s <= '0';
	 
	trig_det_en_s <= '0';

  
	
  ------------------------------------------------------------------------------
  -- CONV Manual Mode 
	------------------------------------------------------------------------------
  -- CONV set pause cnt to a value
  conv_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(256,32));
  run(1);
  mcwrite(16#49#, conv_pause_val_s);	-- MAN_CONV_PAUSE_CNT[31:0]
  conv_pause_check_s <= '0';
 
  -- Manual enable CONV
  mcwrite(16#30#, 2);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- No Manual Pause En for CONV
  mcwrite(16#38#, 0);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger CONV
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 2); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check conv_enable asserted after trigger
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	
	
  -- Check conv is triggered
	if conv_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("CONV has not been triggered");
	end if;	
	
  run(256);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for CONV is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is zero
	
	-- reconfirm CONV is still enabled.
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	 
  
  run(256);

	-- reconfirm CONV is still enabled.
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	 
	
	-- Disable CONV
    mcwrite(16#30#, 0);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
    
  -- confirm CONV is not enabled 
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;	    
    
  run(256);   

  -- reconfirm CONV is not enabled 
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;	 
   
 	-- Enable CONV
  mcwrite(16#30#, 2);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN  

  -- confirm CONV is enabled.
	if conv_enable_s = '0' then
    testbench_passed_v := false;
	  puts("CONV is not enabled");
	end if;	 
  
  run(256);
  
	-- check latched Done signals
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "101" then
    testbench_passed_v := false;
	  puts("Latched CONV Done  detected");
	end if;	

	
	run(128);
  -- check conv_enable goes low when CONV_DONE
	conv_done_s <= '1';
	run(1);
	conv_done_s <= '0';

	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched CONV Done not detected");
	end if;		
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;		
	
	run(100);
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;			

	run(100);
	
	-- check CONV is now disabled
	if conv_enable_s = '1' then
    testbench_passed_v := false;
	  puts("CONV is enabled");
	end if;				 
	 
	conv_pause_check_s <= '0';
	 
	trig_det_en_s <= '0';	
	
	
  ------------------------------------------------------------------------------
  -- HSUM Manual Mode 
	------------------------------------------------------------------------------
  -- HSUM set pause cnt to a value
  hsum_pause_val_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(256,32));
  run(1);
  mcwrite(16#4A#, hsum_pause_val_s);	-- MAN_HSUM_PAUSE_CNT[31:0]
  conv_pause_check_s <= '0';
 
  -- Manual enable HSUM
  mcwrite(16#30#, 4);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
 
  -- No Manual Pause En for HSUM
  mcwrite(16#38#, 0);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN

  -- manual trigger HSUM
  trig_det_en_s <= '1';
  run(1);
  mcwrite(16#28#, 0); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
  mcwrite(16#28#, 4); -- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
 
  -- Check hsum_enable asserted after trigger
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	
	
  -- Check hsum is triggered
	if hsum_trig_det_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM has not been triggered");
	end if;	
	
  run(256);


  -- check pause indication via the MCI
  mcread(16#58#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(2 downto 0) /= "000" then
    testbench_passed_v := false;
	  puts("Latched Pause Indications for HSUM is not zero");
	end if;		 
	mcread(16#58#, 0); -- check HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED is zero
	
	-- reconfirm HSIUM is still enabled.
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	 
  
  run(256);

	-- reconfirm HSUM is still enabled.
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	 
	
	-- Disable HSUM
    mcwrite(16#30#, 0);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
    
  -- confirm HSUM is not enabled 
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;	    
    
  run(256);   

  -- reconfirm HSUM is not enabled 
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;	 
   
 	-- Enable HSUM
  mcwrite(16#30#, 4);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN  

  -- confirm HSUM is enabled.
	if hsum_enable_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM is not enabled");
	end if;	 
  
  run(256);
  
	-- check latched Done signals
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "011" then
    testbench_passed_v := false;
	  puts("Latched HSUM Done  detected");
	end if;	

	
	run(128);
  -- check hsum_enable goes low when HSUM_DONE
	hsum_done_s <= '1';
	run(1);
	hsum_done_s <= '0';

	-- check that this has been detected
	mcread(16#50#, readdata_v); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
  if readdata_v(2 downto 0) /= "111" then
    testbench_passed_v := false;
	  puts("Latched HSUM Done not detected");
	end if;		
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;			
	
	run(100);
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;				

	run(100);
	
	-- check HSUM is now disabled
	if hsum_enable_s = '1' then
    testbench_passed_v := false;
	  puts("HSUM is enabled");
	end if;				 
	 
	hsum_pause_check_s <= '0';
	 
	trig_det_en_s <= '0';		
	
  run(10000);  
  
  
  
end if;  



---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 5: TC.CTRL.DM.05: Test CONV_FFT_READY                                                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_5_v = '1' then  
  puts("Test 5: TC.CTRL.DM.05: Test CONV_FFT_READY  ");

  
  conv_fft_ready_s <= '0';
  
  run(2);

  -- check CONV_FFT_READY indication via the MCI
  mcread(16#60#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(0) /= '0' then
    testbench_passed_v := false;
	  puts("CONV_FFT_READY should be 0");
	end if;	
	
  conv_fft_ready_s <= '1';
  
  run(2);

  -- check CONV_FFT_READY indication via the MCI
  mcread(16#60#, readdata_v); -- HSUM_PAUSED, CONV_PAUSED, CLD_PAUSED
  if readdata_v(0) /= '1' then
    testbench_passed_v := false;
	  puts("CONV_FFT_READY should be 1");
	end if;		
	
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 6: TC.CTRL.DM.06: Test Processing Timers                                                                                                ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_6_v = '1' then  
  puts("Test 6: TC.CTRL.DM.06: Test Processing Timers");
  
  
  -- set the config values for CLD & CONV


  -- MAN_OVERRIDE
  -- Ensure Manual override is disabled
	mcwrite(16#20#, 0); -- MAN_OVERRIDE
  mcread(16#20#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_OVERRIDE is 1");
	end if;	
	
	cld_done_s <= '0';
	conv_done_s <= '0';
	hsum_done_s <= '0';
	
	
	-- Start a DM
	mcwrite(16#00#, 0); -- DM_TRIG
	mcwrite(16#00#, 1); -- DM_TRIG
	
	 -- start from the position where we have finished the previous DM
	run(20);
  cld_done_s <= '1';
  run(1);
  cld_done_s <= '0';
  mcread(16#62#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(22,32)) then
    testbench_passed_v := false;
	  puts("CLD_TIMER_INCORRECT");
	end if;	  
  
	mcwrite(16#00#, 0); -- DM_TRIG
	mcwrite(16#00#, 1); -- DM_TRIG	
	run(31);
  conv_done_s <= '1';
  run(1);
  conv_done_s <= '0';
  mcread(16#63#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(33,32)) then
    testbench_passed_v := false;
	  puts("CONV_TIMER_INCORRECT");
	end if;	  


  conv_done_s <= '1';
  run(1);
  conv_done_s <= '0';
  run(63);
  hsum_done_s <= '1';
  run(1);
  hsum_done_s <= '0';  
  mcread(16#64#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(63,32)) then
    testbench_passed_v := false;
	  puts("HSUM_TIMER_INCORRECT");
	end if;	  

 
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 7: TC.CTRL.DM.07: Test CONV and HSUM DDR SDRAM Access Counts                                                                            ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_7_v = '1' then  
  puts("Test 7: TC.CTRL.DM.07: Test CONV and HSUM DDR SDRAM Access Counts   ");
  
  
  -- Apply a reset to the CTRL module so that we can see the access counts get set to all 1's
  rst_sys_n_s 	                <= '0';  
  run(2);
  rst_sys_n_s 	                <= '1';  

  -- MAN_OVERRIDE
  -- Ensure Manual override is disabled
  mcwrite(16#20#, 0); -- MAN_OVERRIDE
  mcread(16#20#, readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("MAN_OVERRIDE is 1");
	end if;	
	
	cld_done_s <= '0';
	conv_done_s <= '0';
	hsum_done_s <= '0';
	
	
	-- Start a DM
	mcwrite(16#00#, 0); -- DM_TRIG
	mcwrite(16#00#, 1); -- DM_TRIG
	
	-- Check that when the Auto DM Trigger has occured the CONV DDR Access Count is
	-- set to 0.
    mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= "00000000000000000000000000000000" then
      testbench_passed_v := false;
      puts("CONV DDR SDRAM Request Count has not changed to all zeros");
    end if;	  
    
    mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Request Count not set to All 1's");
    end if;	  
    
    mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
    if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Received Count not set to All 1's");
    end if;	  	
	
    -- Simulate the CONV Write Access
    conv_wr_en_gap_s <= "0010";
    conv_waitreq_gap_s <= "0011";
	enable_conv_access_s <='1';
	run(2000);
	enable_conv_access_s <='0';
	run(1);
	
	-- Check that the correct number of CONV DDR Accesses have been counted
    mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(conv_request_cnt_s) then
      testbench_passed_v := false;
      puts("CONV DDR Access Count Not Correct");
    end if;	 
    
    mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Request Count not set to All 1's");
    end if;	  
    
    mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
    if readdata_v(31 downto 0) /= "11111111111111111111111111111111" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Received Count not set to All 1's");
    end if;	      
    
    -- Simulate CONV Finishing which should trigger HSUM to start
 	conv_done_s <= '1';
 	run(1);
 	conv_done_s <= '0';
    run(1);
    
	-- Check that the CONV DDR Accesses remain unchanged, but the HSUM DDR Access Count is now 0
    mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(conv_request_cnt_s) then
      testbench_passed_v := false;
      puts("CONV DDR Access Count Not Correct");
    end if;	 
    
    mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= "00000000000000000000000000000000" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Request Count has not changed to all zeros");
    end if;	  
    
    mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
    if readdata_v(31 downto 0) /= "00000000000000000000000000000000" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Received Count not set to All 1's");
    end if;	          
    
    -- Simulate the HSUM Read Request Access 
    hsum_rd_en_gap_s <= "0011";
    hsum_waitreq_gap_s <= "0100";
	enable_hsum_read_access_s <='1';
	run(2000);
	enable_hsum_read_access_s <='0';
	run(1);    
    
	-- Check that the CONV DDR Accesses remain unchanged, and the HSUM DDR Read Access is correct
    mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(conv_request_cnt_s) then
      testbench_passed_v := false;
      puts("CONV DDR Access Count Not Correct");
    end if;	 
    
    mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(hsum_request_cnt_s) then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Request Count Not Correct");
    end if;	  
    
    mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
    if readdata_v(31 downto 0) /= "00000000000000000000000000000000" then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Received Count not set to All 1's");
    end if;	          	
	

    -- Simulate the HSUM Read Valid Access
    hsum_valid_gap_s <= "0011";
	enable_hsum_valid_access_s <='1';
	run(2000);
	enable_hsum_valid_access_s <='0';
	run(1);  	
    
	-- Check that the CONV DDR and HSUM DDR Read Accesses remain unchanged, and the HSUM DDR Valid Access is correct
    mcread(16#68#, readdata_v); -- CONV DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(conv_request_cnt_s) then
      testbench_passed_v := false;
      puts("CONV DDR Access Count Not Correct");
    end if;	 
    
    mcread(16#69#, readdata_v); -- HSUM DDR SDRAM REQUEST COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(hsum_request_cnt_s) then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Request Count Not Correct");
    end if;	  
    
    mcread(16#6A#, readdata_v); -- HSUM DDR SDRAM RECIEVED COUNT
    if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(hsum_valid_cnt_s) then
      testbench_passed_v := false;
      puts("HSUM DDR SDRAM Received Count Not Correct");
    end if;	          	
    
	
end if;




 ---------------------------------------------------------------------------------------------------        
  -- Display pass/fail message.
  if testbench_passed_v then
    heading("Testbench PASSED");
  else
    heading("Testbench FAILED");
  end if;
  -- Stop simulation.
  test_finished <= true;
  wait;

end process stimgen;

end stim;




