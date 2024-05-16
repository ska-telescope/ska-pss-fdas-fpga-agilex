----------------------------------------------------------------------------
-- Module Name:  convreset_sync
--
-- Source Path:  convreset_sync_synth.vhd
--
-- Description:  Reset synchroniser
--
-- Author:       RMD
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  RMD     29/06/2023  Initial revision.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of convreset_sync is

  signal reset_0_n_s      : std_logic_vector (6 downto 0);
  signal reset_1_n_s      : std_logic_vector (6 downto 0);  
  
  
begin

  assign_rst_out_0_n : RST_OUT_0_N  <= reset_0_n_s(6);
  assign_rst_out_1_n : RST_OUT_1_N  <= reset_1_n_s(6);
 
 
  --------------------------------------------------------------------------
  -- reset_sync
  --------------------------------------------------------------------------
  reset_sync : process (CLK,RST_N)
  begin
    if RST_N='0' then
      reset_0_n_s  <= (others => '0');
      reset_1_n_s  <= (others => '0');
             
    elsif rising_edge(CLK) then
    
      reset_0_n_s  <= reset_0_n_s(5 downto 0) & '1';
      reset_1_n_s  <= reset_1_n_s(5 downto 0) & '1';
          
      
    end if;
  end process reset_sync;
  
end synth;