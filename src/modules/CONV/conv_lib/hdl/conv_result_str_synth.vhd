----------------------------------------------------------------------------
-- Module Name:  CONV_RESULT_STR
--
-- Source Path:  conv_result_str_synth.vhd
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
architecture synth of conv_result_str is

  type ram_t is array (0 to depth_g*pages_g-1) of std_logic_vector(dbits_g-1 downto 0);
  signal datastore_s       : ram_t;
  signal wraddr_s          : unsigned(abits_g-1 downto 0);         
  signal wrpage_s          : unsigned(pgbits_g-1 downto 0);         
  signal ramwren_s         : std_logic;
  signal ramwrdata_s       : std_logic_vector(dbits_g-1 downto 0);
  signal ramwraddr_s       : unsigned(abits_g+pgbits_g-1 downto 0);         
  signal validout_s        : std_logic;
  signal rdaddr_s          : unsigned(abits_g-1 downto 0);
  signal rdpage_s          : unsigned(pgbits_g-1 downto 0);
  signal ramrddata_s       : std_logic_vector(dbits_g-1 downto 0);
  signal ramrddata1_s      : std_logic_vector(dbits_g-1 downto 0);
  signal ramrdaddr_s       : unsigned(abits_g+pgbits_g-1 downto 0);
  signal eof_s             : std_logic;
  signal full_s            : std_logic;
  signal lastpage_s        : std_logic;
    
begin

  assign_lastpage: lastpage_s <= '1' when wrpage_s>=pages_g-1 and rdpage_s=0 else
                                 '1' when wrpage_s<pages_g-1 and wrpage_s+1=rdpage_s else
                                 '0';
                                 
  assign_availout: AVAILOUT <= '1' when rdpage_s/=wrpage_s else
                               '1' when full_s='1' else
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
      -- overflow signal is transitary, so initially clear signal
      OVERFLOW <= '0';
      -- overflow is reported when full and another word is written
      if full_s='1' and ramwren_s='1' then
        OVERFLOW <= '1';
      end if;
      
      -- full when last page written
      if lastpage_s='1' and eof_s='1' then
        full_s <= '1';
      end if;
      
      -- clear full and overflow flags at the end of every page read
      -- assuming read can be to same address as write (old data), as overflow is still cleared
      if RDEN='1' and RDEOF='1' then
        full_s <= '0';
        OVERFLOW <= '0';
      end if;
      
    end if;
  end process status;
  
  -- WRITE SIDE
    
  --------------------------------------------------------------------------
  -- write data
  -- maintain write address
  --------------------------------------------------------------------------
  writestore : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      wraddr_s <= (others => '0');
      wrpage_s <= (others => '0');
      eof_s <= '0';
      DONEOUT <= '0';
      READYOUT <= '0';
    elsif rising_edge(CLK_SYS) then
    
      eof_s <= '0';
      DONEOUT <= '0';
      
      -- deassert ready when last page
      if lastpage_s='1' or full_s='1' then
          READYOUT <= '0';
      -- otherwise ready
      else
        READYOUT <= '1';
      end if;
      
      -- start address at zero for sof and then increment before each write
      if VALID='1' then
        eof_s <= EOF;
        if SOF='1' then
          wraddr_s <= (others => '0');
          -- stop when page full
        elsif (not wraddr_s)/=0 then
          wraddr_s <= wraddr_s + 1;
        end if;
      end if;
      
      -- eof indicates page finished, increment page after last write
      if eof_s='1' then
        DONEOUT <= '1';
        wraddr_s <= (others => '0');
        -- maintain write page count
        -- top bit toggles and others are cleared when pages_g reached
        if wrpage_s>=pages_g-1 then
          wrpage_s <= (others => '0');
        else
          wrpage_s <= wrpage_s + 1;
        end if;
      end if;
      
      -- reset on sync
      if SYNC='1' then
        wraddr_s <= (others => '0');
        wrpage_s <= (others => '0');
        eof_s <= '0';
        DONEOUT <= '0';
      end if;
          
    end if;
  end process writestore;
    
  --------------------------------------------------------------------------
  -- Retime write data
  --------------------------------------------------------------------------
  writedata : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      ramwrdata_s <= (others => '0');
      ramwren_s <= '0';
    elsif rising_edge(CLK_SYS) then
      
      ramwrdata_s <= DATA;
      ramwren_s <= VALID;
      
    end if;
  end process writedata;
  
  assign_ramwraddr: ramwraddr_s <= wrpage_s & wraddr_s;
  --------------------------------------------------------------------------
  -- store frame
  --------------------------------------------------------------------------
  wrstore : process (CLK_SYS,RST_SYS_N)
  begin
    if rising_edge(CLK_SYS) then
      if ramwren_s='1' then
        datastore_s(to_integer(ramwraddr_s)) <= ramwrdata_s;
      end if;
    end if;
    if RST_SYS_N='0' then
--      datastore_s <= (others => (others => '0'));
    end if;
  end process wrstore;
  
  
  -- READ SIDE
  
  assign_dataout: DATAOUT <= ramrddata1_s;
  
  --------------------------------------------------------------------------
  -- read counts
  -- maintain read page address
  --------------------------------------------------------------------------
  readcount : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      rdpage_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      -- check if read
      if RDEN='1' then
        -- increment page after last read
        if RDEOF='1' then
          if rdpage_s>=pages_g-1 then
            rdpage_s <= (others => '0');
          else
            rdpage_s <= rdpage_s + 1;
          end if;
        end if;
      end if;
      
      -- reset on sync
      if SYNC='1' then
        rdpage_s <= (others => '0');
      end if;
      
    end if;
  end process readcount;
  
  assign_ramrdaddr: ramrdaddr_s <= rdpage_s & unsigned(RDADDR);
  --------------------------------------------------------------------------
  -- RAM read (infer ram with registered outputs)
  --------------------------------------------------------------------------
  rdstore  : process (CLK_SYS)
  begin
    if rising_edge(CLK_SYS) then
    
      if RDEN='1' then
        ramrddata_s <= datastore_s(to_integer(ramrdaddr_s));
      end if;
      
      ramrddata1_s <= ramrddata_s;
      
    end if;
  end process rdstore;
  
  
end synth;