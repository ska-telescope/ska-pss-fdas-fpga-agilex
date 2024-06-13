----------------------------------------------------------------------------
-- Module Name:  RESET_SYNC
--
-- Source Path:  reset_sync_synth.vhd
--
-- Description:  Reset synchroniser
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  JT     25/09/2017  Initial revision.
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
architecture synth of reset_sync is

  signal reset_n_s     : std_logic_vector (2 downto 0);
  
begin

  assign_rst_out_n: RST_OUT_N <= reset_n_s(2);

  --------------------------------------------------------------------------
  -- reset_sync data 
  --------------------------------------------------------------------------
  reset_sync : process (CLK,RST_N)
  begin
    if RST_N='0' then
      reset_n_s <= (others => '0');
    elsif rising_edge(CLK) then
    
      reset_n_s <= reset_n_s(1 downto 0) & '1';
        
    end if;
  end process reset_sync;
  
end synth;