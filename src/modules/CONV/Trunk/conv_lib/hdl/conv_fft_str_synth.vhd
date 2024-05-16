----------------------------------------------------------------------------
-- Module Name:  CONV_FFT_STR
--
-- Source Path:  conv_fft_str_synth.vhd
--
-- Description:  
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     18/05/2017  Initial revision.
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
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of conv_fft_str is

  type ram_t is array (0 to depth_g*pages_g-1) of std_logic_vector(dbits_g-1 downto 0);
  signal rdatastore_s      : ram_t;
  signal idatastore_s      : ram_t;
  signal rdyout_s          : std_logic;
  signal wraddr_s          : unsigned(abits_g-1 downto 0);         
  signal wraddr_ordered_s  : unsigned(abits_g-1 downto 0);         
  signal wrpage_s          : unsigned(pgbits_g-1 downto 0);         
  signal ramwren_s         : std_logic;
  signal ramwrrdata_s      : std_logic_vector(dbits_g-1 downto 0);
  signal ramwridata_s      : std_logic_vector(dbits_g-1 downto 0);
  signal ramwraddr_s       : unsigned(abits_g+pgbits_g-1 downto 0);         
  signal validout_s        : std_logic;
  signal rden_s            : std_logic;
  signal rden1_s           : std_logic;
  signal rdaddr_s          : unsigned(abits_g-1 downto 0);
  signal rdaddr_ordered_s  : unsigned(abits_g-1 downto 0);
  signal rdpage_s          : unsigned(pgbits_g-1 downto 0);
  signal ramrdrdata_s      : std_logic_vector(dbits_g-1 downto 0);
  signal ramrdidata_s      : std_logic_vector(dbits_g-1 downto 0);
  signal ramrdaddr_s       : unsigned(abits_g+pgbits_g-1 downto 0);
  signal rdrptcnt_s        : unsigned(loop_bits_g-1 downto 0);
  signal rdrptcnt1_s       : unsigned(loop_bits_g-1 downto 0);
  signal coef_rden_s       : std_logic_vector(loop_g-1 downto 0);
  signal coef_rdaddr_s     : std_logic_vector(abits_g-1 downto 0);
  signal sofout1_s         : std_logic;
  signal eofout1_s         : std_logic;
  signal done_s            : std_logic;
  signal doneout_s         : std_logic;
  signal mcrdaddr_s        : unsigned(abits_g+pgbits_g-1 downto 0);
  signal mcpage_s          : unsigned(pgbits_g-1 downto 0);
  signal mcrdataout_s      : std_logic_vector(dbits_g-1 downto 0);
  signal mcidataout_s      : std_logic_vector(dbits_g-1 downto 0);
  signal lastpage_s        : std_logic;
  signal full_s            : std_logic;
  
begin

  assign_lastpage: lastpage_s <= '1' when wrpage_s>=pages_g-1 and rdpage_s=0 else
                                 '1' when wrpage_s<pages_g-1 and wrpage_s+1=rdpage_s else
                                 '0';
  -- STORE STATUS
  --------------------------------------------------------------------------
  -- maintain full flag
  --------------------------------------------------------------------------
  status : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      full_s <= '0';
      OVERFLOW <= '0';
    elsif rising_edge(CLK_SYS) then
      -- initially clear overflow signal
      OVERFLOW <= '0';
      -- overflow is reported when full and another word is written
      if full_s='1' and VALID='1' then
        OVERFLOW <= '1';
      end if;
      
      -- full when last page written
      if lastpage_s='1' and EOF='1' and VALID='1' then
        full_s <= '1';
      end if;
      
      -- clear full and overflow flags at the end of every page read i.e. when all repeats finished
      -- assuming read can be to same address as write and get old correct data, as overflow is still cleared
      if rden_s='1' and rdaddr_s=depth_g-1 and (rdrptcnt_s=loop_g-1 or '0'&rdrptcnt_s=unsigned(LOOP_NUM)-1) then
        full_s <= '0';
        OVERFLOW <= '0';
      end if;
      
    end if;
  end process status;

  -- WRITE SIDE
  
  assign_readyout: READYOUT <= rdyout_s;
  assign_doneout: DONEOUT <= doneout_s;
  
  --------------------------------------------------------------------------
  -- write data
  -- maintain write address
  --------------------------------------------------------------------------
  writestore : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      wraddr_s <= (others => '0');
      wrpage_s <= (others => '0');
      mcpage_s <= (others => '0');
      rdyout_s <= '0';
      done_s <= '0';
      doneout_s <= '0';
    elsif rising_edge(CLK_SYS) then
      -- start with doneout set to done
      doneout_s <= done_s;
    
      -- only ready if not full and not writing to last page and doneout is inactive
      -- or if doneout is active then page not being read by micro
--      if full_s='0' and (lastpage_s='0' or VALID='0') and (doneout_s='0' or wrpage_s/=mcpage_s) then
--      if full_s='0' and (wrpage_s=rdpage_s) and (doneout_s='0' or wrpage_s/=mcpage_s) then
      -- when 3 pages available
      if full_s='0' and
         ((wrpage_s>=rdpage_s and wrpage_s-rdpage_s<=pages_g-3) or
          (wrpage_s<rdpage_s and rdpage_s-wrpage_s>=3)) and
         (doneout_s='0' or wrpage_s/=mcpage_s) then
        rdyout_s <= '1';
      else
        rdyout_s <= '0';
      end if;
      
      -- write enabled
      if VALID='1' then
        if EOF='1' then
          wraddr_s <= (others => '0');
          -- maintain write page count
          -- count cleared when pages_g reached
          if wrpage_s>=pages_g-1 then
            wrpage_s <= (others => '0');
          else
            wrpage_s <= wrpage_s + 1;
          end if;

          -- done remains set until reset or sync
          done_s <= '1';
          -- doneout is set high but will be forced low if conv_enable is high
          doneout_s <= '1';
          -- if not doing MC read, set mcpage to last write page
          if doneout_s='0' then
            mcpage_s <= wrpage_s;
          end if;
        -- stop when page full
        elsif (not wraddr_s)/=0 then
          wraddr_s <= wraddr_s + 1;
        end if;
      end if;
      
      -- doneout only asserted if conv_enable is inactive
      if CONV_ENABLE='1' then
        doneout_s <= '0';
      end if;
      
      -- reset on sync
      if SYNC='1' then
        wraddr_s <= (others => '0');
        wrpage_s <= (others => '0');
        mcpage_s <= (others => '0');
        done_s <= '0';
      end if;

    end if;
  end process writestore;

  -- Write address order
  -- natural
--  assign_wraddr_ordered: wraddr_ordered_s <= wraddr_s;
  -- digit reversed
--  wrorder: for i in 0 to abits_g/2-1 generate
--    assign_wraddr_ordered: wraddr_ordered_s(i*2+1 downto i*2) <= wraddr_s((abits_g/2-1-i)*2+1 downto (abits_g/2-1-i)*2);
--  end generate;
  -- bit reversed
  wrorder: for i in 0 to abits_g-1 generate
    assign_wraddr_ordered: wraddr_ordered_s(i) <= wraddr_s(abits_g-1-i);
  end generate;
  
  --------------------------------------------------------------------------
  -- Retime write data
  --------------------------------------------------------------------------
  writedata : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      ramwrrdata_s <= (others => '0');
      ramwridata_s <= (others => '0');
      ramwraddr_s <= (others => '0');
      ramwren_s <= '0';
    elsif rising_edge(CLK_SYS) then
      
      ramwrrdata_s <= RDATA;
      ramwridata_s <= IDATA;
      ramwraddr_s <= wrpage_s & wraddr_ordered_s;
      ramwren_s <= '0';
      
      if VALID='1' then
        ramwren_s <= '1';
      end if;
    end if;
  end process writedata;
  
  --------------------------------------------------------------------------
  -- store frame
  --------------------------------------------------------------------------
  wrstore : process (CLK_SYS,RST_SYS_N)
  begin
    if rising_edge(CLK_SYS) then
    
      if ramwren_s='1' then
        rdatastore_s(to_integer(ramwraddr_s)) <= ramwrrdata_s;
        idatastore_s(to_integer(ramwraddr_s)) <= ramwridata_s;
      end if;
    end if;
    if RST_SYS_N='0' then
--      datastore_s <= (others => (others => '0'));
    end if;
  end process wrstore;
  
  
  -- READ SIDE
  
  assign_validout: VALIDOUT <= validout_s;
  
  --------------------------------------------------------------------------
  -- read store
  -- generate read enable for internally stored data and coef store
  -- each page is read repeatedly
  -- once a repeat read sequence has started it must continue to completion
  -- takes precautions to avoid stopping within a sequence
  --------------------------------------------------------------------------
  readstore : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      rden_s <= '0';
      coef_rden_s <= (others => '0');
      coef_rdaddr_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
    
      coef_rdaddr_s <= std_logic_vector(rdaddr_ordered_s);
      coef_rden_s <= (others => '0');
      coef_rden_s(to_integer(rdrptcnt_s)) <= rden_s;
      
      -- generate read enable
      -- begin reading page repeatedly
      -- after start, read remains enabled until all repeats have finished
      -- before starting, data available and ready signal are checked
      
      -- start of repeat sequence
      if rdaddr_s=0 and rdrptcnt_s=0 then
        -- read enabled when page addresses indicate not empty and ready='1'
        if rdpage_s/=wrpage_s or full_s='1' then
          rden_s <= READY(to_integer(unsigned(LOOP_NUM)-1));
        else
          rden_s <= '0';
        end if;
      -- stop at end of each repeat
      elsif rdaddr_s=depth_g-1 then
        -- once started sequence must continue to completion
        if rden_s='0' then
          rden_s <= '1';
        else
          rden_s <= '0';
        end if;
      -- once started sequence must continue to completion
      else
        rden_s <= '1';
      end if;
      
      -- reset on sync
      if SYNC='1' then
        rden_s <= '0';
      end if;
      
    end if;
  end process readstore;
    
  -- coeficient address
  assign_coefrdaddr: COEF_RDADDROUT <= coef_rdaddr_s;
  assign_coefrden: COEF_RDENOUT <= coef_rden_s;
  
  --------------------------------------------------------------------------
  -- read counts
  -- maintain read address
  -- maintain read repeat counter
  -- maintain read page address
  -- generate SOF and EOF for read data
  -- Each page is read repeatedly the lesser of loop_g and LOOP_NUM times 
  -- before moving to next page
  --------------------------------------------------------------------------
  readcount : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      sofout1_s <= '0';
      eofout1_s <= '0';
      rden1_s <= '0';
      rdaddr_s <= (others => '0');
      rdpage_s <= (others => '0');
      rdrptcnt_s <= (others => '0');
      rdrptcnt1_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      -- enable for RAM output
      rden1_s <= rden_s;
      rdrptcnt1_s <= rdrptcnt_s;
      -- check if read
      if rden_s='1' then
        eofout1_s <= '0';
        sofout1_s <= '0';
        -- last address of page
        if rdaddr_s=depth_g-1 then
          eofout1_s <= '1';
          rdaddr_s <= (others => '0');
          -- last repeat
          if rdrptcnt_s=loop_g-1 or '0'&rdrptcnt_s=unsigned(LOOP_NUM)-1 then
            rdrptcnt_s <= (others => '0');
            -- maintain read page count
            -- count is cleared when pages_g reached
            if rdpage_s>=pages_g-1 then
              rdpage_s <= (others => '0');
            else
              rdpage_s <= rdpage_s + 1;
            end if;
          else
            rdrptcnt_s <= rdrptcnt_s + 1;
          end if;
        else
          rdaddr_s <= rdaddr_s + 1;
        end if;
        if rdaddr_s=0 then
          sofout1_s <= '1';
        end if;
      end if;
      
      -- reset on sync
      if SYNC='1' then
        rden1_s <= '0';
        rdaddr_s <= (others => '0');
        rdpage_s <= (others => '0');
        rdrptcnt_s <= (others => '0');
        rdrptcnt1_s <= (others => '0');
      end if;
      
    end if;
  end process readcount;
  
  -- read address order
  -- natural
--  assign_rdaddr_ordered: rdaddr_ordered_s <= rdaddr_s;
  -- digit reversed
--  rdorder: for i in 0 to abits_g/2-1 generate
--    assign_rdaddr_ordered: rdaddr_ordered_s(i*2+1 downto i*2) <= rdaddr_s((abits_g/2-1-i)*2+1 downto (abits_g/2-1-i)*2);
--  end generate;
  -- bit reversed
  rdorder: for i in 0 to abits_g-1 generate
    assign_rdaddr_ordered: rdaddr_ordered_s(i) <= rdaddr_s(abits_g-1-i);
  end generate;

  
  --------------------------------------------------------------------------
  -- read data out
  --------------------------------------------------------------------------
  readdata : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      SOFOUT <= '0';
      EOFOUT <= '0';
      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      LOOP_ADDROUT <= (others => '0');
      validout_s <= '0';
    elsif rising_edge(CLK_SYS) then

      RDATAOUT <= (others => '0');
      IDATAOUT <= (others => '0');
      SOFOUT <= '0';
      EOFOUT <= '0';
      validout_s <= '0';
      -- check if new read data
      if rden1_s='1' then
        RDATAOUT <= ramrdrdata_s;
        IDATAOUT <= ramrdidata_s;
        LOOP_ADDROUT <= std_logic_vector(rdrptcnt1_s);
        SOFOUT <= sofout1_s;
        EOFOUT <= eofout1_s;
        validout_s <= '1';
      end if;
      
      if SYNC='1' then
        SOFOUT <= '0';
        EOFOUT <= '0';
        RDATAOUT <= (others => '0');
        IDATAOUT <= (others => '0');
        LOOP_ADDROUT <= (others => '0');
        validout_s <= '0';
      end if;

    end if;
  end process readdata;

  assign_ramrdaddr: ramrdaddr_s <= rdpage_s & rdaddr_ordered_s;

  --------------------------------------------------------------------------
  -- RAM read (infer ram with non-registered outputs)
  --------------------------------------------------------------------------
  rdstore  : process (CLK_SYS)
  begin
    if rising_edge(CLK_SYS) then
    
      if rden_s='1' then
        ramrdrdata_s <= rdatastore_s(to_integer(ramrdaddr_s));
        ramrdidata_s <= idatastore_s(to_integer(ramrdaddr_s));
      end if;
      
    end if;
  end process rdstore;
  
  
  assign_mcrdaddr: mcrdaddr_s <= mcpage_s & unsigned(MCADDR(abits_g downto 1));
  --------------------------------------------------------------------------
  -- MCI read store frame
  --------------------------------------------------------------------------
  mcrdstore : process (CLK_MC)
  begin
    if rising_edge(CLK_MC) then
    
      if MCRDEN='1' then
        mcrdataout_s <= rdatastore_s(to_integer(mcrdaddr_s));
        mcidataout_s <= idatastore_s(to_integer(mcrdaddr_s));
      end if;
    end if;
  end process mcrdstore;
  
  assign_mcdataout: MCDATAOUT <= (others => '0') when MCRDEN='0' else
                                 mcrdataout_s when MCADDR(0)='0' else
                                 mcidataout_s;
  
end synth;