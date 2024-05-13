----------------------------------------------------------------------------
-- Module Name:  CONV_TB
--
-- Source Path:  conv_tb_bhv.vhd
--
-- Description:  CONV Testbench
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

architecture bhv of conv_tb is
  -- Constants
  -- Conv Generics
  constant filtnum_c      : integer := 21;
  constant rptnum_c       : integer := 2;  -- lte 2**rptbits
  constant rptbits_c      : integer := 1;
  constant ptsnum_c       : integer := 1024;
  constant datalen_c      : integer := 1024;
  constant fop_num_bits_c : integer := 23;
  constant ddr_c          : integer := 3;  -- 1 to 3
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
  
  -- Module Ports
  signal wrdata_s         : std_logic_vector(31 downto 0);
  signal widata_s         : std_logic_vector(31 downto 0);
  signal wvalid_s         : std_logic;
  signal wsof_s           : std_logic;
  signal weof_s           : std_logic;
  signal rready_s         : std_logic;
  signal fifoready_s      : std_logic;
  
  signal sync_s           : std_logic;
  signal conv_enable_s    : std_logic;
  
  -- Some input data has the overlap built in (set input_overlap_s to zero)
  -- otherwise input_overlap_s and conv_overlap_s are set to overlap size
  signal input_overlap_s  : std_logic_vector(9 downto 0); -- overlap size applied to input data
  signal conv_overlap_s   : std_logic_vector(9 downto 0); -- overlap size applied to conv
  signal page_start_s     : std_logic_vector (25 downto 0);
  signal fop_num_s        : std_logic_vector(fop_num_bits_c-1 downto 0);
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
  
  signal rtemplate_real_s    : real := 0.0;
  signal itemplate_real_s    : real := 0.0;
  
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
  signal input_test_vec_s : cmplx_array_t(0 to 8191);
  signal output1_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output2_test_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal output_ref_vec_s : cmplx_array_t(0 to fop_num_c-1);
  signal template_s       : cmplx_array_t(0 to 1023);
  signal datacnt_s        : unsigned(12 downto 0);
  signal smplcnt_s        : unsigned(9 downto 0);
  signal overlapcnt_s     : unsigned(9 downto 0);
  signal timeout_s        : unsigned(9 downto 0) := (others => '0');
  signal test_enable      : std_logic_vector(1 to 10);

  signal testfail_s       :  boolean := false;
  signal test_finished    :  boolean := false;

  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;

  -- results
  file results : text;

  -- filter generation
  file filter : text;
  
  -- FFT results
  file fft : text;
  
   -- constant declaration
  constant cyclesys_c : time := 10 ns;
  constant cyclemc_c : time := 10 ns;
  constant uprate_c : natural := 1;
  constant step_c : natural := 1; --20;
  
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
  
  inputgen_p : process (clk_sys_s,rst_sys_n_s)
  begin
    if rst_sys_n_s='0' then
      wrdata_s <= (others => '0');
      widata_s <= (others => '0');
    elsif rising_edge(clk_sys_s) then
      if convreadyout_s='1' then
        if overlapcnt_s<unsigned(input_overlap_s) then
          wrdata_s <= (others => '0');
          widata_s <= (others => '0');
        else
          wrdata_s <= input_test_vec_s(to_integer(datacnt_s)).RE;
          widata_s <= input_test_vec_s(to_integer(datacnt_s)).IM;
        end if;
      end if;
    end if;    
    
  end process inputgen_p;

  
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
    RDATA         => wrdata_s,
    IDATA         => widata_s,
    EOF           => weof_s,
    SOF           => wsof_s,
    CONV_TRIGGER  => sync_s,
    CONV_ENABLE   => conv_enable_s,
    OVERLAP_SIZE  => conv_overlap_s,
    IFFT_LOOP_NUM => rptnum_s,
    FOP_NUM       => fop_num_s,
    VALID         => wvalid_s,
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
    CONV_DONEOUT  => conv_doneout_s,
    PAGE_START    => page_start_s
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
  
    
  inputctrl_p : process (clk_sys_s,rst_sys_n_s)
    variable datacnt_v : unsigned(12 downto 0);
  begin
    if rst_sys_n_s='0' then
      datacnt_s <= (others => '0');
      smplcnt_s <= (others => '0');
      wvalid_s <= '0';
      wsof_s <= '0';
      weof_s <= '0';
      overlapcnt_s <= (others=> '0');
    elsif rising_edge(clk_sys_s) then
      datacnt_v := datacnt_s;
      if convreadyout_s='1' then
        wvalid_s <= '0';
        wsof_s <= '0';
        weof_s <= '0';
        -- zero data until overlap size
        if overlapcnt_s<unsigned(input_overlap_s) then
          wvalid_s <= '1';
          overlapcnt_s <= overlapcnt_s + 1;
        end if;
        if overlapcnt_s>=unsigned(input_overlap_s) then
          datacnt_v := datacnt_s + 1;
          wvalid_s <= '1';
        end if;
        -- count 1024 samples
        if smplcnt_s<1023 then
          smplcnt_s <= smplcnt_s + 1;
        else
          smplcnt_s <= (others => '0');
          weof_s <= '1';
          -- move datacnt back by overlap amount
          datacnt_v := datacnt_v - unsigned(input_overlap_s);
        end if;
        if smplcnt_s=0 then
          wsof_s <= '1';
        end if;
      end if;
      
      -- restart input data when finished
      if datacnt_s<input_len_c-1 then
        datacnt_s <= datacnt_v;
      else
        datacnt_s <= (others => '0');
        overlapcnt_s <= (others => '0');
      end if;
      
      -- when doneout restart overlap count
--      if conv_doneout_s='1' then
--        overlapcnt_s <= (others => '0');
--      end if;

      if sync_s='1' then
        wvalid_s <= '0';
        datacnt_s <= (others => '0');
        smplcnt_s <= (others => '0');
        wsof_s <= '0';
        weof_s <= '0';
        overlapcnt_s <= (others => '0');
      end if;
            
    end if;    
    
  end process inputctrl_p;
      
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
    variable outline_v          : line;
    variable mcrddata_v         : std_logic_vector(31 downto 0);
    variable mcfail_v           :  boolean := false;
    
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

  begin
  --                 1   2   3   4   5   6   7   8   9  10
    test_enable <= ('0','0','0','0','0','1','0','0','0','0');
    rst_sys_n_s <= '0';
    rst_mc_n_s <= '0';
    page_start_s <= (others => '0');
    fop_num_s <= std_logic_vector(to_unsigned(fop_num_c-1,fop_num_bits_c));
    input_overlap_s <= std_logic_vector(to_unsigned(420,10));
    conv_overlap_s <= std_logic_vector(to_unsigned(420,10));
    rptnum_s <= std_logic_vector(to_unsigned(rptnum_c,rptbits_c+1));
  
    mcaddr_s <= (others => '0');
    mcdata_s <= (others => '0');
    mcrwn_s <= '0';
    mcms_s <= '0';
    convwaitreq_s <= '0';
    sync_s <= '0';
    conv_enable_s <= '1';
--    input_test_vec_s <= LoadFile("input_data_1024_real_imag_single_float.txt,1024");
    input_test_vec_s <= LoadFile("input_data.txt",8192);
    output1_test_vec_s <= LoadFile("output1.txt",fop_num_c);
    output2_test_vec_s <= LoadFile("output2.txt",fop_num_c);
    output_ref_vec_s <= LoadFile("output_ref.txt",fop_num_c);
    template_s <= LoadFile("template1.txt",1024);
--    template_s <= LoadFile("flat.txt",1024);

    testfilter_s <= 35;
        
    wait for 2*cyclesys_c;
    rst_sys_n_s <= '1';
    rst_mc_n_s <= '1';
    
    -- write row0 delay
    mcwrite(16#28000#,1);


    if test_enable(1)='1' then
      wait for 10*cyclesys_c;
      mcwrite(0,"01000000000000000000000000000000");
      mcreadchk(0,"01000000000000000000000000000000");
      mcwrite(1,"11000000000000000000000000000000");
      mcreadchk(1,"11000000000000000000000000000000");
      mcwrite(2048,  "01000000100000000000000000000000");
      mcreadchk(2048,"01000000100000000000000000000000");
      mcwrite(2049,  "11000000100000000000000000000000");
      mcreadchk(2049,"11000000100000000000000000000000");
      mcwrite(2048*2,    "01000001000000000000000000000000");
      mcreadchk(2048*2,  "01000001000000000000000000000000");
      mcwrite(2048*2+1,  "11000001000000000000000000000000");
      mcreadchk(2048*2+1,"11000001000000000000000000000000");
      mcwrite(2048*3,    "01000001100000000000000000000000");
      mcreadchk(2048*3,  "01000001100000000000000000000000");
      mcwrite(2048*3+1,  "11000001100000000000000000000000");
      mcreadchk(2048*3+1,"11000001100000000000000000000000");
      mcwrite(2048*4,    "01000010000000000000000000000000");
      mcreadchk(2048*4,  "01000010000000000000000000000000");
      mcwrite(2048*4+1,  "11000010000000000000000000000000");
      mcreadchk(2048*4+1,"11000010000000000000000000000000");
      mcwrite(2048*5,    "01000010100000000000000000000000");
      mcreadchk(2048*5,  "01000010100000000000000000000000");
      mcwrite(2048*5+1,  "11000010100000000000000000000000");
      mcreadchk(2048*5+1,"11000010100000000000000000000000");
      mcwrite(2048*6,    "01000011000000000000000000000000");
      mcreadchk(2048*6,  "01000011000000000000000000000000");
      mcwrite(2048*6+1,  "11000011000000000000000000000000");
      mcreadchk(2048*6+1,"11000011000000000000000000000000");

    end if;
    
    if test_enable(2)='1' then
      for i in 0 to rptnum_c*filtnum_c-1 loop
        mcwrite(i*2048,  '0' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
        mcwrite(i*2048+1,'1' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
        mcreadchk(i*2048,  '0' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
        mcreadchk(i*2048+1,'1' & std_logic_vector(to_unsigned(16#40000000#+i*16#800000#,31)));
      end loop;

    -- reload filter coefficients
      for i in 0 to 1023 loop
        mcwrite(i*2,  template_s(i).RE);
        mcwrite(i*2+1,template_s(i).IM);
      end loop;

    end if;
    
    if test_enable(3)='1' then
      -- read out template and output and convert to real so it can be inspected
      for i in 0 to 1023 loop
        rtemplate_real_s <= to_real(float32(template_s(i).RE));
        itemplate_real_s <= to_real(float32(template_s(i).IM));
        wait for cyclesys_c;
      end loop;
      
      wait for 200*cyclesys_c;
      
    else
      wait for 1223*cyclesys_c;
      
    end if;
    
    if test_enable(4)='1' then
      -- pause convolution and read back FFT result
      conv_enable_s <= '0';
      timeout_s <= (others => '1');
      while timeout_s/=0 and mcreadyout_s='0' loop
        timeout_s <= timeout_s - 1;
        wait for cyclesys_c;
      end loop;
      if timeout_s=0 then
        puts("mcreadyout timed out");
      end if;
      for i in 0 to 1023 loop
        mcread(16#20000#+i*2,mcrddata_v);
        mcrddata_re_real_s <= to_real(float32(mcrddata_v));
        mcread(16#20000#+i*2+1,mcrddata_v);
        mcrddata_im_real_s <= to_real(float32(mcrddata_v));
      end loop;
      wait for cyclesys_c;
      conv_enable_s <= '1';
      
    end if;
    
    if test_enable(5)='1' then
      -- pause CONV and read FFT to file
      while conv_doneout_s='0' loop
        wait for cyclesys_c;
      end loop;
      -- disable conv and wait for mcreadyout
      conv_enable_s <= '0';
      timeout_s <= (others => '1');
      while timeout_s/=0 and mcreadyout_s='0' loop
        timeout_s <= timeout_s - 1;
        wait for cyclesys_c;
      end loop;
      if timeout_s=0 then
        puts("mcreadyout timed out");
      end if;    
    
      file_open(fft, "results_fft.txt", WRITE_MODE);
      
      for i in 0 to 1023 loop
        mcread(16#20000#+i*2,mcrddata_v);
        mcrddata_re_real_s <= to_real(float32(mcrddata_v));
        hwrite(outline_v, mcrddata_v);
        write(outline_v, string'("  "));
        mcread(16#20000#+i*2+1,mcrddata_v);
        mcrddata_im_real_s <= to_real(float32(mcrddata_v));
        hwrite(outline_v, mcrddata_v);
        writeline(fft,outline_v);
      end loop;
      
      file_close(fft);
    
      conv_enable_s <= '1';
      
    end if;
    
    if test_enable(6)='1' then
      -- run one fop with no back pressure
      for i in 0 to 0 loop
        wait until conv_doneout_s='1';
      end loop;
--      sync_s <= '1';
--      wait for cyclesys_c;
--      sync_s <= '0';
--      wait for 4000*cyclesys_c;
--      sync_s <= '1';
--      wait for cyclesys_c;
--      sync_s <= '0';
    end if;
    
    if test_enable(7)='1' then
      -- exercise wait request
      -- wait for output data
      wait until convvalidout_s='1';
      wait for 10*cyclesys_c;
      convwaitreq_s <= '1';
      wait for 10000*cyclesys_c;
      convwaitreq_s <= '0';
      
      for i in 0 to 4 loop
        wait for 1000*cyclesys_c;
        convwaitreq_s <= '1';
        wait for 1000*cyclesys_c;
        convwaitreq_s <= '0';
      end loop;
      
      wait for 2500*cyclesys_c;
        convwaitreq_s <= '1';
      wait for 13095*cyclesys_c;
        convwaitreq_s <= '0';
        
      wait for 7246*cyclesys_c;
        convwaitreq_s <= '1';
      wait for 13095*cyclesys_c;
        convwaitreq_s <= '0';
        
      wait for 3625*cyclesys_c;
        convwaitreq_s <= '1';
      wait for 16720*cyclesys_c;
        convwaitreq_s <= '0';
        
      wait for 9077*cyclesys_c;
        convwaitreq_s <= '1';
      wait for 16720*cyclesys_c;
        convwaitreq_s <= '0';
        
      wait until conv_doneout_s='1';
    end if;
        
    if test_enable(8)='1' then
      -- check loop num 1 to 5
      for i in 1 to 5 loop
        rptnum_s <= std_logic_vector(to_unsigned(i,rptbits_c+1));
        sync_s <= '0';
        wait for cyclesys_c;
        sync_s <= '1';
        wait for cyclesys_c;
        sync_s <= '0';
        
        conv_enable_s <= '1';
        while conv_doneout_s='0' loop
          wait for cyclesys_c;
        end loop;
        conv_enable_s <= '0';
        wait for 100*cyclesys_c;
        
      end loop;

    end if;
    wait for 2*cyclesys_c;
    ---------------------------------------------------------------------------------------------------        
    testbench_passed_v := not(testfail_s or mcfail_v);
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
    test_finished <= true;
    wait;
  end process main;
      
end bhv;