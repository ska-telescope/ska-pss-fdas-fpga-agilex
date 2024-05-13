----------------------------------------------------------------------------
-- Module Name:  hsumadder
--
-- Source Path:  hsum_lib/hdl/hsumadder_synth.vhd
--
-- Functional Description:
--   Wrapper around a technology specific FP adder component.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     08/05/18 Initial revision.
-- 0.2  RMD     11/05/22 Changed floating point adder to the Agilex famliy (from Arria 10)
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

architecture synth of hsumadder is

signal rst_sys_s : std_logic;

component fp_add is
  port (
	fp32_adder_a : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_adder_a
	fp32_adder_b : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_adder_b
	clr0         : in  std_logic                     := 'X';             -- reset
	clk          : in  std_logic                     := 'X';             -- clk
	ena          : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- ena
	fp32_result  : out std_logic_vector(31 downto 0)                     -- fp32_result  

  );
end component fp_add;

begin

-- Invert reset.
invrst : rst_sys_s <= not rst_sys_n;

fpadd : fp_add
  port map (
	fp32_adder_a => a,
	fp32_adder_b => b,
	clr0         => rst_sys_s,
	clk          => clk_sys,
	ena          => "111",
	fp32_result  => sum 
  );

end architecture synth;

