-- PCIE_HIP_FDAS_clock_bridge_0.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCIE_HIP_FDAS_clock_bridge_0 is
	port (
		in_clk  : in  std_logic := '0'; --  in_clk.clk
		out_clk : out std_logic         -- out_clk.clk
	);
end entity PCIE_HIP_FDAS_clock_bridge_0;

architecture rtl of PCIE_HIP_FDAS_clock_bridge_0 is
begin

	out_clk <= in_clk;

end architecture rtl; -- of PCIE_HIP_FDAS_clock_bridge_0
