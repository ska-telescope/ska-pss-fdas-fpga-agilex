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

-- VHDL created from flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_typeSFloatIEEE_23_8_3w4c92il4i3apyavz626ce8ck9eklc063060c60i65i61u65u63165765jc22652618i4k61q63qc0uq5ux5gv8ylj56c00uq0dp0iuq0cp1jzi
-- VHDL created on Tue Jul 19 12:25:15 2022


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

entity flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi;

architecture normal of flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sx_uid6_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracX_uid7_block_rsrvd_fix_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expX_uid8_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expFracX_uid9_block_rsrvd_fix_q : STD_LOGIC_VECTOR (30 downto 0);
    signal invSX_uid12_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal negResult_uid13_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- sx_uid6_block_rsrvd_fix(BITSELECT,5)@0
    sx_uid6_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(in_0(31 downto 31));

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- invSX_uid12_block_rsrvd_fix(LOGICAL,11)@0
    invSX_uid12_block_rsrvd_fix_q <= not (sx_uid6_block_rsrvd_fix_b);

    -- expX_uid8_block_rsrvd_fix(BITSELECT,7)@0
    expX_uid8_block_rsrvd_fix_b <= in_0(30 downto 23);

    -- fracX_uid7_block_rsrvd_fix(BITSELECT,6)@0
    fracX_uid7_block_rsrvd_fix_b <= in_0(22 downto 0);

    -- expFracX_uid9_block_rsrvd_fix(BITJOIN,8)@0
    expFracX_uid9_block_rsrvd_fix_q <= expX_uid8_block_rsrvd_fix_b & fracX_uid7_block_rsrvd_fix_b;

    -- negResult_uid13_block_rsrvd_fix(BITJOIN,12)@0
    negResult_uid13_block_rsrvd_fix_q <= invSX_uid12_block_rsrvd_fix_q & expFracX_uid9_block_rsrvd_fix_q;

    -- out_primWireOut(GPOUT,4)@0
    out_primWireOut <= negResult_uid13_block_rsrvd_fix_q;

END normal;
