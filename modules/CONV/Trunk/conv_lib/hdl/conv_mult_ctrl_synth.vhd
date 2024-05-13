----------------------------------------------------------------------------
-- Module Name:  CONV_MULT_CTRL
--
-- Source Path:  conv_mult_ctrl_synth.vhd
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
architecture synth of conv_mult_ctrl is

  signal validout_s        : std_logic;
  signal rden_s            : std_logic;
  signal rden1_s           : std_logic;
  signal rdaddr_s          : unsigned(abits_g-1 downto 0);
  signal doneout_s         : std_logic;
  signal lastout1_s        : std_logic;

begin

  assign_rden: rden_s <= VALID and READY;
  assign_validout: VALIDOUT <= validout_s;
  assign_rdenout: RDENOUT <= rden_s;
  assign_rdaddrout: RDADDROUT <= std_logic_vector(rdaddr_s);

  --------------------------------------------------------------------------
  -- read counts
  -- maintain read address
  --------------------------------------------------------------------------
  readcount : process (CLK_SYS,RST_SYS_N)
  begin
    if RST_SYS_N='0' then
      lastout1_s <= '0';
      rden1_s <= '0';
      rdaddr_s <= (others => '0');
    elsif rising_edge(CLK_SYS) then
      -- enable for RAM output
      rden1_s <= rden_s;
      -- check if read
      if rden_s='1' then
        lastout1_s <= '0';
        if rdaddr_s=depth_g-1 then
          lastout1_s <= '1';
          rdaddr_s <= (others => '0');
        else
          rdaddr_s <= rdaddr_s + 1;
        end if;
      end if;
      -- sync
      if DM_TRIGGER='1' then
        rdaddr_s <= (others => '0');
        rden1_s <= '0';
        lastout1_s <= '0';
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
      validout_s <= '0';
      LASTOUT <= '0';
    elsif rising_edge(CLK_SYS) then

      -- check if new read data
      if rden1_s='1' then
        validout_s <= '1';
        LASTOUT <= lastout1_s;
      -- check if no new read and a RDY is received
      elsif READY='1' then
        validout_s <= '0';
        LASTOUT <= '0';
      end if;
      -- sync
      if DM_TRIGGER='1' then
        validout_s <= '0';
        LASTOUT <= '0';
      end if;
      
    end if;
  end process ctrlout;
    
end synth;
