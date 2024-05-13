----------------------------------------------------------------------------
-- Module Name:  hsumreset_sync
--
-- Source Path:  hsumreset_sync_synth.vhd
--
-- Description:  Reset synchroniser
--
-- Author:       RMD
--
----------------------------------------------------------------------------
-- Rev  Auth     Date      Revision History
--
-- 0.1  RMD     29/06/2023  Initial revision.
-- 0.2  RMD     23/01/2024  Updated to support multiple summers
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2024 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
architecture synth of hsumreset_sync is

  type reset_fifo_t is array(0 to summer_g-1) of std_logic_vector (6 downto 0);

  signal reset_0_n_s     : reset_fifo_t;
  signal reset_1_n_s     : reset_fifo_t;
  signal reset_2_n_s     : reset_fifo_t;  
  signal reset_3_n_s     : reset_fifo_t;  
  signal reset_4_n_s     : reset_fifo_t;
  signal reset_5_n_s     : reset_fifo_t;    
  
begin

s1: FOR s IN 0 TO summer_g-1 GENERATE

  assign_rst_out_0_n: RST_OUT_0_N(s) <= reset_0_n_s(s)(6);
  assign_rst_out_1_n: RST_OUT_1_N(s) <= reset_1_n_s(s)(6);
  assign_rst_out_2_n: RST_OUT_2_N(s) <= reset_2_n_s(s)(6);  
  assign_rst_out_3_n: RST_OUT_3_N(s) <= reset_3_n_s(s)(6);  
  assign_rst_out_4_n: RST_OUT_4_N(s) <= reset_4_n_s(s)(6);  
  assign_rst_out_5_n: RST_OUT_5_N(s) <= reset_5_n_s(s)(6);    
  
  --------------------------------------------------------------------------
  -- reset_sync
  --------------------------------------------------------------------------
  reset_sync : process (CLK,RST_N)
  begin
    if RST_N='0' then
      reset_0_n_s(s) <= (others => '0');
      reset_1_n_s(s) <= (others => '0');
      reset_2_n_s(s) <= (others => '0');
      reset_3_n_s(s) <= (others => '0');
      reset_4_n_s(s) <= (others => '0');
      reset_5_n_s(s) <= (others => '0');      
    elsif rising_edge(CLK) then
    
      reset_0_n_s(s) <= reset_0_n_s(s)(5 downto 0) & '1';
      reset_1_n_s(s) <= reset_1_n_s(s)(5 downto 0) & '1';
      reset_2_n_s(s) <= reset_2_n_s(s)(5 downto 0) & '1';      
      reset_3_n_s(s) <= reset_3_n_s(s)(5 downto 0) & '1';    
      reset_4_n_s(s) <= reset_4_n_s(s)(5 downto 0) & '1';    
      reset_5_n_s(s) <= reset_5_n_s(s)(5 downto 0) & '1';         
      
    end if;
  end process reset_sync;
  
end generate s1;
  
end synth;