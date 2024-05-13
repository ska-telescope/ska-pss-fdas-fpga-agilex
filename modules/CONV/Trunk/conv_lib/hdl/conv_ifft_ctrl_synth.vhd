----------------------------------------------------------------------------
-- Module Name:  CONV_IFFT_CTRL
--
-- Source Path:  conv_ifft_ctrl_synth.vhd
--
-- Description:  
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
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of conv_ifft_ctrl is

  signal loop_addr_s    : unsigned(loop_bits_g-1 downto 0);
  signal loop_addrout_s : std_logic_vector(loop_bits_g-1 downto 0);
  signal valid_s        : std_logic_vector (0 to stages_g-1);
  signal sof_s          : std_logic_vector (0 to stages_g-1);
  signal eof_s          : std_logic_vector (0 to stages_g-1);
  signal ready_s        : std_logic;
  signal validin_s      : std_logic;
  
begin

  assign_validin: validin_s <= VALID and ready_s;
  assign_sofout: SOFOUT <= sof_s(stages_g-1);
  assign_eofout: EOFOUT <= eof_s(stages_g-1);
  assign_validout: VALIDOUT <= valid_s(stages_g-1);
  assign_rptaddrout: LOOP_ADDROUT <= loop_addrout_s;

  --------------------------------------------------------------------------
  -- retime data 
  --------------------------------------------------------------------------
  retime : process (CLK,RST_N)
  begin
    if RST_N='0' then
      loop_addr_s <= (others => '0');
      valid_s <= (others => '0');
      sof_s <= (others => '0');
      eof_s <= (others => '0');
      ready_s <= '0';
    elsif rising_edge(CLK) then
    
      -- delay ready to compensate for retime of recscale following IFFT
      ready_s <= READY;
    
      if stages_g=1 then
        valid_s(0) <= validin_s;
        sof_s(0) <= SOF;
        eof_s(0) <= EOF;
      else
        valid_s(0 to stages_g-1) <= validin_s & valid_s(0 to stages_g-2);
        sof_s(0 to stages_g-1) <= SOF & sof_s(0 to stages_g-2);
        eof_s(0 to stages_g-1) <= EOF & eof_s(0 to stages_g-2);
      end if;
      
     if valid_s(stages_g-2)='1' and eof_s(stages_g-2)='1' then
        if loop_addr_s=loop_g-1 or '0'&loop_addr_s=unsigned(LOOP_NUM)-1 then
          loop_addr_s <=(others => '0');
        else
          loop_addr_s <= loop_addr_s + 1;
        end if;
      end if;
      
      if SYNC='1' then
        loop_addr_s <= (others => '0');
        valid_s <= (others => '0');
        sof_s <= (others => '0');
        eof_s <= (others => '0');
        ready_s <= '0';
      end if;
        
    end if;
  end process retime;
  
  --------------------------------------------------------------------------
  -- decode write enables 
  --------------------------------------------------------------------------
  genwren : process (CLK,RST_N)
  begin
    if RST_N='0' then
      loop_addrout_s <= (others => '0');
      WRENOUT <= (others => '0');
    elsif rising_edge(CLK) then
    
      WRENOUT <= (others => '0');
      if valid_s(stages_g-2)='1' then
        -- latch repeat address on SOF
        loop_addrout_s <= std_logic_vector(loop_addr_s);
        WRENOUT(to_integer(loop_addr_s)) <= '1';
      end if;
      
      if SYNC='1' then
        loop_addrout_s <= (others => '0');
        WRENOUT <= (others => '0');
      end if;
        
    end if;
  end process genwren;
  

end synth;