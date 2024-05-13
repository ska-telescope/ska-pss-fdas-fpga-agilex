-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 22.4 (Release Build #8d33fc3646)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2022 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_typeSFloatIEEE_23_8_typeSFloatIEEE_23_8_0_0_addFpArchSoleDatapath_correctRounding_3s5i31if3ie6pa6vb8vn88jeekgewgqygwzc36lfwllan4010i10v10w10r10510t10c70p70980t706d0if03d0ld0xf0cj0uj07k0jj0vj0nj08p054cz5iwt7hrl6v20054c2a6354c2463b0c2463a0044c2abw
-- VHDL created on Tue Feb 28 09:43:18 2023


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
use work.dspba_sim_library_package.all;
entity flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw_atb is
end;

architecture normal of flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw_atb is

component flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end component;

component flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw_stm is
    port (
        in_0_stm : out std_logic_vector(31 downto 0);
        in_1_stm : out std_logic_vector(31 downto 0);
        out_primWireOut_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        rst : out std_logic
    );
end component;

signal in_0_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_1_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_primWireOut_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_0_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_1_dut : STD_LOGIC_VECTOR (31 downto 0);
signal out_primWireOut_dut : STD_LOGIC_VECTOR (31 downto 0);
        signal clk : std_logic;
        signal rst : std_logic;

begin

-- General Purpose data in real output
checkin_0 : process (clk, rst, in_0_dut, in_0_stm)
variable in_0_real : REAL := 0.0;
variable in_0_stm_real : REAL := 0.0;
begin
 in_0_real := vIEEE_2_real(in_0_dut, 8, 23, false);
 in_0_stm_real := vIEEE_2_real(in_0_stm, 8, 23, false);
END PROCESS;


-- General Purpose data in real output
checkin_1 : process (clk, rst, in_1_dut, in_1_stm)
variable in_1_real : REAL := 0.0;
variable in_1_stm_real : REAL := 0.0;
begin
 in_1_real := vIEEE_2_real(in_1_dut, 8, 23, false);
 in_1_stm_real := vIEEE_2_real(in_1_stm, 8, 23, false);
END PROCESS;


dut : flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw port map (
    in_0_stm,
    in_1_stm,
    out_primWireOut_dut,
        clk,
        rst
);

sim : flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw_stm port map (
    in_0_stm,
    in_1_stm,
    out_primWireOut_stm,
        clk,
        rst
);

end normal;
