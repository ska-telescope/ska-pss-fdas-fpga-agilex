----------------------------------------------------------------------------
-- Module Name:  DDRIF2 Test Bench for three DDRIF2 instances
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the DDRIF2 Module
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  05/09/2017   Added separate resets for the clock domains
--                        Added static signals to the DDR controller
-- 0.3  RMD  23/11/2017   Added test to allow PCIe transfers to be odd
--                        size bursts in an overall DMA with an even number
--                        of 256-bit transfers.
-- 0.4  RMD  29/03/2022   PCIe Data Interface is now 512-bit with a 
--                        4-bit burst vector
-- 0.5  RMD  16/09/2022   Updated DDRIF2 module capable of operating as
--                        three DDRIF2 modules acting in unison. This
--                        test bench tests three DDRIF2 instances
--                        acting in unison together 
-- 0.6  RMD  25/01/2023   DMA Writes from the PCIe now have a 
--                        WaitRequest Allowance of 16.
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
library ddrif2_lib;
use ddrif2_lib.ddrif2;


architecture stim of ddrif2_tb is
  -- Define clock period.
  constant clk_sys_per_c   		: time := 2.857 ns; -- 350MHz clock
  constant clk_pcie_per_c       : time := 2.85 ns; -- 350MHz clock (slightly higher than system clock to get phase slip in test bench)
  constant clk_ddr_1_per_c      : time := 3 ns; -- 333.3333MHz clock
  constant clk_ddr_2_per_c      : time := 3.1 ns; -- 333.3333MHz clock, offset as DDR clocks are not aligned
  constant clk_ddr_3_per_c      : time := 3.2 ns; -- 333.3333MHz clock, offset as DDR clocks are not aligned  
  
  
  -- Signal declarations.
  
  -- Inter DDRIF2 Module signals
  signal fifo_ready_out_1_s        : std_logic;
  signal fifo_ready_out_2_s        : std_logic;
  signal fifo_ready_out_3_s        : std_logic;
  signal fifo_full_out_1_s         : std_logic;  
  signal fifo_full_out_2_s         : std_logic;
  signal fifo_full_out_3_s         : std_logic;  
  signal data_avail_out_1_s        : std_logic; 
  signal data_avail_out_2_s        : std_logic;  
  signal data_avail_out_3_s        : std_logic; 
  
  -- DDRIF2 Module PCIe Interface to write to DDR memory
  signal rd_dma_address_1_s                : std_logic_vector(31 downto 0);
  signal rd_dma_burst_count_1_s            : std_logic_vector(3 downto 0);
  signal rd_dma_byte_en_1_s                : std_logic_vector(63 downto 0);
  signal rd_dma_write_1_s                  : std_logic;
  signal rd_dma_write_data_1_s             : std_logic_vector(511 downto 0);
  signal rd_dma_wait_request_1_s           : std_logic;
  
  signal rd_dma_address_2_s                : std_logic_vector(31 downto 0);
  signal rd_dma_burst_count_2_s            : std_logic_vector(3 downto 0);
  signal rd_dma_byte_en_2_s                : std_logic_vector(63 downto 0);
  signal rd_dma_write_2_s                  : std_logic;
  signal rd_dma_write_data_2_s             : std_logic_vector(511 downto 0);
  signal rd_dma_wait_request_2_s           : std_logic;  
  
  signal rd_dma_address_3_s                : std_logic_vector(31 downto 0);
  signal rd_dma_burst_count_3_s            : std_logic_vector(3 downto 0);
  signal rd_dma_byte_en_3_s                : std_logic_vector(63 downto 0);
  signal rd_dma_write_3_s                  : std_logic;
  signal rd_dma_write_data_3_s             : std_logic_vector(511 downto 0);
  signal rd_dma_wait_request_3_s           : std_logic;  
  
        
  -- DDRIF2 Module FDAS Processing Interface to write to DDR memory     
  signal ddr_wr_addr_s                     : std_logic_vector(31 downto 0);
  signal ddr_wr_en_s                       : std_logic;     
      
  signal ddr_wr_data_1_s                   : std_logic_vector(511 downto 0);
  signal ddr_wr_wait_request_1_s           : std_logic;  
    
  signal ddr_wr_data_2_s                   : std_logic_vector(511 downto 0);    
  signal ddr_wr_wait_request_2_s           : std_logic;  
  
  signal ddr_wr_data_3_s                   : std_logic_vector(511 downto 0);  
  signal ddr_wr_wait_request_3_s           : std_logic;  
  
  
  -- DDRIF2 Module PCIe Interface to read from DDR memory
  signal wr_dma_address_1_s                : std_logic_vector(31 downto 0);
  signal wr_dma_burst_count_1_s            : std_logic_vector(3 downto 0);
  signal wr_dma_read_1_s                   : std_logic;
  signal wr_dma_read_data_1_s              : std_logic_vector(511 downto 0);
  signal wr_dma_read_data_valid_1_s        : std_logic;
  signal wr_dma_wait_request_1_s           : std_logic;
  
  signal wr_dma_address_2_s                : std_logic_vector(31 downto 0);
  signal wr_dma_burst_count_2_s            : std_logic_vector(3 downto 0);
  signal wr_dma_read_2_s                   : std_logic;
  signal wr_dma_read_data_2_s              : std_logic_vector(511 downto 0);
  signal wr_dma_read_data_valid_2_s        : std_logic;
  signal wr_dma_wait_request_2_s           : std_logic;  
  
  signal wr_dma_address_3_s                : std_logic_vector(31 downto 0);
  signal wr_dma_burst_count_3_s            : std_logic_vector(3 downto 0);
  signal wr_dma_read_3_s                   : std_logic;
  signal wr_dma_read_data_3_s              : std_logic_vector(511 downto 0);
  signal wr_dma_read_data_valid_3_s        : std_logic;
  signal wr_dma_wait_request_3_s           : std_logic;  
  
 
  -- DDRIF2 Module FDAS Processing Interface to read from DDR memory 
  signal ddr_rd_addr_s                     : std_logic_vector(31 downto 0);
  signal ddr_rd_en_s                       : std_logic;
  
  signal ddr_rd_data_1_s                   : std_logic_vector(511 downto 0);
  signal ddr_rd_data_valid_1_s             : std_logic;
  signal ddr_rd_wait_request_1_s           : std_logic;  
  
  signal ddr_rd_data_2_s                   : std_logic_vector(511 downto 0);
  signal ddr_rd_data_valid_2_s             : std_logic;
  signal ddr_rd_wait_request_2_s           : std_logic;
  
  signal ddr_rd_data_3_s                   : std_logic_vector(511 downto 0);
  signal ddr_rd_data_valid_3_s             : std_logic;
  signal ddr_rd_wait_request_3_s           : std_logic;  
  
  
  -- DDRIF2 Module Interface to DDR Controller
  signal amm_wait_request_1_s              : std_logic;
  signal amm_read_data_1_s                 : std_logic_vector(511 downto 0);
  signal amm_read_data_valid_1_s           : std_logic; 
  signal amm_address_1_s                   : std_logic_vector(31 downto 0);
  signal amm_read_1_s                      : std_logic;
  signal amm_write_1_s                     : std_logic;
  signal amm_write_data_1_s                : std_logic_vector(511 downto 0);
  
  signal amm_wait_request_2_s              : std_logic;
  signal amm_read_data_2_s                 : std_logic_vector(511 downto 0);
  signal amm_read_data_valid_2_s           : std_logic; 
  signal amm_address_2_s                   : std_logic_vector(31 downto 0);
  signal amm_read_2_s                      : std_logic;
  signal amm_write_2_s                     : std_logic;
  signal amm_write_data_2_s                : std_logic_vector(511 downto 0);  
  
  signal amm_wait_request_3_s              : std_logic;
  signal amm_read_data_3_s                 : std_logic_vector(511 downto 0);
  signal amm_read_data_valid_3_s           : std_logic; 
  signal amm_address_3_s                   : std_logic_vector(31 downto 0);
  signal amm_read_3_s                      : std_logic;
  signal amm_write_3_s                     : std_logic;
  signal amm_write_data_3_s                : std_logic_vector(511 downto 0);  
  
  
  -- DDRIF2 Module Clocks and Reset 
  signal clk_sys_s                         : std_logic;
  signal clk_pcie_s                        : std_logic;
  signal clk_ddr_1_s                       : std_logic; 
  signal clk_ddr_2_s                       : std_logic;
  signal clk_ddr_3_s                       : std_logic;
  signal rst_sys_n_s                       : std_logic;
  signal rst_pcie_n_s                      : std_logic;     
  signal rst_ddr_n_1_s                     : std_logic; 
  signal rst_ddr_n_2_s                     : std_logic; 
  signal rst_ddr_n_3_s                     : std_logic; 
  
  -- DDRIF2 Module Static signals
  signal amm_burstcount_1_s                : std_logic_vector(6 downto 0);
  signal amm_byte_en_1_s                   : std_logic_vector(63 downto 0);  
  signal amm_burstcount_2_s                : std_logic_vector(6 downto 0);
  signal amm_byte_en_2_s                   : std_logic_vector(63 downto 0);  
  signal amm_burstcount_3_s                : std_logic_vector(6 downto 0);
  signal amm_byte_en_3_s                   : std_logic_vector(63 downto 0);   
  
  -- process: ddr_interface_ram
  subtype word_t is std_logic_vector(511 downto 0);
  type memory_t is array(2047 downto 0) of word_t;
  -- DDR INTERFACE RAM#1
  signal ram_1_s                           : memory_t;
  signal awren_1_s                         : std_logic;
  signal aa_1_s                            : unsigned(17 downto 0);
  signal ai_1_s                            : std_logic_vector(511 downto 0);
  signal bo_1_s                            : std_logic_vector(511 downto 0);
  signal bo_valid_1_s                      : std_logic;  
  signal ddr_read_ret_1_1_s                : std_logic;
  signal wait_request_toggle_1_s           : std_logic;
  signal wait_request_cnt_1_s              : unsigned(15 downto 0);  
  
  -- DDR INTERFACE RAM#2
  signal ram_2_s                           : memory_t;
  signal awren_2_s                         : std_logic;
  signal aa_2_s                            : unsigned(17 downto 0);
  signal ai_2_s                            : std_logic_vector(511 downto 0);
  signal bo_2_s                            : std_logic_vector(511 downto 0);
  signal bo_valid_2_s                      : std_logic;  
  signal ddr_read_ret_1_2_s                : std_logic;
  signal wait_request_toggle_2_s           : std_logic;
  signal wait_request_cnt_2_s              : unsigned(15 downto 0);    
  
  -- DDR INTERFACE RAM#3
  signal ram_3_s                           : memory_t;
  signal awren_3_s                         : std_logic;
  signal aa_3_s                            : unsigned(17 downto 0);
  signal ai_3_s                            : std_logic_vector(511 downto 0);
  signal bo_3_s                            : std_logic_vector(511 downto 0);
  signal bo_valid_3_s                      : std_logic;  
  signal ddr_read_ret_1_3_s                : std_logic;
  signal wait_request_toggle_3_s           : std_logic;
  signal wait_request_cnt_3_s              : unsigned(15 downto 0);      
  
  
  
  -- process: ddr_latency
  subtype fifo_word_t is std_logic_vector(512 downto 0);
  type fifo_t is array(31 downto 0) of fifo_word_t;

  -- DDR INTERFACE RAM#1  
  signal latency_fifo_1_s                  : fifo_t;
  signal ddr_latency_1_s                   : unsigned(4 downto 0);
  signal ddr_data_1_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_2_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_3_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_4_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_5_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_6_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_7_1_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_8_1_s                    : std_logic_vector(63 downto 0);
  
  -- DDR INTERFACE RAM#2  
  signal latency_fifo_2_s                  : fifo_t;
  signal ddr_latency_2_s                   : unsigned(4 downto 0);
  signal ddr_data_1_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_2_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_3_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_4_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_5_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_6_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_7_2_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_8_2_s                    : std_logic_vector(63 downto 0);  
  
  -- DDR INTERFACE RAM#3  
  signal latency_fifo_3_s                  : fifo_t;
  signal ddr_latency_3_s                   : unsigned(4 downto 0);
  signal ddr_data_1_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_2_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_3_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_4_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_5_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_6_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_7_3_s                    : std_logic_vector(63 downto 0);
  signal ddr_data_8_3_s                    : std_logic_vector(63 downto 0);    
    
  -- process: conv_ram
  subtype word_1536_t is std_logic_vector(1535 downto 0);
  type memory_1536_t is array(2047 downto 0) of word_1536_t;  
  signal conv_ram_s                      : memory_1536_t;
  signal conv_awren_s                    : std_logic;
  signal conv_aa_s                       : unsigned(9 downto 0);
  signal conv_ai_s                       : std_logic_vector(1535 downto 0);
  signal conv_en_rt_1_s                  : std_logic;
  signal conv_cnt_en_s                   : std_logic;
  signal conv_ba_addr_s                  : unsigned(9 downto 0);
  
  
  -- process: pcie_ram
  subtype pcie_word_t is std_logic_vector(511 downto 0);
  type pcie_memory_t is array(1023 downto 0) of pcie_word_t;  
  
  -- PCIe I/F to DDRIF2 #1 
  signal pcie_ram_1_s                      : pcie_memory_t;
  signal pcie_awren_1_s                    : std_logic;
  signal pcie_aa_1_s                       : unsigned(9 downto 0);
  signal pcie_ai_1_s                       : std_logic_vector(511 downto 0);
  signal pcie_write_en_rt_1_1_s            : std_logic;
  signal pcie_write_cnt_en_1_s             : std_logic;
  signal pcie_write_ba_addr_1_s            : unsigned(9 downto 0);  
  signal burst_write_addr_cnt_1_s          : unsigned(3 downto 0);  
  signal send_1_s                          : std_logic;
  signal rd_dma_wait_request_ret_1_s       : std_logic;
  signal wait_count_en_1_s                 : std_logic;
  signal wait_count_1_s                    : unsigned(5 downto 0);   
   
  -- PCIe I/F to DDRIF2 #2
  signal pcie_ram_2_s                      : pcie_memory_t;
  signal pcie_awren_2_s                    : std_logic;
  signal pcie_aa_2_s                       : unsigned(9 downto 0);
  signal pcie_ai_2_s                       : std_logic_vector(511 downto 0);
  signal pcie_write_en_rt_1_2_s            : std_logic;
  signal pcie_write_cnt_en_2_s             : std_logic;
  signal pcie_write_ba_addr_2_s            : unsigned(9 downto 0);  
  signal burst_write_addr_cnt_2_s          : unsigned(3 downto 0);  
  signal send_2_s                          : std_logic;
  signal rd_dma_wait_request_ret_2_s       : std_logic;
  signal wait_count_en_2_s                 : std_logic;
  signal wait_count_2_s                    : unsigned(5 downto 0);     
  
  -- PCIe I/F to DDRIF2 #3
  signal pcie_ram_3_s                      : pcie_memory_t;
  signal pcie_awren_3_s                    : std_logic;
  signal pcie_aa_3_s                       : unsigned(9 downto 0);
  signal pcie_ai_3_s                       : std_logic_vector(511 downto 0);
  signal pcie_write_en_rt_1_3_s            : std_logic;
  signal pcie_write_cnt_en_3_s             : std_logic;
  signal pcie_write_ba_addr_3_s            : unsigned(9 downto 0);  
  signal burst_write_addr_cnt_3_s          : unsigned(3 downto 0);  
  signal send_3_s                          : std_logic;
  signal rd_dma_wait_request_ret_3_s       : std_logic;
  signal wait_count_en_3_s                 : std_logic;
  signal wait_count_3_s                    : unsigned(5 downto 0);     
    
 
  -- process: hsum_addr_gen
  signal hsum_en_rt_1_s                   : std_logic;   
  signal hsum_cnt_en_s                    : std_logic; 
  signal hsum_cnt_s                       : unsigned(9 downto 0);

  
  -- process: pcie_addr_gen
  -- PCIe I/F to DDRIF2 #1  
  signal pcie_read_en_rt_1_1_s              : std_logic;   
  signal pcie_read_cnt_en_1_s               : std_logic; 
  signal pcie_read_cnt_1_s                  : unsigned(10 downto 0);
  signal burst_read_addr_cnt_1_s            : unsigned(4 downto 0);  
 
  -- PCIe I/F to DDRIF2 #2  
  signal pcie_read_en_rt_1_2_s              : std_logic;   
  signal pcie_read_cnt_en_2_s               : std_logic; 
  signal pcie_read_cnt_2_s                  : unsigned(10 downto 0);
  signal burst_read_addr_cnt_2_s            : unsigned(4 downto 0);    
  
  -- PCIe I/F to DDRIF2 #3  
  signal pcie_read_en_rt_1_3_s              : std_logic;   
  signal pcie_read_cnt_en_3_s               : std_logic; 
  signal pcie_read_cnt_3_s                  : unsigned(10 downto 0);
  signal burst_read_addr_cnt_3_s            : unsigned(4 downto 0);      
  
  
  
  -- process check_to_ddr 
  subtype ddr_word_t is std_logic_vector(31 downto 0);
  type ddr_data_t is array(15 downto 0) of ddr_word_t;
  
 -- DDR INTERFACE RAM#1    
  signal ddr_check_en_rt_1_1_s             : std_logic;
  signal ddr_cnt_check_en_1_s              : std_logic;
  signal check_cnt_1_s                     : unsigned(9 downto 0);
  signal exp_ddr_addr_1_s                  : std_logic_vector(31 downto 0);
  signal exp_ddr_data_1_s                  : ddr_data_t;
 
 -- DDR INTERFACE RAM#2    
  signal ddr_check_en_rt_1_2_s             : std_logic;
  signal ddr_cnt_check_en_2_s              : std_logic;
  signal check_cnt_2_s                     : unsigned(9 downto 0);
  signal exp_ddr_addr_2_s                  : std_logic_vector(31 downto 0);
  signal exp_ddr_data_2_s                  : ddr_data_t;  
  
 -- DDR INTERFACE RAM#3    
  signal ddr_check_en_rt_1_3_s             : std_logic;
  signal ddr_cnt_check_en_3_s              : std_logic;
  signal check_cnt_3_s                     : unsigned(9 downto 0);
  signal exp_ddr_addr_3_s                  : std_logic_vector(31 downto 0);
  signal exp_ddr_data_3_s                  : ddr_data_t;  
  
  
  
  -- process check_to_hsum 
  subtype long_word_bit_word_1536_t is std_logic_vector(191 downto 0);
  type hsum_data_t is array(7 downto 0) of long_word_bit_word_1536_t;
  signal hsum_check_en_rt_1_s             : std_logic;
  signal hsum_cnt_check_en_s              : std_logic; 
  signal hsum_check_cnt_s                 : unsigned(9 downto 0);
  signal exp_hsum_data_s                  : hsum_data_t;
  
  
  -- process check_to_pcie
  subtype long_word_bit_word_t is std_logic_vector(63 downto 0);
  type pcie_data_t is array(7 downto 0) of long_word_bit_word_t;
  
  -- PCIe I/F to DDRIF2 #1  
  signal pcie_check_en_rt_1_1_s            : std_logic;
  signal pcie_cnt_check_en_1_s             : std_logic;
  signal pcie_check_cnt_1_s                : unsigned(9 downto 0);
  signal exp_pcie_data_1_s                 : pcie_data_t;    
  
  -- PCIe I/F to DDRIF2 #2  
  signal pcie_check_en_rt_1_2_s            : std_logic;
  signal pcie_cnt_check_en_2_s             : std_logic;
  signal pcie_check_cnt_2_s                : unsigned(9 downto 0);
  signal exp_pcie_data_2_s                 : pcie_data_t;    
 
  -- PCIe I/F to DDRIF2 #3  
  signal pcie_check_en_rt_1_3_s            : std_logic;
  signal pcie_cnt_check_en_3_s             : std_logic;
  signal pcie_check_cnt_3_s                : unsigned(9 downto 0);
  signal exp_pcie_data_3_s                 : pcie_data_t;      
  
  -- process: stimgen  
  signal write_wait_request_en_1_s         : std_logic;
  signal write_wait_request_en_2_s         : std_logic;
  signal write_wait_request_en_3_s         : std_logic;
  signal read_wait_request_en_1_s          : std_logic;
  signal read_wait_request_en_2_s          : std_logic;
  signal read_wait_request_en_3_s          : std_logic;  
  signal conv_en_s                       : std_logic; 
  signal ddr_check_en_1_s                  : std_logic;
  signal ddr_check_en_2_s                  : std_logic;  
  signal ddr_check_en_3_s                  : std_logic;  
  signal wait_gap_1_s                      : unsigned(15 downto 0);
  signal wait_gap_2_s                      : unsigned(15 downto 0);
  signal wait_gap_3_s                      : unsigned(15 downto 0);  
  signal hsum_en_s                       : std_logic;
  signal hsum_check_en_s                 : std_logic;
  signal burst_num_1_s                     : unsigned(3 downto 0);
  signal burst_num_2_s                     : unsigned(3 downto 0);
  signal burst_num_3_s                     : unsigned(3 downto 0);  
  signal pcie_write_en_1_s                 : std_logic;
  signal pcie_write_en_2_s                 : std_logic;
  signal pcie_write_en_3_s                 : std_logic;  
  signal pcie_read_en_1_s                  : std_logic;
  signal pcie_read_en_2_s                  : std_logic;  
  signal pcie_read_en_3_s                  : std_logic;  
  signal pcie_check_en_1_s                 : std_logic; 
  signal pcie_check_en_2_s                 : std_logic; 
  signal pcie_check_en_3_s                 : std_logic;   
  
  -- general
  signal test_finished                   : boolean := false;
  
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  
  
  -- Component Declarations
  component ddrif2
  port (
    amm_read_data          : in     std_logic_vector (511 downto 0);
    amm_read_data_valid    : in     std_logic;
    amm_wait_request       : in     std_logic;
    clk_ddr                : in     std_logic;
    clk_pcie               : in     std_logic;
    clk_sys                : in     std_logic;
    data_avail_in_1        : in     std_logic;
    data_avail_in_2        : in     std_logic;
    ddr_rd_addr            : in     std_logic_vector (31 downto 0);
    ddr_rd_en              : in     std_logic;
    ddr_wr_addr            : in     std_logic_vector (31 downto 0);
    ddr_wr_data            : in     std_logic_vector (511 downto 0);
    ddr_wr_en              : in     std_logic;
    fifo_full_in_1         : in     std_logic;
    fifo_full_in_2         : in     std_logic;
    fifo_ready_in_1        : in     std_logic;
    fifo_ready_in_2        : in     std_logic;
    rd_dma_address         : in     std_logic_vector (31 downto 0);
    rd_dma_burst_count     : in     std_logic_vector (3 downto 0);
    rd_dma_byte_en         : in     std_logic_vector (63 downto 0);
    rd_dma_write           : in     std_logic;
    rd_dma_write_data      : in     std_logic_vector (511 downto 0);
    rst_ddr_n              : in     std_logic;
    rst_pcie_n             : in     std_logic;
    rst_sys_n              : in     std_logic;
    wr_dma_address         : in     std_logic_vector (31 downto 0);
    wr_dma_burst_count     : in     std_logic_vector (3 downto 0);
    wr_dma_read            : in     std_logic;
    amm_address            : out    std_logic_vector (31 downto 0);
    amm_burstcount         : out    std_logic_vector (6 downto 0);
    amm_byte_en            : out    std_logic_vector (63 downto 0);
    amm_read               : out    std_logic;
    amm_write              : out    std_logic;
    amm_write_data         : out    std_logic_vector (511 downto 0);
    data_avail_out         : out    std_logic;
    ddr_rd_data            : out    std_logic_vector (511 downto 0);
    ddr_rd_data_valid      : out    std_logic;
    ddr_rd_wait_request    : out    std_logic;
    ddr_wr_wait_request    : out    std_logic;
    fifo_full_out          : out    std_logic;
    fifo_ready_out         : out    std_logic;
    rd_dma_wait_request    : out    std_logic;
    wr_dma_read_data       : out    std_logic_vector (511 downto 0);
    wr_dma_read_data_valid : out    std_logic;
    wr_dma_wait_request    : out    std_logic
  );
  end component;
  
  
  
  

  begin
    -- Instance port mappings.
    ddrif2_1 : ddrif2
      port map (
        -- PCIe Interface to write data to SDRAM
        rd_dma_address          =>    rd_dma_address_1_s,
        rd_dma_burst_count      =>    rd_dma_burst_count_1_s,
        rd_dma_byte_en          =>    rd_dma_byte_en_1_s,
        rd_dma_write            =>    rd_dma_write_1_s,
        rd_dma_write_data       =>    rd_dma_write_data_1_s,     
        rd_dma_wait_request     =>    rd_dma_wait_request_1_s,
        
        -- PCIe Interface to read data from SDRAM
        wr_dma_address          =>    wr_dma_address_1_s,     
        wr_dma_burst_count      =>    wr_dma_burst_count_1_s,
        wr_dma_read             =>    wr_dma_read_1_s,         
        wr_dma_read_data        =>    wr_dma_read_data_1_s,
        wr_dma_read_data_valid  =>    wr_dma_read_data_valid_1_s,
        wr_dma_wait_request     =>    wr_dma_wait_request_1_s,       
       
        -- CONV Interface to write Data to SDRAM
        ddr_wr_addr           =>    ddr_wr_addr_s,      
        ddr_wr_data           =>    ddr_wr_data_1_s,      
        ddr_wr_en             =>    ddr_wr_en_s,   
        ddr_wr_wait_request   =>    ddr_wr_wait_request_1_s,
              
        -- HSUM Inteface to read data from SDRAM
        ddr_rd_addr           =>    ddr_rd_addr_s,
        ddr_rd_en             =>    ddr_rd_en_s,
        ddr_rd_data           =>    ddr_rd_data_1_s,
        ddr_rd_data_valid     =>    ddr_rd_data_valid_1_s,
        ddr_rd_wait_request   =>    ddr_rd_wait_request_1_s,
                
        -- SDRAM Interface    
        amm_address           =>    amm_address_1_s,    
        amm_burstcount        =>    amm_burstcount_1_s,      
        amm_byte_en           =>    amm_byte_en_1_s,       
        amm_read              =>    amm_read_1_s,
        amm_write             =>    amm_write_1_s, 
        amm_write_data        =>    amm_write_data_1_s,                
        amm_wait_request      =>    amm_wait_request_1_s,       
        amm_read_data         =>    amm_read_data_1_s,
        amm_read_data_valid   =>    amm_read_data_valid_1_s,
        

        -- Inter DDRIF2 alignment signals
        fifo_ready_in_1       =>    fifo_ready_out_2_s,
        fifo_ready_in_2       =>    fifo_ready_out_3_s,
        fifo_ready_out        =>    fifo_ready_out_1_s,         
        fifo_full_in_1        =>    fifo_full_out_2_s, 
        fifo_full_in_2        =>    fifo_full_out_3_s, 
        fifo_full_out         =>    fifo_full_out_1_s,  
        data_avail_in_1       =>    data_avail_out_2_s,
        data_avail_in_2       =>    data_avail_out_3_s,
        data_avail_out        =>    data_avail_out_1_s, 
        
        -- Clocks and resets
        clk_sys               =>    clk_sys_s,     
        clk_pcie              =>    clk_pcie_s,
        clk_ddr               =>    clk_ddr_1_s,
        rst_sys_n             =>    rst_sys_n_s,  
        rst_pcie_n            =>    rst_pcie_n_s,
        rst_ddr_n             =>    rst_ddr_n_1_s
     );

     
    -- Instance port mappings.
    ddrif2_2 : ddrif2
      port map (
        -- PCIe Interface to write data to SDRAM
        rd_dma_address          =>    rd_dma_address_2_s,
        rd_dma_burst_count      =>    rd_dma_burst_count_2_s,
        rd_dma_byte_en          =>    rd_dma_byte_en_2_s,
        rd_dma_write            =>    rd_dma_write_2_s,
        rd_dma_write_data       =>    rd_dma_write_data_2_s,     
        rd_dma_wait_request     =>    rd_dma_wait_request_2_s,
        
        -- PCIe Interface to read data from SDRAM
        wr_dma_address          =>    wr_dma_address_2_s,     
        wr_dma_burst_count      =>    wr_dma_burst_count_2_s,
        wr_dma_read             =>    wr_dma_read_2_s,         
        wr_dma_read_data        =>    wr_dma_read_data_2_s,
        wr_dma_read_data_valid  =>    wr_dma_read_data_valid_2_s,
        wr_dma_wait_request     =>    wr_dma_wait_request_2_s,       
       
        -- CONV Interface to write Data to SDRAM
        ddr_wr_addr           =>    ddr_wr_addr_s,      
        ddr_wr_data           =>    ddr_wr_data_2_s,      
        ddr_wr_en             =>    ddr_wr_en_s,   
        ddr_wr_wait_request   =>    ddr_wr_wait_request_2_s,
              
        -- HSUM Inteface to read data from SDRAM
        ddr_rd_addr           =>    ddr_rd_addr_s,
        ddr_rd_en             =>    ddr_rd_en_s,
        ddr_rd_data           =>    ddr_rd_data_2_s,
        ddr_rd_data_valid     =>    ddr_rd_data_valid_2_s,
        ddr_rd_wait_request   =>    ddr_rd_wait_request_2_s,
                
        -- SDRAM Interface    
        amm_address           =>    amm_address_2_s,    
        amm_burstcount        =>    amm_burstcount_2_s,      
        amm_byte_en           =>    amm_byte_en_2_s,       
        amm_read              =>    amm_read_2_s,
        amm_write             =>    amm_write_2_s, 
        amm_write_data        =>    amm_write_data_2_s,                
        amm_wait_request      =>    amm_wait_request_2_s,       
        amm_read_data         =>    amm_read_data_2_s,
        amm_read_data_valid   =>    amm_read_data_valid_2_s,
        

        -- Inter DDRIF2 alignment signals
        fifo_ready_in_1       =>    fifo_ready_out_1_s,
        fifo_ready_in_2       =>    fifo_ready_out_3_s,
        fifo_ready_out        =>    fifo_ready_out_2_s,         
        fifo_full_in_1        =>    fifo_full_out_1_s, 
        fifo_full_in_2        =>    fifo_full_out_3_s, 
        fifo_full_out         =>    fifo_full_out_2_s,  
        data_avail_in_1       =>    data_avail_out_1_s,
        data_avail_in_2       =>    data_avail_out_3_s,
        data_avail_out        =>    data_avail_out_2_s, 
        
        -- Clocks and resets
        clk_sys               =>    clk_sys_s,     
        clk_pcie              =>    clk_pcie_s,
        clk_ddr               =>    clk_ddr_2_s,
        rst_sys_n             =>    rst_sys_n_s,  
        rst_pcie_n            =>    rst_pcie_n_s,
        rst_ddr_n             =>    rst_ddr_n_2_s
     );
     
     
    -- Instance port mappings.
    ddrif2_3 : ddrif2
      port map (
        -- PCIe Interface to write data to SDRAM
        rd_dma_address          =>    rd_dma_address_3_s,
        rd_dma_burst_count      =>    rd_dma_burst_count_3_s,
        rd_dma_byte_en          =>    rd_dma_byte_en_3_s,
        rd_dma_write            =>    rd_dma_write_3_s,
        rd_dma_write_data       =>    rd_dma_write_data_3_s,     
        rd_dma_wait_request     =>    rd_dma_wait_request_3_s,
        
        -- PCIe Interface to read data from SDRAM
        wr_dma_address          =>    wr_dma_address_3_s,     
        wr_dma_burst_count      =>    wr_dma_burst_count_3_s,
        wr_dma_read             =>    wr_dma_read_3_s,         
        wr_dma_read_data        =>    wr_dma_read_data_3_s,
        wr_dma_read_data_valid  =>    wr_dma_read_data_valid_3_s,
        wr_dma_wait_request     =>    wr_dma_wait_request_3_s,       
       
        -- CONV Interface to write Data to SDRAM
        ddr_wr_addr           =>    ddr_wr_addr_s,      
        ddr_wr_data           =>    ddr_wr_data_3_s,      
        ddr_wr_en             =>    ddr_wr_en_s,   
        ddr_wr_wait_request   =>    ddr_wr_wait_request_3_s,
              
        -- HSUM Inteface to read data from SDRAM
        ddr_rd_addr           =>    ddr_rd_addr_s,
        ddr_rd_en             =>    ddr_rd_en_s,
        ddr_rd_data           =>    ddr_rd_data_3_s,
        ddr_rd_data_valid     =>    ddr_rd_data_valid_3_s,
        ddr_rd_wait_request   =>    ddr_rd_wait_request_3_s,
                
        -- SDRAM Interface    
        amm_address           =>    amm_address_3_s,    
        amm_burstcount        =>    amm_burstcount_3_s,      
        amm_byte_en           =>    amm_byte_en_3_s,       
        amm_read              =>    amm_read_3_s,
        amm_write             =>    amm_write_3_s, 
        amm_write_data        =>    amm_write_data_3_s,                
        amm_wait_request      =>    amm_wait_request_3_s,       
        amm_read_data         =>    amm_read_data_3_s,
        amm_read_data_valid   =>    amm_read_data_valid_3_s,
        

        -- Inter DDRIF2 alignment signals
        fifo_ready_in_1       =>    fifo_ready_out_1_s,
        fifo_ready_in_2       =>    fifo_ready_out_2_s,
        fifo_ready_out        =>    fifo_ready_out_3_s,         
        fifo_full_in_1        =>    fifo_full_out_1_s, 
        fifo_full_in_2        =>    fifo_full_out_2_s, 
        fifo_full_out         =>    fifo_full_out_3_s,  
        data_avail_in_1       =>    data_avail_out_1_s,
        data_avail_in_2       =>    data_avail_out_2_s,
        data_avail_out        =>    data_avail_out_3_s, 
        
        -- Clocks and resets
        clk_sys               =>    clk_sys_s,     
        clk_pcie              =>    clk_pcie_s,
        clk_ddr               =>    clk_ddr_3_s,
        rst_sys_n             =>    rst_sys_n_s,  
        rst_pcie_n            =>    rst_pcie_n_s,
        rst_ddr_n             =>    rst_ddr_n_3_s
     );
     
------------------------------------------------------------------------------
-- PROCESS : clkgen1
-- FUNCTION: Generates clk_sys. Main system clock
------------------------------------------------------------------------------
clkgen1 : process
begin
  while not test_finished loop
    clk_sys_s <= '0', '1' after clk_sys_per_c/2;
    wait for clk_sys_per_c;
  end loop;
  wait;
end process clkgen1;

------------------------------------------------------------------------------
-- PROCESS : clkgen2
-- FUNCTION: Generates clk_pcie. PCIe clock
------------------------------------------------------------------------------
clkgen2 : process
begin
  while not test_finished loop
    clk_pcie_s <= '0', '1' after clk_pcie_per_c/2;
    wait for clk_pcie_per_c;
  end loop;
  wait;
end process clkgen2;

------------------------------------------------------------------------------
-- PROCESS : clkgen3
-- FUNCTION: Generates clk_ddr_1. DDR clock
------------------------------------------------------------------------------
clkgen3 : process
begin
  while not test_finished loop
    clk_ddr_1_s <= '0', '1' after clk_ddr_1_per_c/2;
    wait for clk_ddr_1_per_c;
  end loop;
  wait;
end process clkgen3;

------------------------------------------------------------------------------
-- PROCESS : clkgen4
-- FUNCTION: Generates clk_ddr_2. DDR clock
------------------------------------------------------------------------------
clkgen4 : process
begin
  while not test_finished loop
    clk_ddr_2_s <= '0', '1' after clk_ddr_2_per_c/2;
    wait for clk_ddr_2_per_c;
  end loop;
  wait;
end process clkgen4;

------------------------------------------------------------------------------
-- PROCESS : clkgen5
-- FUNCTION: Generates clk_ddr_2. DDR clock
------------------------------------------------------------------------------
clkgen5 : process
begin
  while not test_finished loop
    clk_ddr_3_s <= '0', '1' after clk_ddr_3_per_c/2;
    wait for clk_ddr_3_per_c;
  end loop;
  wait;
end process clkgen5;


------------------------------------------------------------------------------
-- PROCESS : ddr_interface_ram_1
-- FUNCTION: Provides interface to store DDR samples for delivery
--           to FDAS functions (e.g. HSUM) or the PCIe
--           Also generates the amm_wait_request (dynamically if desired)
------------------------------------------------------------------------------
ddr_interface_ram_1 : process (clk_ddr_1_s, rst_ddr_n_1_s)
      
begin
  if rst_ddr_n_1_s = '0' then
    amm_wait_request_1_s <= '0';
    wait_request_cnt_1_s <= (others => '0');
    bo_1_s <= (others => '0');
    bo_valid_1_s <= '0';
  elsif (rising_edge(clk_ddr_1_s)) then
    if (awren_1_s = '1') then
      ram_1_s(TO_INTEGER(aa_1_s)) <= ai_1_s;
    end if;
   
    -- default
    wait_request_cnt_1_s <= wait_request_cnt_1_s + 1;
    
    
    if (conv_en_rt_1_s = '0' and conv_en_s = '1') or (hsum_en_rt_1_s = '0' and hsum_en_s = '1') or
       (pcie_write_en_rt_1_1_s = '0' and pcie_write_en_1_s = '1') or (pcie_read_en_rt_1_1_s = '0' and pcie_read_en_1_s = '1') then
      wait_request_cnt_1_s <= (others => '0');
      amm_wait_request_1_s <= '0';
    end if;

    
    if conv_en_s  = '1' or pcie_write_en_1_s = '1' then
      if write_wait_request_en_1_s = '0' then
        amm_wait_request_1_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_1_s(0) = wait_gap_1_s(0)  or wait_request_cnt_1_s(0) /= wait_gap_1_s(0) then
        --if wait_request_cnt_1_s(7 downto 0) = wait_gap_1_s(7 downto 0) then
          amm_wait_request_1_s <= not(amm_wait_request_1_s);
        end if;
      end if;
    end if;
    
    
    
    if hsum_en_s  = '1' or pcie_read_en_1_s = '1' then
      if read_wait_request_en_1_s = '0' then
        amm_wait_request_1_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_1_s(0) = wait_gap_1_s(0)  or wait_request_cnt_1_s(0) /= wait_gap_1_s(0) then
        --if wait_request_cnt_1_s(7 downto 0) = wait_gap_1_s(7 downto 0) then
          amm_wait_request_1_s <= not(amm_wait_request_1_s);
        end if;
      end if;
    end if;   
 
    
    bo_1_s <= ram_1_s(TO_INTEGER(UNSIGNED(amm_address_1_s(31 downto 6))));
    if (amm_read_1_s = '1' and amm_wait_request_1_s = '0') then 
      bo_valid_1_s <= '1';
    else
      bo_valid_1_s <= '0';
    end if;
  end if;
end process ddr_interface_ram_1;


------------------------------------------------------------------------------
-- PROCESS : ddr_interface_ram_2
-- FUNCTION: Provides interface to store DDR samples for delivery
--           to FDAS functions (e.g. HSUM) or the PCIe
--           Also generates the amm_wait_request (dynamically if desired)
------------------------------------------------------------------------------
ddr_interface_ram_2 : process (clk_ddr_2_s,rst_ddr_n_2_s)
      
begin
  if rst_ddr_n_2_s = '0' then
    amm_wait_request_2_s <= '0';
    wait_request_cnt_2_s <= (others => '0');
    bo_2_s <= (others => '0');
    bo_valid_2_s <= '0';
  elsif (rising_edge(clk_ddr_2_s)) then
    if (awren_2_s = '1') then
      ram_2_s(TO_INTEGER(aa_2_s)) <= ai_2_s;
    end if;
   
    -- default
    wait_request_cnt_2_s <= wait_request_cnt_2_s + 1;
    
    
    if (conv_en_rt_1_s = '0' and conv_en_s = '1') or (hsum_en_rt_1_s = '0' and hsum_en_s = '1') or
       (pcie_write_en_rt_1_2_s = '0' and pcie_write_en_2_s = '1') or (pcie_read_en_rt_1_2_s = '0' and pcie_read_en_2_s = '1') then
      wait_request_cnt_2_s <= (others => '0');
      amm_wait_request_2_s <= '0';
    end if;

    
    if conv_en_s  = '1' or pcie_write_en_2_s = '1' then
      if write_wait_request_en_2_s = '0' then
        amm_wait_request_2_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_2_s(0) = wait_gap_2_s(0)  or wait_request_cnt_2_s(0) /= wait_gap_2_s(0) then
        --if wait_request_cnt_2_s(7 downto 0) = wait_gap_2_s(7 downto 0) then
          amm_wait_request_2_s <= not(amm_wait_request_2_s);
        end if;
      end if;
    end if;
    
    
    
    if hsum_en_s  = '1' or pcie_read_en_2_s = '1' then
      if read_wait_request_en_2_s = '0' then
        amm_wait_request_2_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_2_s(0) = wait_gap_2_s(0)  or wait_request_cnt_2_s(0) /= wait_gap_2_s(0) then
        --if wait_request_cnt_2_s(7 downto 0) = wait_gap_2_s(7 downto 0) then
          amm_wait_request_2_s <= not(amm_wait_request_2_s);
        end if;
      end if;
    end if;   
 
    
    bo_2_s <= ram_2_s(TO_INTEGER(UNSIGNED(amm_address_2_s(31 downto 6))));
    if (amm_read_2_s = '1' and amm_wait_request_2_s = '0') then 
      bo_valid_2_s <= '1';
    else
      bo_valid_2_s <= '0';
    end if;
  end if;
end process ddr_interface_ram_2;


------------------------------------------------------------------------------
-- PROCESS : ddr_interface_ram_3
-- FUNCTION: Provides interface to store DDR samples for delivery
--           to FDAS functions (e.g. HSUM) or the PCIe
--           Also generates the amm_wait_request (dynamically if desired)
------------------------------------------------------------------------------
ddr_interface_ram_3 : process (clk_ddr_3_s, rst_ddr_n_3_s)
      
begin
  if rst_ddr_n_3_s = '0' then
    amm_wait_request_3_s <= '0';
    wait_request_cnt_3_s <= (others => '0');
    bo_3_s <= (others => '0');
    bo_valid_3_s <= '0';
  elsif (rising_edge(clk_ddr_3_s)) then
    if (awren_3_s = '1') then
      ram_3_s(TO_INTEGER(aa_3_s)) <= ai_3_s;
    end if;
   
    -- default
    wait_request_cnt_3_s <= wait_request_cnt_3_s + 1;
    
    
    if (conv_en_rt_1_s = '0' and conv_en_s = '1') or (hsum_en_rt_1_s = '0' and hsum_en_s = '1') or
       (pcie_write_en_rt_1_3_s = '0' and pcie_write_en_3_s = '1') or (pcie_read_en_rt_1_3_s = '0' and pcie_read_en_3_s = '1') then
      wait_request_cnt_3_s <= (others => '0');
      amm_wait_request_3_s <= '0';
    end if;

    
    if conv_en_s  = '1' or pcie_write_en_3_s = '1' then
      if write_wait_request_en_3_s = '0' then
        amm_wait_request_3_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_3_s(0) = wait_gap_3_s(0)  or wait_request_cnt_3_s(0) /= wait_gap_3_s(0) then
        --if wait_request_cnt_3_s(7 downto 0) = wait_gap_3_s(7 downto 0) then
          amm_wait_request_3_s <= not(amm_wait_request_3_s);
        end if;
      end if;
    end if;
    
    
    
    if hsum_en_s  = '1' or pcie_read_en_3_s = '1' then
      if read_wait_request_en_3_s = '0' then
        amm_wait_request_3_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_3_s(0) = wait_gap_3_s(0)  or wait_request_cnt_3_s(0) /= wait_gap_3_s(0) then
        --if wait_request_cnt_3_s(7 downto 0) = wait_gap_3_s(7 downto 0) then
          amm_wait_request_3_s <= not(amm_wait_request_3_s);
        end if;
      end if;
    end if;   
 
    
    bo_3_s <= ram_3_s(TO_INTEGER(UNSIGNED(amm_address_3_s(31 downto 6))));
    if (amm_read_3_s = '1' and amm_wait_request_3_s = '0') then 
      bo_valid_3_s <= '1';
    else
      bo_valid_3_s <= '0';
    end if;
  end if;
end process ddr_interface_ram_3;


------------------------------------------------------------------------------
-- PROCESS : ddr_latency_1
-- FUNCTION: Mimics the latency of the ddr interface up to 32 cycles
------------------------------------------------------------------------------
ddr_latency_1 : process(clk_ddr_1_s, rst_ddr_n_1_s)
begin
  if rst_ddr_n_1_s = '0' then
    latency_fifo_1_s <= (others => (others => '0'));
    amm_read_data_valid_1_s <= '0';
    amm_read_data_1_s <= (others => '0');
    ddr_data_1_1_s <= (others => '0');
    ddr_data_2_1_s <= (others => '0');
    ddr_data_3_1_s <= (others => '0');
    ddr_data_4_1_s <= (others => '0');
    ddr_data_5_1_s <= (others => '0');
    ddr_data_6_1_s <= (others => '0');
    ddr_data_7_1_s <= (others => '0');
    ddr_data_8_1_s <= (others => '0');
  elsif rising_edge(clk_ddr_1_s) then
    latency_fifo_1_s <= latency_fifo_1_s(30 downto 0) & (bo_valid_1_s & bo_1_s);
    amm_read_data_valid_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (512);
    amm_read_data_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (511 downto 0);
    
    ddr_data_1_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (63 downto 0);
    ddr_data_2_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (127 downto 64);
    ddr_data_3_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (191 downto 128);
    ddr_data_4_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (255 downto 192);
    ddr_data_5_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (319 downto 256);
    ddr_data_6_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (383 downto 320);
    ddr_data_7_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (447 downto 384);
    ddr_data_8_1_s <= latency_fifo_1_s(TO_INTEGER(ddr_latency_1_s)) (511 downto 448);
    
  end if;
  
end process ddr_latency_1;

------------------------------------------------------------------------------
-- PROCESS : ddr_latency_2
-- FUNCTION: Mimics the latency of the ddr interface up to 32 cycles
------------------------------------------------------------------------------
ddr_latency_2 : process(clk_ddr_2_s, rst_ddr_n_2_s)
begin
  if rst_ddr_n_2_s = '0' then
    latency_fifo_2_s <= (others => (others => '0'));
    amm_read_data_valid_2_s <= '0';
    amm_read_data_2_s <= (others => '0');
    ddr_data_1_2_s <= (others => '0');
    ddr_data_2_2_s <= (others => '0');
    ddr_data_3_2_s <= (others => '0');
    ddr_data_4_2_s <= (others => '0');
    ddr_data_5_2_s <= (others => '0');
    ddr_data_6_2_s <= (others => '0');
    ddr_data_7_2_s <= (others => '0');
    ddr_data_8_2_s <= (others => '0');
  elsif rising_edge(clk_ddr_2_s) then
    latency_fifo_2_s <= latency_fifo_2_s(30 downto 0) & (bo_valid_2_s & bo_2_s);
    amm_read_data_valid_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (512);
    amm_read_data_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (511 downto 0);
    
    ddr_data_1_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (63 downto 0);
    ddr_data_2_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (127 downto 64);
    ddr_data_3_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (191 downto 128);
    ddr_data_4_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (255 downto 192);
    ddr_data_5_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (319 downto 256);
    ddr_data_6_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (383 downto 320);
    ddr_data_7_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (447 downto 384);
    ddr_data_8_2_s <= latency_fifo_2_s(TO_INTEGER(ddr_latency_2_s)) (511 downto 448);
    
  end if;
  
end process ddr_latency_2;

------------------------------------------------------------------------------
-- PROCESS : ddr_latency_3
-- FUNCTION: Mimics the latency of the ddr interface up to 32 cycles
------------------------------------------------------------------------------
ddr_latency_3 : process(clk_ddr_3_s, rst_ddr_n_3_s)
begin
  if rst_ddr_n_3_s = '0' then
    latency_fifo_3_s <= (others => (others => '0'));
    amm_read_data_valid_3_s <= '0';
    amm_read_data_3_s <= (others => '0');
    ddr_data_1_3_s <= (others => '0');
    ddr_data_2_3_s <= (others => '0');
    ddr_data_3_3_s <= (others => '0');
    ddr_data_4_3_s <= (others => '0');
    ddr_data_5_3_s <= (others => '0');
    ddr_data_6_3_s <= (others => '0');
    ddr_data_7_3_s <= (others => '0');
    ddr_data_8_3_s <= (others => '0');
  elsif rising_edge(clk_ddr_3_s) then
    latency_fifo_3_s <= latency_fifo_3_s(30 downto 0) & (bo_valid_3_s & bo_3_s);
    amm_read_data_valid_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (512);
    amm_read_data_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (511 downto 0);
    
    ddr_data_1_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (63 downto 0);
    ddr_data_2_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (127 downto 64);
    ddr_data_3_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (191 downto 128);
    ddr_data_4_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (255 downto 192);
    ddr_data_5_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (319 downto 256);
    ddr_data_6_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (383 downto 320);
    ddr_data_7_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (447 downto 384);
    ddr_data_8_3_s <= latency_fifo_3_s(TO_INTEGER(ddr_latency_3_s)) (511 downto 448);
    
  end if;
  
end process ddr_latency_3;

------------------------------------------------------------------------------
-- PROCESS : conv_ram
-- FUNCTION: Provides RAM mimic the data delivery from CONV
------------------------------------------------------------------------------
conv_ram : process (clk_sys_s, rst_sys_n_s)
      
begin
  if rst_sys_n_s = '0' then
    conv_en_rt_1_s <= '0';    
    conv_cnt_en_s <= '0';
    conv_ba_addr_s <= (others => '0');
    ddr_wr_data_1_s <= (others => '0'); 
    ddr_wr_data_2_s <= (others => '0');
    ddr_wr_data_3_s <= (others => '0');
    ddr_wr_addr_s <= (others => '0');
    ddr_wr_en_s <= '0';  
                                        
  elsif (rising_edge(clk_sys_s)) then
    if (conv_awren_s = '1') then
      conv_ram_s(TO_INTEGER(conv_aa_s)) <= conv_ai_s;
    end if;
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    conv_en_rt_1_s <= conv_en_s;
    
    
    -- start the request to write to DDR 
    if conv_en_rt_1_s = '0' and conv_en_s = '1' then
      conv_cnt_en_s <= '1';
      conv_ba_addr_s <= (others => '0');
      ddr_wr_data_1_s <= conv_ram_s(0)(511 downto 0); 
      ddr_wr_data_2_s <= conv_ram_s(0)(1023 downto 512); 
      ddr_wr_data_3_s <= conv_ram_s(0)(1535 downto 1024);
      ddr_wr_addr_s <= (others => '0');
      ddr_wr_en_s <= '1';
    end if;
     
    -- if wait_request is low and write is requested and not all data used increment the address
    -- Just use the wait request from DDRIF2 #1 as they should all be acting in unision for the three DDRIF2 modules
    if conv_cnt_en_s = '1' and ddr_wr_wait_request_1_s = '0' and conv_ba_addr_s < 1023 then
       ddr_wr_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(ddr_wr_addr_s) + 64);
       ddr_wr_data_1_s <= conv_ram_s(TO_INTEGER(conv_ba_addr_s) + 1)(511 downto 0); 
       ddr_wr_data_2_s <= conv_ram_s(TO_INTEGER(conv_ba_addr_s) + 1)(1023 downto 512); 
       ddr_wr_data_3_s <= conv_ram_s(TO_INTEGER(conv_ba_addr_s) + 1)(1535 downto 1024);        
       conv_ba_addr_s <= conv_ba_addr_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if conv_cnt_en_s = '1' and ddr_wr_wait_request_1_s = '0' and conv_ba_addr_s = 1023 then
      conv_cnt_en_s <= '0';
      ddr_wr_en_s <= '0';
    end if;
    
  end if;
end process conv_ram;



------------------------------------------------------------------------------
-- PROCESS : hsum_addr_gen
-- FUNCTION: Generates the address mimicing the HSUM module
------------------------------------------------------------------------------
hsum_addr_gen : process (clk_sys_s, rst_sys_n_s)
      
begin
  if rst_sys_n_s = '0' then
    hsum_en_rt_1_s <= '0';    
    hsum_cnt_en_s <= '0';
    hsum_cnt_s <= (others => '0');
    ddr_rd_addr_s <= (others => '0');  
    ddr_rd_en_s <= '0';  
                                        
  elsif (rising_edge(clk_sys_s)) then
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    hsum_en_rt_1_s <= hsum_en_s;
    
    
    -- start the request to write to DDR 
    if hsum_en_rt_1_s = '0' and hsum_en_s = '1' then
      hsum_cnt_en_s <= '1';
      hsum_cnt_s <= (others => '0');
      ddr_rd_addr_s <= (others => '0');
      ddr_rd_en_s <= '1';
    end if;
     
    -- if wait_request is low and write is requested and not all data used increment the address
    -- Just use the wait request from DDRIF2 #1 as they should all be acting in unision for the three DDRIF2 modules    
    if hsum_cnt_en_s = '1' and ddr_rd_wait_request_1_s = '0' and hsum_cnt_s < 1023 then
       ddr_rd_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(ddr_rd_addr_s) + 64);
       hsum_cnt_s <= hsum_cnt_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if hsum_cnt_en_s = '1' and ddr_rd_wait_request_1_s = '0' and hsum_cnt_s = 1023 then
      hsum_cnt_en_s <= '0';
      ddr_rd_en_s <= '0';
    end if;
    
  end if;
end process hsum_addr_gen;


------------------------------------------------------------------------------
-- PROCESS : check_to_ddr_1
-- FUNCTION: Checks the address and data to DDR #1
------------------------------------------------------------------------------
check_to_ddr_1 : process (clk_ddr_1_s, rst_ddr_n_1_s)
begin
  if rst_ddr_n_1_s = '0' then
    ddr_check_en_rt_1_1_s <= '0';
    ddr_cnt_check_en_1_s <= '0';  
    check_cnt_1_s <= (others => '0');
    exp_ddr_addr_1_s <= (others => '0');
    exp_ddr_data_1_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_ddr_1_s)) then
    
    ddr_check_en_rt_1_1_s <= ddr_check_en_1_s;
    
    -- start the checking
    if ddr_check_en_rt_1_1_s = '0' and ddr_check_en_1_s = '1' then
      ddr_cnt_check_en_1_s <= '1';
      check_cnt_1_s <= (others => '0');      
      exp_ddr_addr_1_s <= (others => '0');
      for i in 0 to 15 loop
        exp_ddr_data_1_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED((1 + i), 32)); 
      end loop;
    end if;
   
    if ddr_cnt_check_en_1_s = '1' then 
      if conv_en_s = '1' or pcie_write_en_1_s = '1' then
        if amm_write_1_s = '1' and amm_wait_request_1_s = '0' then
          -- check the values
          if amm_address_1_s /= exp_ddr_addr_1_s then   
            testbench_passed_v := false;
          end if; 
          for i in 0 to 15 loop
            if amm_write_data_1_s((32* i) + 31 downto (32*i)) /= exp_ddr_data_1_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if check_cnt_1_s < 1023 then
            exp_ddr_addr_1_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_1_s) + 64);
            for i in 0 to 15 loop
              exp_ddr_data_1_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_data_1_s(i)) + 16);
            end loop;
            check_cnt_1_s <= check_cnt_1_s + 1;
          else
            ddr_cnt_check_en_1_s <= '0';
          end if;        
        end if;
      end if;
      if hsum_en_s = '1' or pcie_read_en_1_s = '1' then
        if amm_read_1_s = '1' and amm_wait_request_1_s = '0' then
          -- check the values
          if amm_address_1_s /= exp_ddr_addr_1_s then   
            testbench_passed_v := false;
          end if;    
          -- increment the expected values
          if check_cnt_1_s < 1023 then
            exp_ddr_addr_1_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_1_s) + 64);
            check_cnt_1_s <= check_cnt_1_s + 1;
          else
            ddr_cnt_check_en_1_s <= '0';
          end if;
        end if;
      end if;
    end if;
  end if;

   
 end process check_to_ddr_1;  
 
------------------------------------------------------------------------------
-- PROCESS : check_to_ddr_2
-- FUNCTION: Checks the address and data to DDR #2
------------------------------------------------------------------------------
check_to_ddr_2 : process (clk_ddr_2_s, rst_ddr_n_2_s)
begin
  if rst_ddr_n_2_s = '0' then
    ddr_check_en_rt_1_2_s <= '0';
    ddr_cnt_check_en_2_s <= '0';  
    check_cnt_2_s <= (others => '0');
    exp_ddr_addr_2_s <= (others => '0');
    exp_ddr_data_2_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_ddr_2_s)) then
    
    ddr_check_en_rt_1_2_s <= ddr_check_en_2_s;
    
    -- start the checking
    if ddr_check_en_rt_1_2_s = '0' and ddr_check_en_2_s = '1' then
      ddr_cnt_check_en_2_s <= '1';
      check_cnt_2_s <= (others => '0');      
      exp_ddr_addr_2_s <= (others => '0');
      for i in 0 to 15 loop
        exp_ddr_data_2_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (1 + i), 32)); 
      end loop;
    end if;
   
    if ddr_cnt_check_en_2_s = '1' then 
      if conv_en_s = '1' or pcie_write_en_2_s = '1' then
        if amm_write_2_s = '1' and amm_wait_request_2_s = '0' then
          -- check the values
          if amm_address_2_s /= exp_ddr_addr_2_s then   
            testbench_passed_v := false;
          end if; 
          for i in 0 to 15 loop
            if amm_write_data_2_s((32* i) + 31 downto (32*i)) /= exp_ddr_data_2_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if check_cnt_1_s < 1023 then
            exp_ddr_addr_2_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_2_s) + 64);
            for i in 0 to 15 loop
              exp_ddr_data_2_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_data_2_s(i)) + 16);
            end loop;
            check_cnt_2_s <= check_cnt_2_s + 1;
          else
            ddr_cnt_check_en_2_s <= '0';
          end if;        
        end if;
      end if;
      if hsum_en_s = '1' or pcie_read_en_2_s = '1' then
        if amm_read_2_s = '1' and amm_wait_request_2_s = '0' then
          -- check the values
          if amm_address_2_s /= exp_ddr_addr_2_s then   
            testbench_passed_v := false;
          end if;    
          -- increment the expected values
          if check_cnt_2_s < 1023 then
            exp_ddr_addr_2_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_2_s) + 64);
            check_cnt_2_s <= check_cnt_2_s + 1;
          else
            ddr_cnt_check_en_2_s <= '0';
          end if;
        end if;
      end if;
    end if;
  end if;

   
 end process check_to_ddr_2;   
 
------------------------------------------------------------------------------
-- PROCESS : check_to_ddr_3
-- FUNCTION: Checks the address and data to DDR #3
------------------------------------------------------------------------------
check_to_ddr_3 : process (clk_ddr_3_s, rst_ddr_n_3_s)
begin
  if rst_ddr_n_3_s = '0' then
    ddr_check_en_rt_1_3_s <= '0';
    ddr_cnt_check_en_3_s <= '0';  
    check_cnt_3_s <= (others => '0');
    exp_ddr_addr_3_s <= (others => '0');
    exp_ddr_data_3_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_ddr_3_s)) then
    
    ddr_check_en_rt_1_3_s <= ddr_check_en_3_s;
    
    -- start the checking
    if ddr_check_en_rt_1_3_s = '0' and ddr_check_en_3_s = '1' then
      ddr_cnt_check_en_3_s <= '1';
      check_cnt_3_s <= (others => '0');      
      exp_ddr_addr_3_s <= (others => '0');
      for i in 0 to 15 loop
        exp_ddr_data_3_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (1 + i), 32)); 
      end loop;
    end if;
   
    if ddr_cnt_check_en_3_s = '1' then 
      if conv_en_s = '1' or pcie_write_en_3_s = '1' then
        if amm_write_3_s = '1' and amm_wait_request_3_s = '0' then
          -- check the values
          if amm_address_3_s /= exp_ddr_addr_3_s then   
            testbench_passed_v := false;
          end if; 
          for i in 0 to 15 loop
            if amm_write_data_3_s((32* i) + 31 downto (32*i)) /= exp_ddr_data_3_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if check_cnt_1_s < 1023 then
            exp_ddr_addr_3_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_3_s) + 64);
            for i in 0 to 15 loop
              exp_ddr_data_3_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_data_3_s(i)) + 16);
            end loop;
            check_cnt_3_s <= check_cnt_3_s + 1;
          else
            ddr_cnt_check_en_3_s <= '0';
          end if;        
        end if;
      end if;
      if hsum_en_s = '1' or pcie_read_en_3_s = '1' then
        if amm_read_3_s = '1' and amm_wait_request_3_s = '0' then
          -- check the values
          if amm_address_3_s /= exp_ddr_addr_3_s then   
            testbench_passed_v := false;
          end if;    
          -- increment the expected values
          if check_cnt_3_s < 1023 then
            exp_ddr_addr_3_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_3_s) + 64);
            check_cnt_3_s <= check_cnt_3_s + 1;
          else
            ddr_cnt_check_en_3_s <= '0';
          end if;
        end if;
      end if;
    end if;
  end if;

   
 end process check_to_ddr_3;   
  

------------------------------------------------------------------------------
-- PROCESS : check_to_hsum
-- FUNCTION: Checks the data to HSUM
------------------------------------------------------------------------------
check_to_hsum : process (clk_sys_s, rst_sys_n_s)
begin
  if rst_sys_n_s = '0' then
    hsum_check_en_rt_1_s <= '0';
    hsum_cnt_check_en_s <= '0';  
    hsum_check_cnt_s <= (others => '0');
    exp_hsum_data_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_sys_s)) then
    
    hsum_check_en_rt_1_s <= hsum_check_en_s;
    
    -- start the checking
    if hsum_check_en_rt_1_s = '0' and hsum_check_en_s = '1' then
      hsum_cnt_check_en_s <= '1';
      hsum_check_cnt_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_hsum_data_s(i)(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED((i), 64)); 
        exp_hsum_data_s(i)(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i), 64));
        exp_hsum_data_s(i)(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i), 64));
      end loop;
    end if;
   
    if hsum_cnt_check_en_s = '1' then 
      if hsum_en_s = '1' then
        -- Just use the ddr_rd_data_valid from DDRIF2 #1 as they should act in unison 
        if ddr_rd_data_valid_1_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if ddr_rd_data_1_s((64* i) + 63 downto (64*i)) /= exp_hsum_data_s(i)(63 downto 0) or 
               ddr_rd_data_2_s((64* i) + 63 downto (64*i)) /= exp_hsum_data_s(i)(127 downto 64) or
               ddr_rd_data_3_s((64* i) + 63 downto (64*i)) /= exp_hsum_data_s(i)(191 downto 128) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if hsum_check_cnt_s < 1023 then
            for i in 0 to 7 loop
              exp_hsum_data_s(i)(63 downto 0) <= STD_LOGIC_VECTOR(UNSIGNED(exp_hsum_data_s(i)(63 downto 0)) + 8); 
              exp_hsum_data_s(i)(127 downto 64) <= STD_LOGIC_VECTOR(UNSIGNED(exp_hsum_data_s(i)(127 downto 64)) + 8);
              exp_hsum_data_s(i)(191 downto 128) <= STD_LOGIC_VECTOR(UNSIGNED(exp_hsum_data_s(i)(191 downto 128)) + 8);           
            end loop;
            hsum_check_cnt_s <= hsum_check_cnt_s + 1;
          else
            hsum_cnt_check_en_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_hsum;  
 
------------------------------------------------------------------------------
-- PROCESS : pcie_ram_1
-- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
------------------------------------------------------------------------------
pcie_ram_1 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_write_en_rt_1_1_s <= '0';    
    pcie_write_cnt_en_1_s <= '0';
    pcie_write_ba_addr_1_s <= (others => '0');
    burst_write_addr_cnt_1_s <= (others => '0');
    rd_dma_write_data_1_s <= (others => '0');  
    rd_dma_address_1_s <= (others => '0');
    rd_dma_write_1_s <= '0';
    rd_dma_byte_en_1_s <= (others => '1');  
    rd_dma_burst_count_1_s <= (others => '0'); 
    send_1_s <= '0';
    rd_dma_wait_request_ret_1_s <= '0';
    wait_count_en_1_s <= '0';
    wait_count_1_s <= (others => '0'); 
  elsif (rising_edge(clk_pcie_s)) then
    if (pcie_awren_1_s = '1') then
      pcie_ram_1_s(TO_INTEGER(pcie_aa_1_s)) <= pcie_ai_1_s;
    end if;
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_write_en_rt_1_1_s <= pcie_write_en_1_s;
    
    rd_dma_wait_request_ret_1_s <= rd_dma_wait_request_1_s;
    
    -- Default
    rd_dma_write_1_s <= '0';
    wait_count_1_s  <= (others => '0');
    
    -- start the request to write to DDR 
    if pcie_write_en_rt_1_1_s = '0' and pcie_write_en_1_s = '1' then
      pcie_write_cnt_en_1_s <= '1';
      pcie_write_ba_addr_1_s <= (others => '0');
      burst_write_addr_cnt_1_s <= (others => '0');     
      rd_dma_write_data_1_s <= pcie_ram_1_s(0);  
      rd_dma_address_1_s(31 downto 0) <= (others => '0');
      rd_dma_burst_count_1_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_1_s) +1),4));
      rd_dma_byte_en_1_s <= (others => '0');
      rd_dma_write_1_s <= '1'; 
    end if;
     
      
    if rd_dma_wait_request_1_s = '0' then
      send_1_s <= '1';
    else
      if rd_dma_wait_request_ret_1_s = '0' and rd_dma_wait_request_1_s = '1' then
        wait_count_en_1_s <= '1';
      end if;
    end if;
      
    if wait_count_en_1_s = '1' then 
      wait_count_1_s <= wait_count_1_s + 1;
      if wait_count_1_s = 16 then
        send_1_s <= '0';
        wait_count_en_1_s <= '0';       
      end if;
    end if;
    
    
    -- if triggered to send data from PCIe and send_s = 1  and not all data used increment the address
    if pcie_write_cnt_en_1_s = '1' and send_1_s = '1' and pcie_write_ba_addr_1_s < 1023 then   
      rd_dma_write_1_s <= '1';
      pcie_write_ba_addr_1_s <= pcie_write_ba_addr_1_s + 1;
      burst_write_addr_cnt_1_s <= burst_write_addr_cnt_1_s + 1;       
      if burst_write_addr_cnt_1_s = burst_num_1_s then
        burst_write_addr_cnt_1_s <= (others => '0');
        rd_dma_address_1_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma_address_1_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_1_s) +1), 32));
      end if;
      rd_dma_write_data_1_s <= pcie_ram_1_s(TO_INTEGER(pcie_write_ba_addr_1_s) + 1);      
            
    end if;
      
    
    -- if the pcie_write_ba_addr_s = 1023 allow the burst to complete
    if pcie_write_ba_addr_1_s = 1023 then
      if burst_write_addr_cnt_1_s < burst_num_1_s then
        burst_write_addr_cnt_1_s <= burst_write_addr_cnt_1_s + 1;
      end if;
    end if;
        
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_write_cnt_en_1_s = '1' and send_1_s = '1' and pcie_write_ba_addr_1_s = 1023 and burst_write_addr_cnt_1_s = burst_num_1_s then
      pcie_write_cnt_en_1_s <= '0';
      rd_dma_write_1_s <= '0';
      send_1_s <= '0';
    end if;
    
  end if;
end process pcie_ram_1;


------------------------------------------------------------------------------
-- PROCESS : pcie_ram_2
-- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
------------------------------------------------------------------------------
pcie_ram_2 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_write_en_rt_1_2_s <= '0';    
    pcie_write_cnt_en_2_s <= '0';
    pcie_write_ba_addr_2_s <= (others => '0');
    burst_write_addr_cnt_2_s <= (others => '0');
    rd_dma_write_data_2_s <= (others => '0');  
    rd_dma_address_2_s <= (others => '0');
    rd_dma_write_2_s <= '0';
    rd_dma_byte_en_2_s <= (others => '1');  
    rd_dma_burst_count_2_s <= (others => '0'); 
    send_2_s <= '0';
    rd_dma_wait_request_ret_2_s <= '0';
    wait_count_en_2_s <= '0';
    wait_count_2_s <= (others => '0'); 
  elsif (rising_edge(clk_pcie_s)) then
    if (pcie_awren_2_s = '1') then
      pcie_ram_2_s(TO_INTEGER(pcie_aa_2_s)) <= pcie_ai_2_s;
    end if;
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_write_en_rt_1_2_s <= pcie_write_en_2_s;
    
    rd_dma_wait_request_ret_2_s <= rd_dma_wait_request_2_s;
    
    -- Default
    rd_dma_write_2_s <= '0';
    wait_count_2_s  <= (others => '0');
    
    -- start the request to write to DDR 
    if pcie_write_en_rt_1_2_s = '0' and pcie_write_en_2_s = '1' then
      pcie_write_cnt_en_2_s <= '1';
      pcie_write_ba_addr_2_s <= (others => '0');
      burst_write_addr_cnt_2_s <= (others => '0');     
      rd_dma_write_data_2_s <= pcie_ram_2_s(0);  
      rd_dma_address_2_s(31 downto 0) <= (others => '0');
      rd_dma_burst_count_2_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_2_s) +1),4));
      rd_dma_byte_en_2_s <= (others => '0');
      rd_dma_write_2_s <= '1'; 
    end if;
     
      
    if rd_dma_wait_request_2_s = '0' then
      send_2_s <= '1';
    else
      if rd_dma_wait_request_ret_2_s = '0' and rd_dma_wait_request_2_s = '1' then
        wait_count_en_2_s <= '1';
      end if;
    end if;
      
    if wait_count_en_2_s = '1' then 
      wait_count_2_s <= wait_count_2_s + 1;
      if wait_count_2_s = 16 then
        send_2_s <= '0';
        wait_count_en_2_s <= '0';       
      end if;
    end if;
    
    
    -- if triggered to send data from PCIe and send_s = 1  and not all data used increment the address
    if pcie_write_cnt_en_2_s = '1' and send_2_s = '1' and pcie_write_ba_addr_2_s < 1023 then   
      rd_dma_write_2_s <= '1';
      pcie_write_ba_addr_2_s <= pcie_write_ba_addr_2_s + 1;
      burst_write_addr_cnt_2_s <= burst_write_addr_cnt_2_s + 1;       
      if burst_write_addr_cnt_2_s = burst_num_2_s then
        burst_write_addr_cnt_2_s <= (others => '0');
        rd_dma_address_2_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma_address_2_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_2_s) +1), 32));
      end if;
      rd_dma_write_data_2_s <= pcie_ram_2_s(TO_INTEGER(pcie_write_ba_addr_2_s) + 1);      
            
    end if;
      
    
    -- if the pcie_write_ba_addr_s = 1023 allow the burst to complete
    if pcie_write_ba_addr_2_s = 1023 then
      if burst_write_addr_cnt_2_s < burst_num_2_s then
        burst_write_addr_cnt_2_s <= burst_write_addr_cnt_2_s + 1;
      end if;
    end if;
        
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_write_cnt_en_2_s = '1' and send_2_s = '1' and pcie_write_ba_addr_2_s = 1023 and burst_write_addr_cnt_2_s = burst_num_2_s then
      pcie_write_cnt_en_2_s <= '0';
      rd_dma_write_2_s <= '0';
      send_2_s <= '0';
    end if;
    
  end if;
end process pcie_ram_2;


------------------------------------------------------------------------------
-- PROCESS : pcie_ram_3
-- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
------------------------------------------------------------------------------
pcie_ram_3 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_write_en_rt_1_3_s <= '0';    
    pcie_write_cnt_en_3_s <= '0';
    pcie_write_ba_addr_3_s <= (others => '0');
    burst_write_addr_cnt_3_s <= (others => '0');
    rd_dma_write_data_3_s <= (others => '0');  
    rd_dma_address_3_s <= (others => '0');
    rd_dma_write_3_s <= '0';
    rd_dma_byte_en_3_s <= (others => '1');  
    rd_dma_burst_count_3_s <= (others => '0'); 
    send_3_s <= '0';
    rd_dma_wait_request_ret_3_s <= '0';
    wait_count_en_3_s <= '0';
    wait_count_3_s <= (others => '0'); 
  elsif (rising_edge(clk_pcie_s)) then
    if (pcie_awren_3_s = '1') then
      pcie_ram_3_s(TO_INTEGER(pcie_aa_3_s)) <= pcie_ai_3_s;
    end if;
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_write_en_rt_1_3_s <= pcie_write_en_3_s;
    
    rd_dma_wait_request_ret_3_s <= rd_dma_wait_request_3_s;
    
    -- Default
    rd_dma_write_3_s <= '0';
    wait_count_3_s  <= (others => '0');
    
    -- start the request to write to DDR 
    if pcie_write_en_rt_1_3_s = '0' and pcie_write_en_3_s = '1' then
      pcie_write_cnt_en_3_s <= '1';
      pcie_write_ba_addr_3_s <= (others => '0');
      burst_write_addr_cnt_3_s <= (others => '0');     
      rd_dma_write_data_3_s <= pcie_ram_3_s(0);  
      rd_dma_address_3_s(31 downto 0) <= (others => '0');
      rd_dma_burst_count_3_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_3_s) +1),4));
      rd_dma_byte_en_3_s <= (others => '0');
      rd_dma_write_3_s <= '1'; 
    end if;
     
      
    if rd_dma_wait_request_3_s = '0' then
      send_3_s <= '1';
    else
      if rd_dma_wait_request_ret_3_s = '0' and rd_dma_wait_request_3_s = '1' then
        wait_count_en_3_s <= '1';
      end if;
    end if;
      
    if wait_count_en_3_s = '1' then 
      wait_count_3_s <= wait_count_3_s + 1;
      if wait_count_3_s = 16 then
        send_3_s <= '0';
        wait_count_en_3_s <= '0';       
      end if;
    end if;
    
    
    -- if triggered to send data from PCIe and send_s = 1  and not all data used increment the address
    if pcie_write_cnt_en_3_s = '1' and send_3_s = '1' and pcie_write_ba_addr_3_s < 1023 then   
      rd_dma_write_3_s <= '1';
      pcie_write_ba_addr_3_s <= pcie_write_ba_addr_3_s + 1;
      burst_write_addr_cnt_3_s <= burst_write_addr_cnt_3_s + 1;       
      if burst_write_addr_cnt_3_s = burst_num_3_s then
        burst_write_addr_cnt_3_s <= (others => '0');
        rd_dma_address_3_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma_address_3_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_3_s) +1), 32));
      end if;
      rd_dma_write_data_3_s <= pcie_ram_3_s(TO_INTEGER(pcie_write_ba_addr_3_s) + 1);      
            
    end if;
      
    
    -- if the pcie_write_ba_addr_s = 1023 allow the burst to complete
    if pcie_write_ba_addr_3_s = 1023 then
      if burst_write_addr_cnt_3_s < burst_num_3_s then
        burst_write_addr_cnt_3_s <= burst_write_addr_cnt_3_s + 1;
      end if;
    end if;
        
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_write_cnt_en_3_s = '1' and send_3_s = '1' and pcie_write_ba_addr_3_s = 1023 and burst_write_addr_cnt_3_s = burst_num_3_s then
      pcie_write_cnt_en_3_s <= '0';
      rd_dma_write_3_s <= '0';
      send_3_s <= '0';
    end if;
    
  end if;
end process pcie_ram_3;



------------------------------------------------------------------------------
-- PROCESS : pcie_addr_gen_1
-- FUNCTION: Generates the address mimicing the PCIe Interface to DDRIF2 #1
------------------------------------------------------------------------------
pcie_addr_gen_1 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_read_en_rt_1_1_s <= '0';    
    pcie_read_cnt_en_1_s <= '0';
    pcie_read_cnt_1_s <= (others => '0');
    burst_read_addr_cnt_1_s <= (others => '0');
    wr_dma_address_1_s <= (others => '0');  
    wr_dma_burst_count_1_s <= (others => '0');  
    wr_dma_read_1_s <= '0';  
                                        
  elsif (rising_edge(clk_pcie_s)) then
   
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_read_en_rt_1_1_s <= pcie_read_en_1_s;
    
    
    -- start the request to read from DDR 
    if pcie_read_en_rt_1_1_s = '0' and pcie_read_en_1_s = '1' then
      pcie_read_cnt_en_1_s <= '1';
      pcie_read_cnt_1_s <= (others => '0');
      burst_read_addr_cnt_1_s <= (others => '0'); 
      wr_dma_address_1_s <= (others => '0');    
      wr_dma_burst_count_1_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_1_s) +1),4));
      wr_dma_read_1_s <= '1'; 
    end if;
     
    -- if wait_request is low and read is requested and not all data used increment the address
    if pcie_read_cnt_en_1_s = '1' and wr_dma_wait_request_1_s = '0' and pcie_read_cnt_1_s < 100 then
      pcie_read_cnt_1_s <= pcie_read_cnt_1_s + 1;
      wr_dma_address_1_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma_address_1_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_1_s) +1), 32));
    end if;
       
   
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_read_cnt_en_1_s = '1' and wr_dma_wait_request_1_s = '0' and pcie_read_cnt_1_s = 100 then
      pcie_read_cnt_en_1_s <= '0';
      wr_dma_read_1_s <= '0';
    end if;
    
  end if;
end process pcie_addr_gen_1;

------------------------------------------------------------------------------
-- PROCESS : pcie_addr_gen_2
-- FUNCTION: Generates the address mimicing the PCIe Interface to DDRIF2 #2
------------------------------------------------------------------------------
pcie_addr_gen_2 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_read_en_rt_1_2_s <= '0';    
    pcie_read_cnt_en_2_s <= '0';
    pcie_read_cnt_2_s <= (others => '0');
    burst_read_addr_cnt_2_s <= (others => '0');
    wr_dma_address_2_s <= (others => '0');  
    wr_dma_burst_count_2_s <= (others => '0');  
    wr_dma_read_2_s <= '0';  
                                        
  elsif (rising_edge(clk_pcie_s)) then
   
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_read_en_rt_1_2_s <= pcie_read_en_2_s;
    
    
    -- start the request to read from DDR 
    if pcie_read_en_rt_1_2_s = '0' and pcie_read_en_2_s = '1' then
      pcie_read_cnt_en_2_s <= '1';
      pcie_read_cnt_2_s <= (others => '0');
      burst_read_addr_cnt_2_s <= (others => '0'); 
      wr_dma_address_2_s <= (others => '0');    
      wr_dma_burst_count_2_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_2_s) +1),4));
      wr_dma_read_2_s <= '1'; 
    end if;
     
    -- if wait_request is low and read is requested and not all data used increment the address
    if pcie_read_cnt_en_2_s = '1' and wr_dma_wait_request_2_s = '0' and pcie_read_cnt_2_s < 100 then
      pcie_read_cnt_2_s <= pcie_read_cnt_2_s + 1;
      wr_dma_address_2_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma_address_2_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_2_s) +1), 32));
    end if;
       
   
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_read_cnt_en_2_s = '1' and wr_dma_wait_request_2_s = '0' and pcie_read_cnt_2_s = 100 then
      pcie_read_cnt_en_2_s <= '0';
      wr_dma_read_2_s <= '0';
    end if;
    
  end if;
end process pcie_addr_gen_2;

------------------------------------------------------------------------------
-- PROCESS : pcie_addr_gen_3
-- FUNCTION: Generates the address mimicing the PCIe Interface to DDRIF2 #3
------------------------------------------------------------------------------
pcie_addr_gen_3 : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_read_en_rt_1_3_s <= '0';    
    pcie_read_cnt_en_3_s <= '0';
    pcie_read_cnt_3_s <= (others => '0');
    burst_read_addr_cnt_3_s <= (others => '0');
    wr_dma_address_3_s <= (others => '0');  
    wr_dma_burst_count_3_s <= (others => '0');  
    wr_dma_read_3_s <= '0';  
                                        
  elsif (rising_edge(clk_pcie_s)) then
   
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_read_en_rt_1_3_s <= pcie_read_en_3_s;
    
    
    -- start the request to read from DDR 
    if pcie_read_en_rt_1_3_s = '0' and pcie_read_en_3_s = '1' then
      pcie_read_cnt_en_3_s <= '1';
      pcie_read_cnt_3_s <= (others => '0');
      burst_read_addr_cnt_3_s <= (others => '0'); 
      wr_dma_address_3_s <= (others => '0');    
      wr_dma_burst_count_3_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_3_s) +1),4));
      wr_dma_read_3_s <= '1'; 
    end if;
     
    -- if wait_request is low and read is requested and not all data used increment the address
    if pcie_read_cnt_en_3_s = '1' and wr_dma_wait_request_3_s = '0' and pcie_read_cnt_3_s < 100 then
      pcie_read_cnt_3_s <= pcie_read_cnt_3_s + 1;
      wr_dma_address_3_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma_address_3_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_3_s) +1), 32));
    end if;
       
   
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_read_cnt_en_3_s = '1' and wr_dma_wait_request_3_s = '0' and pcie_read_cnt_3_s = 100 then
      pcie_read_cnt_en_3_s <= '0';
      wr_dma_read_3_s <= '0';
    end if;
    
  end if;
end process pcie_addr_gen_3;

------------------------------------------------------------------------------
-- PROCESS : check_to_pcie_1
-- FUNCTION: Checks the data to the PCie Interface from DDRIF2 #1
------------------------------------------------------------------------------
check_to_pcie_1 : process (clk_pcie_s, rst_pcie_n_s)

begin

  if rst_pcie_n_s = '0' then
    pcie_check_en_rt_1_1_s <= '0';
    pcie_cnt_check_en_1_s <= '0';  
    pcie_check_cnt_1_s <= (others => '0');
    exp_pcie_data_1_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_pcie_s)) then
    
    pcie_check_en_rt_1_1_s <= pcie_check_en_1_s;
    
    -- start the checking
    if pcie_check_en_rt_1_1_s = '0' and pcie_check_en_1_s = '1' then
      pcie_cnt_check_en_1_s <= '1';
      pcie_check_cnt_1_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_pcie_data_1_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED((i), 64)); 
      end loop;
    end if;
   
    if pcie_cnt_check_en_1_s = '1' then 
      if pcie_read_en_1_s = '1' then
        if wr_dma_read_data_valid_1_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if wr_dma_read_data_1_s((64* i) + 63 downto (64*i)) /= exp_pcie_data_1_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if pcie_check_cnt_1_s < 1023 then
            for i in 0 to 7 loop
              exp_pcie_data_1_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_pcie_data_1_s(i)) + 8);
            end loop;
            pcie_check_cnt_1_s <= pcie_check_cnt_1_s + 1;
          else
            pcie_cnt_check_en_1_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_pcie_1;  
 
------------------------------------------------------------------------------
-- PROCESS : check_to_pcie_2
-- FUNCTION: Checks the data to the PCie Interface from DDRIF2 #2
------------------------------------------------------------------------------
check_to_pcie_2 : process (clk_pcie_s, rst_pcie_n_s)

begin

  if rst_pcie_n_s = '0' then
    pcie_check_en_rt_1_2_s <= '0';
    pcie_cnt_check_en_2_s <= '0';  
    pcie_check_cnt_2_s <= (others => '0');
    exp_pcie_data_2_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_pcie_s)) then
    
    pcie_check_en_rt_1_2_s <= pcie_check_en_2_s;
    
    -- start the checking
    if pcie_check_en_rt_1_2_s = '0' and pcie_check_en_2_s = '1' then
      pcie_cnt_check_en_2_s <= '1';
      pcie_check_cnt_2_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_pcie_data_2_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i), 64)); 
      end loop;
    end if;
   
    if pcie_cnt_check_en_2_s = '1' then 
      if pcie_read_en_2_s = '1' then
        if wr_dma_read_data_valid_2_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if wr_dma_read_data_2_s((64* i) + 63 downto (64*i)) /= exp_pcie_data_2_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if pcie_check_cnt_2_s < 1023 then
            for i in 0 to 7 loop
              exp_pcie_data_2_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_pcie_data_2_s(i)) + 8);
            end loop;
            pcie_check_cnt_2_s <= pcie_check_cnt_2_s + 1;
          else
            pcie_cnt_check_en_2_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_pcie_2;   
 
------------------------------------------------------------------------------
-- PROCESS : check_to_pcie_3
-- FUNCTION: Checks the data to the PCie Interface from DDRIR2 #3
------------------------------------------------------------------------------
check_to_pcie_3 : process (clk_pcie_s, rst_pcie_n_s)

begin

  if rst_pcie_n_s = '0' then
    pcie_check_en_rt_1_3_s <= '0';
    pcie_cnt_check_en_3_s <= '0';  
    pcie_check_cnt_3_s <= (others => '0');
    exp_pcie_data_3_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_pcie_s)) then
    
    pcie_check_en_rt_1_3_s <= pcie_check_en_3_s;
    
    -- start the checking
    if pcie_check_en_rt_1_3_s = '0' and pcie_check_en_3_s = '1' then
      pcie_cnt_check_en_3_s <= '1';
      pcie_check_cnt_3_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_pcie_data_3_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i), 64)); 
      end loop;
    end if;
   
    if pcie_cnt_check_en_3_s = '1' then 
      if pcie_read_en_3_s = '1' then
        if wr_dma_read_data_valid_3_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if wr_dma_read_data_3_s((64* i) + 63 downto (64*i)) /= exp_pcie_data_3_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if pcie_check_cnt_3_s < 1023 then
            for i in 0 to 7 loop
              exp_pcie_data_3_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_pcie_data_3_s(i)) + 8);
            end loop;
            pcie_check_cnt_3_s <= pcie_check_cnt_3_s + 1;
          else
            pcie_cnt_check_en_3_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_pcie_3;    
 
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
    variable  test_6_v      : std_logic;  
    variable  test_7_v      : std_logic;  
    variable  test_8_v      : std_logic;  
    variable  test_9_v      : std_logic;     
    variable  test_10_v     : std_logic;   
    variable  test_11_v     : std_logic;   
    variable  test_12_v      : std_logic;
    variable  test_13_v      : std_logic;
    variable  test_14_v      : std_logic;
    variable  test_15_v      : std_logic;  
    variable  test_16_v      : std_logic;  
    variable  test_17_v      : std_logic;  
    variable  test_18_v      : std_logic;  
    variable  test_19_v      : std_logic;     
    variable  test_20_v      : std_logic;   
    variable  test_21_v      : std_logic;   
    variable  test_22_v      : std_logic;
    variable  test_23_v      : std_logic;    
    variable  test_24_v      : std_logic;      
    variable  test_25_v      : std_logic;      
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
    wait for clk_sys_per_c * clocks;
  end procedure run;

  
 

begin

  heading("Initialisation.");
  -- Initialise signals.
  
  -- Signal declarations.
 
  -- DDRIF Module PCIe Interface to write to DDR memory
  -- these are now controlled by pcie_ram
  --rd_dma_address_s                     <= (others => '0');
  --rd_dma_burst_count_s                 <= (others => '0');
  --rd_dma_byte_en_s                     <= (others => '0');
  --rd_dma_write_s                       <= '0';
  --rd_dma_write_data_s                  <= (others => '0');
  
        
  -- DDRIF Module FDAS Processing Interface to write to DDR memory  
  -- These are now controlled by process conv_ram
  --ddr_wr_addr_s                        <= (others => '0');
  --ddr_wr_data_s                        <= (others => '0');
  --ddr_wr_en_s                          <= '0';    
  
  
  -- DDRIF Module PCIe Interface to read from DDR memory
  -- These are now controlled by process pcie_addr_gen
  --wr_dma_address_s                     <= (others => '0');
  --wr_dma_burst_count_s                 <= (others => '0');
  --wr_dma_read_s                        <= '0';
  
  
  -- DDRIF Module FDAS Processing Interface to read from DDR memory 
  -- These are now controlled by process cld_addr_gen
  --ddr_rd_addr_s                        <= (others => '0');
  --ddr_rd_en_s                          <= '0';
  
  
  -- DDRIF Module Interface to DDR Controller
  -- This signal is now controlled by process ddr_latency
  --amm_read_data_s                      <= (others => '0');
  
  

      
  -- Test bench
  -- process: stimgen  
  write_wait_request_en_1_s         <= '0';
  write_wait_request_en_2_s         <= '0';
  write_wait_request_en_3_s         <= '0';
  read_wait_request_en_1_s          <= '0';
  read_wait_request_en_2_s          <= '0';
  read_wait_request_en_3_s          <= '0'; 
  rst_sys_n_s 	                    <= '0'; 
  rst_pcie_n_s 	                    <= '0';  
  rst_ddr_n_1_s 	                <= '0';
  rst_ddr_n_2_s 	                <= '0';  
  rst_ddr_n_3_s 	                <= '0';  
  run(2);  
  rst_sys_n_s 	                    <= '1'; 
  rst_pcie_n_s 	                    <= '1';
  rst_ddr_n_1_s 	                <= '1';  
  rst_ddr_n_2_s 	                <= '1';    
  rst_ddr_n_3_s 	                <= '1';  
  awren_1_s                         <= '0';
  awren_2_s                         <= '0';  
  awren_3_s                         <= '0'; 
  ddr_latency_1_s                   <= "01000";  
  ddr_latency_2_s                   <= "01000";  
  ddr_latency_3_s                   <= "01000";  
  conv_awren_s                      <= '0';
  conv_en_s                         <= '0';  
  
  ddr_check_en_1_s                  <= '0';
  ddr_check_en_2_s                  <= '0';  
  ddr_check_en_3_s                  <= '0'; 
  wait_gap_1_s                      <= (others => '0');
  wait_gap_2_s                      <= (others => '0');
  wait_gap_3_s                      <= (others => '0');
  hsum_en_s                         <= '0';
  hsum_check_en_s                   <= '0';
  burst_num_1_s                     <= (others => '0');
  burst_num_2_s                     <= (others => '0');
  burst_num_3_s                     <= (others => '0');
  pcie_write_en_1_s                 <= '0';
  pcie_write_en_2_s                 <= '0';
  pcie_write_en_3_s                 <= '0'; 
  pcie_read_en_1_s                  <= '0';
  pcie_read_en_2_s                  <= '0'; 
  pcie_read_en_3_s                  <= '0';
  pcie_check_en_1_s                 <= '0';
  pcie_check_en_2_s                 <= '0';  
  pcie_check_en_3_s                 <= '0';  
    
   -- Load the samples into the CONV  memory
  -- This is so that we can write data from the CONV module to the DDR memory
  for i in 0 to 1023 loop 
    -- set each 32-bit sample value to it's sample number with offset:- 
    -- 0x0000 for DDRIF#1
    -- 0x5000 for DDRIF#2
    -- 0xA000 for DDRIF#3    
    conv_awren_s <= '1';
    
    -- CONV data to DDRRIF2 #1
    conv_ai_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 1, 32));
    conv_ai_s(63 downto 32) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 2, 32));
    conv_ai_s(95 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 3, 32));    
    conv_ai_s(127 downto 96) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 4, 32));    
    conv_ai_s(159 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 5, 32));
    conv_ai_s(191 downto 160) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 6, 32));    
    conv_ai_s(223 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 7, 32));
    conv_ai_s(255 downto 224) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 8, 32));    
    conv_ai_s(287 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 9, 32));    
    conv_ai_s(319 downto 288) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 10, 32)); 
    conv_ai_s(351 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 11, 32)); 
    conv_ai_s(383 downto 352) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 12, 32));    
    conv_ai_s(415 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 13, 32));   
    conv_ai_s(447 downto 416) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 14, 32));
    conv_ai_s(479 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 15, 32));    
    conv_ai_s(511 downto 480) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 16, 32));  
    
    -- CONV data to DDRRIF2 #2
    conv_ai_s(543 downto 512) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 1, 32));
    conv_ai_s(575 downto 544) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 2, 32));
    conv_ai_s(607 downto 576) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 3, 32));    
    conv_ai_s(639 downto 608) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 4, 32));    
    conv_ai_s(671 downto 640) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 5, 32));
    conv_ai_s(703 downto 672) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 6, 32));    
    conv_ai_s(735 downto 704) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 7, 32));
    conv_ai_s(767 downto 736) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 8, 32));    
    conv_ai_s(799 downto 768) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 9, 32));    
    conv_ai_s(831 downto 800) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 10, 32)); 
    conv_ai_s(863 downto 832) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 11, 32)); 
    conv_ai_s(895 downto 864) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 12, 32));    
    conv_ai_s(927 downto 896) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 13, 32));   
    conv_ai_s(959 downto 928) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 14, 32));
    conv_ai_s(991 downto 960) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 15, 32));    
    conv_ai_s(1023 downto 992) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 16, 32));       
    
    -- CONV data to DDRRIF2 #3
    conv_ai_s(1055 downto 1024) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 1, 32));
    conv_ai_s(1087 downto 1056) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 2, 32));
    conv_ai_s(1119 downto 1088) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 3, 32));    
    conv_ai_s(1151 downto 1120) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 4, 32));    
    conv_ai_s(1183 downto 1152) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 5, 32));
    conv_ai_s(1215 downto 1184) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 6, 32));    
    conv_ai_s(1247 downto 1216) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 7, 32));
    conv_ai_s(1279 downto 1248) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 8, 32));    
    conv_ai_s(1311 downto 1280) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 9, 32));    
    conv_ai_s(1343 downto 1312) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 10, 32)); 
    conv_ai_s(1375 downto 1344) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 11, 32)); 
    conv_ai_s(1407 downto 1376) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 12, 32));    
    conv_ai_s(1439 downto 1408) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 13, 32));   
    conv_ai_s(1471 downto 1440) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 14, 32));
    conv_ai_s(1503 downto 1472) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 15, 32));    
    conv_ai_s(1535 downto 1504) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 16, 32));  
    
    conv_aa_s <= (TO_UNSIGNED(i, 10));
    run(1);
  end loop;
  conv_awren_s <= '0';
  run(1); 
  


   -- Load the samples into the PCIe  memory to mimic the PCIe interface
  -- This is so that we can write data from the CONV module to the DDR memory
  for i in 0 to 1023 loop 
    -- set each 32-bit sample value to it's sample number with offset:- 
    -- 0x0000 for DDRIF#1
    -- 0x5000 for DDRIF#2
    -- 0xA000 for DDRIF#3  
    
    -- PCIe data to DDRRIF2 #1
    pcie_awren_1_s <= '1';
    pcie_ai_1_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 1, 32));
    pcie_ai_1_s(63 downto 32) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 2, 32));
    pcie_ai_1_s(95 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 3, 32));    
    pcie_ai_1_s(127 downto 96) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 4, 32));    
    pcie_ai_1_s(159 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 5, 32));
    pcie_ai_1_s(191 downto 160) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 6, 32));    
    pcie_ai_1_s(223 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 7, 32));
    pcie_ai_1_s(255 downto 224) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 8, 32));      
    pcie_ai_1_s(287 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 9, 32));
    pcie_ai_1_s(319 downto 288) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 10, 32));
    pcie_ai_1_s(351 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 11, 32));    
    pcie_ai_1_s(383 downto 352) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 12, 32));    
    pcie_ai_1_s(415 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 13, 32));
    pcie_ai_1_s(447 downto 416) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 14, 32));    
    pcie_ai_1_s(479 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 15, 32));
    pcie_ai_1_s(511 downto 480) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 16, 32));       
    pcie_aa_1_s <= (TO_UNSIGNED(i, 10));
    
       -- PCIe data to DDRRIF2 #2
    pcie_awren_2_s <= '1';
    pcie_ai_2_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 1, 32));
    pcie_ai_2_s(63 downto 32) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 2, 32));
    pcie_ai_2_s(95 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 3, 32));    
    pcie_ai_2_s(127 downto 96) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 4, 32));    
    pcie_ai_2_s(159 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 5, 32));
    pcie_ai_2_s(191 downto 160) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 6, 32));    
    pcie_ai_2_s(223 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 7, 32));
    pcie_ai_2_s(255 downto 224) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 8, 32));      
    pcie_ai_2_s(287 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 9, 32));
    pcie_ai_2_s(319 downto 288) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 10, 32));
    pcie_ai_2_s(351 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 11, 32));    
    pcie_ai_2_s(383 downto 352) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 12, 32));    
    pcie_ai_2_s(415 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 13, 32));
    pcie_ai_2_s(447 downto 416) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 14, 32));    
    pcie_ai_2_s(479 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 15, 32));
    pcie_ai_2_s(511 downto 480) <= STD_LOGIC_VECTOR(TO_UNSIGNED(20480 + (i*16) + 16, 32));       
    pcie_aa_2_s <= (TO_UNSIGNED(i, 10));
    
       -- PCIe data to DDRRIF2 #3
    pcie_awren_3_s <= '1';
    pcie_ai_3_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 1, 32));
    pcie_ai_3_s(63 downto 32) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 2, 32));
    pcie_ai_3_s(95 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 3, 32));    
    pcie_ai_3_s(127 downto 96) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 4, 32));    
    pcie_ai_3_s(159 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 5, 32));
    pcie_ai_3_s(191 downto 160) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 6, 32));    
    pcie_ai_3_s(223 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 7, 32));
    pcie_ai_3_s(255 downto 224) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 8, 32));      
    pcie_ai_3_s(287 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 9, 32));
    pcie_ai_3_s(319 downto 288) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 10, 32));
    pcie_ai_3_s(351 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 11, 32));    
    pcie_ai_3_s(383 downto 352) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 12, 32));    
    pcie_ai_3_s(415 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 13, 32));
    pcie_ai_3_s(447 downto 416) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 14, 32));    
    pcie_ai_3_s(479 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 15, 32));
    pcie_ai_3_s(511 downto 480) <= STD_LOGIC_VECTOR(TO_UNSIGNED(40960 + (i*16) + 16, 32));       
    pcie_aa_3_s <= (TO_UNSIGNED(i, 10));
    
    
    run(1);
  end loop;
  pcie_awren_1_s <= '0';
  pcie_awren_2_s <= '0';
  pcie_awren_3_s <= '0';  
  run(1); 
  
  
  
  -- Load the samples into the DDR Interface memory
  -- This is so that when we read from DDR we can check we are getting the correct data
  for i in 0 to 1023 loop 
    -- set each 64-bit word to it's word number with offset:- 
    -- 0x00000 for DDRIF#1
    -- 0x40000 for DDRIF#2
    -- 0x80000 for DDRIF#3     
    
    -- DDR #1
    awren_1_s <= '1';
    ai_1_s(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8, 64));
    ai_1_s(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 1, 64));
    ai_1_s(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 2, 64));
    ai_1_s(255 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 3, 64));
    ai_1_s(319 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 4, 64));
    ai_1_s(383 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 5, 64));
    ai_1_s(447 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 6, 64));
    ai_1_s(511 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 7, 64));
    aa_1_s <= (TO_UNSIGNED(i, 18));
    
    -- DDR #2
    awren_2_s <= '1';
    ai_2_s(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8), 64));
    ai_2_s(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 1, 64));
    ai_2_s(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 2, 64));
    ai_2_s(255 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 3, 64));
    ai_2_s(319 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 4, 64));
    ai_2_s(383 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 5, 64));
    ai_2_s(447 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 6, 64));
    ai_2_s(511 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(262144 + (i*8) + 7, 64));
    aa_2_s <= (TO_UNSIGNED(i, 18));    
    
    -- DDR #3
    awren_3_s <= '1';
    ai_3_s(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8), 64));
    ai_3_s(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 1, 64));
    ai_3_s(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 2, 64));
    ai_3_s(255 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 3, 64));
    ai_3_s(319 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 4, 64));
    ai_3_s(383 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 5, 64));
    ai_3_s(447 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 6, 64));
    ai_3_s(511 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(524288 + (i*8) + 7, 64));
    aa_3_s <= (TO_UNSIGNED(i, 18));        
    
    run(1);
  end loop;
  awren_1_s <= '0';
  awren_2_s <= '0';
  awren_3_s <= '0';
  run(1);
        

  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
  test_6_v := '1';
  test_7_v := '1';
  test_8_v := '1';
  test_9_v := '1';
  test_10_v := '1';
  test_11_v := '1';  
  test_12_v := '1';
  test_13_v := '1';
  test_14_v := '1';
  test_15_v := '1';
  test_16_v := '1';
  test_17_v := '1';
  test_18_v := '1';
  test_19_v := '1';
  test_20_v := '1';
  test_21_v := '1';    
  test_22_v := '1';   
  test_23_v := '1';   
  test_24_v := '1';   
  test_25_v := '1';       
  
----------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.DDRIF.DM.01: Simple Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with no wait_request                  ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.DDRIF.DM.01: Simple Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with no wait_request");
  
  -- Enable the request to write data from CONV to the DDR memory, with no wait request asserted (simple test)
  conv_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  write_wait_request_en_1_s <= '0';
  write_wait_request_en_2_s <= '0';  
  write_wait_request_en_3_s <= '0';  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0'; 
  run(1000);
  
end if;

 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.DDRIF.DM.02: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request                    ---
---         identical on all DDRIF2 modules                                                                                                      ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 2: TC.DDRIF.DM.02: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request identical on all channels");
  
  -- Enable the request to write data from CONV to the DDR memory, with dynamic wait request
  conv_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  write_wait_request_en_1_s <= '1';
  write_wait_request_en_2_s <= '1';  
  write_wait_request_en_3_s <= '1';  
  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0'; 
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.DDRIF.DM.03: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request                     ---
---         identical on all channels                                                                                                            ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.DDRIF.DM.03: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request identical on all channels ");
  
  -- Enable the request to read data from DDR memory by HSUM , with dynamic wait request
  hsum_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  hsum_check_en_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  read_wait_request_en_1_s <= '1';
  read_wait_request_en_2_s <= '1';
  read_wait_request_en_3_s <= '1'; 
  
  run(2000);
 
  
  hsum_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0';
  hsum_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.DDRIF.DM.04: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.DDRIF.DM.04: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #1, with dynamic wait request
  
  pcie_write_en_1_s <= '1';
  burst_num_1_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 5: TC.DDRIF.DM.05: Read Data from the DDR Memory #1 by the PCIe Interface with dynamic wait_request                                     ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_5_v = '1' then  
  puts("Test 5: TC.DDRIF.DM.05: Read Data from the DDR Memory #1 by the PCIe Interface with dynamic wait_request");
  
  -- Enable the request to read data from DDR memory by PCIe #1, with dynamic wait request
  pcie_read_en_1_s <= '1';
  burst_num_1_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_1_s <= '1';
  pcie_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  pcie_check_en_1_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 6: TC.DDRIF.DM.06: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_6_v = '1' then  
  puts("Test 6: TC.DDRIF.DM.06: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #1, with dynamic wait request
  
  pcie_write_en_1_s <= '1';
  burst_num_1_s <= "0011"; -- Burst of 4, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 7: TC.DDRIF.DM.07: Read Data from the DDR Memory # 1 by the PCIe Interface with dynamic wait_request - odd burst size                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_7_v = '1' then  
  puts("Test 7: TC.DDRIF.DM.07: Read Data from the DDR Memory #1 by the PCIe Interface with dynamic wait_request - odd burst size ");
  
  -- Enable the request to read data from DDR memory #1 by PCIe , with dynamic wait request
  pcie_read_en_1_s <= '1';
  burst_num_1_s <= "0100"; -- Burst of 5, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_1_s <= '1';
  pcie_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  pcie_check_en_1_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 8: TC.DDRIF.DM.08: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request-  burst size = 1                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_8_v = '1' then  
  puts("Test 8: TC.DDRIF.DM.08: Write Data to the DDR Memory #1 from the PCIe Interface with dynamic wait_request- burst size = 1     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #1, with dynamic wait request
  
  pcie_write_en_1_s <= '1';
  burst_num_1_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  run(1000);
  
end if;
 
 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 9: TC.DDRIF.DM.09: Read Data from the DDR Memory #1 by the PCIe Interface with dynamic wait_request - burst size = 1                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_9_v = '1' then  
  puts("Test 9: TC.DDRIF.DM.09: Read Data from the DDR Memory #1 by the PCIe Interface with dynamic wait_request - burst size = 1 ");
  
  -- Enable the request to read data from DDR memory #1 by PCIe , with dynamic wait request
  pcie_read_en_1_s <= '1';
  burst_num_1_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_1_s <= '1';
  pcie_check_en_1_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_1_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_1_s  <= '0';
  ddr_check_en_1_s <= '0';
  pcie_check_en_1_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 10: TC.DDRIF.DM.10: Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request                                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_10_v = '1' then  
  puts("Test 10: TC.DDRIF.DM.10: Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #2, with dynamic wait request
  
  pcie_write_en_2_s <= '1';
  burst_num_2_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 11: TC.DDRIF.DM.11: Read Data from the DDR Memory #2 by the PCIe Interface with dynamic wait_request                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_11_v = '1' then  
  puts("Test 11: TC.DDRIF.DM.11: Read Data from the DDR Memory #2 by the PCIe Interface with dynamic wait_request");
  
  -- Enable the request to read data from DDR memory by PCIe #2, with dynamic wait request
  pcie_read_en_2_s <= '1';
  burst_num_2_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_2_s <= '1';
  pcie_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  pcie_check_en_2_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 12: TC.DDRIF.DM.12: Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request                                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_12_v = '1' then  
  puts("Test 12: TC.DDRIF.DM.12 Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #2, with dynamic wait request
  
  pcie_write_en_2_s <= '1';
  burst_num_2_s <= "0011"; -- Burst of 4, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 13: TC.DDRIF.DM.13: Read Data from the DDR Memory # 2 by the PCIe Interface with dynamic wait_request - odd burst size                  ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_13_v = '1' then  
  puts("Test 13: TC.DDRIF.DM.13: Read Data from the DDR Memory #2 by the PCIe Interface with dynamic wait_request - odd burst size ");
  
  -- Enable the request to read data from DDR memory #2 by PCIe , with dynamic wait request
  pcie_read_en_2_s <= '1';
  burst_num_2_s <= "0100"; -- Burst of 5, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_2_s <= '1';
  pcie_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  pcie_check_en_2_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 14: TC.DDRIF.DM.14: Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request-  burst size = 1                  ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_14_v = '1' then  
  puts("Test 14: TC.DDRIF.DM.14: Write Data to the DDR Memory #2 from the PCIe Interface with dynamic wait_request- burst size = 1     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #2, with dynamic wait request
  
  pcie_write_en_2_s <= '1';
  burst_num_2_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  run(1000);
  
end if;
 
 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 15: TC.DDRIF.DM.15: Read Data from the DDR Memory #2 by the PCIe Interface with dynamic wait_request - burst size = 1                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_15_v = '1' then  
  puts("Test 15: TC.DDRIF.DM.15: Read Data from the DDR Memory #2 by the PCIe Interface with dynamic wait_request - burst size = 1 ");
  
  -- Enable the request to read data from DDR memory #2 by PCIe , with dynamic wait request
  pcie_read_en_2_s <= '1';
  burst_num_2_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_2_s <= '1';
  pcie_check_en_2_s <= '1';
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_2_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_2_s  <= '0';
  ddr_check_en_2_s <= '0';
  pcie_check_en_2_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 16: TC.DDRIF.DM.16: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request                                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_16_v = '1' then  
  puts("Test 16: TC.DDRIF.DM.16: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #3, with dynamic wait request
  
  pcie_write_en_3_s <= '1';
  burst_num_3_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 17: TC.DDRIF.DM.17: Read Data from the DDR Memory #3 by the PCIe Interface with dynamic wait_request                                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_17_v = '1' then  
  puts("Test 17: TC.DDRIF.DM.17: Read Data from the DDR Memory #3 by the PCIe Interface with dynamic wait_request");
  
  -- Enable the request to read data from DDR memory by PCIe #3, with dynamic wait request
  pcie_read_en_3_s <= '1';
  burst_num_3_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_3_s <= '1';
  pcie_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  pcie_check_en_3_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 18: TC.DDRIF.DM.18: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request                                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_18_v = '1' then  
  puts("Test 18: TC.DDRIF.DM.18: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #3, with dynamic wait request
  
  pcie_write_en_3_s <= '1';
  burst_num_3_s <= "0011"; -- Burst of 4, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 19: TC.DDRIF.DM.19: Read Data from the DDR Memory # 3 by the PCIe Interface with dynamic wait_request - odd burst size                  ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_19_v = '1' then  
  puts("Test 19: TC.DDRIF.DM.19: Read Data from the DDR Memory #3 by the PCIe Interface with dynamic wait_request - odd burst size ");
  
  -- Enable the request to read data from DDR memory #3 by PCIe , with dynamic wait request
  pcie_read_en_3_s <= '1';
  burst_num_3_s <= "0100"; -- Burst of 5, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_3_s <= '1';
  pcie_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  pcie_check_en_3_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 20: TC.DDRIF.DM.20: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request-  burst size = 1                  ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_20_v = '1' then  
  puts("Test 20: TC.DDRIF.DM.20: Write Data to the DDR Memory #3 from the PCIe Interface with dynamic wait_request- burst size = 1     ");
  
   -- Enable the request to write data from PCIe to the DDR memory #3, with dynamic wait request
  
  pcie_write_en_3_s <= '1';
  burst_num_3_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  run(1000);
  
end if;
 
 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 21: TC.DDRIF.DM.21: Read Data from the DDR Memory #3 by the PCIe Interface with dynamic wait_request - burst size = 1                   ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_21_v = '1' then  
  puts("Test 21: TC.DDRIF.DM.21: Read Data from the DDR Memory #3 by the PCIe Interface with dynamic wait_request - burst size = 1 ");
  
  -- Enable the request to read data from DDR memory #3 by PCIe , with dynamic wait request
  pcie_read_en_3_s <= '1';
  burst_num_3_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_3_s <= '1';
  pcie_check_en_3_s <= '1';
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_3_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_3_s  <= '0';
  ddr_check_en_3_s <= '0';
  pcie_check_en_3_s <= '0';
  run(1000);
  
end if;




---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 22: TC.DDRIF.DM.22: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request                   ---
---          on just DDRIF2 #3                                                                                                                   ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_22_v = '1' then  
  puts("Test 22: TC.DDRIF.DM.22: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request on one DDRIF2");
  
  -- Enable the request to write data from CONV to the DDR memory, with dynamic wait request
  conv_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  write_wait_request_en_1_s <= '0';
  write_wait_request_en_2_s <= '0';  
  write_wait_request_en_3_s <= '1';  
  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0'; 
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 23: TC.DDRIF.DM.23: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request                    ---
---         on just DDRIF2 #3                                                                                                                    ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_23_v = '1' then  
  puts("Test 23: TC.DDRIF.DM.23: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request on one DDRIF2");
  
  -- Enable the request to read data from DDR memory by HSUM , with dynamic wait request
  hsum_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  hsum_check_en_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  read_wait_request_en_1_s <= '0';
  read_wait_request_en_2_s <= '0';
  read_wait_request_en_3_s <= '1'; 
  
  run(2000);
 
  
  hsum_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0';
  hsum_check_en_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 24: TC.DDRIF.DM.22: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request                   ---
---          on DDRIF #2 and  DDRIF2 #3                                                                                                          ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_24_v = '1' then  
  puts("Test 24: TC.DDRIF.DM.24: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request on two DDRIF2s");
  
  -- Enable the request to write data from CONV to the DDR memory, with dynamic wait request
  conv_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  write_wait_request_en_1_s <= '0';
  write_wait_request_en_2_s <= '1';  
  write_wait_request_en_3_s <= '1';  
  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0'; 
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 25: TC.DDRIF.DM.25: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request                    ---
---         on DDRIF2 #2 and DDRIF2 #3                                                                                                           ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_25_v = '1' then  
  puts("Test 25: TC.DDRIF.DM.25: Read Data from the DDR Memory by the FDAS Processing Module (e.g HSUM) with dynamic wait_request on two DDRIF2s");
  
  -- Enable the request to read data from DDR memory by HSUM , with dynamic wait request
  hsum_en_s  <= '1';
  ddr_check_en_1_s <= '1';
  ddr_check_en_2_s <= '1';
  ddr_check_en_3_s <= '1';  
  hsum_check_en_s <= '1';
  wait_gap_1_s     <= TO_UNSIGNED(255, 16);
  wait_gap_2_s     <= TO_UNSIGNED(255, 16);  
  wait_gap_3_s     <= TO_UNSIGNED(255, 16);  
  read_wait_request_en_1_s <= '0';
  read_wait_request_en_2_s <= '1';
  read_wait_request_en_3_s <= '1'; 
  
  run(2000);
 
  
  hsum_en_s  <= '0';
  ddr_check_en_1_s <= '0';
  ddr_check_en_2_s <= '0';
  ddr_check_en_3_s <= '0';
  hsum_check_en_s <= '0';
  run(1000);
  
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




