----------------------------------------------------------------------------
-- Module Name:  hsummins
--
-- Source Path:  hsum_lib/hdl/hsummins_synth.vhd
--
-- Requirements Covered:
--   FDAS.HARMONIC_SUM:070/A
--
-- Functional Description:
--
-- Replaces DATA_SUM with the constant value M.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     25/09/18 Initial revision.
-- 0.2  RJH     03/06/19 Updated to work for number of harmonics from 8 to 16.
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

architecture synth of hsummins is

begin

----------------------------------------------------------------------------
-- Function: Select between DATA_SUM and M for each harmonic.
----------------------------------------------------------------------------
seldata_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n ='0' then
    -- Initialise.
    data_sum_out <= (others => '0');

  elsif rising_edge(clk_sys) then
    -- Defaults.
    data_sum_out <= data_sum_in;

    for i in 0 to harmonic_g-1 loop
      if msel(i) = '1' then
        for j in first_res_c(i) to last_column_c(i)-1 loop
          data_sum_out((j+1)*32-1 downto j*32) <= m;
        end loop;
      end if;
    end loop;

  end if;

end process seldata_p;

end architecture synth;

