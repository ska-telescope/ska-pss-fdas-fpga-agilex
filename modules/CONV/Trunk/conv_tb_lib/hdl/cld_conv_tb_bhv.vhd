----------------------------------------------------------------------------
-- Module Name:  CLD_CONV_TB
--
-- Source Path:  cld_conv_tb_bhv.vhd
--
-- Description:  CLD CONV Testbench
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     12/06/2017  Initial revision.
----------------------------------------------------------------------------
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
-- VHDL Version: VHDL 2008
----------------------------------------------------------------------------

architecture bhv of cld_conv_tb is
  -- Constants
  -- Conv Generics
  constant filtnum_c      : integer := 21;
  constant rptnum_c       : integer := 2;  -- lte 2**rptbits
  constant rptbits_c      : integer := 1;
  constant ptsnum_c       : integer := 1024;
  constant datalen_c      : integer := 1024;
  constant fop_num_bits_c : integer := 23;
  constant ddr_c          : integer := 1;  -- 1 to 3
  constant fop_num_c      : integer := 4832;
  constant abits_c        : integer := 10;
  -- Testbench
  constant input_len_c    : integer := 4832; -- 8x604
  constant output_len_c   : integer := 4832; 
   -- Internal signal declarations
  signal clk_sys_s        : std_logic := '0';
  signal rst_sys_n_s      : std_logic;
  signal clk_mc_s         : std_logic := '0';
  signal rst_mc_n_s       : std_logic;

  -- process: ddr_interface_ram
  subtype word_t is std_logic_vector(511 downto 0);
  type memory_t is array(262154 downto 0) of word_t;
  signal ram_s                           : memory_t;
  signal awren_s                         : std_logic;
  signal aa_s                            : unsigned(17 downto 0);
  signal ai_s                            : std_logic_vector(511 downto 0);
  signal bo_s                            : std_logic_vector(511 downto 0);
  signal bo_valid_s                      : std_logic;  
  signal ddr_read_ret_1_s                : std_logic;
  signal wait_request_toggle_s           : std_logic;
  signal wait_request_cnt_s              : unsigned(1 downto 0);  
  
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
  
  -- CLD Module CTRL Interface
  signal cld_trigger_s                   : std_logic;
  signal cld_enable_s 		             : std_logic;
  signal cld_page_s    		             : std_logic_vector(31 downto 0);
  signal cld_done_s 		             : std_logic; 
  signal fop_sample_num_s                : std_logic_vector(fop_num_bits_c-1 downto 0);
  
  -- CLD Module DDR Interface
  signal ddr_addr_s                      : std_logic_vector(31 downto 0); 
  signal ddr_read_s      		         : std_logic;
  signal wait_request_s  		         : std_logic;
  signal data_valid_s   		         : std_logic;
  signal ddr_data_s 		             : std_logic_vector(511 downto 0);
  signal overlap_rem_s                   : std_logic_vector(4 downto 0);
  signal overlap_int_s                   : std_logic_vector(4 downto 0);
  
  -- CONV Module Interface
  signal fft_sample_s		             : std_logic_vector(9 downto 0);
  signal conv_req_s		                 : std_logic;
  signal ready_s 		                 : std_logic;  
  signal sof_s 		                     : std_logic;
  signal eof_s 		                     : std_logic;
  signal valid_s 		                 : std_logic;
  signal conv_data_s 		             : std_logic_vector(63 downto 0);  

  -- CONV Module Ports  
  signal sync_s           : std_logic;
  signal conv_enable_s    : std_logic;
  
  signal overlap_size_s   : std_logic_vector(9 downto 0);
  signal page_start_s     : std_logic_vector(25 downto 0);
  signal rptnum_s         : std_logic_vector(rptbits_c downto 0);
  
  signal mcdata_s         : std_logic_vector(31 downto 0);
  signal mcaddr_s         : std_logic_vector(19 downto 0);
  signal mcrwn_s          : std_logic;
  signal mcms_s           : std_logic;
  signal mcdataout_s      : std_logic_vector(31 downto 0);
  signal mcreadyout_s     : std_logic;
  
  signal convlast_s       : std_logic;
  signal convreadyout_s   : std_logic;
  
  signal convwaitreq_s    : std_logic;
  signal convdataout_s    : std_logic_vector(ddr_c*512 -1 downto 0);
  signal convaddrout_s    : std_logic_vector(25 downto 0);
  signal convvalidout_s   : std_logic;
  signal segdoneout_s     : std_logic;
  signal conv_doneout_s   : std_logic;
  signal conv_done_cnt_s  : unsigned(3 downto 0);
  
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
  signal input_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output1_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output2_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output_ref_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal template_s       : cmplx_array_t(0 to 1023);
  signal datacnt_s        : unsigned(12 downto 0);
  signal smplcnt_s        : unsigned(9 downto 0);
  signal upsamplecnt_s    : unsigned(3 downto 0);
  signal overlapcnt_s     : unsigned(9 downto 0);

  -- general
  signal testfail_s                      : boolean := false;
  signal test_finished                   : boolean := false;
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;

  -- results
  file results : text;

  -- filter generation
  file filter : text;
  
   -- constant declaration
  constant cyclesys_c : time := 10 ns;
  constant cyclemc_c : time := 10 ns;
  
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

  clk_sys_s   <= not clk_sys_s after (0.5*cyclesys_c) when not test_finished;
  
  clk_mc_s   <= not clk_mc_s after (0.5*cyclemc_c) when not test_finished;


  ready_s <= convreadyout_s;
  
  ------------------------------------------------------------------------------
  -- PROCESS : ddr_interface_ram
  -- FUNCTION: Provides RAM to store the samples
  ------------------------------------------------------------------------------
  ddr_interface_ram : process (clk_sys_s, rst_sys_n_s)
        
  begin
    if rst_sys_n_s='0' then
      input_test_vec_s <= LoadFile("input_data.txt",fop_num_c);
      for i in 0 to 603 loop
        for j in 0 to 7 loop
          ram_s(i)((j+1)*64-1 downto j*64) <= input_test_vec_s(i*8+j).IM & input_test_vec_s(i*8+j).RE;
        end loop;
      end loop;
    elsif (rising_edge(clk_sys_s)) then
      if (awren_s = '1') then
        ram_s(TO_INTEGER(aa_s)) <= ai_s;
      end if;
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
      
      
      bo_s <= ram_s(TO_INTEGER(UNSIGNED(ddr_addr_s(31 downto 6))));
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
    elsif rising_edge(clk_sys_s) then
      latency_fifo_s <= latency_fifo_s(30 downto 0) & (bo_valid_s & bo_s);
      data_valid_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (512);
      ddr_data_s <= latency_fifo_s(TO_INTEGER(ddr_latency_s)) (511 downto 0);
      
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


  
  cld_i : entity cld_lib.cld
  generic map (
    ddr_g                    => 1,
	fft_ddr_addr_num_g       => 128,
	fop_ddr_addr_max_width_g => 18, 
	fft_ddr_addr_num_width_g => 7, 
	fft_g                    => 1024,
	fft_count_width_g        => 10, 
	sample_count_width_g     => 23, 
	fifo_waddr_width_g       => 9,  
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
    fop_sample_num   =>     fop_sample_num_s,
    overlap_int      =>     overlap_int_s,
    overlap_rem      =>     overlap_rem_s,
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

  overlap_rem_s <= (others => '0');
  overlap_int_s <= (others => '0');
  
  sync_s <= '0';
  
  convrdata_s <= to_real(float32(conv_data_s(31 downto 0)));
  convidata_s <= to_real(float32(conv_data_s(63 downto 32)));
  
  
  conv_i : entity conv_lib.conv
  generic map (
    fop_num_bits_g   => fop_num_bits_c,
    ddr_g            => ddr_c,
    ifft_g           => filtnum_c,
    ifft_loop_g      => rptnum_c,
    ifft_loop_bits_g => rptbits_c,
    fft_g            => ptsnum_c,
    abits_g          => abits_c
  )
  port map (
    CLK_SYS       => clk_sys_s,
    RST_SYS_N     => rst_sys_n_s,
    RDATA         => conv_data_s(31 downto 0),
    IDATA         => conv_data_s(63 downto 32),
    EOF           => eof_s,
    SOF           => sof_s,
    CONV_TRIGGER  => sync_s,
    CONV_ENABLE   => conv_enable_s,
    OVERLAP_SIZE  => overlap_size_s,
    PAGE_START    => page_start_s,
    IFFT_LOOP_NUM => rptnum_s,
    FOP_NUM       => fop_sample_num_s,
    VALID         => valid_s,
    READYOUT      => convreadyout_s,
    DDR_WAITREQ   => convwaitreq_s,
    CLK_MC        => clk_mc_s,
    RST_MC_N      => rst_mc_n_s,
    MCADDR        => mcaddr_s,
    MCDATA        => mcdata_s,
    MCRWN         => mcrwn_s,
    MCMS          => mcms_s,
    MCDATAOUT     => mcdataout_s,
    MCREADYOUT    => mcreadyout_s,
    DDR_DATAOUT   => convdataout_s,
    DDR_ADDROUT   => convaddrout_s,
    DDR_VALIDOUT  => convvalidout_s,
    SEGDONEOUT    => segdoneout_s,
    CONV_DONEOUT  => conv_doneout_s
  );

-- get address and word position for filter under test
  decode_addr : process (testfilter_s)
--    variable selddrout_v : integer range 0 to 2
    variable seladdrout_v : integer range 0 to 5;
  begin
    if testfilter_s>0 then
--      selddrout_v := (testfilter_s-1)/(14*(4-ddr_c));
--      seladdrout_v := (testfilter_s-1)/(7*ddr_c); 
      seladdrout_v := (testfilter_s-1)/(7*ddr_c); 
    else
      seladdrout_v := 0;
    end if;
    seladdrout_s <= seladdrout_v;
    selwordout_s <= testfilter_s-(seladdrout_v*7*ddr_c);
  end process decode_addr;
  
  -- get data out for selected filter (and conjugate)
  seldataout_s <= convdataout_s(selwordout_s*64+31 downto selwordout_s*64);
  seldataout_real_s <= to_real(float32(seldataout_s));
  selconjdataout_s <= convdataout_s(selwordout_s*64+63 downto selwordout_s*64+32);
  selconjdataout_real_s <= to_real(float32(selconjdataout_s));
  
  seldataout_float_s <= float32(seldataout_s);
  selconjdataout_float_s <= float32(selconjdataout_s);
  
  
  convpowerout_s <= to_float(seldataout_s);
  convpowerlog2_s <= signed(seldataout_s(31 downto 23))-127;
  
  output1_float_s <= float32(output1_test_vec_s(to_integer(opcnt_s)).RE)*float32(output1_test_vec_s(to_integer(opcnt_s)).RE) + float32(output1_test_vec_s(to_integer(opcnt_s)).IM)*float32(output1_test_vec_s(to_integer(opcnt_s)).IM);
  output2_float_s <= float32(output2_test_vec_s(to_integer(opcnt_s)).RE)*float32(output2_test_vec_s(to_integer(opcnt_s)).RE) + float32(output2_test_vec_s(to_integer(opcnt_s)).IM)*float32(output2_test_vec_s(to_integer(opcnt_s)).IM);

  ref1_float_s <= float32(output_ref_vec_s(to_integer(opcnt_s)).RE);
  ref2_float_s <= float32(output_ref_vec_s(to_integer(opcnt_s)).IM);
  
          
  chk_result_p : process (clk_sys_s,rst_sys_n_s)
    variable outline_v : line;
  begin
    if rst_sys_n_s='0' then
      max_s <= (others => '0');
      maxnum_s <= (others => '0');
      result_s <= (others => '0');
      resultnum_s <= (others => '0');
      conv_done_cnt_s <= (others => '0');
      opcnt_s <= (others => '0');
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
    elsif rising_edge(clk_sys_s) then
    
      -- check expected results
      -- DDR data valid for filter under test
      if convvalidout_s='1' and convwaitreq_s='0' and unsigned(convaddrout_s(3-ddr_c downto 0))=seladdrout_s then
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
      
      if conv_doneout_s='1' then
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
      
      if segdoneout_s='1' then
        operr1_maxseg_float_s <= (others => '0');
        operr2_maxseg_float_s <= (others => '0');
        
        maxerrseg1_float_s <= operr1_maxseg_float_s;
        maxerrseg2_float_s <= operr2_maxseg_float_s;
      end if;
      
      if sync_s='1' then
        max_s <= (others => '0');
        maxnum_s <= (others => '0');
        result_s <= (others => '0');
        resultnum_s <= (others => '0');
        opcnt_s <= (others => '0');
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
      wait until rising_edge(clk_sys_s);
      
      -- DDR data valid for filter under test
      if convvalidout_s='1' and convwaitreq_s='0' and unsigned(convaddrout_s(3-ddr_c downto 0))=seladdrout_s then
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
      data : in std_logic_vector(mcdata_s'range)) is
      variable bin_addr : std_logic_vector(mcaddr_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,mcaddr_s'length));
      mcrwn_s <= '0';
      mcms_s  <= '1';
      mcaddr_s <= bin_addr;
      mcdata_s <= data;
      wait for 2*cyclemc_c;
      mcms_s  <= '0';
      wait for cyclemc_c;
    end mcwrite;
    
    procedure mcwrite(
      addr : in integer;
      data : in integer) is
      variable bin_addr : std_logic_vector(mcaddr_s'range);
      variable bin_data : std_logic_vector(mcdata_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,mcaddr_s'length));
      bin_data := std_logic_vector(to_unsigned(data,mcdata_s'length));
      mcrwn_s <= '0';
      mcms_s  <= '1';
      mcaddr_s <= bin_addr;
      mcdata_s <= bin_data;
      wait for 2*cyclemc_c;
      mcms_s  <= '0';
      wait for cyclemc_c;
    end mcwrite;
        
    procedure mcread(
      addr : in integer;
      bin_data : out std_logic_vector(mcdataout_s'range)) is
      variable bin_addr : std_logic_vector(mcaddr_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,mcaddr_s'length));
      mcaddr_s <= bin_addr;
      mcrwn_s <= '1';
      mcms_s  <= '1';
      wait for 4*cyclemc_c;
      mcms_s  <= '0';
      bin_data := mcdataout_s;
      wait for cyclemc_c;
    end mcread;
    
    procedure mcreadchk(
      addr : in integer;
      bin_data : in std_logic_vector(mcdataout_s'range)) is
      variable bin_addr : std_logic_vector(mcaddr_s'range);
    begin
      bin_addr := std_logic_vector(to_unsigned(addr,mcaddr_s'length));
      mcaddr_s <= bin_addr;
      mcrwn_s <= '1';
      mcms_s  <= '1';
      wait for 4*cyclemc_c;
      mcms_s  <= '0';
      if mcdataout_s /= bin_data then
        mcfail_v := true;
        write(outline_v, string'("Micro read incorrect: Addr 0x"));
        hwrite(outline_v, bin_addr);
        write(outline_v, string'(" expected "));
        hwrite(outline_v, bin_data);
        write(outline_v, string'(", got "));
        hwrite(outline_v, mcdataout_s);
        writeline(OUTPUT,outline_v);
      end if;
      wait for cyclemc_c;
      mcaddr_s <= (others => '0');
    end mcreadchk;
    
    procedure mcreadchk(
      addr : in integer;
      data : in integer) is
    begin
      mcreadchk(addr,std_logic_vector(to_unsigned(data,mcdataout_s'length)));
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
    procedure run (clocks : natural) is
    begin
      wait for cyclesys_c * clocks;
    end procedure run;
    
    
  begin

    heading("Initialisation.");
    -- Initialise signals.
    
    page_start_s <= (others => '0');
    rptnum_s <= std_logic_vector(to_unsigned(rptnum_c,rptbits_c+1));
    testfilter_s <= 1;
    
    mcaddr_s <= (others => '0');
    mcdata_s <= (others => '0');
    mcrwn_s <= '0';
    mcms_s <= '0';
    convwaitreq_s <= '0';
    conv_enable_s <= '1';
--    input_test_vec_s <= LoadFile1("input_data_1024_real_imag_single_float.txt",1024);
    output1_test_vec_s <= LoadFile("output1.txt",fop_num_c);
    output2_test_vec_s <= LoadFile("output2.txt",fop_num_c);
    output_ref_vec_s <= LoadFile("output_ref.txt",fop_num_c);
    template_s <= LoadFile("template1.txt",1024);
--    template_s <= LoadFile("flat.txt",1024);

    -- CLD Module CTRL Interface
    cld_trigger_s                 <= '0';
    cld_enable_s 		          <= '0';
    cld_page_s    		          <= (others => '0');
    fop_sample_num_s              <= std_logic_vector(to_unsigned(fop_num_c-1,fop_num_bits_c));
    
    -- CLD Module CONV Interface
    overlap_size_s 		          <= std_logic_vector(to_unsigned(420,10));

    -- Test bench
    rst_sys_n_s 	              <= '0';
    rst_mc_n_s                    <= '0';
    run(2);
    rst_sys_n_s 	              <= '1';
    rst_mc_n_s                    <= '1';
    awren_s                       <= '0';
    ddr_latency_s                 <= "01000";
    
    test_1_v := '1';
    test_2_v := '1';
    test_3_v := '1';
    test_4_v := '1';
    test_5_v := '1';
  

    ---------------------------------------------------------------------------------------------------------------------------------------------------- 
    --- Test 1: TC.CLD.DM.01: Read the samples for a DM with overlap size = 420                                                      ---
    ---                                                                                                                                              ---                                                                                                     ---                                                                                                       
    ---------------------------------------------------------------------------------------------------------------------------------------------------- 
    if test_1_v = '1' then  
      puts("Test 1: TC.CLD.DM.01: Read the samples for a DM with overlap size = 420");
    
      -- overlap size = 420
      overlap_size_s <= std_logic_vector(to_unsigned(420,10));
      -- Enable and trigger CLD
      cld_enable_s             <= '1';
      -- check that initially there is no convolution request
      if conv_req_s = '1' then
        testbench_passed_v := false;
      end if;
      run(1);
      cld_trigger_s   	       <= '1';
      run(1);
      cld_trigger_s   	       <= '0';
      run(56300);
      
      cld_trigger_s   	       <= '1';
      run(1);
      cld_trigger_s   	       <= '0';
      run(56300);
      
    end if;
        
    wait for 10*cyclesys_c;
--    mcwrite(0,"01000000000000000000000000000000");
--    mcreadchk(0,"01000000000000000000000000000000");
--    mcwrite(1,"11000000000000000000000000000000");
--    mcreadchk(1,"11000000000000000000000000000000");
--    mcwrite(2048,  "01000000100000000000000000000000");
--    mcreadchk(2048,"01000000100000000000000000000000");
--    mcwrite(2049,  "11000000100000000000000000000000");
--    mcreadchk(2049,"11000000100000000000000000000000");
--    mcwrite(2048*2,    "01000001000000000000000000000000");
--    mcreadchk(2048*2,  "01000001000000000000000000000000");
--    mcwrite(2048*2+1,  "11000001000000000000000000000000");
--    mcreadchk(2048*2+1,"11000001000000000000000000000000");
--    mcwrite(2048*3,    "01000001100000000000000000000000");
--    mcreadchk(2048*3,  "01000001100000000000000000000000");
--    mcwrite(2048*3+1,  "11000001100000000000000000000000");
--    mcreadchk(2048*3+1,"11000001100000000000000000000000");
--    mcwrite(2048*4,    "01000010000000000000000000000000");
--    mcreadchk(2048*4,  "01000010000000000000000000000000");
--    mcwrite(2048*4+1,  "11000010000000000000000000000000");
--    mcreadchk(2048*4+1,"11000010000000000000000000000000");
--    mcwrite(2048*5,    "01000010100000000000000000000000");
--    mcreadchk(2048*5,  "01000010100000000000000000000000");
--    mcwrite(2048*5+1,  "11000010100000000000000000000000");
--    mcreadchk(2048*5+1,"11000010100000000000000000000000");
--    mcwrite(2048*6,    "01000011000000000000000000000000");
--    mcreadchk(2048*6,  "01000011000000000000000000000000");
--    mcwrite(2048*6+1,  "11000011000000000000000000000000");
--    mcreadchk(2048*6+1,"11000011000000000000000000000000");
--    for i in 0 to ifft_loop_c*ifft_c-1 loop
--      mcwrite(i*2048,  '0' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
--      mcwrite(i*2048+1,'1' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
--    end loop;
    -- load filter coefficients
--    for i in 0 to 1023 loop
--      mcwrite(i*2,  template_s(i).RE);
--      mcwrite(i*2+1,template_s(i).IM);
--    end loop;

    -- read out template and output and convert to real so it can be inspected
--    for i in 0 to 1023 loop
--      rtemplate_real_s <= to_real(float32(template_s(i).RE));
--      itemplate_real_s <= to_real(float32(template_s(i).IM));
--      wait for cyclesys_c;
--    end loop;
--    
--    wait for 200*cyclesys_c;
    
    -- read out FFT
    conv_enable_s <= '0';
    wait for 1000*cyclesys_c;
    for i in 0 to 1023 loop
      mcread(16#20000#+i*2,mcrddata_v);
      mcrddata_re_real_s <= to_real(float32(mcrddata_v));
      mcread(16#20000#+i*2+1,mcrddata_v);
      mcrddata_im_real_s <= to_real(float32(mcrddata_v));
    end loop;
    wait for cyclesys_c;
    conv_enable_s <= '1';

    
--    wait until convvalidout_s='1';
--    wait for 10*cyclesys_c;
--    convwaitreq_s <= '1';
--    wait for 10*cyclesys_c;
--    convwaitreq_s <= '0';

    wait for 2*cyclesys_c;
    testbench_passed_v := testbench_passed_v or not testfail_s;
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
    wait;
  end process main;
      
end bhv;