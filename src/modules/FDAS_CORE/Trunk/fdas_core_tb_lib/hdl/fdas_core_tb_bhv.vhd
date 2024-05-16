----------------------------------------------------------------------------
-- Module Name:  FDAS_CORE_TB
--
-- Source Path:  fdas_core_tb_bhv.vhd
--
-- Description:  FDAS_CORE Testbench
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     18/08/2022  Initial revision.
----------------------------------------------------------------------------
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
-- VHDL Version: VHDL 2008
----------------------------------------------------------------------------

architecture bhv of fdas_core_tb is
  -- Constant Definition
  -- Define clock period.
  constant clk_sys_per_c   	  : time := 5 ns; -- 200MHz clock
  constant clk_mc_per_c   	  : time := 5 ns; -- 200MHz clock
  constant clk_pcie_per_c     : time := 4 ns; -- 250MHz clock
  constant clk_pll_ref_per_c  : time := 8 ns; -- 250MHz/2 clock
  
  constant burst_count_c      : std_logic_vector(6 downto 0) := "0000001";
  constant byte_enable_c      : std_logic_vector(71 downto 0) := "000000001111111111111111111111111111111111111111111111111111111111111111";
  
  constant ddr_c             : integer := 1;  -- 1 to 3
  constant fft_c             : integer := 1024;
  constant fft_abits_c       : integer := 10;
  constant ifft_c            : integer := 7;
  constant ifft_loop_c       : integer := 6;
  constant ifft_loop_bits_c  : integer := 3;
  constant fop_num_bits_c    : integer := 23;
  constant fop_num_c         : integer := 4832;
  constant summer_c          : integer := 1;
  constant harmonic_c        : integer := 12;
  constant product_id_c      : integer := 0;
  constant version_number_c  : integer := 0;
  constant revision_number_c : integer := 0;
  
  constant output_len_c      : integer := 4832;
   -- Internal signal declarations
   
  -- Module Clocks and Reset 
  signal clk_sys_s        : std_logic := '0';
  signal rst_sys_n_s      : std_logic;
  signal clk_mc_s         : std_logic := '0';
  signal rst_mc_n_s       : std_logic;
  signal clk_pcie_s       : std_logic := '0';
  signal rst_pcie_n_s     : std_logic;
  signal clk_ddr0_s       : std_logic := '0'; 
  signal rst_ddr0_n_s     : std_logic; 
  signal clk_ddr1_s       : std_logic := '0'; 
  signal rst_ddr1_n_s     : std_logic; 
  signal clk_pll_ref_s    : std_logic := '0'; 
  signal rst_pll_ref_n_s  : std_logic;
  signal rst_ddr0_gbl_n_s : std_logic;
  signal rst_ddr1_gbl_n_s : std_logic;
  signal rst_ddr0_req_s   : std_logic;
  signal rst_ddr1_req_s   : std_logic;
  signal rst_ddr0_done_s  : std_logic;
  signal rst_ddr1_done_s  : std_logic;

  signal top_version_s     : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(version_number_c,16));
  signal top_revision_s    : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(revision_number_c,16));
  signal user_msix_ready_s : std_logic;
  signal user_msix_valid_s : std_logic;
  signal user_msix_data_s  : std_logic_vector(15 downto 0);
  
  ----------------------------------------------------------------------------------------------------------------
  -----  PCIF Signals
  ----------------------------------------------------------------------------------------------------------------
  signal rxm_wait_request_s      : std_logic;
  signal rxm_address_s           : std_logic_vector(21 downto 0);
  signal rxm_write_data_s        : std_logic_vector(31 downto 0);
  signal rxm_byte_enable_s       : std_logic_vector(3 downto 0);
  signal rxm_read_s              : std_logic;
  signal rxm_write_s             : std_logic;
  signal rxm_read_data_s         : std_logic_vector(31 downto 0);
  signal rxm_read_data_valid_s   : std_logic;

  ----------------------------------------------------------------------------------------------------------------
  -----  DDRIF Signals
  ----------------------------------------------------------------------------------------------------------------
  
  -- DDRIF0 Module PCIe Interface to write to DDR memory
  signal rd_dma0_address_s                : std_logic_vector(63 downto 0);
  signal rd_dma0_burst_count_s            : std_logic_vector(3 downto 0);
  signal rd_dma0_byte_en_s                : std_logic_vector(63 downto 0);
  signal rd_dma0_write_s                  : std_logic;
  signal rd_dma0_write_data_s             : std_logic_vector(511 downto 0);
  signal rd_dma0_wait_request_s           : std_logic;
        
  -- DDRIF0 Module PCIe Interface to read from DDR memory
  signal wr_dma0_address_s                : std_logic_vector(63 downto 0);
  signal wr_dma0_burst_count_s            : std_logic_vector(3 downto 0);
  signal wr_dma0_read_s                   : std_logic;
  signal wr_dma0_read_data_s              : std_logic_vector(511 downto 0);
  signal wr_dma0_read_data_valid_s        : std_logic;
  signal wr_dma0_wait_request_s           : std_logic;
  
  -- DDRIF0 Module Interface to DDR Controller
  signal amm0_wait_request_s              : std_logic;
  signal amm0_read_data_s                 : std_logic_vector(575 downto 0);
  signal amm0_read_data_valid_s           : std_logic; 
  signal amm0_address_s                   : std_logic_vector(31 downto 0);
  signal amm0_read_s                      : std_logic;
  signal amm0_write_s                     : std_logic;
  signal amm0_write_data_s                : std_logic_vector(511 downto 0);
  signal amm0_burstcount_s                : std_logic_vector(6 downto 0);
  signal amm0_byte_en_s                   : std_logic_vector(71 downto 0);
  
  -- DDRIF1 Module PCIe Interface to write to DDR memory
  signal rd_dma1_address_s                : std_logic_vector(63 downto 0);
  signal rd_dma1_burst_count_s            : std_logic_vector(3 downto 0);
  signal rd_dma1_byte_en_s                : std_logic_vector(63 downto 0);
  signal rd_dma1_write_s                  : std_logic;
  signal rd_dma1_write_data_s             : std_logic_vector(511 downto 0);
  signal rd_dma1_wait_request_s           : std_logic;
        
  -- DDRIF1 Module PCIe Interface to read from DDR memory
  signal wr_dma1_address_s                : std_logic_vector(63 downto 0);
  signal wr_dma1_burst_count_s            : std_logic_vector(3 downto 0);
  signal wr_dma1_read_s                   : std_logic;
  signal wr_dma1_read_data_s              : std_logic_vector(511 downto 0);
  signal wr_dma1_read_data_valid_s        : std_logic;
  signal wr_dma1_wait_request_s           : std_logic;
  
  -- DDRIF1 Module Interface to DDR Controller
  signal amm1_wait_request_s              : std_logic;
  signal amm1_read_data_s                 : std_logic_vector(575 downto 0);
  signal amm1_read_data_valid_s           : std_logic; 
  signal amm1_address_s                   : std_logic_vector(31 downto 0);
  signal amm1_read_s                      : std_logic;
  signal amm1_write_s                     : std_logic;
  signal amm1_write_data_s                : std_logic_vector(511 downto 0);
  signal amm1_burstcount_s                : std_logic_vector(6 downto 0);
  signal amm1_byte_en_s                   : std_logic_vector(71 downto 0);
  
  ----------------------------------------------------------------------------------------------------------------
  -----  DDR_CONTROLLER Signals
  ----------------------------------------------------------------------------------------------------------------    
  signal amm0_ready_s                     : std_logic;
  signal local0_cal_success_s             : std_logic;              
  signal local0_cal_fail_s                : std_logic;
  signal amm0_write_data_576_s            : std_logic_vector(575 downto 0);
  
  signal amm1_ready_s                     : std_logic;
  signal local1_cal_success_s             : std_logic;              
  signal local1_cal_fail_s                : std_logic;
  signal amm1_write_data_576_s            : std_logic_vector(575 downto 0);
  
  signal calbus_read_0_s                  : std_logic;                       -- DDR#0 emif_calbus_0.calbus_read,          Calibration bus read
  signal calbus_write_0_s                 : std_logic;                       -- DDR#0 .calbus_write,         Calibration bus write
  signal calbus_address_0_s               : std_logic_vector(19 downto 0);   -- DDR#0 .calbus_address,       Calibration bus address
  signal calbus_wdata_0_s                 : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_wdata,         Calibration bus write data
  signal calbus_rdata_0_s                 : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_rdata,         Calibration bus read data
  signal calbus_seq_param_tbl_0_s         : std_logic_vector(4095 downto 0); -- DDR#0 .calbus_seq_param_tbl, Calibration bus param table data
  signal calbus_clk_0_s                   : std_logic;                      -- DDR#0 emif_calbus_clk.clk,                  Calibration bus clock
  signal amm_address_0_s                  : std_logic_vector(26 downto 0);
  
--  signal calbus_read_1_s                  : std_logic;                       -- DDR#0 emif_calbus_0.calbus_read,          Calibration bus read
--  signal calbus_write_1_s                 : std_logic;                       -- DDR#0 .calbus_write,         Calibration bus write
--  signal calbus_address_1_s               : std_logic_vector(19 downto 0);   -- DDR#0 .calbus_address,       Calibration bus address
--  signal calbus_wdata_1_s                 : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_wdata,         Calibration bus write data
  signal calbus_rdata_1_s                 : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_rdata,         Calibration bus read data
  signal calbus_seq_param_tbl_1_s         : std_logic_vector(4095 downto 0); -- DDR#0 .calbus_seq_param_tbl, Calibration bus param table data
--  signal calbus_clk_1_s                   : std_logic;                      -- DDR#0 emif_calbus_clk.clk,                  Calibration bus clock
  signal amm_address_1_s                  : std_logic_vector(26 downto 0);
  
  
  ----------------------------------------------------------------------------------------------------------------
  -----  DDR SDRAM Model Signals
  ----------------------------------------------------------------------------------------------------------------  
  signal mem0_ck_s                        : std_logic_vector(0 downto 0); -- mem.mem_ck
  signal mem0_ck_n_s                      : std_logic_vector(0 downto 0); --    .mem_ck_n
  signal mem0_a_s                         : std_logic_vector(16 downto 0); --    .mem_a
  signal mem0_act_n_s                     : std_logic_vector(0 downto 0); --    .mem_act_n
  signal mem0_ba_s                        : std_logic_vector(1 downto 0); --    .mem_ba
  signal mem0_bg_s                        : std_logic_vector(1 downto 0); --    .mem_bg
  signal mem0_cke_s                       : std_logic_vector(0 downto 0); --    .mem_cke
  signal mem0_cs_n_s                      : std_logic_vector(0 downto 0); --    .mem_cs_n
  signal mem0_odt_s                       : std_logic_vector(0 downto 0); --    .mem_odt
  signal mem0_reset_n_s                   : std_logic_vector(0 downto 0); --    .mem_reset_n
  signal mem0_par_s                       : std_logic_vector(0 downto 0); --    .mem_par
  signal mem0_alert_n_s                   : std_logic_vector(0 downto 0); --    .mem_alert_n
  signal mem0_dqs_s                       : std_logic_vector(8 downto 0); --    .mem_dqs
  signal mem0_dqs_n_s                     : std_logic_vector(8 downto 0); --    .mem_dqs_n
  signal mem0_dq_s                        : std_logic_vector(71 downto 0); --    .mem_dq
  signal mem0_dbi_n_s                     : std_logic_vector(8 downto 0);   --    .mem_dbi_n 
  
  signal mem1_ck_s                        : std_logic_vector(0 downto 0); -- mem.mem_ck
  signal mem1_ck_n_s                      : std_logic_vector(0 downto 0); --    .mem_ck_n
  signal mem1_a_s                         : std_logic_vector(16 downto 0); --    .mem_a
  signal mem1_act_n_s                     : std_logic_vector(0 downto 0); --    .mem_act_n
  signal mem1_ba_s                        : std_logic_vector(1 downto 0); --    .mem_ba
  signal mem1_bg_s                        : std_logic_vector(1 downto 0); --    .mem_bg
  signal mem1_cke_s                       : std_logic_vector(0 downto 0); --    .mem_cke
  signal mem1_cs_n_s                      : std_logic_vector(0 downto 0); --    .mem_cs_n
  signal mem1_odt_s                       : std_logic_vector(0 downto 0); --    .mem_odt
  signal mem1_reset_n_s                   : std_logic_vector(0 downto 0); --    .mem_reset_n
  signal mem1_par_s                       : std_logic_vector(0 downto 0); --    .mem_par
  signal mem1_alert_n_s                   : std_logic_vector(0 downto 0); --    .mem_alert_n
  signal mem1_dqs_s                       : std_logic_vector(8 downto 0); --    .mem_dqs
  signal mem1_dqs_n_s                     : std_logic_vector(8 downto 0); --    .mem_dqs_n
  signal mem1_dq_s                        : std_logic_vector(71 downto 0); --    .mem_dq
  signal mem1_dbi_n_s                     : std_logic_vector(8 downto 0);   --    .mem_dbi_n 
  
  ----------------------------------------------------------------------------------------------------------------
  -----  Test Bench Ancillary Process Signals
  ----------------------------------------------------------------------------------------------------------------    
  -- process: pcie0_ram
  subtype pcie_word_t is std_logic_vector(511 downto 0);
  type pcie_memory_t is array(2047 downto 0) of pcie_word_t;  
  signal pcie0_ram_s                      : pcie_memory_t;
  signal pcie0_awren_s                    : std_logic;
  signal pcie0_aa_s                       : unsigned(10 downto 0);
  signal pcie0_ai_s                       : std_logic_vector(511 downto 0);
  signal pcie0_write_en_rt_1_s            : std_logic;
  signal pcie0_write_cnt_en_s             : std_logic;
  signal pcie0_write_ba_addr_s            : unsigned(10 downto 0);  
  signal burst0_write_addr_cnt_s          : unsigned(4 downto 0);  
  -- process: pcie0_addr_gen
  signal pcie0_read_en_rt_1_s              : std_logic;   
  signal pcie0_read_cnt_en_s               : std_logic; 
  signal pcie0_read_cnt_s                  : unsigned(10 downto 0);
  signal burst0_read_addr_cnt_s            : unsigned(4 downto 0);  
  -- process check_to_pcie0
  subtype long_word_bit_word_t is std_logic_vector(31 downto 0);
  type pcie_data_t is array(7 downto 0) of long_word_bit_word_t;
  signal pcie0_check_en_rt_1_s            : std_logic;
  signal pcie0_cnt_check_en_s             : std_logic;
  signal pcie0_check_cnt_s                : unsigned(10 downto 0);
  signal exp_pcie0_data_s                 : pcie_data_t;    
  
  -- process: pcie1_ram
  signal pcie1_ram_s                      : pcie_memory_t;
  signal pcie1_awren_s                    : std_logic;
  signal pcie1_aa_s                       : unsigned(10 downto 0);
  signal pcie1_ai_s                       : std_logic_vector(511 downto 0);
  signal pcie1_write_en_rt_1_s            : std_logic;
  signal pcie1_write_cnt_en_s             : std_logic;
  signal pcie1_write_ba_addr_s            : unsigned(10 downto 0);  
  signal burst1_write_addr_cnt_s          : unsigned(4 downto 0);  
  -- process: pcie1_addr_gen
  signal pcie1_read_en_rt_1_s              : std_logic;   
  signal pcie1_read_cnt_en_s               : std_logic; 
  signal pcie1_read_cnt_s                  : unsigned(10 downto 0);
  signal burst1_read_addr_cnt_s            : unsigned(4 downto 0);  
  -- process check_to_pcie1
  signal pcie1_check_en_rt_1_s            : std_logic;
  signal pcie1_cnt_check_en_s             : std_logic;
  signal pcie1_check_cnt_s                : unsigned(10 downto 0);
  signal exp_pcie1_data_s                 : pcie_data_t;    
  
  -- display signals
  signal mcrddata_re_real_s  : real := 0.0;
  signal mcrddata_im_real_s  : real := 0.0;
  
  signal convrdata_s      : real := 0.0;
  signal convidata_s      : real := 0.0;

  signal rtemplate_real_s : real := 0.0;
  signal itemplate_real_s : real := 0.0;
  
  -- comparison signals
  signal output1_float_s     : float32;
  signal output2_float_s     : float32;

  signal operr1_float_s      : float32;
  signal operr2_float_s      : float32;
  
  signal operr1_max_float_s  : float32;
  signal operr2_max_float_s  : float32;
  
  signal maxerr1_float_s     : float32;
  signal maxerr2_float_s     : float32;
  
  signal operr1_maxseg_float_s  : float32;
  signal operr2_maxseg_float_s  : float32;
  
  signal maxerrseg1_float_s  : float32;
  signal maxerrseg2_float_s  : float32;

  signal ref1_float_s        : float32;
  signal ref2_float_s        : float32;

  signal referr1_float_s     : float32;
  signal referr2_float_s     : float32;
  
  signal referr1_max_float_s : float32;
  signal referr2_max_float_s : float32;
  
  signal maxreferr1_float_s  : float32;
  signal maxreferr2_float_s  : float32;
  
  -- filter under test
  signal testfilter_s     : integer range 0 to 42;
  -- DDR lsb address
  signal seladdrout_s     : integer range 0 to 7;
  -- DDR word position
  signal selwordout_s     : integer range 0 to 31;
  -- DDR selected data
  signal seldataout_s     : std_logic_vector(31 downto 0);
  signal selconjdataout_s : std_logic_vector(31 downto 0);
  signal seldataout_real_s : real;
  signal selconjdataout_real_s : real;
  signal seldataout_float_s : float32;
  signal selconjdataout_float_s : float32;
  signal convpowerout_s   : float32;
  signal convpowerlog2_s  : signed(8 downto 0);
  signal max_s            : float32;
  signal maxnum_s         : unsigned(12 downto 0);
  signal result_s         : float32;
  signal resultnum_s      : unsigned(12 downto 0);
  signal opcnt_s          : unsigned(12 downto 0);

  -- testbench signals
  signal input_test_vec_s : cmplx_array_t(0 to 4831);
  signal output1_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output2_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output_ref_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal template_s       : cmplx_array_t(0 to 1023);
  signal datacnt_s        : unsigned(12 downto 0);
  signal smplcnt_s        : unsigned(9 downto 0);
  signal overlapcnt_s     : unsigned(9 downto 0);
  signal conv_done_cnt_s  : unsigned(3 downto 0);

  -- process: main  
  signal cld_check_en_s                  : std_logic;
  signal burst_num_s                     : unsigned(4 downto 0);
  signal pcie0_write_en_s                 : std_logic;
  signal pcie0_read_en_s                  : std_logic;
  signal pcie0_check_en_s                 : std_logic; 
  signal pcie1_write_en_s                 : std_logic;
  signal pcie1_read_en_s                  : std_logic;
  signal pcie1_check_en_s                 : std_logic; 

  -- general
  signal testfail_s                      : boolean := false;
  signal test_finished                   : boolean := false;
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;

  -- results
  file results : text;

  -- filter generation
  file filter : text;
  
  impure function loadfile (initfilename : in string; size : integer) return cmplx_array_t is
    file initfile : text;
    variable fileline_v : line;
    variable ram : cmplx_array_t(0 to size-1);
  begin
    file_open(initfile, initfilename, READ_MODE);
    for i in 0 to size-1 loop
      readline(initfile, fileline_v);
      hread(fileline_v, ram(i).RE);
      hread(fileline_v, ram(i).IM);
    end loop;
    return ram;
  end function;
  
begin
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
  -- FUNCTION: Generates clk_pll_ref. DDR clock
  ------------------------------------------------------------------------------
  clkgen3 : process
  begin
    while not test_finished loop
      clk_pll_ref_s <= '0', '1' after clk_pll_ref_per_c/2;
      wait for clk_pll_ref_per_c;
    end loop;
    wait;
  end process clkgen3;

  ------------------------------------------------------------------------------
  -- PROCESS : clkgen4
  -- FUNCTION: Generates clk_mc. Micro clock
  ------------------------------------------------------------------------------
  clkgen4 : process
  begin
    while not test_finished loop
      clk_mc_s <= '0', '1' after clk_mc_per_c/2;
      wait for clk_mc_per_c;
    end loop;
    wait;
  end process clkgen4;

--  rst_sys_n_s <= '0', '1' after clk_sys_per_c;
--  rst_pcie_n_s <= '0', '1' after clk_pcie_per_c;
--  rst_pll_ref_n_s <= '0', '1' after clk_pll_ref_per_c;
  rst_mc_n_s <= '0', '1' after clk_mc_per_c;

  ------------------------------------------------------------------------------
  -- PROCESS : pcie0_ram
  -- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
  ------------------------------------------------------------------------------
  pcie0_ram : process (clk_pcie_s, rst_pcie_n_s)
        
  begin
    if rst_pcie_n_s = '0' then
      pcie0_write_en_rt_1_s <= '0';    
      pcie0_write_cnt_en_s <= '0';
      pcie0_write_ba_addr_s <= (others => '0');
      burst0_write_addr_cnt_s <= (others => '0');
      rd_dma0_write_data_s <= (others => '0');  
      rd_dma0_address_s <= (others => '0');
      rd_dma0_write_s <= '0';
      rd_dma0_byte_en_s <= (others => '1');  
      rd_dma0_burst_count_s <= (others => '0'); 
      input_test_vec_s <= LoadFile("input_data.txt",fop_num_c);
      for i in 0 to 603 loop
        for j in 0 to 7 loop
          pcie0_ram_s(i)((j+1)*64-1 downto j*64) <= input_test_vec_s(i*8+j).IM & input_test_vec_s(i*8+j).RE;
        end loop;
      end loop;
    elsif (rising_edge(clk_pcie_s)) then
      if (pcie0_awren_s = '1') then
        pcie0_ram_s(TO_INTEGER(pcie0_aa_s)) <= pcie0_ai_s;
      end if;
      
      -- when enabled from the main stimgen process the ram asserts the write request
      -- and sets the address to requested location
      -- it then responds to the ddr_rd_waitreq from DDRIF, incrementing the read address
      -- on each cycle that ddr_rd_waitreq is low
      pcie0_write_en_rt_1_s <= pcie0_write_en_s;
      
      
      -- start the request to write to DDR 
      if pcie0_write_en_rt_1_s = '0' and pcie0_write_en_s = '1' then
        pcie0_write_cnt_en_s <= '1';
        pcie0_write_ba_addr_s <= (others => '0');
        burst0_write_addr_cnt_s <= (others => '0');     
        rd_dma0_write_data_s <= pcie0_ram_s(0);  
        rd_dma0_address_s(31 downto 0) <= (others => '0');
        rd_dma0_address_s(63 downto 32) <= (others => '0');
        rd_dma0_write_s <= '1';
        rd_dma0_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
        rd_dma0_byte_en_s <= (others => '0');
      end if;
       
      -- if ddr_rd_waitreq is low and write is requested and not all data used increment the address
      if pcie0_write_cnt_en_s = '1' and rd_dma0_wait_request_s = '0' and pcie0_write_ba_addr_s < 2047 then
        pcie0_write_ba_addr_s <= pcie0_write_ba_addr_s + 1;
        burst0_write_addr_cnt_s <= burst0_write_addr_cnt_s + 1;       
        if burst0_write_addr_cnt_s = burst_num_s then
          burst0_write_addr_cnt_s <= (others => '0');
          rd_dma0_address_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma0_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 64));
        end if;
        rd_dma0_write_data_s <= pcie0_ram_s(TO_INTEGER(pcie0_write_ba_addr_s) + 1);
         
      end if;
      
      -- at the end of the transfer deassert the write req when DDRIF has sampled the data
      if pcie0_write_cnt_en_s = '1' and rd_dma0_wait_request_s = '0' and pcie0_write_ba_addr_s = 2047 then
        pcie0_write_cnt_en_s <= '0';
        rd_dma0_write_s <= '0';
      end if;
      
    end if;
  end process pcie0_ram;


  ------------------------------------------------------------------------------
  -- PROCESS : pcie0_addr_gen
  -- FUNCTION: Generates the address mimicing the PCIe Interface
  ------------------------------------------------------------------------------
  pcie0_addr_gen : process (clk_pcie_s, rst_pcie_n_s)
        
  begin
    if rst_pcie_n_s = '0' then
      pcie0_read_en_rt_1_s <= '0';    
      pcie0_read_cnt_en_s <= '0';
      pcie0_read_cnt_s <= (others => '0');
      burst0_read_addr_cnt_s <= (others => '0');
      wr_dma0_address_s <= (others => '0');  
      wr_dma0_burst_count_s <= (others => '0');  
      wr_dma0_read_s <= '0';  
                                          
    elsif (rising_edge(clk_pcie_s)) then
     
      -- when enabled from the main stimgen process the ram asserts the write request
      -- and sets the address to requested location
      -- it then responds to the wait_request from DDRIF, incrementing the read address
      -- on each cycle that wait_request is low
      pcie0_read_en_rt_1_s <= pcie0_read_en_s;
      
      
      -- start the request to read from DDR 
      if pcie0_read_en_rt_1_s = '0' and pcie0_read_en_s = '1' then
        pcie0_read_cnt_en_s <= '1';
        pcie0_read_cnt_s <= (others => '0'); 
        burst0_read_addr_cnt_s <= (others => '0'); 
        wr_dma0_address_s(31 downto 0) <= (others => '0');
        wr_dma0_address_s(63 downto 32) <= (others => '0');      
        wr_dma0_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
        wr_dma0_read_s <= '1'; 
      end if;
       
      -- if wait_request is low and read is requested and not all data used increment the address
      if pcie0_read_cnt_en_s = '1' and wr_dma0_wait_request_s = '0' and pcie0_read_cnt_s < 100 then
        pcie0_read_cnt_s <= pcie0_read_cnt_s + 1;
        wr_dma0_address_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma0_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 64));
      end if;
         
     
      -- at the end of the transfer deassert the write req when DDRIF has sampled the data
      if pcie0_read_cnt_en_s = '1' and wr_dma0_wait_request_s = '0' and pcie0_read_cnt_s = 100 then
        pcie0_read_cnt_en_s <= '0';
        wr_dma0_read_s <= '0';
      end if;
      
    end if;
  end process pcie0_addr_gen;
     
  ------------------------------------------------------------------------------
  -- PROCESS : pcie1_ram
  -- FUNCTION: Provides RAM to mimic the data and address delivery from PCIe
  ------------------------------------------------------------------------------
  pcie1_ram : process (clk_pcie_s, rst_pcie_n_s)
        
  begin
    if rst_pcie_n_s = '0' then
      pcie1_write_en_rt_1_s <= '0';    
      pcie1_write_cnt_en_s <= '0';
      pcie1_write_ba_addr_s <= (others => '0');
      burst1_write_addr_cnt_s <= (others => '0');
      rd_dma1_write_data_s <= (others => '0');  
      rd_dma1_address_s <= (others => '0');
      rd_dma1_write_s <= '0';
      rd_dma1_byte_en_s <= (others => '1');  
      rd_dma1_burst_count_s <= (others => '0'); 
      input_test_vec_s <= LoadFile("input_data.txt",fop_num_c);
      for i in 0 to 603 loop
        for j in 0 to 7 loop
          pcie1_ram_s(i)((j+1)*64-1 downto j*64) <= input_test_vec_s(i*8+j).RE & input_test_vec_s(i*8+j).IM;
        end loop;
      end loop;
    elsif (rising_edge(clk_pcie_s)) then
      if (pcie1_awren_s = '1') then
        pcie1_ram_s(TO_INTEGER(pcie1_aa_s)) <= pcie1_ai_s;
      end if;
      
      -- when enabled from the main stimgen process the ram asserts the write request
      -- and sets the address to requested location
      -- it then responds to the ddr_rd_waitreq from DDRIF, incrementing the read address
      -- on each cycle that ddr_rd_waitreq is low
      pcie1_write_en_rt_1_s <= pcie1_write_en_s;
      
      
      -- start the request to write to DDR 
      if pcie1_write_en_rt_1_s = '0' and pcie1_write_en_s = '1' then
        pcie1_write_cnt_en_s <= '1';
        pcie1_write_ba_addr_s <= (others => '0');
        burst1_write_addr_cnt_s <= (others => '0');     
        rd_dma1_write_data_s <= pcie1_ram_s(0);  
        rd_dma1_address_s(31 downto 0) <= (others => '0');
        rd_dma1_address_s(63 downto 32) <= (others => '0');
        rd_dma1_write_s <= '1';
        rd_dma1_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
        rd_dma1_byte_en_s <= (others => '0');
      end if;
       
      -- if ddr_rd_waitreq is low and write is requested and not all data used increment the address
      if pcie1_write_cnt_en_s = '1' and rd_dma1_wait_request_s = '0' and pcie1_write_ba_addr_s < 2047 then
        pcie1_write_ba_addr_s <= pcie1_write_ba_addr_s + 1;
        burst1_write_addr_cnt_s <= burst1_write_addr_cnt_s + 1;       
        if burst1_write_addr_cnt_s = burst_num_s then
          burst1_write_addr_cnt_s <= (others => '0');
          rd_dma1_address_s <= STD_LOGIC_VECTOR(UNSIGNED(rd_dma1_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 64));
        end if;
        rd_dma1_write_data_s <= pcie1_ram_s(TO_INTEGER(pcie1_write_ba_addr_s) + 1);
         
      end if;
      
      -- at the end of the transfer deassert the write req when DDRIF has sampled the data
      if pcie1_write_cnt_en_s = '1' and rd_dma1_wait_request_s = '0' and pcie1_write_ba_addr_s = 2047 then
        pcie1_write_cnt_en_s <= '0';
        rd_dma1_write_s <= '0';
      end if;
      
    end if;
  end process pcie1_ram;


  ------------------------------------------------------------------------------
  -- PROCESS : pcie1_addr_gen
  -- FUNCTION: Generates the address mimicing the PCIe Interface
  ------------------------------------------------------------------------------
  pcie1_addr_gen : process (clk_pcie_s, rst_pcie_n_s)
        
  begin
    if rst_pcie_n_s = '0' then
      pcie1_read_en_rt_1_s <= '0';    
      pcie1_read_cnt_en_s <= '0';
      pcie1_read_cnt_s <= (others => '0');
      burst1_read_addr_cnt_s <= (others => '0');
      wr_dma1_address_s <= (others => '0');  
      wr_dma1_burst_count_s <= (others => '0');  
      wr_dma1_read_s <= '0';  
                                          
    elsif (rising_edge(clk_pcie_s)) then
     
      -- when enabled from the main stimgen process the ram asserts the write request
      -- and sets the address to requested location
      -- it then responds to the wait_request from DDRIF, incrementing the read address
      -- on each cycle that wait_request is low
      pcie1_read_en_rt_1_s <= pcie1_read_en_s;
      
      
      -- start the request to read from DDR 
      if pcie1_read_en_rt_1_s = '0' and pcie1_read_en_s = '1' then
        pcie1_read_cnt_en_s <= '1';
        pcie1_read_cnt_s <= (others => '0'); 
        burst1_read_addr_cnt_s <= (others => '0'); 
        wr_dma1_address_s(31 downto 0) <= (others => '0');
        wr_dma1_address_s(63 downto 32) <= (others => '0');      
        wr_dma1_burst_count_s <= STD_LOGIC_VECTOR(TO_UNSIGNED((TO_INTEGER(burst_num_s) +1),4));
        wr_dma1_read_s <= '1'; 
      end if;
       
      -- if wait_request is low and read is requested and not all data used increment the address
      if pcie1_read_cnt_en_s = '1' and wr_dma1_wait_request_s = '0' and pcie1_read_cnt_s < 100 then
        pcie1_read_cnt_s <= pcie1_read_cnt_s + 1;
        wr_dma1_address_s <= STD_LOGIC_VECTOR(UNSIGNED(wr_dma1_address_s) + TO_UNSIGNED(64*(TO_INTEGER(burst_num_s) +1), 64));
      end if;
         
     
      -- at the end of the transfer deassert the write req when DDRIF has sampled the data
      if pcie1_read_cnt_en_s = '1' and wr_dma1_wait_request_s = '0' and pcie1_read_cnt_s = 100 then
        pcie1_read_cnt_en_s <= '0';
        wr_dma1_read_s <= '0';
      end if;
      
    end if;
  end process pcie1_addr_gen;

  DDR_CONTROLLER_i0 : entity fdas_ddr_controller.fdas_ddr_controller
  port map (
    local_reset_req       => rst_ddr0_req_s,
    local_reset_done      => rst_ddr0_done_s,
    pll_ref_clk           => 'X',          
    oct_rzqin             => clk_pll_ref_s,
    mem_ck                => mem0_ck_s,     
    mem_ck_n              => mem0_ck_n_s,   
    mem_a                 => mem0_a_s,     
    mem_act_n             => mem0_act_n_s,  
    mem_ba                => mem0_ba_s,     
    mem_bg                => mem0_bg_s,     
    mem_cke               => mem0_cke_s,    
    mem_cs_n              => mem0_cs_n_s,   
    mem_odt               => mem0_odt_s,    
    mem_reset_n           => mem0_reset_n_s,
    mem_par               => mem0_par_s,    
    mem_alert_n           => mem0_alert_n_s,
    mem_dqs               => mem0_dqs_s,    
    mem_dqs_n             => mem0_dqs_n_s,  
    mem_dq                => mem0_dq_s,     
    mem_dbi_n             => mem0_dbi_n_s,  
    local_cal_success     => local0_cal_success_s,
    local_cal_fail        => local0_cal_fail_s,    
    emif_usr_reset_n      => rst_ddr0_n_s,  
    emif_usr_clk          => clk_ddr0_s,
    amm_ready_0           => amm0_ready_s,         
    amm_read_0            => amm0_read_s,                
    amm_write_0           => amm0_write_s,               
    amm_address_0         => amm_address_0_s,
    amm_readdata_0        => amm0_read_data_s,     
    amm_writedata_0       => amm0_write_data_576_s,     
    amm_burstcount_0      => amm0_burstcount_s,        
    amm_byteenable_0      => amm0_byte_en_s,       
    amm_readdatavalid_0   => amm0_read_data_valid_s,
    calbus_read           => calbus_read_0_s,         
    calbus_write          => calbus_write_0_s,        
    calbus_address        => calbus_address_0_s,      
    calbus_wdata          => calbus_wdata_0_s,        
    calbus_rdata          => calbus_rdata_0_s,        
    calbus_seq_param_tbl  => calbus_seq_param_tbl_0_s,
    calbus_clk            => calbus_clk_0_s             
  );
  amm_address_0_s <= '0' & amm0_address_s(31 downto 6);
  
  DDR_CONTROLLER_i1 : entity fdas_ddr_controller.fdas_ddr_controller
  port map (
    local_reset_req       => rst_ddr1_req_s,
    local_reset_done      => rst_ddr1_done_s,
    pll_ref_clk           => 'X',          
    oct_rzqin             => clk_pll_ref_s,
    mem_ck                => mem1_ck_s,     
    mem_ck_n              => mem1_ck_n_s,   
    mem_a                 => mem1_a_s,     
    mem_act_n             => mem1_act_n_s,  
    mem_ba                => mem1_ba_s,     
    mem_bg                => mem1_bg_s,     
    mem_cke               => mem1_cke_s,    
    mem_cs_n              => mem1_cs_n_s,   
    mem_odt               => mem1_odt_s,    
    mem_reset_n           => mem1_reset_n_s,
    mem_par               => mem1_par_s,    
    mem_alert_n           => mem1_alert_n_s,
    mem_dqs               => mem1_dqs_s,    
    mem_dqs_n             => mem1_dqs_n_s,  
    mem_dq                => mem1_dq_s,     
    mem_dbi_n             => mem1_dbi_n_s,  
    local_cal_success     => local1_cal_success_s,
    local_cal_fail        => local1_cal_fail_s,    
    emif_usr_reset_n      => rst_ddr1_n_s,  
    emif_usr_clk          => clk_ddr1_s,
    amm_ready_0           => amm1_ready_s,         
    amm_read_0            => amm1_read_s,                
    amm_write_0           => amm1_write_s,               
    amm_address_0         => amm_address_1_s,
    amm_readdata_0        => amm1_read_data_s,     
    amm_writedata_0       => amm1_write_data_576_s,     
    amm_burstcount_0      => amm1_burstcount_s,        
    amm_byteenable_0      => amm1_byte_en_s,       
    amm_readdatavalid_0   => amm1_read_data_valid_s,
    calbus_read           => calbus_read_0_s,         
    calbus_write          => calbus_write_0_s,        
    calbus_address        => calbus_address_0_s,      
    calbus_wdata          => calbus_wdata_0_s,        
    calbus_rdata          => calbus_rdata_1_s,        
    calbus_seq_param_tbl  => calbus_seq_param_tbl_1_s,
    calbus_clk            => calbus_clk_0_s             
  );
  amm_address_1_s <= '0' & amm1_address_s(31 downto 6);
  
   emif_cal_i0 : entity fdas_emif_calibration.fdas_emif_calibration
   port map (
     calbus_read_0          => calbus_read_0_s,          -- emif_calbus_0.calbus_read,          Calibration bus read
     calbus_write_0         => calbus_write_0_s,         -- .calbus_write,         Calibration bus write
     calbus_address_0       => calbus_address_0_s,       -- .calbus_address,       Calibration bus address
     calbus_wdata_0         => calbus_wdata_0_s,         -- .calbus_wdata,         Calibration bus write data
     calbus_rdata_0         => calbus_rdata_0_s,         -- .calbus_rdata,         Calibration bus read data
     calbus_seq_param_tbl_0 => calbus_seq_param_tbl_0_s, -- .calbus_seq_param_tbl, Calibration bus param table data
     calbus_clk             => calbus_clk_0_s              -- emif_calbus_clk.clk,                  Calibration bus clock
   );      
  
--   emif_cal_i1 : entity fdas_emif_calibration.fdas_emif_calibration
--   port map (
--     calbus_read_0          => calbus_read_1_s,          -- emif_calbus_0.calbus_read,          Calibration bus read
--     calbus_write_0         => calbus_write_1_s,         -- .calbus_write,         Calibration bus write
--     calbus_address_0       => calbus_address_1_s,       -- .calbus_address,       Calibration bus address
--     calbus_wdata_0         => calbus_wdata_1_s,         -- .calbus_wdata,         Calibration bus write data
--     calbus_rdata_0         => calbus_rdata_1_s,         -- .calbus_rdata,         Calibration bus read data
--     calbus_seq_param_tbl_0 => calbus_seq_param_tbl_1_s, -- .calbus_seq_param_tbl, Calibration bus param table data
--     calbus_clk             => calbus_clk_1_s              -- emif_calbus_clk.clk,                  Calibration bus clock
--   );      
  
  
--  DDR_CONTROLLER_i0 : entity fdas_top_lib.fdas_ddr_controller_calibration
--  port map (
--    amm_ready_o         =>       amm0_ready_s,         
--    amm_read_i          =>       amm0_read_s,                      
--    amm_write_i         =>       amm0_write_s,                     
--    amm_address_i       =>       amm0_address_s(31 downto 6),      
--    amm_readdata_o      =>       amm0_read_data_s,     
--    amm_writedata_i     =>       amm0_write_data_576_s,     
--    amm_burstcount_i    =>       amm0_burstcount_s,        
--    amm_byteenable_i    =>       amm0_byte_en_s,       
--    emif_usr_clk_o      =>       clk_ddr0_s,                         
--    emif_user_reset_n_o =>       rst_ddr0_n_s,                          
--    local_reset_req_i   =>       rst_ddr0_req_s,
--    local_reset_done_o  =>       rst_ddr0_done_s,
--    mem_ck_o            =>       mem0_ck_s,       
--    mem_ck_n_o          =>       mem0_ck_n_s,       
--    mem_a_o             =>       mem0_a_s,     
--    mem_act_n_o         =>       mem0_act_n_s,       
--    mem_ba_o            =>       mem0_ba_s,       
--    mem_bg_o            =>       mem0_bg_s,       
--    mem_cke_o           =>       mem0_cke_s,      
--    mem_cs_n_o          =>       mem0_cs_n_s,       
--    mem_odt_o           =>       mem0_odt_s,      
--    mem_reset_n_o       =>       mem0_reset_n_s,       
--    mem_par_o           =>       mem0_par_s,       
--    mem_alert_n_i       =>       mem0_alert_n_s,       
--    mem_dqs_io          =>       mem0_dqs_s,       
--    mem_dqs_n_io        =>       mem0_dqs_n_s,       
--    mem_dq_io           =>       mem0_dq_s,       
--    mem_dbi_n_io        =>       mem0_dbi_n_s,        
--    oct_rzqin_i         =>       'X',                         
--    pll_ref_clk_i       =>       clk_pll_ref_s,                        
--    local_cal_success_o =>       local0_cal_success_s,                        
--    local_cal_fail_o    =>       local0_cal_fail_s                          
--  );
--           
--  DDR_CONTROLLER_i1 : entity fdas_top_lib.fdas_ddr_controller_calibration
--  port map (
--    amm_ready_o         =>       amm1_ready_s,         
--    amm_read_i          =>       amm1_read_s,                      
--    amm_write_i         =>       amm1_write_s,                     
--    amm_address_i       =>       amm1_address_s(31 downto 6),      
--    amm_readdata_o      =>       amm1_read_data_s,     
--    amm_writedata_i     =>       amm1_write_data_576_s,     
--    amm_burstcount_i    =>       amm1_burstcount_s,        
--    amm_byteenable_i    =>       amm1_byte_en_s,       
--    emif_usr_clk_o      =>       clk_ddr1_s,                         
--    emif_user_reset_n_o =>       rst_ddr1_n_s,                          
--    local_reset_req_i   =>       rst_ddr1_req_s,
--    local_reset_done_o  =>       rst_ddr1_done_s,
--    mem_ck_o            =>       mem1_ck_s,       
--    mem_ck_n_o          =>       mem1_ck_n_s,       
--    mem_a_o             =>       mem1_a_s,     
--    mem_act_n_o         =>       mem1_act_n_s,       
--    mem_ba_o            =>       mem1_ba_s,       
--    mem_bg_o            =>       mem1_bg_s,       
--    mem_cke_o           =>       mem1_cke_s,      
--    mem_cs_n_o          =>       mem1_cs_n_s,       
--    mem_odt_o           =>       mem1_odt_s,      
--    mem_reset_n_o       =>       mem1_reset_n_s,       
--    mem_par_o           =>       mem1_par_s,       
--    mem_alert_n_i       =>       mem1_alert_n_s,       
--    mem_dqs_io          =>       mem1_dqs_s,       
--    mem_dqs_n_io        =>       mem1_dqs_n_s,       
--    mem_dq_io           =>       mem1_dq_s,       
--    mem_dbi_n_io        =>       mem1_dbi_n_s,        
--    oct_rzqin_i         =>       'X',                         
--    pll_ref_clk_i       =>       clk_pll_ref_s,                        
--    local_cal_success_o =>       local1_cal_success_s,                        
--    local_cal_fail_o    =>       local1_cal_fail_s                          
--  );
          
  ed_sim_mem_i0 : entity ed_sim_mem.ed_sim_mem
  port map(
    mem_ck      =>    mem0_ck_s,         
    mem_ck_n    =>    mem0_ck_n_s,       
    mem_a       =>    mem0_a_s,          
    mem_act_n   =>    mem0_act_n_s,      
    mem_ba      =>    mem0_ba_s,         
    mem_bg      =>    mem0_bg_s,         
    mem_cke     =>    mem0_cke_s,        
    mem_cs_n    =>    mem0_cs_n_s,       
    mem_odt     =>    mem0_odt_s,        
    mem_reset_n =>    mem0_reset_n_s,    
    mem_par     =>    mem0_par_s,        
    mem_alert_n =>    mem0_alert_n_s,    
    mem_dqs     =>    mem0_dqs_s,        
    mem_dqs_n   =>    mem0_dqs_n_s,      
    mem_dq      =>    mem0_dq_s,         
    mem_dbi_n   =>    mem0_dbi_n_s      
  );
       
  ed_sim_mem_i1 : entity ed_sim_mem.ed_sim_mem
  port map(
    mem_ck      =>    mem1_ck_s,         
    mem_ck_n    =>    mem1_ck_n_s,       
    mem_a       =>    mem1_a_s,          
    mem_act_n   =>    mem1_act_n_s,      
    mem_ba      =>    mem1_ba_s,         
    mem_bg      =>    mem1_bg_s,         
    mem_cke     =>    mem1_cke_s,        
    mem_cs_n    =>    mem1_cs_n_s,       
    mem_odt     =>    mem1_odt_s,        
    mem_reset_n =>    mem1_reset_n_s,    
    mem_par     =>    mem1_par_s,        
    mem_alert_n =>    mem1_alert_n_s,    
    mem_dqs     =>    mem1_dqs_s,        
    mem_dqs_n   =>    mem1_dqs_n_s,      
    mem_dq      =>    mem1_dq_s,         
    mem_dbi_n   =>    mem1_dbi_n_s      
  );
       
  -- concurrent assignments
  assign_wait_request0: amm0_wait_request_s <= not(amm0_ready_s);
  assign_write_data0 : amm0_write_data_576_s <= "0000000000000000000000000000000000000000000000000000000000000000" & amm0_write_data_s;

  assign_wait_request1: amm1_wait_request_s <= not(amm1_ready_s);
  assign_write_data1 : amm1_write_data_576_s <= "0000000000000000000000000000000000000000000000000000000000000000" & amm1_write_data_s;

  
  rst_ddr0_req_s <= not rst_ddr0_gbl_n_s;
  rst_ddr1_req_s <= not rst_ddr1_gbl_n_s;

  fdas_core_i : entity fdas_core_lib.fdas_core
  generic map (
    ddr_g             => ddr_c,
    fft_g             => fft_c,
    fft_abits_g       => fft_abits_c,
    ifft_g            => ifft_c,
    ifft_loop_g       => ifft_loop_c,
    ifft_loop_bits_g  => ifft_loop_bits_c,
    summer_g          => summer_c,
    harmonic_g        => harmonic_c,
    product_id_g      => product_id_c,
    version_number_g  => version_number_c,
    revision_number_g => revision_number_c
  )
  port map (
    AMM_READ_DATA0           => amm0_read_data_s(511 downto 0),     
    AMM_READ_DATA1           => amm1_read_data_s(511 downto 0),     
    AMM_READ_DATA_VALID0     => amm0_read_data_valid_s,      
    AMM_READ_DATA_VALID1     => amm1_read_data_valid_s,      
    AMM_WAIT_REQUEST0        => amm0_wait_request_s,
    AMM_WAIT_REQUEST1        => amm1_wait_request_s,
    CLK_DDR0                 => clk_ddr0_s,
    CLK_DDR1                 => clk_ddr1_s,
    CLK_MC                   => clk_mc_s,
    CLK_PCIE                 => clk_pcie_s,
    CLK_SYS                  => clk_sys_s,
    DDR_0_CAL_FAIL           => local0_cal_fail_s,
    DDR_0_CAL_SUCESS         => local0_cal_success_s,
    DDR_1_CAL_FAIL           => local1_cal_fail_s,
    DDR_1_CAL_SUCESS         => local1_cal_success_s,
    RD_DMA_0_ADDRESS         => rd_dma0_address_s,
    RD_DMA_0_BURST_COUNT     => rd_dma0_burst_count_s,
    RD_DMA_0_BYTE_EN         => rd_dma0_byte_en_s,
    RD_DMA_0_WRITE           => rd_dma0_write_s,
    RD_DMA_0_WRITE_DATA      => rd_dma0_write_data_s,
    RD_DMA_1_ADDRESS         => rd_dma1_address_s,
    RD_DMA_1_BURST_COUNT     => rd_dma1_burst_count_s,
    RD_DMA_1_BYTE_EN         => rd_dma1_byte_en_s,
    RD_DMA_1_WRITE           => rd_dma1_write_s,
    RD_DMA_1_WRITE_DATA      => rd_dma1_write_data_s,
    TOP_VERSION              => top_version_s,
    TOP_REVISION             => top_revision_s,
    RST_DDR0_N               => rst_ddr0_n_s,
    RST_DDR1_N               => rst_ddr1_n_s,
    DDR_0_RST_N              => rst_ddr0_gbl_n_s,
    DDR_1_RST_N              => rst_ddr1_gbl_n_s,
    DDR_0_RESET_DONE         => rst_ddr0_done_s,
    DDR_1_RESET_DONE         => rst_ddr1_done_s,
    RST_MC_N                 => rst_mc_n_s,
    RST_PCIE_N               => rst_pcie_n_s,
    RST_GLOBAL_N             => rst_pcie_n_s,
    RXM_ADDRESS              => rxm_address_s,
    RXM_BYTE_ENABLE          => rxm_byte_enable_s,
    RXM_READ                 => rxm_read_s,
    RXM_WRITE                => rxm_write_s,
    RXM_WRITE_DATA           => rxm_write_data_s,
    WR_DMA_0_ADDRESS         => wr_dma0_address_s,
    WR_DMA_0_BURST_COUNT     => wr_dma0_burst_count_s,
    WR_DMA_0_READ            => wr_dma0_read_s,
    WR_DMA_1_ADDRESS         => wr_dma1_address_s,
    WR_DMA_1_BURST_COUNT     => wr_dma1_burst_count_s,
    WR_DMA_1_READ            => wr_dma1_read_s,
    AMM_ADDRESS0             => amm0_address_s, 
    AMM_ADDRESS1             => amm1_address_s, 
    AMM_BURSTCOUNT0          => amm0_burstcount_s,
    AMM_BURSTCOUNT1          => amm1_burstcount_s,
    AMM_BYTE_EN0             => amm0_byte_en_s,
    AMM_BYTE_EN1             => amm1_byte_en_s,
    AMM_READ0                => amm0_read_s,                 
    AMM_READ1                => amm1_read_s,                 
    AMM_WRITE0               => amm0_write_s,                
    AMM_WRITE1               => amm1_write_s,                
    AMM_WRITE_DATA0          => amm0_write_data_s,     
    AMM_WRITE_DATA1          => amm1_write_data_s,     
    RD_DMA_0_WAIT_REQUEST    => rd_dma0_wait_request_s,
    RD_DMA_1_WAIT_REQUEST    => rd_dma1_wait_request_s,
    RXM_READ_DATA            => rxm_read_data_s,
    RXM_READ_DATA_VALD       => rxm_read_data_valid_s,
    RXM_WAIT_REQUEST         => rxm_wait_request_s,
    WR_DMA_0_READ_DATA       => wr_dma0_read_data_s,
    WR_DMA_0_READ_DATA_VALID => wr_dma0_read_data_valid_s,
    WR_DMA_0_WAIT_REQUEST    => wr_dma0_wait_request_s,
    WR_DMA_1_READ_DATA       => wr_dma1_read_data_s,
    WR_DMA_1_READ_DATA_VALID => wr_dma1_read_data_valid_s,
    WR_DMA_1_WAIT_REQUEST    => wr_dma1_wait_request_s,
    USR_EVENT_MSIX_READY     => user_msix_ready_s,
    USR_EVENT_MSIX_VALID     => user_msix_valid_s,
    USR_EVENT_MSIX_DATA      => user_msix_data_s
  );
         
-- get address and word position for filter under test
  decode_addr : process (testfilter_s)
    variable seladdrout_v : integer range 0 to 5;
  begin
    if testfilter_s>0 then
      seladdrout_v := (testfilter_s-1)/(7*ddr_c); 
    else
      seladdrout_v := 0;
    end if;
    seladdrout_s <= seladdrout_v;
    selwordout_s <= testfilter_s-(seladdrout_v*7*ddr_c);
  end process decode_addr;
  
  -- get data out for selected filter (and conjugate)
  seldataout_s <= amm1_write_data_s(selwordout_s*64+31 downto selwordout_s*64);
  seldataout_real_s <= to_real(float32(seldataout_s));
  selconjdataout_s <= amm1_write_data_s(selwordout_s*64+63 downto selwordout_s*64+32);
  selconjdataout_real_s <= to_real(float32(selconjdataout_s));
  
  seldataout_float_s <= float32(seldataout_s);
  selconjdataout_float_s <= float32(selconjdataout_s);
  
  convpowerout_s <= to_float(seldataout_s);
  convpowerlog2_s <= signed(seldataout_s(31 downto 23))-127;
  
  output1_float_s <= float32(output1_test_vec_s(to_integer(opcnt_s)).RE)*float32(output1_test_vec_s(to_integer(opcnt_s)).RE) + float32(output1_test_vec_s(to_integer(opcnt_s)).IM)*float32(output1_test_vec_s(to_integer(opcnt_s)).IM);
  output2_float_s <= float32(output2_test_vec_s(to_integer(opcnt_s)).RE)*float32(output2_test_vec_s(to_integer(opcnt_s)).RE) + float32(output2_test_vec_s(to_integer(opcnt_s)).IM)*float32(output2_test_vec_s(to_integer(opcnt_s)).IM);

  ref1_float_s <= float32(output_ref_vec_s(to_integer(opcnt_s)).RE);
  ref2_float_s <= float32(output_ref_vec_s(to_integer(opcnt_s)).IM);
  
      
  chk_result_p : process (clk_ddr1_s,rst_ddr1_n_s)
    variable outline_v : line;
  begin
    if rst_ddr1_n_s='0' then
      max_s <= (others => '0');
      maxnum_s <= (others => '0');
      result_s <= (others => '0');
      resultnum_s <= (others => '0');
      opcnt_s <= (others => '0');
      conv_done_cnt_s <= (others => '0');
      operr1_float_s <= (others => '0');
      operr2_float_s <= (others => '0');
      operr1_max_float_s <= (others => '0');
      operr2_max_float_s <= (others => '0');
      maxerr1_float_s <= (others => '0');
      maxerr2_float_s <= (others => '0');
      referr1_float_s <= (others => '0');
      referr2_float_s <= (others => '0');
      referr1_max_float_s <= (others => '0');
      referr2_max_float_s <= (others => '0');
      maxreferr1_float_s <= (others => '0');
      maxreferr2_float_s <= (others => '0');
      operr1_maxseg_float_s <= (others => '0');
      operr2_maxseg_float_s <= (others => '0');
      maxerrseg1_float_s <= (others => '0');
      maxerrseg2_float_s <= (others => '0');
      testfail_s <= false;
    elsif rising_edge(clk_ddr1_s) then
    
      -- check expected results      
      if amm1_write_s='1' and amm1_wait_request_s='0' and unsigned(amm1_address_s(9-ddr_c downto 6))=seladdrout_s then
        operr1_float_s <= ABS((output1_float_s - seldataout_float_s));
        operr2_float_s <= ABS((output2_float_s - selconjdataout_float_s));
          
        referr1_float_s <= ABS((ref1_float_s - seldataout_float_s));
        referr2_float_s <= ABS((ref2_float_s - selconjdataout_float_s));
          
        if opcnt_s<output_len_c-1 then
          opcnt_s <= opcnt_s + 1;
        else
          opcnt_s <= (others => '0');
        end if;
      
        if convpowerout_s>max_s then
          max_s <= convpowerout_s;
          maxnum_s <= opcnt_s;
        end if;
                
        if operr1_float_s>operr1_max_float_s then
          operr1_max_float_s <= operr1_float_s;
        end if;
        
        if operr2_float_s>operr2_max_float_s then
          operr2_max_float_s <= operr2_float_s;
        end if;

        if referr1_float_s>referr1_max_float_s then
          referr1_max_float_s <= referr1_float_s;
        end if;
        
        if referr2_float_s>referr2_max_float_s then
          referr2_max_float_s <= referr2_float_s;
        end if;
        
        if operr1_float_s>operr1_maxseg_float_s then
          operr1_maxseg_float_s <= operr1_float_s;
        end if;
        
        if operr2_float_s>operr2_maxseg_float_s then
          operr2_maxseg_float_s <= operr2_float_s;
        end if;
        
        -- compare to golden reference
        if seldataout_s /= output_ref_vec_s(to_integer(opcnt_s)).RE then
          testfail_s <= true;
        elsif selconjdataout_s /= output_ref_vec_s(to_integer(opcnt_s)).IM then
          testfail_s <= true;
        end if;
        
      end if;
      
      if opcnt_s=fop_num_c-1 then
        conv_done_cnt_s <= conv_done_cnt_s + 1;
        maxnum_s <= (others => '0');
        max_s <= (others => '0');
        operr1_max_float_s <= (others => '0');
        operr2_max_float_s <= (others => '0');
        referr1_max_float_s <= (others => '0');
        referr2_max_float_s <= (others => '0');
        
        result_s <= max_s;
        resultnum_s <= maxnum_s;
        
        maxerr1_float_s <= operr1_max_float_s;
        maxerr2_float_s <= operr2_max_float_s;
        
        maxreferr1_float_s <= referr1_max_float_s;
        maxreferr2_float_s <= referr2_max_float_s;
        
        write(outline_v, string'("Max diff to output for conv"));
        write(outline_v, to_integer(conv_done_cnt_s)+1);
        write(outline_v, string'(": "));
        write(outline_v, to_real(operr1_max_float_s));
        writeline(OUTPUT,outline_v);
        write(outline_v, string'("Max diff to conj output for conv"));
        write(outline_v, to_integer(conv_done_cnt_s)+1);
        write(outline_v, string'(": "));
        write(outline_v, to_real(operr2_max_float_s));
        writeline(OUTPUT,outline_v);

        write(outline_v, string'("Max diff to ref for conv"));
        write(outline_v, to_integer(conv_done_cnt_s)+1);
        write(outline_v, string'(": "));
        write(outline_v, to_real(referr1_max_float_s));
        writeline(OUTPUT,outline_v);
        write(outline_v, string'("Max diff to conj ref for conv"));
        write(outline_v, to_integer(conv_done_cnt_s)+1);
        write(outline_v, string'(": "));
        write(outline_v, to_real(referr2_max_float_s));
        writeline(OUTPUT,outline_v);

      end if;
            
    end if;    
    
  end process chk_result_p;
  
  -- save results for selected filter (and conjugate)
  dump_result : process 
    variable outline_v : line;
  begin
    -- prepare results file
    file_open(results, "results_conv.txt", WRITE_MODE);
    while test_finished=false loop
      wait until rising_edge(clk_ddr1_s);
      
      -- DDR data valid for filter under test
      if amm1_write_s='1' and amm1_wait_request_s='0' and unsigned(amm1_address_s(9-ddr_c downto 6))=seladdrout_s then
        hwrite(outline_v, seldataout_s);
        write(outline_v, string'("  "));
        hwrite(outline_v, selconjdataout_s);
        writeline(results,outline_v);
      end if;
    
    end loop;
    file_close(results);
    wait;
    
  end process dump_result;
  
  main : process
    variable outline_v     : line;
    variable mcrddata_v    : std_logic_vector(31 downto 0);
    variable test_1_v      : std_logic;
    variable test_2_v      : std_logic;
    variable test_3_v      : std_logic;
    variable test_4_v      : std_logic;
    variable test_5_v      : std_logic;
    variable mcfail_v      : boolean := false;

    
    procedure mcwrite(
      addr : in integer;
      data : in std_logic_vector(rxm_write_data_s'range)) is
      variable bin_addr : std_logic_vector(rxm_address_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,rxm_address_s'length));
      rxm_address_s      <= bin_addr;
      rxm_write_data_s   <= data; 
      rxm_write_s        <= '1';
      wait for clk_pcie_per_c;
      while rxm_wait_request_s='1' loop
        wait for clk_pcie_per_c;
      end loop;
      rxm_write_s        <= '0';  
    end mcwrite;
    
    procedure mcwrite(
      addr : in integer;
      data : in integer) is
      variable bin_addr : std_logic_vector(rxm_address_s'range);
      variable bin_data : std_logic_vector(rxm_write_data_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,rxm_address_s'length));
      bin_data := std_logic_vector(to_unsigned(data,rxm_write_data_s'length));
      rxm_address_s <= bin_addr;
      rxm_write_data_s <= bin_data;
      rxm_write_s        <= '1';
      wait for clk_pcie_per_c;
      while rxm_wait_request_s='1' loop
        wait for clk_pcie_per_c;
      end loop;
      rxm_write_s        <= '0';  
    end mcwrite;
        
    procedure mcread(
      addr : in integer;
      bin_data : out std_logic_vector(rxm_read_data_s'range)) is
      variable bin_addr : std_logic_vector(rxm_address_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,rxm_address_s'length));
      rxm_address_s <= bin_addr;
      rxm_read_s        <= '1';
      wait for clk_pcie_per_c;
      while rxm_wait_request_s='1' loop
        wait for clk_pcie_per_c;
      end loop;
      rxm_read_s        <= '0';
      if rxm_read_data_valid_s='0' then
        wait for clk_pcie_per_c;
      end if;
      
      bin_data := rxm_read_data_s;

    end mcread;
    
    procedure mcreadchk(
      addr : in integer;
      bin_data : in std_logic_vector(rxm_read_data_s'range)) is
      variable bin_addr : std_logic_vector(rxm_address_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,rxm_address_s'length));
      rxm_address_s <= bin_addr;
      rxm_read_s        <= '1';
      wait for clk_pcie_per_c;
      while rxm_wait_request_s='1' loop
        wait for clk_pcie_per_c;
      end loop;
      rxm_read_s        <= '0';
      if rxm_read_data_valid_s='0' then
        wait for clk_pcie_per_c;
      end if;
      if rxm_read_data_s /= bin_data then
        mcfail_v := true;
        write(outline_v, string'("Micro read incorrect: Addr 0x"));
        hwrite(outline_v, bin_addr);
        write(outline_v, string'(" expected "));
        hwrite(outline_v, bin_data);
        write(outline_v, string'(", got "));
        hwrite(outline_v, rxm_read_data_s);
        writeline(OUTPUT,outline_v);
      end if;
    end mcreadchk;
    
    procedure mcreadchk(
      addr : in integer;
      data : in integer) is
    begin
      mcreadchk(addr,std_logic_vector(to_unsigned(data,rxm_read_data_s'length)));
    end mcreadchk;
    
    -- Procedure to output a string.
    procedure puts(msg : string) is
    begin
      write(outline_v, msg);
      writeline(output,outline_v);
    end procedure puts;
    
    
    -- Procedure to generate a heading.
    procedure heading (title : string) is
    begin
      writeline(output,outline_v);
      puts("-------------------------------------------------");
      puts("-- " & title);
      puts("-------------------------------------------------");
    end procedure heading;
    
    
    --Procedure to run for a period of time.
    procedure run_sys (clocks : natural) is
    begin
      wait for clk_sys_per_c * clocks;
    end procedure run_sys;
    
  begin

    heading("Initialisation.");
    -- Initialise signals.
    -- PCIF Module 
    rxm_write_data_s   <= (others => '0'); 
    rxm_address_s      <= (others => '0');
    rxm_write_s        <= '0';  
    rxm_read_s         <= '0';    
    rxm_byte_enable_s  <= (others => '1');
      
    -- DDRIF Module Static signals
--    ddr_wr_waitreq_s <= '0';
--    input_test_vec_s <= LoadFile("input_data_1024_real_imag_single_float.txt",1024);
    output1_test_vec_s <= LoadFile("output1.txt",fop_num_c);
    output2_test_vec_s <= LoadFile("output2.txt",fop_num_c);
    output_ref_vec_s <= LoadFile("output_ref.txt",fop_num_c);
    template_s <= LoadFile("template1.txt",1024);
--    template_s <= LoadFile("flat.txt",1024);

    testfilter_s <= 1;

    -- Test bench
    burst_num_s <= (others => '0');
    pcie0_aa_s <= (others => '0');
    pcie0_ai_s <= (others => '0');
    pcie0_awren_s <= '0';
    pcie0_write_en_s <= '0';
    pcie0_read_en_s <= '0';
    pcie0_check_en_s <= '0';
    pcie1_aa_s <= (others => '0');
    pcie1_ai_s <= (others => '0');
    pcie1_awren_s <= '0';
    pcie1_write_en_s <= '0';
    pcie1_read_en_s <= '0';
    pcie1_check_en_s <= '0';
    rst_sys_n_s <= '0';  
    rst_pcie_n_s <= '0';  
    run_sys(200);
    rst_sys_n_s <= '1';
    rst_pcie_n_s <= '1';
    run_sys(200);
    -- apply resets
    mcwrite(16#000010#, 0); -- 

    run_sys(200);
    mcwrite(16#000010#, 1023); -- 

    -- Ensure CTRL bitmap is initialised
    mcwrite(16#100000#, 0); -- DM_TRIG
    mcwrite(16#100008#, 0);	-- PAGE
    mcwrite(16#100010#, 420);	-- OVERLAP_SIZE[9:0]
    mcwrite(16#100018#, 4831);	-- FOP_SAMPLE_NUM[22:0] 
    mcwrite(16#10001A#, ifft_loop_c);	-- IFFT_LOOP_NUM[5:0]
    mcwrite(16#100020#, 0);	-- MAN_OVERRIDE
    mcwrite(16#100028#, 0);	-- MAN_HSUM_TRIG, MAN_CONV_TRIG, MAN_CLD_TRIG
    mcwrite(16#100030#, 0);	-- MAN_HSUM_EN, MAN_CONV_EN, MAN_CLD_EN
    mcwrite(16#100038#, 0);	-- MAN_HSUM_PAUSE_EN, MAN_CONV_PAUSE_EN, MAN_CLD_PAUSE_EN
    mcwrite(16#100040#, 0);	-- MAN_HSUM_PAUSE_RST, MAN_CONV_PAUSE_RST, MAN_CLD_PAUSE_RST
    mcwrite(16#100048#, 0);	-- MAN_CLD_PAUSE_CNT[31:0]
    mcwrite(16#100049#, 0);	-- MAN_CONV_PAUSE_CNT[31:0]
    mcwrite(16#10004A#, 0);	-- MAN_HSUM_PAUSE_CNT[31:0]
    mcreadchk(16#100050#, 7); -- LATCHED_HSUM_DONE, LATCHED_CONV_DONE, LATCHED_CLD_DONE
--    run_sys(40000);
    wait until local0_cal_success_s='1' and local1_cal_success_s='1';
    
    test_1_v := '1';
    test_2_v := '1';
    test_3_v := '1';
    test_4_v := '1';
    test_5_v := '1';
  
    puts("Test 1: Write Data to the DDR Memory from the PCIe Interface and read back with dynamic ddr_rd_waitreq");
    
     -- Enable the request to write data from PCIe to the DDR memory, with dynamic wait request
    pcie0_write_en_s <= '1';
    burst_num_s <= "00011"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
    run_sys(2000);
    pcie0_write_en_s  <= '0';
    run_sys(100);
    
    -- Enable the request to read data from DDR memory by PCIe , with dynamic wait request
    pcie0_read_en_s <= '1';
    burst_num_s <= "00011"; -- this is 1 less than the value on the interface since the internal counter in the test bench rolls over to 0.
    pcie0_check_en_s <= '1';
    run_sys(1000);
    pcie0_read_en_s  <= '0';
    pcie0_check_en_s <= '0';
    run_sys(100);  

    ---------------------------------------------------------------------------------------------------------------------------------------------------- 
    --- Test 2: Read the samples for a DM with overlap size = 420                                                      ---
    ---                                                                                                                                              ---                                                                                                     ---                                                                                                       
    ---------------------------------------------------------------------------------------------------------------------------------------------------- 
    mcwrite(16#100000#, 0); -- DM_TRIG
    mcwrite(16#100000#, 1); -- DM_TRIG
    
    -- read out template and output and convert to real so it can be inspected
--    for i in 0 to 1023 loop
--      rtemplate_real_s <= to_real(float32(template_s(i).RE));
--      itemplate_real_s <= to_real(float32(template_s(i).IM));
--      wait for clk_sys_per_c;
--    end loop;
    
--    wait for 200*clk_sys_per_c;
--    conv_enable_s <= '0';
--    wait for 1000*clk_sys_per_c;
--    for i in 0 to 1023 loop
--      mcread(16#120000#+i*2,mcrddata_v);
--      mcrddata_re_real_s <= to_real(float32(mcrddata_v));
--      mcread(16#120000#+i*2+1,mcrddata_v);
--      mcrddata_im_real_s <= to_real(float32(mcrddata_v));
--    end loop;
--    wait for clk_sys_per_c;

    -- wait till conv finshed fop and hsum starts to request data from DDR
    wait until amm1_read_s='1';

    run_sys(2);
    ---------------------------------------------------------------------------------------------------        
    testbench_passed_v := not(testfail_s or mcfail_v);
    ---------------------------------------------------------------------------------------------------        
    -- Display pass/fail message.
    if testbench_passed_v then
      heading("Testbench PASSED");
    else
      heading("Testbench FAILED");
    end if;
    write(outline_v, string'("Max diff: "));
    write(outline_v, to_real(maxerr1_float_s));
    writeline(OUTPUT,outline_v);
    write(outline_v, string'("Max conj diff: "));
    write(outline_v, to_real(maxerr2_float_s));
    writeline(OUTPUT,outline_v);
    -- Stop simulation.
    test_finished <= true;
    assert false
    report "simulation ended"
    severity failure;
    wait;
  end process main;
      
end bhv;