----------------------------------------------------------------------------
-- Module Name:  CONV_IFFT
--
-- Source Path:  conv_ifft.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    16/05/2022  Initial revision.
-- 0.2  JT    28/09/2023  Check for exponent roll under
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

architecture synth of conv_ifft is

  signal rst_sys_n_d1   : std_logic;
  signal sync_d1        : std_logic;
  signal ifftdatain_s   : std_logic_vector(63 downto 0);
  signal ifftdataout_s  : std_logic_vector(63 downto 0);
  signal rdataout_s     : std_logic_vector(31 downto 0);
  signal idataout_s     : std_logic_vector(31 downto 0);
  signal ifftvalidin_s  : std_logic;
  signal ifftvalidout_s : std_logic;
  signal validout_s     : std_logic;
  signal validout1_s    : std_logic;
  signal readyout_s     : std_logic;

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
  -- IFFT input side
  --------------------------------------------------------------------------

  --------------------------------------------------------------------------
  -- FFT input retime
  -- retime IFFT input signals
  --------------------------------------------------------------------------
  retime_in : process(CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      ifftdatain_s <= (others => '0');
      ifftvalidin_s <= '0';
    elsif rising_edge(CLK_SYS) then
      ifftdatain_s <= IDATA & RDATA;
      ifftvalidin_s <= VALID;
      if sync_d1='1' then
        ifftvalidin_s <= '0';
      end if;
    end if;
  end process retime_in;

  
  ifft_i : entity ifft1024.ifft1024
  port map (
    clk              => CLK_SYS,         --    clk.clk
    rst              => rst_sys_n_d1,    --    rst.reset_n
    validIn(0)       => ifftvalidin_s,   --   sink.sink_valid
    channelIn        => (others => '0'),
    d                => ifftdatain_s,    --       .sink_data
    validOut(0)      => ifftvalidout_s,  -- source.source_valid
    channelOut       => open,
    q                => ifftdataout_s    --       .source_data
  );

  --------------------------------------------------------------------------
  -- IFFT output side
  --------------------------------------------------------------------------

  --------------------------------------------------------------------------
  -- Scale floating point IFFT data
  --------------------------------------------------------------------------
  scaleifft : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      rdataout_s <= (others => '0');
      idataout_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      rdataout_s <= ifftdataout_s(31 downto 0);
      idataout_s <= ifftdataout_s(63 downto 32);
      -- scale floating point data, 10 is subtracted from exponent
      RDATAOUT(31) <= rdataout_s(31);
      -- check for exponent roll under
      if unsigned(rdataout_s(30 downto 23))<10 then 
        RDATAOUT <= (others => '0');
      else
        RDATAOUT(30 downto 23) <= std_logic_vector(unsigned(rdataout_s(30 downto 23))-10);
        RDATAOUT(22 downto 0) <= rdataout_s(22 downto 0);
      end if;
      IDATAOUT(31) <= idataout_s(31);
      -- check for exponent roll under
      if unsigned(idataout_s(30 downto 23))<10 then 
        IDATAOUT <= (others => '0');
      else
        IDATAOUT(30 downto 23) <= std_logic_vector(unsigned(idataout_s(30 downto 23))-10);
        IDATAOUT(22 downto 0) <= idataout_s(22 downto 0);
      end if;
    end if;
  end process scaleifft;

  --------------------------------------------------------------------------
  -- Control Signal generate
  -- generate control output signals
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
      validout_s <= ifftvalidout_s;
      validout1_s <= validout_s;
      -- generate SOF on rising edge of IFFT output valid signal
      if validout_s='1' and validout1_s='0' then
        SOFOUT <= '1';
      end if;
      -- generate EOF on falling edge of valid signal
      if ifftvalidout_s='0' and validout_s='1' then
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


end architecture synth; -- of conv_ifft
