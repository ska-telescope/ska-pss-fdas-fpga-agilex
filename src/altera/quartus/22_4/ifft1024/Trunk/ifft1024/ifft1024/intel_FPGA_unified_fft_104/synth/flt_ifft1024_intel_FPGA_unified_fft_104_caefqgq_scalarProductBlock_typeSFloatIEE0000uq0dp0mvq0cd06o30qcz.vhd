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

-- VHDL created from flt_ifft1024_intel_FPGA_unified_fft_104_caefqgq_scalarProductBlock_typeSFloatIEEE_23_8_5_5_0_correctRounding_false_false_381i92il4i37pz62uc87e8sc063060c60i65i61u65u63165760vc3860e62ei4e60k62k60360960f60uq5ux5gv8ylj56c00uq0dp0mvq0cd06o30qcz
-- VHDL created on Tue Feb 28 09:43:12 2023


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;

library tennm;
use tennm.tennm_components.tennm_mac;
use tennm.tennm_components.tennm_fp_mac;

entity flt_ifft1024_intel_FPGA_unified_fft_104_caefqgq_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_2 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_3 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end flt_ifft1024_intel_FPGA_unified_fft_104_caefqgq_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz;

architecture normal of flt_ifft1024_intel_FPGA_unified_fft_104_caefqgq_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal block_rsrvd_fix_sp0_impl_reset0 : std_logic;
    signal block_rsrvd_fix_sp0_impl_ena0 : std_logic;
    signal block_rsrvd_fix_sp0_impl_ay0 : STD_LOGIC_VECTOR (31 downto 0);
    signal block_rsrvd_fix_sp0_impl_az0 : STD_LOGIC_VECTOR (31 downto 0);
    signal block_rsrvd_fix_sp0_impl_q0 : STD_LOGIC_VECTOR (31 downto 0);
    signal block_rsrvd_fix_sp0_impl_reset1 : std_logic;
    signal block_rsrvd_fix_sp0_impl_ena1 : std_logic;
    signal block_rsrvd_fix_sp0_impl_ay1 : STD_LOGIC_VECTOR (31 downto 0);
    signal block_rsrvd_fix_sp0_impl_az1 : STD_LOGIC_VECTOR (31 downto 0);
    signal block_rsrvd_fix_sp0_impl_chain1 : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- block_rsrvd_fix_sp0_impl(FPCOLUMN,9)@0
    -- out q0@5
    block_rsrvd_fix_sp0_impl_ay0 <= in_0;
    block_rsrvd_fix_sp0_impl_az0 <= in_1;
    block_rsrvd_fix_sp0_impl_reset0 <= '0';
    block_rsrvd_fix_sp0_impl_ena0 <= '1';
    block_rsrvd_fix_sp0_impl_DSP0 : tennm_fp_mac
    GENERIC MAP (
        operation_mode => "fp32_mult_add",
        use_chainin => "true",
        fp32_mult_a_clken => "0",
        fp32_mult_b_clken => "0",
        mult_2nd_pipeline_clken => "0",
        adder_input_clken => "0",
        mult_pipeline_clken => "0",
        output_clken => "0",
        clear_type => "none"
    )
    PORT MAP (
        clk => clk,
        ena(0) => block_rsrvd_fix_sp0_impl_ena0,
        ena(1) => '0',
        ena(2) => '0',
        clr(0) => block_rsrvd_fix_sp0_impl_reset0,
        clr(1) => block_rsrvd_fix_sp0_impl_reset0,
        fp32_mult_a => block_rsrvd_fix_sp0_impl_ay0,
        fp32_mult_b => block_rsrvd_fix_sp0_impl_az0,
        fp32_chainin => block_rsrvd_fix_sp0_impl_chain1,
        fp32_result => block_rsrvd_fix_sp0_impl_q0
    );
    block_rsrvd_fix_sp0_impl_ay1 <= in_2;
    block_rsrvd_fix_sp0_impl_az1 <= in_3;
    block_rsrvd_fix_sp0_impl_reset1 <= '0';
    block_rsrvd_fix_sp0_impl_ena1 <= '1';
    block_rsrvd_fix_sp0_impl_DSP1 : tennm_fp_mac
    GENERIC MAP (
        operation_mode => "fp32_mult",
        fp32_mult_a_clken => "0",
        fp32_mult_b_clken => "0",
        mult_2nd_pipeline_clken => "0",
        output_clken => "0",
        clear_type => "none"
    )
    PORT MAP (
        clk => clk,
        ena(0) => block_rsrvd_fix_sp0_impl_ena1,
        ena(1) => '0',
        ena(2) => '0',
        clr(0) => block_rsrvd_fix_sp0_impl_reset1,
        clr(1) => block_rsrvd_fix_sp0_impl_reset1,
        fp32_mult_a => block_rsrvd_fix_sp0_impl_ay1,
        fp32_mult_b => block_rsrvd_fix_sp0_impl_az1,
        fp32_chainout => block_rsrvd_fix_sp0_impl_chain1
    );

    -- out_primWireOut(GPOUT,7)@5
    out_primWireOut <= block_rsrvd_fix_sp0_impl_q0;

END normal;
