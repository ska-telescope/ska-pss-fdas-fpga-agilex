----------------------------------------------------------------------------
-- Module Name:  hsumretime
--
-- Source Path:  hsum_lib/hdl/hsumretime_synth.vhd
--
-- Functional Description:
--   Retimes a data signal. The width of the data signal and the number of
--   retimes are set by generics.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     14/05/20 Initial revision.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of hsumretime is

begin

nodelay : if delay_g = 0 generate
  -- Connect input directly to output.
  dout <= din;
end generate nodelay;

retime_gen : if delay_g > 0 generate
  type vecarray_t is array(1 to delay_g) of unsigned(width_g - 1 downto 0);
  signal din_d : vecarray_t;
begin
  retime_p : process(clk_sys, rst_sys_n)
  begin
    if rst_sys_n = '0' then
      -- Initialise.
      din_d <= (others => (others => '0'));

    elsif rising_edge(clk_sys) then

        din_d(1) <= din;

        -- Create delay stages.
        for i in 2 to delay_g loop
          din_d(i) <= din_d(i-1);
        end loop;

    end if;
  end process retime_p;

  -- Connect last stage to output.
  conout : dout <= din_d(delay_g);

end generate retime_gen;

end architecture synth;

