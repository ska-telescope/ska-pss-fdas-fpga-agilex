----------------------------------------------------------------------------
-- Module Name:  DDRIF2 Test Bench
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
-- 0.5  RMD  08/09/2022   Updated DDRIF2 module capable of operating as
--                        three DDRIF2 modules acting in unison. This
--                        test bench tests a single DDRIF2 instance
-- 0.6  RMD  25/01/2023   Updated process pcie_ram to mimic the
--                        wait allowance of the PCIe Hard IP Macro.
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
  constant clk_pcie_per_c     : time := 2.85 ns; -- 350MHz clock (slightly higher than system clock to get phase slip in test bench)
  constant clk_ddr_per_c      : time := 3 ns; -- 333.3333MHz clock
  
  
  -- Signal declarations.
  
  -- Inter DDRIF2 Module signals
  signal fifo_ready_in_1_s        : std_logic;
  signal fifo_ready_in_2_s        : std_logic;
  signal fifo_full_in_1_s         : std_logic;
  signal fifo_full_in_2_s         : std_logic;  
  signal data_avail_in_1_s        : std_logic;
  signal data_avail_in_2_s        : std_logic;  
  signal fifo_ready_out_s         : std_logic; 
  signal fifo_full_out_s          : std_logic;  
  signal data_avail_out_s         : std_logic; 
  
  -- DDRIF2 Module PCIe Interface to write to DDR memory
  signal rd_dma_address_s                : std_logic_vector(31 downto 0);
  signal rd_dma_burst_count_s            : std_logic_vector(3 downto 0);
  signal rd_dma_byte_en_s                : std_logic_vector(63 downto 0);
  signal rd_dma_write_s                  : std_logic;
  signal rd_dma_write_data_s             : std_logic_vector(511 downto 0);
  signal rd_dma_wait_request_s           : std_logic;
        
  -- DDRIF2 Module FDAS Processing Interface to write to DDR memory     
  signal ddr_wr_addr_s                   : std_logic_vector(31 downto 0);
  signal ddr_wr_data_s                   : std_logic_vector(511 downto 0);
  signal ddr_wr_en_s                     : std_logic;     
  signal ddr_wr_wait_request_s           : std_logic;
  
  -- DDRIF2 Module PCIe Interface to read from DDR memory
  signal wr_dma_address_s                : std_logic_vector(31 downto 0);
  signal wr_dma_burst_count_s            : std_logic_vector(3 downto 0);
  signal wr_dma_read_s                   : std_logic;
  signal wr_dma_read_data_s              : std_logic_vector(511 downto 0);
  signal wr_dma_read_data_valid_s        : std_logic;
  signal wr_dma_wait_request_s           : std_logic;
  
  -- DDRIF2 Module FDAS Processing Interface to read from DDR memory 
  signal ddr_rd_addr_s                   : std_logic_vector(31 downto 0);
  signal ddr_rd_en_s                     : std_logic;
  signal ddr_rd_data_s                   : std_logic_vector(511 downto 0);
  signal ddr_rd_data_valid_s             : std_logic;
  signal ddr_rd_wait_request_s           : std_logic;
  
  -- DDRIF2 Module Interface to DDR Controller
  signal amm_wait_request_s              : std_logic;
  signal amm_read_data_s                 : std_logic_vector(511 downto 0);
  signal amm_read_data_valid_s           : std_logic; 
  signal amm_address_s                   : std_logic_vector(31 downto 0);
  signal amm_read_s                      : std_logic;
  signal amm_write_s                     : std_logic;
  signal amm_write_data_s                : std_logic_vector(511 downto 0);
  
  -- DDRIF2 Module Clocks and Reset 
  signal clk_sys_s                       : std_logic;
  signal clk_pcie_s                      : std_logic;
  signal clk_ddr_s                       : std_logic; 
  signal rst_sys_n_s                     : std_logic;
  signal rst_pcie_n_s                    : std_logic;     
  signal rst_ddr_n_s                     : std_logic; 
  
  -- DDRIF2 Module Static signals
  signal amm_burstcount_s                : std_logic_vector(6 downto 0);
  signal amm_byte_en_s                   : std_logic_vector(63 downto 0);  

  -- process: ddr_interface_ram
  subtype word_t is std_logic_vector(511 downto 0);
  type memory_t is array(2047 downto 0) of word_t;
  signal ram_s                           : memory_t;
  signal awren_s                         : std_logic;
  signal aa_s                            : unsigned(17 downto 0);
  signal ai_s                            : std_logic_vector(511 downto 0);
  signal bo_s                            : std_logic_vector(511 downto 0);
  signal bo_valid_s                      : std_logic;  
  signal ddr_read_ret_1_s                : std_logic;
  signal wait_request_toggle_s           : std_logic;
  signal wait_request_cnt_s              : unsigned(15 downto 0);  
  
  
  
  -- process: ddr_latency
  subtype fifo_word_t is std_logic_vector(512 downto 0);
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
    
  -- process: conv_ram
  signal conv_ram_s                      : memory_t;
  signal conv_awren_s                    : std_logic;
  signal conv_aa_s                       : unsigned(9 downto 0);
  signal conv_ai_s                       : std_logic_vector(511 downto 0);
  signal conv_en_rt_1_s                  : std_logic;
  signal conv_cnt_en_s                   : std_logic;
  signal conv_ba_addr_s                  : unsigned(9 downto 0);
  
  
  -- process: pcie_ram
  subtype pcie_word_t is std_logic_vector(511 downto 0);
  type pcie_memory_t is array(1023 downto 0) of pcie_word_t;  
  signal pcie_ram_s                      : pcie_memory_t;
  signal pcie_awren_s                    : std_logic;
  signal pcie_aa_s                       : unsigned(9 downto 0);
  signal pcie_ai_s                       : std_logic_vector(511 downto 0);
  signal pcie_write_en_rt_1_s            : std_logic;
  signal pcie_write_cnt_en_s             : std_logic;
  signal pcie_write_ba_addr_s            : unsigned(9 downto 0);  
  signal burst_write_addr_cnt_s          : unsigned(3 downto 0);  
  signal send_s                          : std_logic;
  signal rd_dma_wait_request_ret_s       : std_logic;
  signal wait_count_en_s                 : std_logic;
  signal wait_count_s                    : unsigned(5 downto 0); 

  
  -- process: cld_addr_gen
  signal cld_en_rt_1_s                   : std_logic;   
  signal cld_cnt_en_s                    : std_logic; 
  signal cld_cnt_s                       : unsigned(9 downto 0);

  
  -- process: pcie_addr_gen
  signal pcie_read_en_rt_1_s              : std_logic;   
  signal pcie_read_cnt_en_s               : std_logic; 
  signal pcie_read_cnt_s                  : unsigned(10 downto 0);
  signal burst_read_addr_cnt_s            : unsigned(4 downto 0);  
  
  
  -- process check_to_ddr 
  subtype ddr_word_t is std_logic_vector(31 downto 0);
  type ddr_data_t is array(15 downto 0) of ddr_word_t;
  signal ddr_check_en_rt_1_s             : std_logic;
  signal ddr_cnt_check_en_s              : std_logic;
  signal check_cnt_s                     : unsigned(9 downto 0);
  signal exp_ddr_addr_s                  : std_logic_vector(31 downto 0);
  signal exp_ddr_data_s                  : ddr_data_t;
  
  
  -- process check_to_cld 
  subtype long_word_bit_word_t is std_logic_vector(63 downto 0);
  type cld_data_t is array(7 downto 0) of long_word_bit_word_t;
  signal cld_check_en_rt_1_s             : std_logic;
  signal cld_cnt_check_en_s              : std_logic; 
  signal cld_check_cnt_s                 : unsigned(9 downto 0);
  signal exp_cld_data_s                  : cld_data_t;
  
  
  -- process check_to_pcie
  type pcie_data_t is array(7 downto 0) of long_word_bit_word_t;
  signal pcie_check_en_rt_1_s            : std_logic;
  signal pcie_cnt_check_en_s             : std_logic;
  signal pcie_check_cnt_s                : unsigned(9 downto 0);
  signal exp_pcie_data_s                 : pcie_data_t;    
  
  
  -- process: stimgen  
  signal write_wait_request_en_s         : std_logic;
  signal read_wait_request_en_s          : std_logic;
  signal conv_en_s                       : std_logic; 
  signal ddr_check_en_s                  : std_logic;
  signal wait_gap_s                      : unsigned(15 downto 0);
  signal cld_en_s                        : std_logic;
  signal cld_check_en_s                  : std_logic;
  signal burst_num_s                     : unsigned(3 downto 0);
  signal pcie_write_en_s                 : std_logic;
  signal pcie_read_en_s                  : std_logic;
  signal pcie_check_en_s                 : std_logic; 
  
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
    ddrif2_i : ddrif2
      port map (
        -- PCIe Interface to write data to SDRAM
        rd_dma_address          =>    rd_dma_address_s,
        rd_dma_burst_count      =>    rd_dma_burst_count_s,
        rd_dma_byte_en          =>    rd_dma_byte_en_s,
        rd_dma_write            =>    rd_dma_write_s,
        rd_dma_write_data       =>    rd_dma_write_data_s,     
        rd_dma_wait_request     =>    rd_dma_wait_request_s,
        
        -- PCIe Interface to read data from SDRAM
        wr_dma_address          =>    wr_dma_address_s,     
        wr_dma_burst_count      =>    wr_dma_burst_count_s,
        wr_dma_read             =>    wr_dma_read_s,         
        wr_dma_read_data        =>    wr_dma_read_data_s,
        wr_dma_read_data_valid  =>    wr_dma_read_data_valid_s,
        wr_dma_wait_request     =>    wr_dma_wait_request_s,       
       
        -- CONV Interface to write Data to SDRAM
        ddr_wr_addr           =>    ddr_wr_addr_s,      
        ddr_wr_data           =>    ddr_wr_data_s,      
        ddr_wr_en             =>    ddr_wr_en_s,   
        ddr_wr_wait_request   =>    ddr_wr_wait_request_s,
              
        -- CLD/HSUM Inteface to read data from SDRAM
        ddr_rd_addr           =>    ddr_rd_addr_s,
        ddr_rd_en             =>    ddr_rd_en_s,
        ddr_rd_data           =>    ddr_rd_data_s,
        ddr_rd_data_valid     =>    ddr_rd_data_valid_s,
        ddr_rd_wait_request   =>    ddr_rd_wait_request_s,
                
        -- SDRAM Interface    
        amm_address           =>    amm_address_s,    
        amm_burstcount        =>    amm_burstcount_s,      
        amm_byte_en           =>    amm_byte_en_s,       
        amm_read              =>    amm_read_s,
        amm_write             =>    amm_write_s, 
        amm_write_data        =>    amm_write_data_s,                
        amm_wait_request      =>    amm_wait_request_s,       
        amm_read_data         =>    amm_read_data_s,
        amm_read_data_valid   =>    amm_read_data_valid_s,
        

        -- Inter DDRIF2 alignment signals
        fifo_ready_in_1       =>    fifo_ready_in_1_s,
        fifo_ready_in_2       =>    fifo_ready_in_2_s,
        fifo_ready_out        =>    fifo_ready_out_s,         
        fifo_full_in_1        =>    fifo_full_in_1_s, 
        fifo_full_in_2        =>    fifo_full_in_2_s, 
        fifo_full_out         =>    fifo_full_out_s,  
        data_avail_in_1       =>    data_avail_in_1_s,
        data_avail_in_2       =>    data_avail_in_2_s,
        data_avail_out        =>    data_avail_out_s, 
        
        -- Clocks and resets
        clk_sys               =>    clk_sys_s,     
        clk_pcie              =>    clk_pcie_s,
        clk_ddr               =>    clk_ddr_s,
        rst_sys_n             =>    rst_sys_n_s,  
        rst_pcie_n            =>    rst_pcie_n_s,
        rst_ddr_n             =>    rst_ddr_n_s
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
-- FUNCTION: Generates clk_ddr. DDR clock
------------------------------------------------------------------------------
clkgen3 : process
begin
  while not test_finished loop
    clk_ddr_s <= '0', '1' after clk_ddr_per_c/2;
    wait for clk_ddr_per_c;
  end loop;
  wait;
end process clkgen3;


------------------------------------------------------------------------------
-- PROCESS : ddr_interface_ram
-- FUNCTION: Provides interface to store DDR samples for delivery
--           to FDAS functions (e.g. CLD) or the PCIe
--           Also generates the amm_wait_request (dynamically if desired)
------------------------------------------------------------------------------
ddr_interface_ram : process (clk_ddr_s)
      
begin
  if (rising_edge(clk_ddr_s)) then
    if (awren_s = '1') then
      ram_s(TO_INTEGER(aa_s)) <= ai_s;
    end if;
   
    -- default
    wait_request_cnt_s <= wait_request_cnt_s + 1;
    
    
    if (conv_en_rt_1_s = '0' and conv_en_s = '1') or (cld_en_rt_1_s = '0' and cld_en_s = '1') or
       (pcie_write_en_rt_1_s = '0' and pcie_write_en_s = '1') or (pcie_read_en_rt_1_s = '0' and pcie_read_en_s = '1') then
      wait_request_cnt_s <= (others => '0');
      amm_wait_request_s <= '0';
    end if;

    
    if conv_en_s  = '1' or pcie_write_en_s = '1' then
      if write_wait_request_en_s = '0' then
        amm_wait_request_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_s(0) = wait_gap_s(0)  or wait_request_cnt_s(0) /= wait_gap_s(0) then
        --if wait_request_cnt_s(7 downto 0) = wait_gap_s(7 downto 0) then
          amm_wait_request_s <= not(amm_wait_request_s);
        end if;
      end if;
    end if;
    
    
    
    if cld_en_s  = '1' or pcie_read_en_s = '1' then
      if read_wait_request_en_s = '0' then
        amm_wait_request_s <= '0';
      else
        -- make the wait request profile as desired
        if wait_request_cnt_s(0) = wait_gap_s(0)  or wait_request_cnt_s(0) /= wait_gap_s(0) then
        --if wait_request_cnt_s(7 downto 0) = wait_gap_s(7 downto 0) then
          amm_wait_request_s <= not(amm_wait_request_s);
        end if;
      end if;
    end if;   
 
    
    bo_s <= ram_s(TO_INTEGER(UNSIGNED(amm_address_s(31 downto 6))));
    if (amm_read_s = '1' and amm_wait_request_s = '0') then 
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
ddr_latency : process(clk_ddr_s, rst_ddr_n_s)
begin
  if rst_ddr_n_s = '0' then
    latency_fifo_s <= (others => (others => '0'));
    amm_read_data_valid_s <= '0';
    amm_read_data_s <= (others => '0');
    ddr_data_1_s <= (others => '0');
    ddr_data_2_s <= (others => '0');
    ddr_data_3_s <= (others => '0');
    ddr_data_4_s <= (others => '0');
    ddr_data_5_s <= (others => '0');
    ddr_data_6_s <= (others => '0');
    ddr_data_7_s <= (others => '0');
    ddr_data_8_s <= (others => '0');
  elsif rising_edge(clk_ddr_s) then
    latency_fifo_s <= latency_fifo_s(30 downto 0) & (bo_valid_s & bo_s);
    amm_read_data_valid_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (512);
    amm_read_data_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (511 downto 0);
    
    ddr_data_1_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (63 downto 0);
    ddr_data_2_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (127 downto 64);
    ddr_data_3_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (191 downto 128);
    ddr_data_4_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (255 downto 192);
    ddr_data_5_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (319 downto 256);
    ddr_data_6_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (383 downto 320);
    ddr_data_7_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (447 downto 384);
    ddr_data_8_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (511 downto 448);
    
  end if;
  
end process ddr_latency;


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
    ddr_wr_data_s <= (others => '0');  
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
      ddr_wr_data_s <= conv_ram_s(0);  
      ddr_wr_addr_s <= (others => '0');
      ddr_wr_en_s <= '1';
    end if;
     
    -- if wait_request is low and write is requested and not all data used increment the address
    if conv_cnt_en_s = '1' and ddr_wr_wait_request_s = '0' and conv_ba_addr_s < 1023 then
       ddr_wr_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(ddr_wr_addr_s) + 64);
       ddr_wr_data_s <= conv_ram_s(TO_INTEGER(conv_ba_addr_s) + 1);
       conv_ba_addr_s <= conv_ba_addr_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if conv_cnt_en_s = '1' and ddr_wr_wait_request_s = '0' and conv_ba_addr_s = 1023 then
      conv_cnt_en_s <= '0';
      ddr_wr_en_s <= '0';
    end if;
    
  end if;
end process conv_ram;



------------------------------------------------------------------------------
-- PROCESS : cld_addr_gen
-- FUNCTION: Generates the address mimicing the CLD module
------------------------------------------------------------------------------
cld_addr_gen : process (clk_sys_s, rst_sys_n_s)
      
begin
  if rst_sys_n_s = '0' then
    cld_en_rt_1_s <= '0';    
    cld_cnt_en_s <= '0';
    cld_cnt_s <= (others => '0');
    ddr_rd_addr_s <= (others => '0');  
    ddr_rd_en_s <= '0';  
                                        
  elsif (rising_edge(clk_sys_s)) then
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    cld_en_rt_1_s <= cld_en_s;
    
    
    -- start the request to write to DDR 
    if cld_en_rt_1_s = '0' and cld_en_s = '1' then
      cld_cnt_en_s <= '1';
      cld_cnt_s <= (others => '0');
      ddr_rd_addr_s <= (others => '0');
      ddr_rd_en_s <= '1';
    end if;
     
    -- if wait_request is low and write is requested and not all data used increment the address
    if cld_cnt_en_s = '1' and ddr_rd_wait_request_s = '0' and cld_cnt_s < 1023 then
       ddr_rd_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(ddr_rd_addr_s) + 64);
       cld_cnt_s <= cld_cnt_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if cld_cnt_en_s = '1' and ddr_rd_wait_request_s = '0' and cld_cnt_s = 1023 then
      cld_cnt_en_s <= '0';
      ddr_rd_en_s <= '0';
    end if;
    
  end if;
end process cld_addr_gen;



------------------------------------------------------------------------------
-- PROCESS : check_to_ddr
-- FUNCTION: Checks the address and data to DDR
------------------------------------------------------------------------------
check_to_ddr : process (clk_ddr_s, rst_ddr_n_s)
begin
  if rst_ddr_n_s = '0' then
    ddr_check_en_rt_1_s <= '0';
    ddr_cnt_check_en_s <= '0';  
    check_cnt_s <= (others => '0');
    exp_ddr_addr_s <= (others => '0');
    exp_ddr_data_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_ddr_s)) then
    
    ddr_check_en_rt_1_s <= ddr_check_en_s;
    
    -- start the checking
    if ddr_check_en_rt_1_s = '0' and ddr_check_en_s = '1' then
      ddr_cnt_check_en_s <= '1';
      check_cnt_s <= (others => '0');      
      exp_ddr_addr_s <= (others => '0');
      for i in 0 to 15 loop
        exp_ddr_data_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED((1 + i), 32)); 
      end loop;
    end if;
   
    if ddr_cnt_check_en_s = '1' then 
      if conv_en_s = '1' or pcie_write_en_s = '1' then
        if amm_write_s = '1' and amm_wait_request_s = '0' then
          -- check the values
          if amm_address_s /= exp_ddr_addr_s then   
            testbench_passed_v := false;
          end if; 
          for i in 0 to 15 loop
            if amm_write_data_s((32* i) + 31 downto (32*i)) /= exp_ddr_data_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if check_cnt_s < 1023 then
            exp_ddr_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_s) + 64);
            for i in 0 to 15 loop
              exp_ddr_data_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_data_s(i)) + 16);
            end loop;
            check_cnt_s <= check_cnt_s + 1;
          else
            ddr_cnt_check_en_s <= '0';
          end if;        
        end if;
      end if;
      if cld_en_s = '1' or pcie_read_en_s = '1' then
        if amm_read_s = '1' and amm_wait_request_s = '0' then
          -- check the values
          if amm_address_s /= exp_ddr_addr_s then   
            testbench_passed_v := false;
          end if;    
          -- increment the expected values
          if check_cnt_s < 1023 then
            exp_ddr_addr_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_ddr_addr_s) + 64);
            check_cnt_s <= check_cnt_s + 1;
          else
            ddr_cnt_check_en_s <= '0';
          end if;
        end if;
      end if;
    end if;
  end if;

   
 end process check_to_ddr;  
 
------------------------------------------------------------------------------
-- PROCESS : check_to_cld
-- FUNCTION: Checks the data to CLD
------------------------------------------------------------------------------
check_to_cld : process (clk_sys_s, rst_sys_n_s)
begin
  if rst_sys_n_s = '0' then
    cld_check_en_rt_1_s <= '0';
    cld_cnt_check_en_s <= '0';  
    cld_check_cnt_s <= (others => '0');
    exp_cld_data_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_sys_s)) then
    
    cld_check_en_rt_1_s <= cld_check_en_s;
    
    -- start the checking
    if cld_check_en_rt_1_s = '0' and cld_check_en_s = '1' then
      cld_cnt_check_en_s <= '1';
      cld_check_cnt_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_cld_data_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED((i), 64)); 
      end loop;
    end if;
   
    if cld_cnt_check_en_s = '1' then 
      if cld_en_s = '1' then
        if ddr_rd_data_valid_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if ddr_rd_data_s((64* i) + 63 downto (64*i)) /= exp_cld_data_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if cld_check_cnt_s < 1023 then
            for i in 0 to 7 loop
              exp_cld_data_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_cld_data_s(i)) + 8);
            end loop;
            cld_check_cnt_s <= cld_check_cnt_s + 1;
          else
            cld_cnt_check_en_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_cld;  
 

------------------------------------------------------------------------------
-- PROCESS : pcie_ram
-- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
------------------------------------------------------------------------------
pcie_ram : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_write_en_rt_1_s <= '0';    
    pcie_write_cnt_en_s <= '0';
    pcie_write_ba_addr_s <= (others => '0');
    burst_write_addr_cnt_s <= (others => '0');
    rd_dma_write_data_s <= (others => '0');  
    rd_dma_address_s <= (others => '0');
    rd_dma_write_s <= '0';
    rd_dma_byte_en_s <= (others => '1');  
    rd_dma_burst_count_s <= (others => '0'); 
    send_s <= '0';
    rd_dma_wait_request_ret_s <= '0';
    wait_count_en_s <= '0';
    wait_count_s <= (others => '0'); 
  elsif (rising_edge(clk_pcie_s)) then
    if (pcie_awren_s = '1') then
      pcie_ram_s(TO_INTEGER(pcie_aa_s)) <= pcie_ai_s;
    end if;
    
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_write_en_rt_1_s <= pcie_write_en_s;
    
    rd_dma_wait_request_ret_s <= rd_dma_wait_request_s;
    
    -- Default
    rd_dma_write_s <= '0';
    wait_count_s  <= (others => '0');
    
    -- start the request to write to DDR 
    if pcie_write_en_rt_1_s = '0' and pcie_write_en_s = '1' then
      pcie_write_cnt_en_s <= '1';
      pcie_write_ba_addr_s <= (others => '0');
      burst_write_addr_cnt_s <= (others => '0');     
      rd_dma_write_data_s <= pcie_ram_s(0);  
      rd_dma_address_s(31 downto 0) <= (others => '0');
      rd_dma_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
      rd_dma_byte_en_s <= (others => '0');
      rd_dma_write_s <= '1'; 
    end if;
     
      
    if rd_dma_wait_request_s = '0' then
      send_s <= '1';
    else
      if rd_dma_wait_request_ret_s = '0' and rd_dma_wait_request_s = '1' then
        wait_count_en_s <= '1';
      end if;
    end if;
      
    if wait_count_en_s = '1' then 
      wait_count_s <= wait_count_s + 1;
      if wait_count_s = 16 then
        send_s <= '0';
        wait_count_en_s <= '0';       
      end if;
    end if;
    
    
    -- if triggered to send data from PCIe and send_s = 1  and not all data used increment the address
    if pcie_write_cnt_en_s = '1' and send_s = '1' and pcie_write_ba_addr_s < 1023 then   
      rd_dma_write_s <= '1';
      pcie_write_ba_addr_s <= pcie_write_ba_addr_s + 1;
      burst_write_addr_cnt_s <= burst_write_addr_cnt_s + 1;       
      if burst_write_addr_cnt_s = burst_num_s then
        burst_write_addr_cnt_s <= (others => '0');
        rd_dma_address_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 32));
      end if;
      rd_dma_write_data_s <= pcie_ram_s(TO_INTEGER(pcie_write_ba_addr_s) + 1);      
            
    end if;
      
    
    -- if the pcie_write_ba_addr_s = 1023 allow the burst to complete
    if pcie_write_ba_addr_s = 1023 then
      if burst_write_addr_cnt_s < burst_num_s then
        burst_write_addr_cnt_s <= burst_write_addr_cnt_s + 1;
      end if;
    end if;
        
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_write_cnt_en_s = '1' and send_s = '1' and pcie_write_ba_addr_s = 1023 and burst_write_addr_cnt_s = burst_num_s then
      pcie_write_cnt_en_s <= '0';
      rd_dma_write_s <= '0';
      send_s <= '0';
    end if;
    
  end if;
end process pcie_ram;


------------------------------------------------------------------------------
-- PROCESS : pcie_addr_gen
-- FUNCTION: Generates the address mimicing the PCIe Interface
------------------------------------------------------------------------------
pcie_addr_gen : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_read_en_rt_1_s <= '0';    
    pcie_read_cnt_en_s <= '0';
    pcie_read_cnt_s <= (others => '0');
    burst_read_addr_cnt_s <= (others => '0');
    wr_dma_address_s <= (others => '0');  
    wr_dma_burst_count_s <= (others => '0');  
    wr_dma_read_s <= '0';  
                                        
  elsif (rising_edge(clk_pcie_s)) then
   
    -- when enabled from the main stimgen process the ram asserts the write request
    -- and sets the address to requested location
    -- it then responds to the wait_request from DDRIF, incrementing the read address
    -- on each cycle that wait_request is low
    pcie_read_en_rt_1_s <= pcie_read_en_s;
    
    
    -- start the request to read from DDR 
    if pcie_read_en_rt_1_s = '0' and pcie_read_en_s = '1' then
      pcie_read_cnt_en_s <= '1';
      pcie_read_cnt_s <= (others => '0');
      burst_read_addr_cnt_s <= (others => '0'); 
      wr_dma_address_s <= (others => '0');    
      wr_dma_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
      wr_dma_read_s <= '1'; 
    end if;
     
    -- if wait_request is low and read is requested and not all data used increment the address
    if pcie_read_cnt_en_s = '1' and wr_dma_wait_request_s = '0' and pcie_read_cnt_s < 100 then
      pcie_read_cnt_s <= pcie_read_cnt_s + 1;
      wr_dma_address_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 32));
    end if;
       
   
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_read_cnt_en_s = '1' and wr_dma_wait_request_s = '0' and pcie_read_cnt_s = 100 then
      pcie_read_cnt_en_s <= '0';
      wr_dma_read_s <= '0';
    end if;
    
  end if;
end process pcie_addr_gen;


------------------------------------------------------------------------------
-- PROCESS : check_to_pcie
-- FUNCTION: Checks the data to the PCie Interface
------------------------------------------------------------------------------
check_to_pcie : process (clk_pcie_s, rst_pcie_n_s)

begin

  if rst_pcie_n_s = '0' then
    pcie_check_en_rt_1_s <= '0';
    pcie_cnt_check_en_s <= '0';  
    pcie_check_cnt_s <= (others => '0');
    exp_pcie_data_s <= (others => (others => '0'));
    
                                        
  elsif (rising_edge(clk_pcie_s)) then
    
    pcie_check_en_rt_1_s <= pcie_check_en_s;
    
    -- start the checking
    if pcie_check_en_rt_1_s = '0' and pcie_check_en_s = '1' then
      pcie_cnt_check_en_s <= '1';
      pcie_check_cnt_s <= (others => '0');      
      for i in 0 to 7 loop
        exp_pcie_data_s(i) <= STD_LOGIC_VECTOR(TO_UNSIGNED((i), 64)); 
      end loop;
    end if;
   
    if pcie_cnt_check_en_s = '1' then 
      if pcie_read_en_s = '1' then
        if wr_dma_read_data_valid_s  = '1' then
          -- check the values
          for i in 0 to 7 loop
            if wr_dma_read_data_s((64* i) + 63 downto (64*i)) /= exp_pcie_data_s(i) then   
              testbench_passed_v := false;
            end if; 
          end loop;
          -- increment the expected values
          if pcie_check_cnt_s < 1023 then
            for i in 0 to 7 loop
              exp_pcie_data_s(i) <= STD_LOGIC_VECTOR(UNSIGNED(exp_pcie_data_s(i)) + 8);
            end loop;
            pcie_check_cnt_s <= pcie_check_cnt_s + 1;
          else
            pcie_cnt_check_en_s <= '0';
          end if;        
        end if;
      end if;  
    end if;
  end if;

   
 end process check_to_pcie;  
 
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
  -- Inter DDRIF2 Module signals
  fifo_ready_in_1_s       <= '1';
  fifo_ready_in_2_s       <= '1';                
  fifo_full_in_1_s        <= '0'; 
  fifo_full_in_2_s        <= '0'; 
  data_avail_in_1_s       <= '1';
  data_avail_in_2_s       <= '1';
 
 
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
  write_wait_request_en_s       <= '0';  
  read_wait_request_en_s        <= '0';  
  rst_sys_n_s 	                <= '0'; 
  rst_pcie_n_s 	                <= '0';
  rst_ddr_n_s 	                <= '0';
  run(2);
  rst_sys_n_s 	                <= '1'; 
  rst_pcie_n_s 	                <= '1';
  rst_ddr_n_s 	                <= '1';
  awren_s                       <= '0';
  ddr_latency_s                 <= "01000";
  conv_awren_s                  <= '0';
  conv_en_s                     <= '0';
  ddr_check_en_s                <= '0';
  wait_gap_s                    <= (others => '0');
  cld_en_s                      <= '0';
  cld_check_en_s                <= '0';
  burst_num_s                   <= (others => '0');
  pcie_write_en_s               <= '0';
  pcie_read_en_s                <= '0';
  pcie_check_en_s               <= '0';
  
   -- Load the samples into the CONV  memory
  -- This is so that we can write data from the CONV module to the DDR memory
  for i in 0 to 1023 loop 
    -- set each 32-bit sample value to it's sample number
    conv_awren_s <= '1';
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
    conv_aa_s <= (TO_UNSIGNED(i, 10));
    run(1);
  end loop;
  conv_awren_s <= '0';
  run(1); 
  


   -- Load the samples into the PCIe  memory to mimic the PCIe interface
  -- This is so that we can write data from the CONV module to the DDR memory
  for i in 0 to 1023 loop 
    -- set each 32-bit sample value to it's sample number
    pcie_awren_s <= '1';
    pcie_ai_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 1, 32));
    pcie_ai_s(63 downto 32) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 2, 32));
    pcie_ai_s(95 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 3, 32));    
    pcie_ai_s(127 downto 96) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 4, 32));    
    pcie_ai_s(159 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 5, 32));
    pcie_ai_s(191 downto 160) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 6, 32));    
    pcie_ai_s(223 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 7, 32));
    pcie_ai_s(255 downto 224) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 8, 32));      
    pcie_ai_s(287 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 9, 32));
    pcie_ai_s(319 downto 288) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 10, 32));
    pcie_ai_s(351 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 11, 32));    
    pcie_ai_s(383 downto 352) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 12, 32));    
    pcie_ai_s(415 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 13, 32));
    pcie_ai_s(447 downto 416) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 14, 32));    
    pcie_ai_s(479 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 15, 32));
    pcie_ai_s(511 downto 480) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*16 + 16, 32));       
    pcie_aa_s <= (TO_UNSIGNED(i, 10));
    run(1);
  end loop;
  pcie_awren_s <= '0';
  run(1); 
  
  
  
  -- Load the samples into the DDR Interface memory
  -- This is so that when we read from DDR we can check we are getting the correct data
  for i in 0 to 1023 loop 
    -- set each 64-bit sample value to it's sample number
    awren_s <= '1';
    ai_s(63 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8, 64));
    ai_s(127 downto 64) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 1, 64));
    ai_s(191 downto 128) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 2, 64));
    ai_s(255 downto 192) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 3, 64));
    ai_s(319 downto 256) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 4, 64));
    ai_s(383 downto 320) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 5, 64));
    ai_s(447 downto 384) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 6, 64));
    ai_s(511 downto 448) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i*8 + 7, 64));
    aa_s <= (TO_UNSIGNED(i, 18));
    run(1);
  end loop;
  awren_s <= '0';
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
  ddr_check_en_s <= '1';
  write_wait_request_en_s <= '0';
  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_s <= '0';
  run(1000);
  
end if;

 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.DDRIF.DM.02: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request                    ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 2: TC.DDRIF.DM.02: Write Data to the DDR Memory from the FDAS Processing Module (e.g CONV) with dynamic wait_request");
  
  -- Enable the request to write data from CONV to the DDR memory, with dynamic wait request
  conv_en_s  <= '1';
  ddr_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  write_wait_request_en_s <= '1';
  
  run(2000);
 
  
  conv_en_s  <= '0';
  ddr_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.DDRIF.DM.03: Read Data from the DDR Memory by the FDAS Processing Module (e.g CLD) with dynamic wait_request                      ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.DDRIF.DM.03: Read Data from the DDR Memory by the FDAS Processing Module (e.g CLD) with dynamic wait_request ");
  
  -- Enable the request to read data from DDR memory by CLD , with dynamic wait request
  cld_en_s  <= '1';
  ddr_check_en_s <= '1';
  cld_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  cld_en_s  <= '0';
  ddr_check_en_s <= '0';
  cld_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.DDRIF.DM.04: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request                                       ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.DDRIF.DM.04: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request     ");
  
   -- Enable the request to write data from PCIe to the DDR memory, with dynamic wait request
  
  pcie_write_en_s <= '1';
  burst_num_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_s  <= '0';
  ddr_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 5: TC.DDRIF.DM.05: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request                                        ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_5_v = '1' then  
  puts("Test 5: TC.DDRIF.DM.05: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request");
  
  -- Enable the request to read data from DDR memory by PCIe , with dynamic wait request
  pcie_read_en_s <= '1';
  burst_num_s <= "0111"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
  ddr_check_en_s <= '1';
  pcie_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_s  <= '0';
  ddr_check_en_s <= '0';
  pcie_check_en_s <= '0';
  run(1000);
  
end if;
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 6: TC.DDRIF.DM.06: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request                                       ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_6_v = '1' then  
  puts("Test 6: TC.DDRIF.DM.06: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request    ");
  
   -- Enable the request to write data from PCIe to the DDR memory, with dynamic wait request
  
  pcie_write_en_s <= '1';
  burst_num_s <= "0011"; -- Burst of 4, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_s  <= '0';
  ddr_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 7: TC.DDRIF.DM.07: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request - odd burst size                       ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_7_v = '1' then  
  puts("Test 7: TC.DDRIF.DM.07: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request - odd burst size ");
  
  -- Enable the request to read data from DDR memory by PCIe , with dynamic wait request
  pcie_read_en_s <= '1';
  burst_num_s <= "0100"; -- Burst of 5, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_s <= '1';
  pcie_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_s  <= '0';
  ddr_check_en_s <= '0';
  pcie_check_en_s <= '0';
  run(1000);
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 8: TC.DDRIF.DM.08: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request-  burst size = 1                      ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_8_v = '1' then  
  puts("Test 8: TC.DDRIF.DM.08: Write Data to the DDR Memory from the PCIe Interface with dynamic wait_request- burst size = 1     ");
  
   -- Enable the request to write data from PCIe to the DDR memory, with dynamic wait request
  
  pcie_write_en_s <= '1';
  burst_num_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_write_en_s  <= '0';
  ddr_check_en_s <= '0';
  run(1000);
  
end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 9: TC.DDRIF.DM.09: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request - burst size = 1                        ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_9_v = '1' then  
  puts("Test 9: TC.DDRIF.DM.09: Read Data from the DDR Memory by the PCIe Interface with dynamic wait_request - burst size = 1 ");
  
  -- Enable the request to read data from DDR memory by PCIe , with dynamic wait request
  pcie_read_en_s <= '1';
  burst_num_s <= "0000"; -- Burst of 1, (this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0).
  ddr_check_en_s <= '1';
  pcie_check_en_s <= '1';
  wait_gap_s     <= TO_UNSIGNED(255, 16);
  read_wait_request_en_s <= '1';
  
  run(2000);
 
  
  pcie_read_en_s  <= '0';
  ddr_check_en_s <= '0';
  pcie_check_en_s <= '0';
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




