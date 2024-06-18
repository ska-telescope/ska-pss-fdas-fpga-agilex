----------------------------------------------------------------------------
-- Module Name:  CONV_FFT
--
-- Source Path:  conv_fft.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/05/2022  Initial revision.
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
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------

architecture synth of conv_fft is

  signal rst_sys_n_d1  : std_logic;
  signal sync_d1       : std_logic;
  signal fftdatain_s   : std_logic_vector(63 downto 0);
  signal fftvalidin_s  : std_logic;
  signal fftdataout_s  : std_logic_vector(63 downto 0);
  signal dataout_s     : std_logic_vector(63 downto 0);
  signal fftvalidout_s : std_logic;
  signal validout_s    : std_logic;
  signal validout1_s   : std_logic;
  signal readyout_s    : std_logic;

  constant fftpts_c : std_logic_vector(10 downto 0) := std_logic_vector(to_unsigned(ptsnum_g,11));

begin

  -- Locally retime reset to reduce load.
  rst_retime : process
  begin
    wait until rising_edge(CLK_SYS);
    rst_sys_n_d1 <= RST_SYS_N and not SYNC;
  end process rst_retime;
  
  --------------------------------------------------------------------------
  -- Reime SYNC to match delay to ifft reset
  --------------------------------------------------------------------------
  sync_retime : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      sync_d1 <= '0';
    elsif rising_edge(CLK_SYS) then
      sync_d1 <= SYNC;
    end if;
  end process sync_retime;

  --------------------------------------------------------------------------
  -- FFT input side
  --------------------------------------------------------------------------

  --------------------------------------------------------------------------
  -- FFT input retime
  -- retime FFT input signals
  -- validin is qualified with readyout
  --------------------------------------------------------------------------
  retime_in : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      fftdatain_s <= (others => '0');
      fftvalidin_s <= '0';
    elsif rising_edge(CLK_SYS) then
      fftdatain_s <= IDATA & RDATA;
      fftvalidin_s <= VALID and readyout_s;
      if sync_d1='1' then
        fftvalidin_s <= '0';
      end if;
    end if;
  end process retime_in;
    
  fft_i_0 : entity fft1024.fft1024
  port map (
    clk              => CLK_SYS,      --    clk.clk
    rst              => rst_sys_n_d1, --    rst.reset_n
    validIn(0)       => fftvalidin_s, --   sink.sink_valid
    channelIn        => (others => '0'),
    d                => fftdatain_s,  --       .sink_data
    validOut(0)      => fftvalidout_s,-- source.source_valid
    channelOut       => open,
    q                => fftdataout_s  --       .source_data
  );

  --------------------------------------------------------------------------
  -- FFT output side
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  -- FFT output retime
  -- retime FFT output signals (2 stages)
  --------------------------------------------------------------------------
  retime_op : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      dataout_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      dataout_s <= fftdataout_s;
      RDATAOUT <= dataout_s(31 downto 0);
      IDATAOUT <= dataout_s(63 downto 32);
    end if;
  end process retime_op;

  --------------------------------------------------------------------------
  -- Control Signal generate
  -- generate SOF and EOF output signals
  --------------------------------------------------------------------------
  ctrl_gen : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      SOFOUT <= '0';
      EOFOUT <= '0';
      validout_s <= '0';
      validout1_s <= '0';
    elsif rising_edge(CLK_SYS) then
      SOFOUT <= '0';
      EOFOUT <= '0';
      validout_s <= fftvalidout_s;
      validout1_s <= validout_s;
      -- generate SOF on rising edge of FFT output valid signal
      if validout_s='1' and validout1_s='0' then
        SOFOUT <= '1';
      end if;
      -- generate EOF on falling edge of valid signal
      if fftvalidout_s='0' and validout_s='1' then
        EOFOUT <= '1';
      end if;
      if sync_d1='1' then
        SOFOUT <= '0';
        EOFOUT <= '0';
        validout_s <= '0';
        validout1_s <= '0';
      end if;
    end if;
  end process ctrl_gen;
  
  assign_validout: VALIDOUT <= validout1_s;
  assign_readyout: READYOUT <= readyout_s;

  --------------------------------------------------------------------------
  -- Ready Signal generate
  -- generate ready output signal
  --------------------------------------------------------------------------
  ready_gen : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      readyout_s <= '0';
    elsif rising_edge(CLK_SYS) then
      -- ensure readyout is de-asserted at the end of a block of input data
      if EOF='1' and VALID='1' then
        readyout_s <= '0';
      -- assert readyout when ready is asserted
      elsif READY='1' then
        readyout_s <= '1';
      -- only deassert readyout when input data is not valid.
      elsif VALID='0' then
        readyout_s <= '0';
      end if;
      if sync_d1='1' then
        readyout_s <= '0';
      end if;
      
    end if;
  end process ready_gen;

end architecture synth; -- conv_fft
