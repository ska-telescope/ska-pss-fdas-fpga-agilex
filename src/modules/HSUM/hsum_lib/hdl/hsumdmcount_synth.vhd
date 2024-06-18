----------------------------------------------------------------------------
-- Module Name:  hsumdmcount
--
-- Source Path:  hsum_lib/hdl/hsumdmcount_synth.vhd
--
-- Requirements Covered:
--   FDAS.THRESHOLD:050/A
--
-- Functional Description:
--
-- 32-bit counter that is incremented each time HSUM module is triggered.
-- The counter may be reset via the micro interface.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     03/07/18 Initial revision.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2018 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of hsumdmcount is

signal dm_cnt_s        : unsigned(31 downto 0);
signal dm_cnt_reset_d1 : std_logic;
signal dm_cnt_reset_d2 : std_logic;
signal dm_cnt_reset_d3 : std_logic;
signal working_page_s  : std_logic;

begin

----------------------------------------------------------------------------
-- Function: DM Counter
----------------------------------------------------------------------------
dm_count_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    dm_cnt_s        <= (others => '0');
    dm_cnt_reset_d1 <= '0';
    dm_cnt_reset_d2 <= '0';
    dm_cnt_reset_d3 <= '0';

  elsif rising_edge(clk_sys) then

    -- Retime count reset for metastability and edge detection.
    dm_cnt_reset_d1 <= dm_cnt_reset;
    dm_cnt_reset_d2 <= dm_cnt_reset_d1;
    dm_cnt_reset_d3 <= dm_cnt_reset_d2;

    if dm_cnt_reset_d2 = '1' and dm_cnt_reset_d3 = '0' then
      -- Reset count on rising edge of dm_cnt_reset.
      dm_cnt_s <= (others => '0');

    elsif triggered = '1' then
      -- Increment count.
      dm_cnt_s <= dm_cnt_s + 1;
    end if;

  end if;
end process dm_count_p;

----------------------------------------------------------------------------
-- Function: Toggle the working page for the results RAM after a run.
----------------------------------------------------------------------------
toggle_page_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    working_page_s <= '0';
  elsif rising_edge(clk_sys) then
    if hsum_done = '1' then
      working_page_s <= not working_page_s;
    end if;
  end if;
end process toggle_page_p;

-- Connect up output.
out1 : dm_cnt       <= std_logic_vector(dm_cnt_s);
out2 : working_page <= working_page_s;

end synth;

