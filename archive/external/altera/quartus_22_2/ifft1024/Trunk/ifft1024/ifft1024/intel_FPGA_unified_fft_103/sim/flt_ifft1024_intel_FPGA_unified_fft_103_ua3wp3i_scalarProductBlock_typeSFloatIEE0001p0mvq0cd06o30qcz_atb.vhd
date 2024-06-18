-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 22.2 (Release Build #46.1)
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

-- VHDL created from flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEEE_23_8_5_5_0_correctRounding_true_false_381i92il4i37pz62uc87e8sc063060c60i65i61u65u63165760vc3860e62ei4e60k62k60365365960uq5ux5gv8ylj56c00uq0dp0mvq0cd06o30qcz
-- VHDL created on Tue Jul 19 12:25:15 2022


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
use work.dspba_sim_library_package.all;
entity flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz_atb is
end;

architecture normal of flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz_atb is

component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_2 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_3 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end component;

component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz_stm is
    port (
        in_0_stm : out std_logic_vector(31 downto 0);
        in_1_stm : out std_logic_vector(31 downto 0);
        in_2_stm : out std_logic_vector(31 downto 0);
        in_3_stm : out std_logic_vector(31 downto 0);
        out_primWireOut_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        rst : out std_logic
    );
end component;

signal in_0_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_1_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_2_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_3_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_primWireOut_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_0_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_1_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_2_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_3_dut : STD_LOGIC_VECTOR (31 downto 0);
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


-- General Purpose data in real output
checkin_2 : process (clk, rst, in_2_dut, in_2_stm)
variable in_2_real : REAL := 0.0;
variable in_2_stm_real : REAL := 0.0;
begin
 in_2_real := vIEEE_2_real(in_2_dut, 8, 23, false);
 in_2_stm_real := vIEEE_2_real(in_2_stm, 8, 23, false);
END PROCESS;


-- General Purpose data in real output
checkin_3 : process (clk, rst, in_3_dut, in_3_stm)
variable in_3_real : REAL := 0.0;
variable in_3_stm_real : REAL := 0.0;
begin
 in_3_real := vIEEE_2_real(in_3_dut, 8, 23, false);
 in_3_stm_real := vIEEE_2_real(in_3_stm, 8, 23, false);
END PROCESS;


dut : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz port map (
    in_0_stm,
    in_1_stm,
    in_2_stm,
    in_3_stm,
    out_primWireOut_dut,
        clk,
        rst
);

sim : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz_stm port map (
    in_0_stm,
    in_1_stm,
    in_2_stm,
    in_3_stm,
    out_primWireOut_stm,
        clk,
        rst
);

end normal;
