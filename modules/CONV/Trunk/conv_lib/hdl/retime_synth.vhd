----------------------------------------------------------------------------
-- Module Name:  RETIME
--
-- Source Path:  retime_synth.vhd
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
architecture synth of retime is

  type data_t is array (0 to stages_g-1) of std_logic_vector(dataw_g-1 downto 0);
  signal data_s        : data_t;
  signal de_s          : std_logic_vector (0 to stages_g-1);
  
begin

  gennodelay: if stages_g=0 generate
    assign_dataout: DATAOUT <= DATA;
    assign_deout: DEOUT <= DE;
  end generate;
  gendelay: if stages_g/=0 generate
  assign_dataout: DATAOUT <= data_s(stages_g-1);
  assign_deout: DEOUT <= de_s(stages_g-1);

  --------------------------------------------------------------------------
  -- retime data 
  --------------------------------------------------------------------------
  retime : process (CLK,RST_N)
  begin
    if RST_N='0' then
      data_s <= (others => (others => '0'));
      de_s <= (others => '0');
    elsif rising_edge(CLK) then
    
      if stages_g=1 then
        data_s(0) <= DATA;
        de_s(0) <= DE;
      else
        data_s(0 to stages_g-1) <= DATA & data_s(0 to stages_g-2);
        de_s(0 to stages_g-1) <= DE & de_s(0 to stages_g-2);
      end if;
      
      if SYNC='1' then
        de_s <= (others => '0');
      end if;
        
    end if;
  end process retime;
  
  end generate;

end synth;