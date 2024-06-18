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

-- VHDL created from flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_typeSFloatIEEE_23_8_3w4c31if3iw9ps9vtbv0h82he3dkfc063065665c64i60u64u62164764jc12642608i3k60q62qc0uq5ux5gv8ylj56c00uq0dp0iuq0cp1jzi
-- VHDL created on Tue Jul 19 12:46:04 2022


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
use work.dspba_sim_library_package.all;
entity flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi_atb is
end;

architecture normal of flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi_atb is

component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end component;

component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi_stm is
    port (
        in_0_stm : out std_logic_vector(31 downto 0);
        out_primWireOut_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        rst : out std_logic
    );
end component;

signal in_0_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_primWireOut_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_0_dut : STD_LOGIC_VECTOR (31 downto 0);
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


dut : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi port map (
    in_0_stm,
    out_primWireOut_dut,
        clk,
        rst
);

sim : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi_stm port map (
    in_0_stm,
    out_primWireOut_stm,
        clk,
        rst
);

end normal;
