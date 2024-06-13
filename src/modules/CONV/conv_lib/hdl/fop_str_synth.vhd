----------------------------------------------------------------------------
-- Module Name:  FOP_STR
--
-- Source Path:  fop_str_synth.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     09/06/2017  Initial revision.
-- 0.2  JT     11/10/2018  conv_doneout_s latched until last bin read
-- 0.3  JT     20/02/2019  Added delay for Row 0 results
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2019 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of fop_str is

  type data_array_t is array (delay_g+2 downto 1) of std_logic_vector(ddr_g*512-1 downto 0);
  signal data_sr_s         : data_array_t;
  type addr_array_t is array (delay_g+2 downto 1) of unsigned(3-ddr_g downto 0);
  signal addrcnt_sr_s      : addr_array_t;
  signal validout_s        : std_logic;
  signal ready_s           : std_logic;
  signal read_s            : std_logic;
  signal read1_s           : std_logic;
  signal rden_s            : std_logic;
  signal poscnt_s          : unsigned(delaybits_g-1 downto 0);
  signal rden_sr_s         : std_logic_vector(delay_g+1 downto 1);
  type wordcnt_array_t is array (delay_g+1 downto 1) of unsigned(3-ddr_g downto 0);
  signal wordcnt_sr_s      : wordcnt_array_t;
  signal doneout_s         : std_logic;
  signal conv_doneout_s    : std_logic;
  signal wordcnt_s         : unsigned(3-ddr_g downto 0);
  signal words_s           : unsigned(3-ddr_g downto 0);
  signal smplcnt_s         : unsigned(abits_g-1 downto 0);
  signal bincnt_s          : unsigned(fop_num_bits_g downto 0);
  signal ifft_loop_s       : unsigned(ifft_loop_bits_g downto 0);
    
begin

  assign_validout: DDR_VALIDOUT <= validout_s;
  assign_doneout: DONEOUT <= doneout_s;
  assign_ready: ready_s <= not DDR_WAITREQ;
  
  assign_rden: rden_s <= (ready_s or not validout_s) and read_s and CONV_ENABLE;
  
  
  --------------------------------------------------------------------------
  -- read counts
  -- maintain read address
  -- latch read
  --------------------------------------------------------------------------
  readcount : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      read_s <= '0';
      read1_s <= '0';
      rden_sr_s <= (others => '0');
      ifft_loop_s <= (others => '0');
      wordcnt_sr_s <= (others => (others => '0'));
      wordcnt_s <= (others => '0');
      words_s <= (others => '1');
      smplcnt_s <= (others => '0');
      bincnt_s <= (others => '0');
      doneout_s <= '0';
      conv_doneout_s <= '0';
      CONV_DONEOUT <= '0';
    elsif rising_edge(CLK_SYS) then
      -- ensure ifft_loop_num remains in range 1 to ifft_loop_num_g
      if unsigned(IFFT_LOOP_NUM)<1 then
        ifft_loop_s <= to_unsigned(1,ifft_loop_bits_g+1);
      elsif unsigned(IFFT_LOOP_NUM)>ifft_loop_g then
        ifft_loop_s <= to_unsigned(ifft_loop_g,ifft_loop_bits_g+1);
      else
        ifft_loop_s <= unsigned(IFFT_LOOP_NUM);
      end if;
      -- default
      doneout_s <= '0';
      CONV_DONEOUT <= '0';
      read1_s <= read_s;
      -- delay read enable to match RAM turn around time
      rden_sr_s <= rden_sr_s(delay_g downto 1) & rden_s;
      -- delay word address to match RAM turn around time
      wordcnt_sr_s <= wordcnt_sr_s(delay_g downto 1) & wordcnt_s;
      -- check if read required
      if rden_s='1' then
        -- check if any more words are needed
        if ('0'&wordcnt_s+1)*ddr_g*14<2*ifft_g*to_integer(ifft_loop_s) then
          wordcnt_s <= wordcnt_s + 1;
        else
          -- store number of words sent (minus 1)
          words_s <= wordcnt_s;
          wordcnt_s <= (others => '0');
          -- increment sample count
          if (not smplcnt_s)/=0 then
            smplcnt_s <= smplcnt_s + 1;
          else
            -- when complete, end read and raise segment done flag
            read_s <= '0';
            doneout_s <= '1';
          end if;
        end if;
      end if;
      -- begin read when data available
      if read_s='0' and read1_s='0' and AVAIL='1' then
        -- begin read, set sample count to overlap position
        read_s <= '1';
        smplcnt_s <= unsigned(OVERLAP_SIZE);
      end if;
      
      -- bincnt and pagecnt are maintained at data output
      if (validout_s='0' or ready_s='1') and poscnt_s/=0 then
        if addrcnt_sr_s(to_integer(poscnt_s))>=words_s then
          -- increment bin count
          if bincnt_s<('0' & unsigned(FOP_NUM)) then
            bincnt_s <= bincnt_s + 1;
          else
            -- on last bin, set conv_done flag, clear bin count and increment page count
            conv_doneout_s <= '1';
            bincnt_s <= (others => '0');
          end if;
        end if;
      end if;
      -- raise conv done and clear flag when last bin read
      if validout_s='1' and ready_s='1' and conv_doneout_s='1' then
        CONV_DONEOUT <= '1';
        conv_doneout_s <= '0';
      end if;
      -- clear counters and status on sync
      if SYNC='1' then
        read_s <= '0';
        rden_sr_s <= (others => '0');
        wordcnt_s <= (others => '0');
        words_s <= (others => '1');
        smplcnt_s <= (others => '0');
        bincnt_s <= (others => '0');
      end if;
      
    end if;
  end process readcount;
  
  --------------------------------------------------------------------------
  -- output control signals
  -- respond to demand as indicated by ready signal
  --------------------------------------------------------------------------
  ctrlout : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      RDADDROUT <= (others => '0');
      RDADDR0OUT <= (others => '0');
      RDENOUT <= (others => '0');
      RDEOFOUT <= '0';
    elsif rising_edge(CLK_SYS) then
      RDADDROUT <= std_logic_vector(smplcnt_s);
      RDADDR0OUT <= std_logic_vector(smplcnt_s - unsigned(ROW0_DELAY));
      RDENOUT <= (others => '0');
      RDEOFOUT <= '0';
      -- check if read required
      if rden_s='1' then
        -- pattern of read requests depends on word count
        if wordcnt_s=0 then
          RDENOUT(0) <= '1';
        end if;
        for j in 1 to ddr_g*14 loop
          if wordcnt_s*ddr_g*14+j<=2*ifft_g*to_integer(ifft_loop_s) then
            RDENOUT(to_integer(wordcnt_s)*ddr_g*14+j) <= '1';
          end if;
        end loop;
        -- on last word, raise read eof resquest
        if (not smplcnt_s)=0 then
          RDEOFOUT <= '1';
        end if;
      end if;
      if SYNC='1' then
        RDENOUT <= (others => '0');
        RDEOFOUT <= '0';
      end if;

    end if;
  end process ctrlout;
  
  --------------------------------------------------------------------------
  -- delay data
  -- shift register
  --------------------------------------------------------------------------
  delaydata : process (CLK_SYS,RST_SYS_N)
    variable wordcnt_v : unsigned(3-ddr_g downto 0);
  begin
    if RST_SYS_N='0' then
      data_sr_s <= (others => (others => '0'));
      addrcnt_sr_s <= (others => (others => '0'));
    elsif rising_edge(CLK_SYS) then

      -- default
      wordcnt_v := wordcnt_sr_s(delay_g+1);
      
      -- check if delayed read enable indicates read data available
      if rden_sr_s(delay_g+1)='1' then
        -- delay data for use in output data
        data_sr_s(delay_g+2 downto 2) <= data_sr_s(delay_g+1 downto 1);
        -- load shift register 
        -- data is arranged according to delayed word count
        if wordcnt_sr_s(delay_g+1)=0 then
          data_sr_s(1)(31 downto 0) <= RDDATA(31 downto 0);
          data_sr_s(1)(63 downto 32) <= RDDATA(31 downto 0);
        else
          data_sr_s(1)(63 downto 0) <= (others => '0');
        end if;
        for i in 0 to ddr_g-1 loop
          for j in 1 to 14 loop
            if wordcnt_v*ddr_g*14+i*14+j<=2*ifft_g*to_integer(ifft_loop_s) then
              data_sr_s(1)((i*16+j+2)*32-1 downto (i*16+j+1)*32) <= RDDATA((to_integer(wordcnt_v)*ddr_g*14+i*14+j+1)*32-1 downto (to_integer(wordcnt_v)*ddr_g*14+i*14+j)*32);
            end if;
          end loop;
        end loop;
        
        -- delay word count for use in output address
        addrcnt_sr_s(delay_g+2 downto 2) <= addrcnt_sr_s(delay_g+1 downto 1);
        addrcnt_sr_s(1) <= wordcnt_v;

      end if;
      
    end if;
  end process delaydata;
  
  --------------------------------------------------------------------------
  -- fifo control
  -- up/down counter for use as position indicator
  --------------------------------------------------------------------------
  fifoctrl : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      poscnt_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      
      -- if delayed read enable indicates new read data available
      if rden_sr_s(delay_g+1)='1' then
        -- increment if no read currently in progress
        if poscnt_s=0 then
          poscnt_s <= poscnt_s + 1;
        elsif ready_s='0' and validout_s='1'then
          if (not poscnt_s)/=0 then
            poscnt_s <= poscnt_s + 1;
          end if;
        end if;
      -- if no new data
      elsif ready_s='1' or validout_s='0' then
        -- decrement if read currently in progress
        if poscnt_s/=0 then
          poscnt_s <= poscnt_s - 1;
        end if;
      end if;
      -- on sync, reset position
      if SYNC='1' then
        poscnt_s <= (others => '0');
      end if;
    end if;
  end process fifoctrl;
  
  --------------------------------------------------------------------------
  -- DDR data output
  -- respond to demand as indicated by ready signal
  --------------------------------------------------------------------------
  ddrout : process (CLK_SYS,RST_SYS_N)
    variable wordcnt_v : unsigned(3-ddr_g downto 0);
    variable ddr_addr_v : unsigned(25 downto 0);
  begin
    if RST_SYS_N='0' then
      DDR_ADDROUT <= (others => '0');
      DDR_DATAOUT <= (others => '0');
      validout_s <= '0';
    elsif rising_edge(CLK_SYS) then
      ddr_addr_v := (others =>'0');
      -- check if new data required
      if (ready_s='1' or validout_s='0') then
        DDR_ADDROUT <= (others => '0');
        DDR_DATAOUT <= (others => '0');
        validout_s <= '0';
        -- check if new data available
        if poscnt_s/=0 then
          validout_s <= '1';
          -- output DDR address
          wordcnt_v := addrcnt_sr_s(to_integer(poscnt_s));
          ddr_addr_v(fop_num_bits_g+3-ddr_g downto 0) := bincnt_s(fop_num_bits_g-1 downto 0) & wordcnt_v;
          ddr_addr_v := ddr_addr_v + unsigned(PAGE_START);
          DDR_ADDROUT <= std_logic_vector(ddr_addr_v);
          -- output DDR data
          DDR_DATAOUT <= data_sr_s(to_integer(poscnt_s));
          -- for diagnostic purposes insert address without page into unused data
          if unsigned(wordcnt_v)/=0 then
            DDR_DATAOUT(3-ddr_g downto 0) <= std_logic_vector(wordcnt_v);
            DDR_DATAOUT(fop_num_bits_g+3-ddr_g downto 4-ddr_g) <= std_logic_vector(bincnt_s(fop_num_bits_g-1 downto 0));
          end if;
            
        end if;
      end if;
      
    end if;
  end process ddrout;
  

    
end synth;