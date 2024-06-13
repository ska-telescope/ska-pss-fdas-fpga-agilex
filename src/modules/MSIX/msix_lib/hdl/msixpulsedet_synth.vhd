----------------------------------------------------------------------------
-- Module Name:  msixpulsedet
--
-- Source Path:  msix_lib/hdl/msixpulsedet_synth.vhd
--
-- Requirements Covered:
--
-- Functional Description: Module takes in the 3 interrupts cld_done, conv_done,
-- hsum_done and pipelines them so they can be rising edge detected. When a new
-- interrupt is detected a toggle signal is toggled.
--
-- Three toggle signals, one for each of the three interrupts, are output.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   21/04/2022  Initial revision.
--
---------------------------------------------------------------------------
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of msixpulsedet is
  signal cld_toggle_s  : std_logic;
  signal conv_toggle_s : std_logic;
  signal hsum_toggle_s : std_logic;

  signal cld_done_s    : std_logic;
  signal conv_done_s   : std_logic;
  signal hsum_done_s   : std_logic;
begin
  -- Generate a toggle signal on rising edge of cld_done interrupt.
  cld_toggle_gen: process(clk_sys, rst_sys_n) is
  begin
    if rst_sys_n = '0' then
      cld_toggle_s <= '0';
      cld_done_s   <= '0';
    elsif rising_edge(clk_sys) then
      cld_done_s <= cld_done;

      if cld_done = '1' and cld_done_s = '0' then
        cld_toggle_s <= not cld_toggle_s;
      end if;
    end if;
  end process cld_toggle_gen;

  -- Generate a toggle signal on rising edge of conv_done interrupt.
  conv_toggle_gen: process(clk_sys, rst_sys_n) is
  begin
    if rst_sys_n = '0' then
      conv_toggle_s <= '0';
      conv_done_s   <= '0';
    elsif rising_edge(clk_sys) then
      conv_done_s <= conv_done;

      if conv_done = '1' and conv_done_s = '0' then
        conv_toggle_s <= not conv_toggle_s;
      end if;
    end if;
  end process conv_toggle_gen;

  -- Generate a toggle signal on rising edge of hsum_done interrupt.
  hsum_toggle_gen: process(clk_sys, rst_sys_n) is
  begin
    if rst_sys_n = '0' then
      hsum_toggle_s <= '0';
      hsum_done_s   <= '0';
    elsif rising_edge(clk_sys) then
      hsum_done_s <= hsum_done;

      if hsum_done = '1' and hsum_done_s = '0' then
        hsum_toggle_s <= not hsum_toggle_s;
      end if;
    end if;
  end process hsum_toggle_gen;

  -- Toggle outputs for msitx.
  cld_toggle  <= cld_toggle_s;
  conv_toggle <= conv_toggle_s;
  hsum_toggle <= hsum_toggle_s;
end architecture synth;

