----------------------------------------------------------------------------
-- Module Name:  CLD Test Bench
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the CLD Module with 1024 point FFT and three DDR Interfaces
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  27/9/2017   Initial revision.
-- 0.2  RMD  10/11/2017  Corrected overlap
-- 0.3  RMD  13/11/2017 FOP_DDR_ADDR_NUM not required
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






library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;
use std.textio.all;
library cld_lib;
use cld_lib.cld;


architecture stim of cld_tb is
  -- Define clock period.
  constant ck_per_c   		: time := 5 ns; -- 200MHz clock


  -- Signal declarations.
  -- CLD Module CTRL Interface
  signal cld_trigger_s                   : std_logic;
  signal cld_enable_s 		               : std_logic;
  signal cld_page_s    		               : std_logic_vector(31 downto 0);
  signal cld_done_s 		                 : std_logic; 
  signal overlap_size_s 		             : std_logic_vector(9 downto 0);
  signal overlap_int_s                   : std_logic_vector(4 downto 0);
  signal overlap_rem_s                   : std_logic_vector(4 downto 0);  
  signal fop_sample_num_s                  : std_logic_vector(22 downto 0);
  
  -- CLD Module DDR Interface
  signal ddr_addr_s                      : std_logic_vector(31 downto 0); 
  signal ddr_read_s      		             : std_logic;
  signal wait_request_s  		             : std_logic;
  signal data_valid_s   		             : std_logic;
  signal ddr_data_s 		                 : std_logic_vector(1535 downto 0);
  
  -- CONV Module Interface
  signal fft_sample_s		                 : std_logic_vector(9 downto 0);
  signal conv_req_s		                   : std_logic;
  signal ready_s 		                     : std_logic;  
  signal sof_s 		                       : std_logic;
  signal eof_s 		                       : std_logic;
  signal valid_s 		                     : std_logic;
  signal conv_data_s 		                 : std_logic_vector(63 downto 0);  
  
  -- Test bench 
  --process: clk_gen
  signal clk_sys_s 		                   : std_logic;
  
  -- process: ddr_interface_ram
  signal bo_s                            : std_logic_vector(1535 downto 0);
  signal bo_valid_s                      : std_logic;  
  signal ddr_read_ret_1_s                : std_logic;
  signal wait_request_toggle_s           : std_logic;
  signal wait_request_cnt_s              : unsigned(1 downto 0);  
  
  -- process: ddr_latency
  subtype fifo_word_t is std_logic_vector(1536 downto 0);
  type fifo_t is array(31 downto 0) of fifo_word_t;
  signal latency_fifo_s                  : fifo_t;
  signal ddr_latency_s                   : unsigned(4 downto 0);
  signal ddr_data_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_4_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_5_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_6_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_7_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_8_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_9_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_10_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_11_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_12_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_13_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_14_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_15_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_16_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_17_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_18_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_19_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_20_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_21_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_22_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_23_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_24_s                    : std_logic_vector(63 downto 0);
 
  
  
  -- process: fft_check
  signal sample_count_s                  : unsigned(63 downto 0);
  signal fft_count_s                     : unsigned(9 downto 0);   
  signal pad_needed_s                    : std_logic;
  signal pad_limit_s                     : unsigned(9 downto 0);
  signal conv_req_fifo_s                 : std_logic_vector(15 downto 0);
  signal start_ready_toggle_s            : std_logic;
  signal ready_cnt_s                     : unsigned(1 downto 0);  
  signal sof_rt_1_s                      : std_logic;
  signal conv_required_s                 : std_logic;   
  
  -- process: stimgen  
  signal increment_check_s               : std_logic;
  signal fixed_value_check_s             : std_logic;
  signal sample_value_s                  : std_logic_vector(63 downto 0);
  
  -- general
  signal test_finished                   : boolean := false;
  signal rst_sys_n_s 		                 : std_logic;  
  signal error_s                         : unsigned(3 downto 0);   
  signal wrong_s                         : std_logic_vector(3 downto 0);
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  -- Component Declarations
  component cld
  generic (
  ddr_g                    : integer;
	fft_ddr_addr_num_g           : integer;
	fop_ddr_addr_max_width_g     : integer;
	fft_ddr_addr_num_width_g     : integer;
	fft_g                    : integer;
	fft_count_width_g        : integer;
	sample_count_width_g     : integer;
	fifo_waddr_width_g       : integer;
	fifo_raddr_width_g       : integer
	);
  port (
     cld_trigger   	       : in     std_logic;
     cld_enable     	     : in     std_logic;
     cld_page      	       : in     std_logic_vector(31 downto 0);
     wait_request          : in     std_logic;
     data_valid            : in     std_logic;
     ddr_data              : in     std_logic_vector(512*ddr_g -1 downto 0);
     overlap_size          : in     std_logic_vector(9 downto 0);
     overlap_int           : in     std_logic_vector(4 downto 0);
     overlap_rem           : in     std_logic_vector(4 downto 0);
     fop_sample_num        : in     std_logic_vector(22 downto 0);
     ready                 : in     std_logic;
     clk_sys    	         : in     std_logic;
     rst_sys_n             : in     std_logic;  
     cld_done              : out    std_logic;
     ddr_addr       	     : out    std_logic_vector(31 downto 0);
     ddr_read              : out    std_logic;
     fft_sample            : out    std_logic_vector(9 downto 0);
     conv_req              : out    std_logic;
     sof                   : out    std_logic;
     eof                   : out    std_logic;
     valid                 : out    std_logic; 
     conv_data             : out    std_logic_vector(63 downto 0)
  );
  end component;

  begin
    -- Instance port mappings.
    cld_i : cld
      generic map (
        ddr_g                    => 3,
	      fft_ddr_addr_num_g       => 43,-- should be 43
	      fop_ddr_addr_max_width_g => 18, 
	      fft_ddr_addr_num_width_g => 6,  
	      fft_g                    => 1024, 
	      fft_count_width_g        => 10, 
	      sample_count_width_g     => 23, 
	      fifo_waddr_width_g       => 7, -- should be 8 
	      fifo_raddr_width_g       => 12  
	  )
      port map (
        cld_trigger   	 =>     cld_trigger_s,
        cld_enable       =>     cld_enable_s,
        cld_page      	 =>     cld_page_s,
        wait_request     =>     wait_request_s,
        data_valid       =>     data_valid_s,
        ddr_data         =>     ddr_data_s,
        overlap_size     =>     overlap_size_s,
        overlap_int      =>     overlap_int_s,
        overlap_rem      =>     overlap_rem_s,
        fop_sample_num   =>     fop_sample_num_s,
        ready            =>     ready_s,
        clk_sys    	     =>     clk_sys_s,
        rst_sys_n        =>     rst_sys_n_s,   
        cld_done         =>     cld_done_s,
        ddr_addr         =>     ddr_addr_s, 
        ddr_read         =>     ddr_read_s,
        fft_sample       =>     fft_sample_s,
        conv_req         =>     conv_req_s, 
        sof              =>     sof_s,
        eof              =>     eof_s,
        valid            =>     valid_s, 
        conv_data        =>     conv_data_s  
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
-- PROCESS : ddr_interface_ram
-- FUNCTION: Provides RAM to store the samples
------------------------------------------------------------------------------
ddr_interface_ram : process (clk_sys_s)
      
begin
  if (rising_edge(clk_sys_s)) then
 
    -- wait request is always asserted initially then is deasserted when a read request is sensed
    -- (this is the behaviour of DDRIF)
    wait_request_s <= not(ddr_read_s);
    ddr_read_ret_1_s <= ddr_read_s;
    if ddr_read_s = '1' and ddr_read_ret_1_s = '0' then
      wait_request_toggle_s <= '1';
      wait_request_cnt_s <= (others => '0');
    end if;
    -- toggle wait request (possible real world situation)
    if wait_request_toggle_s = '1' then
      wait_request_s <= '0';
      wait_request_cnt_s <= wait_request_cnt_s + 1;
      if wait_request_cnt_s = 3 then
        wait_request_s <= '1';
      end if;
    end if;
    if ddr_read_s = '0' and ddr_read_ret_1_s = '1' then
      wait_request_toggle_s <= '0';
    end if;    
    
    bo_s(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24), 64));
    bo_s(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 1, 64));   
    bo_s(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 2, 64));
    bo_s(255 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 3, 64));
    bo_s(319 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 4, 64));
    bo_s(383 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 5, 64));
    bo_s(447 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 6, 64));
    bo_s(511 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 7, 64));
    
    bo_s(575 downto 512) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 8, 64));
    bo_s(639 downto 576) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 9, 64));   
    bo_s(703 downto 640) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 10, 64));
    bo_s(767 downto 704) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 11, 64));
    bo_s(831 downto 768) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 12, 64));
    bo_s(895 downto 832) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 13, 64));
    bo_s(959 downto 896) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 14, 64));
    bo_s(1023 downto 960) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 15, 64));
    
    bo_s(1087 downto 1024) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 16, 64));
    bo_s(1151 downto 1088) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 17, 64));   
    bo_s(1215 downto 1152) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 18, 64));
    bo_s(1279 downto 1216) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 19, 64));
    bo_s(1343 downto 1280) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 20, 64));
    bo_s(1407 downto 1344) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 21, 64));
    bo_s(1471 downto 1408) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 22, 64));
    bo_s(1535 downto 1472) <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))))*(24) + 23, 64));
    
   
    --bo_s <= ram_s(TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))));
    if (ddr_read_s = '1' and wait_request_s = '0') then 
      bo_valid_s <= '1';
    else
      bo_valid_s <= '0';
    end if;
  end if;
end process ddr_interface_ram;


------------------------------------------------------------------------------
-- PROCESS : ddr_latency
-- FUNCTION: Mimics the latency of the ddr interface up to 32 cycles
------------------------------------------------------------------------------
ddr_latency : process(clk_sys_s, rst_sys_n_s)
begin
  if rst_sys_n_s = '0' then
    latency_fifo_s <= (others => (others => '0'));
    data_valid_s <= '0';
    ddr_data_s <= (others => '0');
    ddr_data_1_s <= (others => '0');
    ddr_data_2_s <= (others => '0');
    ddr_data_3_s <= (others => '0');
    ddr_data_4_s <= (others => '0');
    ddr_data_5_s <= (others => '0');
    ddr_data_6_s <= (others => '0');
    ddr_data_7_s <= (others => '0');
    ddr_data_8_s <= (others => '0');
    ddr_data_9_s <= (others => '0');
    ddr_data_10_s <= (others => '0');
    ddr_data_11_s <= (others => '0');
    ddr_data_12_s <= (others => '0');
    ddr_data_13_s <= (others => '0');
    ddr_data_14_s <= (others => '0');
    ddr_data_15_s <= (others => '0');
    ddr_data_16_s <= (others => '0');
    ddr_data_17_s <= (others => '0');
    ddr_data_18_s <= (others => '0');
    ddr_data_19_s <= (others => '0');
    ddr_data_20_s <= (others => '0');
    ddr_data_21_s <= (others => '0');
    ddr_data_22_s <= (others => '0');
    ddr_data_23_s <= (others => '0');
    ddr_data_24_s <= (others => '0');
      
  elsif rising_edge(clk_sys_s) then
    latency_fifo_s <= latency_fifo_s(30 downto 0) & (bo_valid_s & bo_s);
    data_valid_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1536);
    ddr_data_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1535 downto 0);
    
    ddr_data_1_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (63 downto 0);
    ddr_data_2_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (127 downto 64);
    ddr_data_3_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (191 downto 128);
    ddr_data_4_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (255 downto 192);
    ddr_data_5_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (319 downto 256);
    ddr_data_6_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (383 downto 320);
    ddr_data_7_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (447 downto 384);
    ddr_data_8_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (511 downto 448);
    
    ddr_data_9_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (575 downto 512);
    ddr_data_10_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (639 downto 576);
    ddr_data_11_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (703 downto 640);
    ddr_data_12_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (767 downto 704);
    ddr_data_13_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (831 downto 768);
    ddr_data_14_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (895 downto 832);
    ddr_data_15_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (959 downto 896);
    ddr_data_16_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1023 downto 960); 
    
    ddr_data_17_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1087 downto 1024);
    ddr_data_18_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1151 downto 1088);
    ddr_data_19_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1215 downto 1152);
    ddr_data_20_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1279 downto 1216);
    ddr_data_21_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1343 downto 1280);
    ddr_data_22_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1407 downto 1344);
    ddr_data_23_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1471 downto 1408);
    ddr_data_24_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (1535 downto 1472);     
    
  end if;
  
end process ddr_latency;


------------------------------------------------------------------------------
-- PROCESS : fft_check
-- FUNCTION: Checks that the values for the FFT are correct
--           Assuming the value of each sample is it's sample number
------------------------------------------------------------------------------
fft_check : process(clk_sys_s, rst_sys_n_s)
begin
  if rst_sys_n_s = '0' then
    ready_s <= '0';
    sample_count_s <= (others => '0');
    fft_count_s <= (others => '0');
    pad_needed_s <= '0';
    pad_limit_s <= (others => '0');
    conv_req_fifo_s <= (others => '0');
    start_ready_toggle_s <= '0';
    ready_cnt_s <= (others => '0');
    sof_rt_1_s <= '0';
    conv_required_s <= '0';
    error_s <= "0000";
  elsif rising_edge(clk_sys_s) then
    
      -- reset the sample counter for a DM
      if cld_trigger_s = '1' then
        sample_count_s <= (others => '0');
        pad_needed_s <= '1';
        pad_limit_s <= UNSIGNED(overlap_size_s);
      end if;
      

      
    
      conv_req_fifo_s <= conv_req_fifo_s(14 downto 0) & conv_required_s;
    
      -- delay the ready signal when convolution is requested (real world situation)
      if conv_req_fifo_s(15) = '1' then
        ready_s <= '1';
        start_ready_toggle_s <= '1';
      end if;
    
      -- toggle ready (possible real world situation)
      if start_ready_toggle_s = '1' then
        ready_s <= '1';
        ready_cnt_s <= ready_cnt_s + 1;
        if ready_cnt_s = 3 then
          ready_s <= '0';
        end if;
      end if;
    
      -- if we receive valid data when ready is also active
      if valid_s = '1' and ready_s = '1' then
        -- default is to increment the counters
        sample_count_s <= sample_count_s + 1;
        fft_count_s <= fft_count_s + 1;
        -- check the sof and eof signal positions
        if fft_count_s = 0 then
          if sof_s = '0' or eof_s = '1' then
            testbench_passed_v := false;
            error_s <= "0001";
          end if;
        end if;
        if fixed_value_check_s = '0' then
          if fft_count_s > 0 and fft_count_s < 1023 then
            if eof_s = '1' or sof_s = '1' then
              testbench_passed_v := false;
              error_s <= "0010";
            end if;
          end if; 
        end if;
        if fft_count_s = 1023 then
          fft_count_s <= (others => '0');
          if UNSIGNED(conv_data_s) < pad_limit_s then
            pad_needed_s <= '1';
            pad_limit_s <= pad_limit_s - UNSIGNED(conv_data_s(9 downto 0));
          else
            pad_needed_s <= '0';
            pad_limit_s <= UNSIGNED(overlap_size_s);
          end if;
          if eof_s = '0' or sof_s = '1' then
            testbench_passed_v := false;
            error_s <= "0011";
          end if;
          if pad_needed_s = '0' then
            -- sample count reduced by the overlap size for the next FFT
            sample_count_s <= sample_count_s + 1 - UNSIGNED(overlap_size_s);
          else
            if UNSIGNED(conv_data_s) < pad_limit_s then
              sample_count_s <= (others => '0');
            else
              sample_count_s <= UNSIGNED(conv_data_s) + 1 - UNSIGNED(overlap_size_s);
            end if;
          end if; 
          ready_s <= '0';
          start_ready_toggle_s <= '0';
        end if;
      
        -- Check the sample value matches the sample number
        if pad_needed_s = '1' then
          if fft_count_s >= pad_limit_s then
            if increment_check_s = '1' then
              if conv_data_s /= STD_LOGIC_VECTOR(sample_count_s -pad_limit_s) then
                testbench_passed_v := false;
                error_s <= "0100";
              end if;  
            end if;
            if fixed_value_check_s = '1' then
              if conv_data_s /= sample_value_s then
                testbench_passed_v := false;
                error_s <= "0101";
              end if;
            end if;
          else
           if (conv_data_s /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,64))) and fixed_value_check_s = '0' then
              testbench_passed_v := false;
              error_s <= "0110";
            end if; 
          end if;
        end if;
 
        if pad_needed_s = '0' then 
          if increment_check_s = '1' then
            if conv_data_s /= STD_LOGIC_VECTOR(sample_count_s) then
              testbench_passed_v := false;
              error_s <= "0111";
            end if;
          end if;
          if fixed_value_check_s = '1' then
            if conv_data_s /= sample_value_s then
              testbench_passed_v := false;
              error_s <= "1000";
            end if;
          end if;          
        end if;
      
        -- Check that the fft point macthes the expected value
        if fixed_value_check_s = '0' then
          if fft_sample_s /= STD_LOGIC_VECTOR(fft_count_s) then
            testbench_passed_v := false;
            error_s <= "1001";
          end if;   
        end if;
      
 
      end if;
    
      sof_rt_1_s <= sof_s;
      
      -- detect the start of the FFT
      if sof_s = '1' and sof_rt_1_s = '0' then
        conv_required_s <= '1';
        if valid_s = '0' or ready_s = '0' then
          fft_count_s <= (others => '0');
        else
          fft_count_s <= TO_UNSIGNED(1, 10);
        end if;
      end if;
      
      
  end if;
      
end process fft_check;




------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- PROCESS : stimgen
-- FUNCTION: Main test process.
------------------------------------------------------------------------------
stimgen : process


  -- Testbench variables.
    variable  test_1_v      : std_logic;
    variable  test_2_v      : std_logic;
    variable  test_3_v      : std_logic;
    variable  test_4_v      : std_logic;
    variable  test_5_v      : std_logic;    
    variable  outline_v 	      : line;
    
    
   
--------------------------------------------------------------------------------
-------------------------- PROCEDURES ------------------------------------------
--------------------------------------------------------------------------------


  -- 1) Procedure to output a string.
  procedure puts(msg : string) is
  begin
    write(outline_v, msg);
    writeline(output,outline_v);
  end procedure puts;

  
  -- 2) Procedure to generate a heading.
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
  -- CLD Module CTRL Interface
  cld_trigger_s                 <= '0';
  cld_enable_s 		              <= '0';
  cld_page_s    		            <= (others => '0');
  fop_sample_num_s              <= STD_LOGIC_VECTOR(TO_UNSIGNED(4194303,23));
  
  -- CLD Module CONV Interface
  overlap_size_s 		            <= "1000000001";
  overlap_int_s                 <= "00000";
  overlap_rem_s                 <= "00000";
  -- Test bench
  rst_sys_n_s 	                <= '0';  
  run(2);
  rst_sys_n_s 	                <= '1';
  ddr_latency_s                 <= "01000";
  increment_check_s             <= '0';
  fixed_value_check_s           <= '0';
 

        

  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
----------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.CLD.DM.01: Read the samples for a DM with overlap size = 254                                                      ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.CLD.DM.01: Read the samples for a DM with overlap size = 254");

  -- overlap size = 254
  overlap_size_s 		            <= "0011111110";
  overlap_int_s                 <= "01010"; -- 24 x 10 = 240
  overlap_rem_s                 <= "01110"; -- 14 
  -- Enable and trigger CLD
  cld_enable_s             <= '1';
  -- check that initially there is no convolution request
  if conv_req_s = '1' then
    testbench_passed_v := false;
  end if;
  -- enable the checking of incremental sample values
  increment_check_s <= '1';
  fixed_value_check_s <= '0';
  run(1);
  cld_trigger_s   	       <= '1';
  run(1);
  cld_trigger_s   	       <= '0';
  run(1898600);
  cld_enable_s   	       <= '0';
  run(100000);
  cld_enable_s   	       <= '1';
  run(15101400);
  
  run(1000000);
end if;
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.CLD.DM.02: Read the samples for a DM with overlap size = 127                                                      ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then   
  puts("Test 2: TC.CLD.DM.02: Read the samples for a DM with overlap size = 127");
 
  -- overlap size = 127
  overlap_size_s 		            <= "0001111111"; 
  overlap_int_s                 <= "00101"; -- 24 x 5 = 120
  overlap_rem_s                 <= "00111"; -- 7
  -- Enable and trigger CLD
  cld_enable_s             <= '1';
  -- check that initially there is no convolution request
  if conv_req_s = '1' then
    testbench_passed_v := false;
  end if;
  -- enable the checking of incremental sample values
  increment_check_s <= '1';
  fixed_value_check_s <= '0';
  run(1);
  cld_trigger_s   	       <= '1';
  run(1);
  cld_trigger_s   	       <= '0';
  run(1898600);
  cld_enable_s   	       <= '0';
  run(100000);
  cld_enable_s   	       <= '1';
  run(15101400);  
end if; 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.CLD.DM.03: Read the samples for a DM with overlap size = 0                                                     ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.CLD.DM.03: Read the samples for a DM with overlap size = 0");
 
  -- overlap size = 0
  overlap_size_s 		            <= "0000000000";  
  overlap_int_s                 <= "00000"; 
  overlap_rem_s                 <= "00000"; 
  -- Enable and trigger CLD
  cld_enable_s             <= '1';
  -- check that initially there is no convolution request
  if conv_req_s = '1' then
    testbench_passed_v := false;
  end if;
  -- enable the checking of incremental sample values
  increment_check_s <= '1';
  fixed_value_check_s <= '0';
  run(1);
  cld_trigger_s   	       <= '1';
  run(1);
  cld_trigger_s   	       <= '0';
  run(1898600);
  cld_enable_s   	       <= '0';
  run(100000);
  cld_enable_s   	       <= '1';
  run(15101400);   
end if;
  
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.CLD.DM.04: Read the samples for a DM with overlap size = 259                                                     ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.CLD.DM.04: Read the samples for a DM with overlap size = 259");
 
  -- overlap size = 259
  overlap_size_s 		            <= "0100000011";  
  overlap_int_s                 <= "01010"; -- 24 x 10 = 240
  overlap_rem_s                 <= "10011"; -- 19
  -- Enable and trigger CLD
  cld_enable_s             <= '1';
  -- check that initially there is no convolution request
  if conv_req_s = '1' then
    testbench_passed_v := false;
  end if;
  -- eyeball only!!!!! (at the moment)
  increment_check_s <= '1';
  fixed_value_check_s <= '0';
  run(1);
  cld_trigger_s   	       <= '1';
  run(1);
  cld_trigger_s   	       <= '0';
  run(1898600);
  cld_enable_s   	       <= '0';
  run(100000);
  cld_enable_s   	       <= '1';
  run(15101400);   
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




