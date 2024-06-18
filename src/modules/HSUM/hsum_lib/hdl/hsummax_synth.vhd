----------------------------------------------------------------------------
-- Module Name:  hsummax
--
-- Source Path:  hsum_lib/hdl/hsummax_synth.vhd
--
-- Functional Description:
--
-- Finds the maximum value from the inputs using a tree of comparators.
-- The inputs must be IEEE 754 single precision floating point numbers.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH  14/05/2020  Initial revision.
-- 0.2  RJH  09/06/2020  Added retime for all stages.
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

library ieee, hsum_lib;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use hsum_lib.hsum_pkg.all;

architecture synth of hsummax is

-- Create a constant to determine the size of sub-comparator to use for the requested size.
constant sub_size_c : natural_array_t(2 to 32) := (2 => 1, 3 to 4 => 2, 5 to 8 => 4, 9 to 16 => 8, 17 to 32 => 16);

component hsummax is
  generic (
    size_g : natural range 2 to 32  -- Number of values to compare.
  );
  port (
    values    : in  unsigned32array_t(size_g-1 downto 0); -- Values to compare.
    maxval    : out unsigned(31 downto 0);                -- Maximum value.

    clk_sys   : in  std_logic;
    rst_sys_n : in  std_logic
  );
end component hsummax;

-- Define a signal to connect the inputs to the sub-comparators.
signal values1 : unsigned32array_t(sub_size_c(size_g)-1 downto 0);
signal values2 : unsigned32array_t(sub_size_c(size_g)-1 downto 0);

-- Define signals for the output of the sub-blocks.
signal val1 : unsigned(31 downto 0);
signal val2 : unsigned(31 downto 0);

begin

  -- Connect up inputs to internal signal, which will be tied off when the number
  -- of inputs is not a power of 2.
  con1 : values1 <= values(sub_size_c(size_g)-1 downto 0); -- Use all of one of the sub-comparators.
  con2 : for i in sub_size_c(size_g) to sub_size_c(size_g)*2-1 generate
    tie : if i >= size_g generate
      values2(i-sub_size_c(size_g)) <= (others => '0');
    end generate tie;
    sel : if i < size_g generate
      values2(i-sub_size_c(size_g)) <= values(i);
    end generate sel;
  end generate con2;

  notree : if size_g = 2 generate
    -- There is no tree to create, so feed inputs forward.
    conval1 : val1 <= values1(0);
    conval2 : val2 <= values2(0);
  end generate notree;

  gentree : if size_g > 2 generate

    -- Divide the task into two parallel comparators.
    comp1: hsummax
      generic map (
        size_g => sub_size_c(size_g)
      )
      port map (
        values    => values1,
        maxval    => val1,
        clk_sys   => clk_sys,
        rst_sys_n => rst_sys_n
      );
    comp2: hsummax
      generic map (
        size_g => sub_size_c(size_g)
      )
      port map (
        values    => values2,
        maxval    => val2,
        clk_sys   => clk_sys,
        rst_sys_n => rst_sys_n
      );
  end generate gentree;

  -- Generate final result with retime.
  retime_p : process(clk_sys, rst_sys_n)
  begin
    if rst_sys_n = '0' then
      -- Initialise.
      maxval <= (others => '0');
    elsif rising_edge(clk_sys) then

      -- Invert sign bit to give correct result.
      if ((not val1(31)) & val1(30 downto 0)) > 
         ((not val2(31)) & val2(30 downto 0)) then
        maxval <= val1;
      else
        maxval <= val2;
      end if;
    end if;
  end process retime_p;

end architecture synth;

