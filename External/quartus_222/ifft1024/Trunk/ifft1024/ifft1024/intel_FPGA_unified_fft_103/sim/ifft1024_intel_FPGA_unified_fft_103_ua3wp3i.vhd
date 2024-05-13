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

-- VHDL created from ifft1024_intel_FPGA_unified_fft_103_ua3wp3i
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

entity ifft1024_intel_FPGA_unified_fft_103_ua3wp3i is
    port (
        validIn : in std_logic_vector(0 downto 0);  -- ufix1
        channelIn : in std_logic_vector(7 downto 0);  -- ufix8
        in_d_real_tpl : in std_logic_vector(31 downto 0);  -- float32_m23
        in_d_imag_tpl : in std_logic_vector(31 downto 0);  -- float32_m23
        validOut : out std_logic_vector(0 downto 0);  -- ufix1
        channelOut : out std_logic_vector(7 downto 0);  -- ufix8
        out_q_real_tpl : out std_logic_vector(31 downto 0);  -- float32_m23
        out_q_imag_tpl : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end ifft1024_intel_FPGA_unified_fft_103_ua3wp3i;

architecture normal of ifft1024_intel_FPGA_unified_fft_103_ua3wp3i is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;



    component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_2 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_3 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;


    component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_2 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_3 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;








    component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;





















    component flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;

















































    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_castNegateCos_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_castNegateSin_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_latch_0L_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_latch_0L_mux_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_pulseDivider_counter_x_i : UNSIGNED (10 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of fft_fftLight_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i : UNSIGNED (0 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (2 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_reset0 : std_logic;
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ir : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_a : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_o : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xnorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroConst_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_delay_0 : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist119_chanIn_cunroll_x_validIn_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist120_chanIn_cunroll_x_validIn_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist120_chanIn_cunroll_x_validIn_6_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist120_chanIn_cunroll_x_validIn_6_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist120_chanIn_cunroll_x_validIn_6_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist120_chanIn_cunroll_x_validIn_6_delay_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist121_chanIn_cunroll_x_validIn_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist122_chanIn_cunroll_x_validIn_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist123_chanIn_cunroll_x_validIn_20_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist124_chanIn_cunroll_x_validIn_21_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist125_chanIn_cunroll_x_validIn_29_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist126_chanIn_cunroll_x_validIn_30_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist127_chanIn_cunroll_x_validIn_38_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist128_chanIn_cunroll_x_validIn_39_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist129_chanIn_cunroll_x_validIn_40_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist130_chanIn_cunroll_x_validIn_49_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist131_chanIn_cunroll_x_validIn_50_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist132_chanIn_cunroll_x_validIn_53_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist132_chanIn_cunroll_x_validIn_53_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist132_chanIn_cunroll_x_validIn_53_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist136_chanIn_cunroll_x_in_d_real_tpl_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist139_chanIn_cunroll_x_in_d_imag_tpl_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_reset0 : std_logic;
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i : signal is true;
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq : signal is true;
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_reset0 : std_logic;
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i : signal is true;
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq : signal is true;
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_reset0 : std_logic;
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i : signal is true;
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq : signal is true;
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_reset0 : std_logic;
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i : signal is true;
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq : signal is true;
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_reset0 : std_logic;
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i : signal is true;
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq : signal is true;
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_reset0 : std_logic;
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i : signal is true;
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq : signal is true;
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_reset0 : std_logic;
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i : signal is true;
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq : signal is true;
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_reset0 : std_logic;
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i : signal is true;
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq : signal is true;
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_reset0 : std_logic;
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i : signal is true;
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq : signal is true;
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_q : signal is true;
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q : signal is true;
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0 : std_logic;
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i : signal is true;
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq : signal is true;
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q : signal is true;
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q : signal is true;
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_reset0 : std_logic;
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i : signal is true;
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq : signal is true;
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_q : signal is true;
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q : signal is true;
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0 : std_logic;
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i : signal is true;
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq : signal is true;
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q : signal is true;
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q : signal is true;
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_reset0 : std_logic;
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i : signal is true;
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq : signal is true;
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_reset0 : std_logic;
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i : signal is true;
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq : signal is true;
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_reset0 : std_logic;
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i : signal is true;
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq : signal is true;
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_reset0 : std_logic;
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i : signal is true;
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq : signal is true;
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_reset0 : std_logic;
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i : signal is true;
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq : signal is true;
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_reset0 : std_logic;
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i : signal is true;
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq : signal is true;
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_reset0 : std_logic;
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i : signal is true;
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq : signal is true;
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_reset0 : std_logic;
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i : signal is true;
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq : signal is true;
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_reset0 : std_logic;
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i : signal is true;
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq : signal is true;
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_q : signal is true;
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q : signal is true;
    signal redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_reset0 : std_logic;
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i : signal is true;
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq : signal is true;
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_q : signal is true;
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q : signal is true;
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_reset0 : std_logic;
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i : signal is true;
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq : signal is true;
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_q : signal is true;
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q : signal is true;
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_reset0 : std_logic;
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i : signal is true;
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq : signal is true;
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_q : signal is true;
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q : signal is true;
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_reset0 : std_logic;
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i : signal is true;
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq : signal is true;
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_q : signal is true;
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q : signal is true;
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_reset0 : std_logic;
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i : signal is true;
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq : signal is true;
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_q : signal is true;
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q : signal is true;
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_reset0 : std_logic;
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i : signal is true;
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq : signal is true;
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_q : signal is true;
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q : signal is true;
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_reset0 : std_logic;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_q : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_reset0 : std_logic;
    signal redist87_fft_latch_0L_mux_x_q_24_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist87_fft_latch_0L_mux_x_q_24_rdcnt_i : signal is true;
    signal redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq : signal is true;
    signal redist87_fft_latch_0L_mux_x_q_24_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist87_fft_latch_0L_mux_x_q_24_cmpReg_q : signal is true;
    signal redist87_fft_latch_0L_mux_x_q_24_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q : signal is true;
    signal redist87_fft_latch_0L_mux_x_q_24_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_inputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_reset0 : std_logic;
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_cmpReg_q : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_reset0 : std_logic;
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_q : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q : signal is true;
    signal redist133_chanIn_cunroll_x_channelIn_54_split_0_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_notEnable(LOGICAL,890)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_nor(LOGICAL,891)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_nor_q <= not (redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_notEnable_q or redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_q);

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_last(CONSTANT,887)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_last_q <= "0111111011";

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp(LOGICAL,888)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_b <= STD_LOGIC_VECTOR("0" & redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_q);
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_q <= "1" WHEN redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_last_q = redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_b ELSE "0";

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg(REG,889)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg_q <= "0";
            ELSE
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena(REG,892)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_q <= "0";
            ELSE
                IF (redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_nor_q = "1") THEN
                    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_enaAnd(LOGICAL,893)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_enaAnd_q <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_sticky_ena_q and VCC_q;

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt(COUNTER,885)
    -- low=0, high=508, step=1, init=0
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq <= '0';
            ELSE
                IF (redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i = TO_UNSIGNED(507, 9)) THEN
                    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq <= '1';
                ELSE
                    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq <= '0';
                END IF;
                IF (redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_eq = '1') THEN
                    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i + 4;
                ELSE
                    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_i, 9)));

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_notEnable(LOGICAL,754)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_nor(LOGICAL,755)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_nor_q <= not (redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_notEnable_q or redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_q);

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_last(CONSTANT,751)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_last_q <= "011111100";

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp(LOGICAL,752)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_q);
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_q <= "1" WHEN redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_last_q = redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_b ELSE "0";

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg(REG,753)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg_q <= "0";
            ELSE
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg_q <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena(REG,756)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_q <= "0";
            ELSE
                IF (redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_nor_q = "1") THEN
                    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_enaAnd(LOGICAL,757)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_enaAnd_q <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_sticky_ena_q and VCC_q;

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt(COUNTER,749)
    -- low=0, high=253, step=1, init=0
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '0';
            ELSE
                IF (redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i = TO_UNSIGNED(252, 8)) THEN
                    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '1';
                ELSE
                    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '0';
                END IF;
                IF (redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_eq = '1') THEN
                    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i + 3;
                ELSE
                    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_i, 8)));

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_notEnable(LOGICAL,934)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_nor(LOGICAL,935)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_nor_q <= not (redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_notEnable_q or redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_q);

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_last(CONSTANT,931)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_last_q <= "01111011";

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp(LOGICAL,932)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_b <= STD_LOGIC_VECTOR("0" & redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_q);
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_q <= "1" WHEN redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_last_q = redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_b ELSE "0";

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg(REG,933)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg_q <= "0";
            ELSE
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena(REG,936)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_q <= "0";
            ELSE
                IF (redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_nor_q = "1") THEN
                    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_enaAnd(LOGICAL,937)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_enaAnd_q <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_sticky_ena_q and VCC_q;

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt(COUNTER,929)
    -- low=0, high=124, step=1, init=0
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq <= '0';
            ELSE
                IF (redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i = TO_UNSIGNED(123, 7)) THEN
                    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq <= '1';
                ELSE
                    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq <= '0';
                END IF;
                IF (redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_eq = '1') THEN
                    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i + 4;
                ELSE
                    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_i, 7)));

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_notEnable(LOGICAL,798)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_nor(LOGICAL,799)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_nor_q <= not (redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_notEnable_q or redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_q);

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_last(CONSTANT,795)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_last_q <= "0111100";

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp(LOGICAL,796)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_q);
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_q <= "1" WHEN redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_last_q = redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_b ELSE "0";

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg(REG,797)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg_q <= "0";
            ELSE
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg_q <= STD_LOGIC_VECTOR(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena(REG,800)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_q <= "0";
            ELSE
                IF (redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_nor_q = "1") THEN
                    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_enaAnd(LOGICAL,801)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_enaAnd_q <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_sticky_ena_q and VCC_q;

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt(COUNTER,793)
    -- low=0, high=61, step=1, init=0
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '0';
            ELSE
                IF (redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i = TO_UNSIGNED(60, 6)) THEN
                    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '1';
                ELSE
                    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '0';
                END IF;
                IF (redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_eq = '1') THEN
                    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i + 3;
                ELSE
                    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_i, 6)));

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_notEnable(LOGICAL,978)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_nor(LOGICAL,979)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_nor_q <= not (redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_notEnable_q or redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q);

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_last(CONSTANT,975)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_last_q <= "011011";

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp(LOGICAL,976)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_b <= STD_LOGIC_VECTOR("0" & redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_q);
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_q <= "1" WHEN redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_last_q = redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_b ELSE "0";

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg(REG,977)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_q <= "0";
            ELSE
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_q <= STD_LOGIC_VECTOR(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena(REG,980)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q <= "0";
            ELSE
                IF (redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_nor_q = "1") THEN
                    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q <= STD_LOGIC_VECTOR(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_enaAnd(LOGICAL,981)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_enaAnd_q <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_sticky_ena_q and VCC_q;

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt(COUNTER,973)
    -- low=0, high=28, step=1, init=0
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq <= '0';
            ELSE
                IF (redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i = TO_UNSIGNED(27, 5)) THEN
                    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq <= '1';
                ELSE
                    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq <= '0';
                END IF;
                IF (redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_eq = '1') THEN
                    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i + 4;
                ELSE
                    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_i, 5)));

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_notEnable(LOGICAL,842)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_nor(LOGICAL,843)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_nor_q <= not (redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_notEnable_q or redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q);

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_last(CONSTANT,839)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_last_q <= "01100";

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp(LOGICAL,840)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_q);
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_q <= "1" WHEN redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_last_q = redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_b ELSE "0";

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg(REG,841)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_q <= "0";
            ELSE
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_q <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena(REG,844)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q <= "0";
            ELSE
                IF (redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_nor_q = "1") THEN
                    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_enaAnd(LOGICAL,845)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_enaAnd_q <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_sticky_ena_q and VCC_q;

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt(COUNTER,837)
    -- low=0, high=13, step=1, init=0
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '0';
            ELSE
                IF (redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '1';
                ELSE
                    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '0';
                END IF;
                IF (redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_eq = '1') THEN
                    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i + 3;
                ELSE
                    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_i, 4)));

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_notEnable(LOGICAL,1022)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_nor(LOGICAL,1023)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_nor_q <= not (redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_notEnable_q or redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q);

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_last(CONSTANT,1019)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_last_q <= "011";

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmp(LOGICAL,1020)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmp_q <= "1" WHEN redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_last_q = redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_q ELSE "0";

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg(REG,1021)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_q <= "0";
            ELSE
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_q <= STD_LOGIC_VECTOR(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena(REG,1024)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q <= "0";
            ELSE
                IF (redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_nor_q = "1") THEN
                    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_enaAnd(LOGICAL,1025)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_enaAnd_q <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_sticky_ena_q and VCC_q;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt(COUNTER,1017)
    -- low=0, high=4, step=1, init=0
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq <= '0';
            ELSE
                IF (redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq <= '1';
                ELSE
                    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq <= '0';
                END IF;
                IF (redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_eq = '1') THEN
                    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i + 4;
                ELSE
                    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_i, 3)));

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_1(DELAY,740)
    redist134_chanIn_cunroll_x_in_d_real_tpl_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_1_q <= (others => '0');
            ELSE
                redist134_chanIn_cunroll_x_in_d_real_tpl_1_q <= STD_LOGIC_VECTOR(in_d_real_tpl);
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_2(DELAY,741)
    redist135_chanIn_cunroll_x_in_d_real_tpl_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_2_q <= (others => '0');
            ELSE
                redist135_chanIn_cunroll_x_in_d_real_tpl_2_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,36)@1
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist135_chanIn_cunroll_x_in_d_real_tpl_2_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x(COUNTER,148)@0 + 1
    -- low=0, high=1, step=1, init=1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i <= TO_UNSIGNED(1, 1);
            ELSE
                IF (validIn = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i, 1)));

    -- redist119_chanIn_cunroll_x_validIn_1(DELAY,725)
    redist119_chanIn_cunroll_x_validIn_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist119_chanIn_cunroll_x_validIn_1_q <= (others => '0');
            ELSE
                redist119_chanIn_cunroll_x_validIn_1_q <= STD_LOGIC_VECTOR(validIn);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x(LOGICAL,146)@1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q <= redist119_chanIn_cunroll_x_validIn_1_q and fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x(MUX,58)@1 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist135_chanIn_cunroll_x_in_d_real_tpl_2_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist136_chanIn_cunroll_x_in_d_real_tpl_3(DELAY,742)
    redist136_chanIn_cunroll_x_in_d_real_tpl_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist136_chanIn_cunroll_x_in_d_real_tpl_3_q <= (others => '0');
            ELSE
                redist136_chanIn_cunroll_x_in_d_real_tpl_3_q <= STD_LOGIC_VECTOR(redist135_chanIn_cunroll_x_in_d_real_tpl_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,514)@1 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist136_chanIn_cunroll_x_in_d_real_tpl_3_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist134_chanIn_cunroll_x_in_d_real_tpl_1_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,80)@2
    -- out out_primWireOut@5
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,706)
    redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_1(DELAY,743)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_1_q <= (others => '0');
            ELSE
                redist137_chanIn_cunroll_x_in_d_imag_tpl_1_q <= STD_LOGIC_VECTOR(in_d_imag_tpl);
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_2(DELAY,744)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q <= (others => '0');
            ELSE
                redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,35)@1
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(MUX,57)@1 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist139_chanIn_cunroll_x_in_d_imag_tpl_3(DELAY,745)
    redist139_chanIn_cunroll_x_in_d_imag_tpl_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist139_chanIn_cunroll_x_in_d_imag_tpl_3_q <= (others => '0');
            ELSE
                redist139_chanIn_cunroll_x_in_d_imag_tpl_3_q <= STD_LOGIC_VECTOR(redist138_chanIn_cunroll_x_in_d_imag_tpl_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,513)@1 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist139_chanIn_cunroll_x_in_d_imag_tpl_3_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist137_chanIn_cunroll_x_in_d_imag_tpl_1_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,79)@2
    -- out out_primWireOut@5
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,707)
    redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,708)
    redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist120_chanIn_cunroll_x_validIn_6(DELAY,726)
    redist120_chanIn_cunroll_x_validIn_6_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist120_chanIn_cunroll_x_validIn_6_delay_0 <= (others => '0');
            ELSE
                redist120_chanIn_cunroll_x_validIn_6_delay_0 <= STD_LOGIC_VECTOR(redist119_chanIn_cunroll_x_validIn_1_q);
            END IF;
        END IF;
    END PROCESS;
    redist120_chanIn_cunroll_x_validIn_6_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist120_chanIn_cunroll_x_validIn_6_delay_1 <= redist120_chanIn_cunroll_x_validIn_6_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist120_chanIn_cunroll_x_validIn_6_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist120_chanIn_cunroll_x_validIn_6_delay_2 <= (others => '0');
            ELSE
                redist120_chanIn_cunroll_x_validIn_6_delay_2 <= redist120_chanIn_cunroll_x_validIn_6_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist120_chanIn_cunroll_x_validIn_6_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist120_chanIn_cunroll_x_validIn_6_delay_3 <= redist120_chanIn_cunroll_x_validIn_6_delay_2;
            END IF;
        END IF;
    END PROCESS;
    redist120_chanIn_cunroll_x_validIn_6_clkproc_4: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist120_chanIn_cunroll_x_validIn_6_q <= (others => '0');
            ELSE
                redist120_chanIn_cunroll_x_validIn_6_q <= redist120_chanIn_cunroll_x_validIn_6_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_counter_x(COUNTER,102)@5 + 1
    -- low=0, high=3, step=1, init=3
    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i <= TO_UNSIGNED(3, 2);
            ELSE
                IF (redist120_chanIn_cunroll_x_validIn_6_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i, 2)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select(BITSELECT,597)@6
    fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q(0 downto 0);
    fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q(1 downto 1);

    -- fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x(LOGICAL,98)@6 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x(MUX,152)@7
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s, redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1(DELAY,683)
    redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q <= (others => '0');
            ELSE
                redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,25)@6
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist121_chanIn_cunroll_x_validIn_7(DELAY,727)
    redist121_chanIn_cunroll_x_validIn_7_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist121_chanIn_cunroll_x_validIn_7_q <= (others => '0');
            ELSE
                redist121_chanIn_cunroll_x_validIn_7_q <= STD_LOGIC_VECTOR(redist120_chanIn_cunroll_x_validIn_6_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x(LOGICAL,97)@6
    fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q <= redist121_chanIn_cunroll_x_validIn_7_q and fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x(MUX,47)@6 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4(DELAY,684)
    redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_0 <= (others => '0');
            ELSE
                redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_0 <= STD_LOGIC_VECTOR(redist77_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_1_q);
            END IF;
        END IF;
    END PROCESS;
    redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_1 <= redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_q <= (others => '0');
            ELSE
                redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_q <= redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1(DELAY,691)
    redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x(MUX,446)@7
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s <= redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s, redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= redist78_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_4_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,69)@7
    -- out out_primWireOut@10
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,716)
    redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x(BLACKBOX,215)@11
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1(DELAY,661)
    redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist122_chanIn_cunroll_x_validIn_14(DELAY,728)
    redist122_chanIn_cunroll_x_validIn_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist121_chanIn_cunroll_x_validIn_7_q, xout => redist122_chanIn_cunroll_x_validIn_14_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x(COUNTER,132)@11 + 1
    -- low=0, high=15, step=1, init=15
    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i <= TO_UNSIGNED(15, 4);
            ELSE
                IF (redist122_chanIn_cunroll_x_validIn_14_q = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i, 4)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,591)@12
    fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x(BLACKBOX,153)@6
    thefft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1(DELAY,682)
    redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x(BLACKBOX,154)@7
    thefft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist76_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateIm_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x(MUX,151)@7
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s, redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateImconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1(DELAY,685)
    redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q <= (others => '0');
            ELSE
                redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,26)@6
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x(MUX,48)@6 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4(DELAY,686)
    redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_0 <= (others => '0');
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_0 <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_1_q);
            END IF;
        END IF;
    END PROCESS;
    redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_1 <= redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_q <= (others => '0');
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_q <= redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x(MUX,447)@7
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s <= redist85_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s, redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= redist80_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_4_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,70)@7
    -- out out_primWireOut@10
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,715)
    redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x(BLACKBOX,216)@11
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1(DELAY,660)
    redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,592)@12
    fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00100100100011010011000100110010";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x(BLACKBOX,15)@12
    -- out out_primWireOut@17
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1(DELAY,723)
    redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x(BLACKBOX,218)@18
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist117_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4(DELAY,656)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_0 <= (others => '0');
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_1 <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_q <= (others => '0');
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_q <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0(DELAY,879)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q <= (others => '0');
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,38)@18
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist123_chanIn_cunroll_x_validIn_20(DELAY,729)
    redist123_chanIn_cunroll_x_validIn_20 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist122_chanIn_cunroll_x_validIn_14_q, xout => redist123_chanIn_cunroll_x_validIn_20_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x(COUNTER,162)@17 + 1
    -- low=0, high=7, step=1, init=7
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i <= TO_UNSIGNED(7, 3);
            ELSE
                IF (redist123_chanIn_cunroll_x_validIn_20_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i, 3)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x(BITSELECT,161)@18
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q(2 downto 2);

    -- redist124_chanIn_cunroll_x_validIn_21(DELAY,730)
    redist124_chanIn_cunroll_x_validIn_21_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist124_chanIn_cunroll_x_validIn_21_q <= (others => '0');
            ELSE
                redist124_chanIn_cunroll_x_validIn_21_q <= STD_LOGIC_VECTOR(redist123_chanIn_cunroll_x_validIn_20_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x(LOGICAL,160)@18
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q <= redist124_chanIn_cunroll_x_validIn_21_q and fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x(MUX,60)@18 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0(DELAY,880)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0_q <= (others => '0');
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_4_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8(DELAY,657)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_0 <= (others => '0');
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_0 <= STD_LOGIC_VECTOR(redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_inputreg0_q);
            END IF;
        END IF;
    END PROCESS;
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_1 <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_q <= (others => '0');
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_q <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,520)@18 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_8_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,82)@19
    -- out out_primWireOut@22
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,703)
    redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x(BLACKBOX,14)@12
    -- out out_primWireOut@17
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist55_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist54_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1(DELAY,724)
    redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x(BLACKBOX,217)@18
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist118_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4(DELAY,658)
    redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_0 <= (others => '0');
            ELSE
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_1 <= redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_q <= (others => '0');
            ELSE
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_q <= redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0(DELAY,881)
    redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q <= (others => '0');
            ELSE
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q <= STD_LOGIC_VECTOR(redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,37)@18
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(MUX,59)@18 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0(DELAY,882)
    redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0_q <= (others => '0');
            ELSE
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0_q <= STD_LOGIC_VECTOR(redist52_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_4_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8(DELAY,659)
    redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_0 <= (others => '0');
            ELSE
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_0 <= STD_LOGIC_VECTOR(redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_inputreg0_q);
            END IF;
        END IF;
    END PROCESS;
    redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_1 <= redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_q <= (others => '0');
            ELSE
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_q <= redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,519)@18 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist53_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_8_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,81)@19
    -- out out_primWireOut@22
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,704)
    redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,705)
    redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist125_chanIn_cunroll_x_validIn_29(DELAY,731)
    redist125_chanIn_cunroll_x_validIn_29 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist124_chanIn_cunroll_x_validIn_21_q, xout => redist125_chanIn_cunroll_x_validIn_29_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_1_counter_x(COUNTER,109)@22 + 1
    -- low=0, high=15, step=1, init=15
    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i <= TO_UNSIGNED(15, 4);
            ELSE
                IF (redist125_chanIn_cunroll_x_validIn_29_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i, 4)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select(BITSELECT,598)@23
    fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q(2 downto 2);
    fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q(3 downto 3);

    -- fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x(LOGICAL,105)@23 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x(MUX,166)@24
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s, redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= redist99_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr(REG,1018)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr_q <= "100";
            ELSE
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr_q <= STD_LOGIC_VECTOR(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem(DUALMEM,1016)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q);
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_aa <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_wraddr_q;
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ab <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_rdcnt_q;
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_reset0 <= not (rst);
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 5,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_reset0,
        clock1 => clk,
        address_a => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_aa,
        data_a => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_ab,
        q_b => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_iq
    );
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_q <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_iq(31 downto 0);

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0(DELAY,1015)
    redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q <= (others => '0');
            ELSE
                redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q <= STD_LOGIC_VECTOR(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,27)@23
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist126_chanIn_cunroll_x_validIn_30(DELAY,732)
    redist126_chanIn_cunroll_x_validIn_30_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist126_chanIn_cunroll_x_validIn_30_q <= (others => '0');
            ELSE
                redist126_chanIn_cunroll_x_validIn_30_q <= STD_LOGIC_VECTOR(redist125_chanIn_cunroll_x_validIn_29_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x(LOGICAL,104)@23
    fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q <= redist126_chanIn_cunroll_x_validIn_30_q and fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x(MUX,49)@23 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_notEnable(LOGICAL,1033)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_nor(LOGICAL,1034)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_nor_q <= not (redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_notEnable_q or redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q);

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_last(CONSTANT,1030)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_last_q <= "0101";

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp(LOGICAL,1031)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_q);
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_q <= "1" WHEN redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_last_q = redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_b ELSE "0";

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg(REG,1032)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_q <= "0";
            ELSE
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_q <= STD_LOGIC_VECTOR(redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena(REG,1035)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q <= "0";
            ELSE
                IF (redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_nor_q = "1") THEN
                    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_enaAnd(LOGICAL,1036)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_enaAnd_q <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_sticky_ena_q and VCC_q;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt(COUNTER,1028)
    -- low=0, high=6, step=1, init=0
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq <= '0';
            ELSE
                IF (redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq <= '1';
                ELSE
                    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq <= '0';
                END IF;
                IF (redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_eq = '1') THEN
                    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i + 2;
                ELSE
                    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_i, 3)));

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0(DELAY,1026)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0_q <= (others => '0');
            ELSE
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0_q <= STD_LOGIC_VECTOR(redist72_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_7_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr(REG,1029)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr_q <= "110";
            ELSE
                redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr_q <= STD_LOGIC_VECTOR(redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem(DUALMEM,1027)
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ia <= STD_LOGIC_VECTOR(redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_inputreg0_q);
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_aa <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_wraddr_q;
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ab <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_rdcnt_q;
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_reset0 <= not (rst);
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_reset0,
        clock1 => clk,
        address_a => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_aa,
        data_a => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_ab,
        q_b => redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_iq
    );
    redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_q <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_iq(31 downto 0);

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1(DELAY,690)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x(MUX,452)@24
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s, redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= redist73_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_16_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,71)@24
    -- out out_primWireOut@27
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,714)
    redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x(BLACKBOX,245)@28
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1(DELAY,655)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroConst_x(CONSTANT,273)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroConst_x_q <= "00000000";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x(SUB,270)@25
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_a <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroConst_x_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_b <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_c);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_a) - UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_b));
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_o(8 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select(BITSELECT,604)@25
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q(7 downto 0);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q(8 downto 8);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1(DELAY,1093)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q <= (others => '0');
            ELSE
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q <= STD_LOGIC_VECTOR(redist129_chanIn_cunroll_x_validIn_40_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr(LOGICAL,1094)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr_q <= redist129_chanIn_cunroll_x_validIn_40_q or fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const(CONSTANT,556)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const_q <= "00000000000000000000000000000000";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- redist127_chanIn_cunroll_x_validIn_38(DELAY,733)
    redist127_chanIn_cunroll_x_validIn_38 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist126_chanIn_cunroll_x_validIn_30_q, xout => redist127_chanIn_cunroll_x_validIn_38_q, clk => clk, aclr => rst, ena => '1' );

    -- redist128_chanIn_cunroll_x_validIn_39(DELAY,734)
    redist128_chanIn_cunroll_x_validIn_39_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist128_chanIn_cunroll_x_validIn_39_q <= (others => '0');
            ELSE
                redist128_chanIn_cunroll_x_validIn_39_q <= STD_LOGIC_VECTOR(redist127_chanIn_cunroll_x_validIn_38_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist129_chanIn_cunroll_x_validIn_40(DELAY,735)
    redist129_chanIn_cunroll_x_validIn_40_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist129_chanIn_cunroll_x_validIn_40_q <= (others => '0');
            ELSE
                redist129_chanIn_cunroll_x_validIn_40_q <= STD_LOGIC_VECTOR(redist128_chanIn_cunroll_x_validIn_39_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x(CONSTANT,400)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q <= "0000000000";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x(CONSTANT,402)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q <= "0000";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x(COUNTER,135)@23 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (redist127_chanIn_cunroll_x_validIn_38_q = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select(BITSELECT,602)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q(9 downto 4);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q(3 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x(LOGICAL,395)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q <= "1" WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c = fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q ELSE "0";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x(LOGICAL,394)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(0 downto 0) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(1 downto 1) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(2 downto 2) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(3 downto 3) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(4 downto 4) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(5 downto 5);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x(MUX,398)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s <= redist128_chanIn_cunroll_x_validIn_39_q;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q;
            WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= STD_LOGIC_VECTOR("0000" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q);
            WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x(ADD,392)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1 <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q = "1" ELSE fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q = "1" ELSE fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1));
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o(10 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x(BITSELECT,512)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q(9 downto 0);

    -- redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1(DELAY,612)
    redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select(BITSELECT,605)@25
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b <= redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q(9 downto 8);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_c <= redist6_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q(7 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x(DUALMEM,262)@25 + 2
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_aa <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ab <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_b;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_reset0 <= not (rst);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "BIDIR_DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x.hex",
        init_file_layout => "PORT_B",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr_q(0),
        sclr => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_reset0,
        clock0 => clk,
        address_a => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_aa,
        wren_a => '0',
        q_a => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ir,
        rden_a => redist129_chanIn_cunroll_x_validIn_40_q(0),
        address_b => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ab,
        wren_b => '0',
        q_b => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_iq,
        rden_b => redist129_chanIn_cunroll_x_validIn_40_q(0)
    );
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_iq(31 downto 0);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ir(31 downto 0);

    -- redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2(DELAY,607)
    redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_delay_0 <= (others => '0');
            ELSE
                redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c);
            END IF;
        END IF;
    END PROCESS;
    redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_q <= redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x(MUX,263)@27
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_s <= redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2_q;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_s, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const_q, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const_q;
            WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2(DELAY,606)
    redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_delay_0 <= (others => '0');
            ELSE
                redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b);
            END IF;
        END IF;
    END PROCESS;
    redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_q <= redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select(BITSELECT,603)@27
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_b <= redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_q(0 downto 0);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c <= redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2_q(1 downto 1);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x(MUX,404)@27
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_s <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_b;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_s, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r)
    BEGIN
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q;
            WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r;
            WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x(BLACKBOX,267)@27
    thefft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1(DELAY,648)
    redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_castNegateSin_x(BLACKBOX,13)@28
    thedupName_0_castNegateSin_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist42_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_castNegateSin_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1(DELAY,625)
    redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_q <= (others => '0');
            ELSE
                redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1(DELAY,608)
    redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_q <= (others => '0');
            ELSE
                redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xnorBlock_x(LOGICAL,271)@28
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xnorBlock_x_q <= not (redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_q xor VCC_q);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x(MUX,265)@28 + 1
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_s <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xnorBlock_x_q;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q <= redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_q;
                    WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q <= dupName_0_castNegateSin_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_notEnable(LOGICAL,1044)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_nor(LOGICAL,1045)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_nor_q <= not (redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_notEnable_q or redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q);

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_last(CONSTANT,1041)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_last_q <= "011";

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmp(LOGICAL,1042)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmp_q <= "1" WHEN redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_last_q = redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_q ELSE "0";

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg(REG,1043)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_q <= "0";
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_q <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena(REG,1046)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q <= "0";
            ELSE
                IF (redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_nor_q = "1") THEN
                    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_enaAnd(LOGICAL,1047)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_enaAnd_q <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_sticky_ena_q and VCC_q;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt(COUNTER,1039)
    -- low=0, high=4, step=1, init=0
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq <= '0';
            ELSE
                IF (redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq <= '1';
                ELSE
                    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq <= '0';
                END IF;
                IF (redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_eq = '1') THEN
                    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i + 4;
                ELSE
                    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_i, 3)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x(BLACKBOX,167)@23
    thefft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist98_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1(DELAY,677)
    redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x(BLACKBOX,168)@24
    thefft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist71_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateIm_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x(MUX,165)@24
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s, redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= redist97_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateImconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr(REG,1040)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr_q <= "100";
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr_q <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem(DUALMEM,1038)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q);
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_aa <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_wraddr_q;
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ab <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_rdcnt_q;
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_reset0 <= not (rst);
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 5,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_reset0,
        clock1 => clk,
        address_a => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_aa,
        data_a => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_ab,
        q_b => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_iq
    );
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_q <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_iq(31 downto 0);

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0(DELAY,1037)
    redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q <= (others => '0');
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,28)@23
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x(MUX,50)@23 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_notEnable(LOGICAL,1055)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_nor(LOGICAL,1056)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_nor_q <= not (redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_notEnable_q or redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q);

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_last(CONSTANT,1052)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_last_q <= "0101";

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp(LOGICAL,1053)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_q);
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_q <= "1" WHEN redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_last_q = redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_b ELSE "0";

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg(REG,1054)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_q <= "0";
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena(REG,1057)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q <= "0";
            ELSE
                IF (redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_nor_q = "1") THEN
                    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_enaAnd(LOGICAL,1058)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_enaAnd_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_sticky_ena_q and VCC_q;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt(COUNTER,1050)
    -- low=0, high=6, step=1, init=0
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq <= '0';
            ELSE
                IF (redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq <= '1';
                ELSE
                    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq <= '0';
                END IF;
                IF (redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_eq = '1') THEN
                    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i + 2;
                ELSE
                    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_i, 3)));

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0(DELAY,1048)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0_q <= (others => '0');
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0_q <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_7_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr(REG,1051)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr_q <= "110";
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem(DUALMEM,1049)
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ia <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_inputreg0_q);
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_aa <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_wraddr_q;
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ab <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_rdcnt_q;
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_reset0 <= not (rst);
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 7,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_reset0,
        clock1 => clk,
        address_a => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_aa,
        data_a => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_ab,
        q_b => redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_iq
    );
    redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x(MUX,453)@24
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s, redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_16_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,72)@24
    -- out out_primWireOut@27
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,713)
    redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x(BLACKBOX,246)@28
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1(DELAY,654)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x(MUX,403)@27
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_s <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_b;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_s, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r;
            WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux1_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x(BLACKBOX,266)@27
    thefft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1(DELAY,649)
    redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_castNegateCos_x(BLACKBOX,12)@28
    thedupName_0_castNegateCos_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist43_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_castNegateCos_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1(DELAY,626)
    redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_q <= (others => '0');
            ELSE
                redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x(LOGICAL,272)@27 + 1
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_qi <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_b xor fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_qi, xout => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x(MUX,264)@28 + 1
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_s <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xorBlock_x_q;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q <= redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_q;
                    WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q <= dupName_0_castNegateCos_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x(BLACKBOX,17)@29
    -- out out_primWireOut@34
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q,
        in_1 => redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q,
        in_3 => redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1(DELAY,721)
    redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x(BLACKBOX,248)@35
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist115_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr(REG,838)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr_q <= "1101";
            ELSE
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr_q <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem(DUALMEM,836)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut);
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_aa <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_wraddr_q;
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ab <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_rdcnt_q;
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_reset0 <= not (rst);
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 14,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_reset0,
        clock1 => clk,
        address_a => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_aa,
        data_a => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_ab,
        q_b => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_iq
    );
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_q <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_iq(31 downto 0);

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0(DELAY,835)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q <= (others => '0');
            ELSE
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,40)@35
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist130_chanIn_cunroll_x_validIn_49(DELAY,736)
    redist130_chanIn_cunroll_x_validIn_49 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist129_chanIn_cunroll_x_validIn_40_q, xout => redist130_chanIn_cunroll_x_validIn_49_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x(COUNTER,176)@34 + 1
    -- low=0, high=31, step=1, init=31
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i <= TO_UNSIGNED(31, 5);
            ELSE
                IF (redist130_chanIn_cunroll_x_validIn_49_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i, 5)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x(BITSELECT,175)@35
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q(4 downto 4);

    -- redist131_chanIn_cunroll_x_validIn_50(DELAY,737)
    redist131_chanIn_cunroll_x_validIn_50_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist131_chanIn_cunroll_x_validIn_50_q <= (others => '0');
            ELSE
                redist131_chanIn_cunroll_x_validIn_50_q <= STD_LOGIC_VECTOR(redist130_chanIn_cunroll_x_validIn_49_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x(LOGICAL,174)@35
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q <= redist131_chanIn_cunroll_x_validIn_50_q and fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x(MUX,62)@35 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable(LOGICAL,853)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor(LOGICAL,854)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q <= not (redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q or redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q);

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last(CONSTANT,850)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q <= "01100";

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp(LOGICAL,851)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q);
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q <= "1" WHEN redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q = redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b ELSE "0";

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg(REG,852)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q <= "0";
            ELSE
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q <= STD_LOGIC_VECTOR(redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena(REG,855)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q <= "0";
            ELSE
                IF (redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q = "1") THEN
                    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd(LOGICAL,856)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q and VCC_q;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt(COUNTER,848)
    -- low=0, high=13, step=1, init=0
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '0';
            ELSE
                IF (redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '1';
                ELSE
                    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '0';
                END IF;
                IF (redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq = '1') THEN
                    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i + 3;
                ELSE
                    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i, 4)));

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0(DELAY,846)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0_q <= (others => '0');
            ELSE
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0_q <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_16_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr(REG,849)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q <= "1101";
            ELSE
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q <= STD_LOGIC_VECTOR(redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem(DUALMEM,847)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia <= STD_LOGIC_VECTOR(redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_inputreg0_q);
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q;
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q;
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0 <= not (rst);
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 14,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0,
        clock1 => clk,
        address_a => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa,
        data_a => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab,
        q_b => redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq
    );
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,526)@35 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,84)@36
    -- out out_primWireOut@39
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,700)
    redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_notEnable(LOGICAL,864)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_nor(LOGICAL,865)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_nor_q <= not (redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_notEnable_q or redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q);

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_last(CONSTANT,861)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_last_q <= "01100";

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp(LOGICAL,862)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_q);
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_q <= "1" WHEN redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_last_q = redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_b ELSE "0";

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg(REG,863)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_q <= "0";
            ELSE
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_q <= STD_LOGIC_VECTOR(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena(REG,866)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q <= "0";
            ELSE
                IF (redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_nor_q = "1") THEN
                    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_enaAnd(LOGICAL,867)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_enaAnd_q <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_sticky_ena_q and VCC_q;

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt(COUNTER,859)
    -- low=0, high=13, step=1, init=0
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '0';
            ELSE
                IF (redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '1';
                ELSE
                    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '0';
                END IF;
                IF (redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_eq = '1') THEN
                    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i + 3;
                ELSE
                    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_i, 4)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x(BLACKBOX,16)@29
    -- out out_primWireOut@34
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q,
        in_1 => redist49_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q,
        in_3 => redist48_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1(DELAY,722)
    redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x(BLACKBOX,247)@35
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist116_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr(REG,860)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr_q <= "1101";
            ELSE
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr_q <= STD_LOGIC_VECTOR(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem(DUALMEM,858)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut);
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_aa <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_wraddr_q;
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ab <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_rdcnt_q;
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_reset0 <= not (rst);
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 14,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_reset0,
        clock1 => clk,
        address_a => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_aa,
        data_a => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_ab,
        q_b => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_iq
    );
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_q <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_iq(31 downto 0);

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0(DELAY,857)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q <= (others => '0');
            ELSE
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q <= STD_LOGIC_VECTOR(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,39)@35
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(MUX,61)@35 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable(LOGICAL,875)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor(LOGICAL,876)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q <= not (redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q or redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q);

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last(CONSTANT,872)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q <= "01100";

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp(LOGICAL,873)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q);
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q <= "1" WHEN redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q = redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b ELSE "0";

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg(REG,874)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q <= "0";
            ELSE
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q <= STD_LOGIC_VECTOR(redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena(REG,877)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q <= "0";
            ELSE
                IF (redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q = "1") THEN
                    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd(LOGICAL,878)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q and VCC_q;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt(COUNTER,870)
    -- low=0, high=13, step=1, init=0
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '0';
            ELSE
                IF (redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i = TO_UNSIGNED(12, 4)) THEN
                    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '1';
                ELSE
                    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '0';
                END IF;
                IF (redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq = '1') THEN
                    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i + 3;
                ELSE
                    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i, 4)));

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0(DELAY,868)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0_q <= (others => '0');
            ELSE
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0_q <= STD_LOGIC_VECTOR(redist46_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_16_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr(REG,871)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q <= "1101";
            ELSE
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q <= STD_LOGIC_VECTOR(redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem(DUALMEM,869)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia <= STD_LOGIC_VECTOR(redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_inputreg0_q);
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q;
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q;
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0 <= not (rst);
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 14,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 14,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0,
        clock1 => clk,
        address_a => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa,
        data_a => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab,
        q_b => redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq
    );
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,525)@35 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist47_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,83)@36
    -- out out_primWireOut@39
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,701)
    redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,702)
    redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,473)
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "10000";

    -- redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,623)
    redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist132_chanIn_cunroll_x_validIn_53(DELAY,738)
    redist132_chanIn_cunroll_x_validIn_53_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist132_chanIn_cunroll_x_validIn_53_delay_0 <= (others => '0');
            ELSE
                redist132_chanIn_cunroll_x_validIn_53_delay_0 <= STD_LOGIC_VECTOR(redist131_chanIn_cunroll_x_validIn_50_q);
            END IF;
        END IF;
    END PROCESS;
    redist132_chanIn_cunroll_x_validIn_53_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist132_chanIn_cunroll_x_validIn_53_delay_1 <= redist132_chanIn_cunroll_x_validIn_53_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist132_chanIn_cunroll_x_validIn_53_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist132_chanIn_cunroll_x_validIn_53_q <= (others => '0');
            ELSE
                redist132_chanIn_cunroll_x_validIn_53_q <= redist132_chanIn_cunroll_x_validIn_53_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,469)@38 + 1
    -- low=0, high=31, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 5);
            ELSE
                IF (redist132_chanIn_cunroll_x_validIn_53_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i, 5)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,468)@39
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q(4 downto 4);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,532)@39
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist17_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,470)@38
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("00000" & fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(5 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,533)@38
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(4 downto 0);

    -- redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,611)
    redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,472)@39
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist5_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(4 downto 4);

    -- fft_fftLight_FFTPipe_FFT4Block_2_counter_x(COUNTER,116)@39 + 1
    -- low=0, high=63, step=1, init=63
    fft_fftLight_FFTPipe_FFT4Block_2_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i <= TO_UNSIGNED(63, 6);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_counter_x_i, 6)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select(BITSELECT,599)@40
    fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q(4 downto 4);
    fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q(5 downto 5);

    -- fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x(LOGICAL,112)@40 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x(MUX,180)@41
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s, redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= redist96_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr(REG,974)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr_q <= "11100";
            ELSE
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr_q <= STD_LOGIC_VECTOR(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem(DUALMEM,972)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q);
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_aa <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_wraddr_q;
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ab <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_rdcnt_q;
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_reset0 <= not (rst);
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 29,
        width_b => 32,
        widthad_b => 5,
        numwords_b => 29,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_reset0,
        clock1 => clk,
        address_a => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_aa,
        data_a => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_ab,
        q_b => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_iq
    );
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_q <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_iq(31 downto 0);

    -- redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0(DELAY,971)
    redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q <= (others => '0');
            ELSE
                redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q <= STD_LOGIC_VECTOR(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,29)@40
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1(DELAY,621)
    redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= (others => '0');
            ELSE
                redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x(LOGICAL,111)@40
    fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q <= redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q and fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x(MUX,51)@40 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_notEnable(LOGICAL,989)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_nor(LOGICAL,990)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_nor_q <= not (redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_notEnable_q or redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q);

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_last(CONSTANT,986)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_last_q <= "011101";

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp(LOGICAL,987)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_q);
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_q <= "1" WHEN redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_last_q = redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_b ELSE "0";

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg(REG,988)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_q <= "0";
            ELSE
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_q <= STD_LOGIC_VECTOR(redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena(REG,991)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q <= "0";
            ELSE
                IF (redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_nor_q = "1") THEN
                    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_enaAnd(LOGICAL,992)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_enaAnd_q <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_sticky_ena_q and VCC_q;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt(COUNTER,984)
    -- low=0, high=30, step=1, init=0
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq <= '0';
            ELSE
                IF (redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i = TO_UNSIGNED(29, 5)) THEN
                    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq <= '1';
                ELSE
                    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq <= '0';
                END IF;
                IF (redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_eq = '1') THEN
                    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i + 2;
                ELSE
                    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_i, 5)));

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0(DELAY,982)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0_q <= (others => '0');
            ELSE
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0_q <= STD_LOGIC_VECTOR(redist67_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_31_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr(REG,985)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr_q <= "11110";
            ELSE
                redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr_q <= STD_LOGIC_VECTOR(redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem(DUALMEM,983)
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ia <= STD_LOGIC_VECTOR(redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_inputreg0_q);
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_aa <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_wraddr_q;
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ab <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_rdcnt_q;
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_reset0 <= not (rst);
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 32,
        widthad_b => 5,
        numwords_b => 31,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_reset0,
        clock1 => clk,
        address_a => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_aa,
        data_a => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_ab,
        q_b => redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_iq
    );
    redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_q <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_iq(31 downto 0);

    -- redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1(DELAY,689)
    redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x(MUX,458)@41
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s <= redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s, redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= redist68_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_64_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,73)@41
    -- out out_primWireOut@44
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,712)
    redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x(BLACKBOX,275)@45
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1(DELAY,647)
    redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x(CONSTANT,344)
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q <= "100000";

    -- redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,635)
    redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5(DELAY,622)
    redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 <= (others => '0');
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 <= STD_LOGIC_VECTOR(redist15_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q);
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1 <= redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 <= (others => '0');
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 <= redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q <= redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x(COUNTER,340)@44 + 1
    -- low=0, high=63, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 6);
            ELSE
                IF (redist16_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i, 6)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x(BITSELECT,339)@45
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q(5 downto 5);

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,465)@45
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b xor redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x(ADD,341)@44
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("000000" & fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o(6 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,466)@44
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q(5 downto 0);

    -- redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,624)
    redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,343)@45
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b <= redist18_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(5 downto 5);

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x(COUNTER,138)@45 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x(BITSELECT,139)@46
    fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b <= fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q(9 downto 4);

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,593)@46
    fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b) IS
            WHEN "000000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "000110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "001000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "001010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "001011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "001100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "001110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "001111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "010000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "010001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110010001111100010111000010";
            WHEN "010010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "010011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111000011100011100111011010";
            WHEN "010100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "010101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010101001101101100110001";
            WHEN "010110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "010111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110010001111100010111000010";
            WHEN "011000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "011001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111000011100011100111011010";
            WHEN "011010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "011011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011110110001010010111110";
            WHEN "011100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "011101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011110110001010010111110";
            WHEN "011110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "011111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010101001101101100110001";
            WHEN "100000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "100001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111101110010001011110100110110";
            WHEN "100010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110010001111100010111000010";
            WHEN "100011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110100101001010000000110001";
            WHEN "100100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "100101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010001011110010000000011";
            WHEN "100110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011110110001010010111110";
            WHEN "100111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110111100010101101011101010";
            WHEN "101000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "101001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110111100010101101011101010";
            WHEN "101010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010101001101101100110001";
            WHEN "101011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011111101100010001101101";
            WHEN "101100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "101101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011101001111101000001011";
            WHEN "101110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111000011100011100111011010";
            WHEN "101111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001000100110011110011001";
            WHEN "110000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "110001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110100101001010000000110001";
            WHEN "110010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111000011100011100111011010";
            WHEN "110011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010001011110010000000011";
            WHEN "110100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "110101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011000011100010110011000";
            WHEN "110110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010101001101101100110001";
            WHEN "110111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111101110010001011110100110110";
            WHEN "111000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "111001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001000100110011110011001";
            WHEN "111010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011110110001010010111110";
            WHEN "111011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011000011100010110011000";
            WHEN "111100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "111101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011111101100010001101101";
            WHEN "111110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110010001111100010111000010";
            WHEN "111111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011101001111101000001011";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_notEnable(LOGICAL,1000)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_nor(LOGICAL,1001)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_nor_q <= not (redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_notEnable_q or redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q);

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_last(CONSTANT,997)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_last_q <= "011011";

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp(LOGICAL,998)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_b <= STD_LOGIC_VECTOR("0" & redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_q);
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_q <= "1" WHEN redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_last_q = redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_b ELSE "0";

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg(REG,999)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_q <= "0";
            ELSE
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena(REG,1002)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q <= "0";
            ELSE
                IF (redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_nor_q = "1") THEN
                    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_enaAnd(LOGICAL,1003)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_enaAnd_q <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_sticky_ena_q and VCC_q;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt(COUNTER,995)
    -- low=0, high=28, step=1, init=0
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq <= '0';
            ELSE
                IF (redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i = TO_UNSIGNED(27, 5)) THEN
                    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq <= '1';
                ELSE
                    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq <= '0';
                END IF;
                IF (redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_eq = '1') THEN
                    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i + 4;
                ELSE
                    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_i, 5)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x(BLACKBOX,181)@40
    thefft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist95_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1(DELAY,672)
    redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x(BLACKBOX,182)@41
    thefft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist66_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateIm_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x(MUX,179)@41
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s, redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= redist94_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateImconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr(REG,996)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr_q <= "11100";
            ELSE
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem(DUALMEM,994)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q);
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_aa <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_wraddr_q;
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ab <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_rdcnt_q;
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_reset0 <= not (rst);
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 29,
        width_b => 32,
        widthad_b => 5,
        numwords_b => 29,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_reset0,
        clock1 => clk,
        address_a => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_aa,
        data_a => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_ab,
        q_b => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_iq
    );
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_q <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_iq(31 downto 0);

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0(DELAY,993)
    redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q <= (others => '0');
            ELSE
                redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,30)@40
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x(MUX,52)@40 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_notEnable(LOGICAL,1011)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_nor(LOGICAL,1012)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_nor_q <= not (redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_notEnable_q or redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q);

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_last(CONSTANT,1008)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_last_q <= "011101";

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp(LOGICAL,1009)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_q);
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_q <= "1" WHEN redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_last_q = redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_b ELSE "0";

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg(REG,1010)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_q <= "0";
            ELSE
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_q <= STD_LOGIC_VECTOR(redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena(REG,1013)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q <= "0";
            ELSE
                IF (redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_nor_q = "1") THEN
                    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_enaAnd(LOGICAL,1014)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_enaAnd_q <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_sticky_ena_q and VCC_q;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt(COUNTER,1006)
    -- low=0, high=30, step=1, init=0
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq <= '0';
            ELSE
                IF (redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i = TO_UNSIGNED(29, 5)) THEN
                    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq <= '1';
                ELSE
                    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq <= '0';
                END IF;
                IF (redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_eq = '1') THEN
                    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i + 2;
                ELSE
                    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_i, 5)));

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0(DELAY,1004)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0_q <= (others => '0');
            ELSE
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_31_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr(REG,1007)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr_q <= "11110";
            ELSE
                redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr_q <= STD_LOGIC_VECTOR(redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem(DUALMEM,1005)
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ia <= STD_LOGIC_VECTOR(redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_inputreg0_q);
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_aa <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_wraddr_q;
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ab <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_rdcnt_q;
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_reset0 <= not (rst);
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 32,
        widthad_b => 5,
        numwords_b => 31,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_reset0,
        clock1 => clk,
        address_a => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_aa,
        data_a => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_ab,
        q_b => redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_iq
    );
    redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_q <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x(MUX,459)@41
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s <= redist83_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s, redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= redist70_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_64_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,74)@41
    -- out out_primWireOut@44
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,711)
    redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x(BLACKBOX,276)@45
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1(DELAY,646)
    redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,594)@46
    fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_2_extractCount_x_b) IS
            WHEN "000000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "000110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00100100100011010011000100110010";
            WHEN "000111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "001000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "001010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "001011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "001100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "001110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "001111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN "010000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "010001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011110110001010010111110";
            WHEN "010010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "010011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "010100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "010101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111000011100011100111011010";
            WHEN "010110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110110000111110111100010101";
            WHEN "010111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011110110001010010111110";
            WHEN "011000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "011001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "011010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "011011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110010001111100010111000010";
            WHEN "011100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "011101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110010001111100010111000010";
            WHEN "011110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN "011111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111000011100011100111011010";
            WHEN "100000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "100001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011111101100010001101101";
            WHEN "100010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011110110001010010111110";
            WHEN "100011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011101001111101000001011";
            WHEN "100100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "100101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001000100110011110011001";
            WHEN "100110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110010001111100010111000010";
            WHEN "100111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011000011100010110011000";
            WHEN "101000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "101001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011000011100010110011000";
            WHEN "101010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111000011100011100111011010";
            WHEN "101011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111101110010001011110100110110";
            WHEN "101100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "101101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110100101001010000000110001";
            WHEN "101110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111010101001101101100110001";
            WHEN "101111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111010001011110010000000011";
            WHEN "110000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "110001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011101001111101000001011";
            WHEN "110010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "110011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001000100110011110011001";
            WHEN "110100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "110101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110111100010101101011101010";
            WHEN "110110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111000011100011100111011010";
            WHEN "110111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011111101100010001101101";
            WHEN "111000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "111001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010001011110010000000011";
            WHEN "111010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110010001111100010111000010";
            WHEN "111011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110111100010101101011101010";
            WHEN "111100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "111101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111101110010001011110100110110";
            WHEN "111110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011110110001010010111110";
            WHEN "111111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110100101001010000000110001";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x(BLACKBOX,19)@46
    -- out out_primWireOut@51
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1(DELAY,719)
    redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x(BLACKBOX,278)@52
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist113_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr(REG,794)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr_q <= "111101";
            ELSE
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr_q <= STD_LOGIC_VECTOR(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem(DUALMEM,792)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut);
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_aa <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_wraddr_q;
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ab <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_rdcnt_q;
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_reset0 <= not (rst);
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 62,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 62,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_reset0,
        clock1 => clk,
        address_a => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_aa,
        data_a => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_ab,
        q_b => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_iq
    );
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_q <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_iq(31 downto 0);

    -- redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0(DELAY,791)
    redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q <= (others => '0');
            ELSE
                redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q <= STD_LOGIC_VECTOR(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,42)@52
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6(DELAY,632)
    redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b, xout => redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x(COUNTER,190)@51 + 1
    -- low=0, high=127, step=1, init=127
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i <= TO_UNSIGNED(127, 7);
            ELSE
                IF (redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i, 7)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x(BITSELECT,189)@52
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q(6 downto 6);

    -- redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7(DELAY,633)
    redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= (others => '0');
            ELSE
                redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= STD_LOGIC_VECTOR(redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_6_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x(LOGICAL,188)@52
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q <= redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_q and fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x(MUX,64)@52 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_notEnable(LOGICAL,809)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_nor(LOGICAL,810)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_nor_q <= not (redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_notEnable_q or redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_q);

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_last(CONSTANT,806)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_last_q <= "0111100";

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp(LOGICAL,807)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_q);
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_q <= "1" WHEN redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_last_q = redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_b ELSE "0";

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg(REG,808)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg_q <= "0";
            ELSE
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg_q <= STD_LOGIC_VECTOR(redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena(REG,811)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_q <= "0";
            ELSE
                IF (redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_nor_q = "1") THEN
                    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_enaAnd(LOGICAL,812)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_enaAnd_q <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_sticky_ena_q and VCC_q;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt(COUNTER,804)
    -- low=0, high=61, step=1, init=0
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '0';
            ELSE
                IF (redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i = TO_UNSIGNED(60, 6)) THEN
                    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '1';
                ELSE
                    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '0';
                END IF;
                IF (redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_eq = '1') THEN
                    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i + 3;
                ELSE
                    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_i, 6)));

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0(DELAY,802)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0_q <= (others => '0');
            ELSE
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0_q <= STD_LOGIC_VECTOR(redist36_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_64_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr(REG,805)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr_q <= "111101";
            ELSE
                redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr_q <= STD_LOGIC_VECTOR(redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem(DUALMEM,803)
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ia <= STD_LOGIC_VECTOR(redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_inputreg0_q);
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_aa <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_wraddr_q;
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ab <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_rdcnt_q;
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_reset0 <= not (rst);
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 62,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 62,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_reset0,
        clock1 => clk,
        address_a => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_aa,
        data_a => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_ab,
        q_b => redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_iq
    );
    redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_q <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,536)@52 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist37_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_128_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,86)@53
    -- out out_primWireOut@56
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,697)
    redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_notEnable(LOGICAL,820)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_nor(LOGICAL,821)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_nor_q <= not (redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_notEnable_q or redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_q);

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_last(CONSTANT,817)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_last_q <= "0111100";

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp(LOGICAL,818)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_q);
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_q <= "1" WHEN redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_last_q = redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_b ELSE "0";

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg(REG,819)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg_q <= "0";
            ELSE
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena(REG,822)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_q <= "0";
            ELSE
                IF (redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_nor_q = "1") THEN
                    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_enaAnd(LOGICAL,823)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_enaAnd_q <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_sticky_ena_q and VCC_q;

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt(COUNTER,815)
    -- low=0, high=61, step=1, init=0
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '0';
            ELSE
                IF (redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i = TO_UNSIGNED(60, 6)) THEN
                    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '1';
                ELSE
                    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '0';
                END IF;
                IF (redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_eq = '1') THEN
                    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i + 3;
                ELSE
                    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_i, 6)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x(BLACKBOX,18)@46
    -- out out_primWireOut@51
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist41_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist40_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1(DELAY,720)
    redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x(BLACKBOX,277)@52
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist114_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr(REG,816)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr_q <= "111101";
            ELSE
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem(DUALMEM,814)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut);
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_aa <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_wraddr_q;
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ab <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_rdcnt_q;
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_reset0 <= not (rst);
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 62,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 62,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_reset0,
        clock1 => clk,
        address_a => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_aa,
        data_a => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_ab,
        q_b => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_iq
    );
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_q <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_iq(31 downto 0);

    -- redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0(DELAY,813)
    redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q <= (others => '0');
            ELSE
                redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,41)@52
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(MUX,63)@52 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_notEnable(LOGICAL,831)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_nor(LOGICAL,832)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_nor_q <= not (redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_notEnable_q or redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_q);

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_last(CONSTANT,828)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_last_q <= "0111100";

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp(LOGICAL,829)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_q);
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_q <= "1" WHEN redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_last_q = redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_b ELSE "0";

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg(REG,830)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg_q <= "0";
            ELSE
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg_q <= STD_LOGIC_VECTOR(redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena(REG,833)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_q <= "0";
            ELSE
                IF (redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_nor_q = "1") THEN
                    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_enaAnd(LOGICAL,834)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_enaAnd_q <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_sticky_ena_q and VCC_q;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt(COUNTER,826)
    -- low=0, high=61, step=1, init=0
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '0';
            ELSE
                IF (redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i = TO_UNSIGNED(60, 6)) THEN
                    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '1';
                ELSE
                    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '0';
                END IF;
                IF (redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_eq = '1') THEN
                    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i + 3;
                ELSE
                    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_i, 6)));

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0(DELAY,824)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0_q <= (others => '0');
            ELSE
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_64_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr(REG,827)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr_q <= "111101";
            ELSE
                redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr_q <= STD_LOGIC_VECTOR(redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem(DUALMEM,825)
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ia <= STD_LOGIC_VECTOR(redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_inputreg0_q);
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_aa <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_wraddr_q;
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ab <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_rdcnt_q;
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_reset0 <= not (rst);
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 62,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 62,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_reset0,
        clock1 => clk,
        address_a => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_aa,
        data_a => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_ab,
        q_b => redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_iq
    );
    redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_q <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,535)@52 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist39_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_128_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,85)@53
    -- out out_primWireOut@56
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,698)
    redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,699)
    redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,491)
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "1000000";

    -- redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,619)
    redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10(DELAY,634)
    redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 <= (others => '0');
            ELSE
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 <= STD_LOGIC_VECTOR(redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_7_q);
            END IF;
        END IF;
    END PROCESS;
    redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1 <= redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q <= (others => '0');
            ELSE
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q <= redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,487)@55 + 1
    -- low=0, high=127, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 7);
            ELSE
                IF (redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_i, 7)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,486)@56
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_counter_x_q(6 downto 6);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,542)@56
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist13_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,488)@55
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("0000000" & fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(7 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,543)@55
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(6 downto 0);

    -- redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,610)
    redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,490)@56
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist4_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(6 downto 6);

    -- fft_fftLight_FFTPipe_FFT4Block_3_counter_x(COUNTER,123)@56 + 1
    -- low=0, high=255, step=1, init=255
    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i <= TO_UNSIGNED(255, 8);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select(BITSELECT,600)@57
    fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q(6 downto 6);
    fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q(7 downto 7);

    -- fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x(LOGICAL,119)@57 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x(MUX,194)@58
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s, redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= redist93_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr(REG,930)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr_q <= "1111100";
            ELSE
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem(DUALMEM,928)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q);
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_aa <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_wraddr_q;
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ab <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_rdcnt_q;
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_reset0 <= not (rst);
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 125,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 125,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_reset0,
        clock1 => clk,
        address_a => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_aa,
        data_a => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_ab,
        q_b => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_iq
    );
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_q <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_iq(31 downto 0);

    -- redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0(DELAY,927)
    redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q <= (others => '0');
            ELSE
                redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,31)@57
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1(DELAY,617)
    redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= (others => '0');
            ELSE
                redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x(LOGICAL,118)@57
    fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q <= redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q and fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x(MUX,53)@57 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_notEnable(LOGICAL,945)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_nor(LOGICAL,946)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_nor_q <= not (redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_notEnable_q or redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_q);

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_last(CONSTANT,942)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_last_q <= "01111101";

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp(LOGICAL,943)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_q);
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_q <= "1" WHEN redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_last_q = redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_b ELSE "0";

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg(REG,944)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg_q <= "0";
            ELSE
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena(REG,947)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_q <= "0";
            ELSE
                IF (redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_nor_q = "1") THEN
                    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_enaAnd(LOGICAL,948)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_enaAnd_q <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_sticky_ena_q and VCC_q;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt(COUNTER,940)
    -- low=0, high=126, step=1, init=0
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq <= '0';
            ELSE
                IF (redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i = TO_UNSIGNED(125, 7)) THEN
                    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq <= '1';
                ELSE
                    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq <= '0';
                END IF;
                IF (redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_eq = '1') THEN
                    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i + 2;
                ELSE
                    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_i, 7)));

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0(DELAY,938)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0_q <= (others => '0');
            ELSE
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_127_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr(REG,941)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr_q <= "1111110";
            ELSE
                redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem(DUALMEM,939)
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ia <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_inputreg0_q);
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_aa <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_wraddr_q;
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ab <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_rdcnt_q;
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_reset0 <= not (rst);
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 127,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 127,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_reset0,
        clock1 => clk,
        address_a => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_aa,
        data_a => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_ab,
        q_b => redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_iq
    );
    redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_q <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_iq(31 downto 0);

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1(DELAY,688)
    redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x(MUX,476)@58
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s <= redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s, redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= redist63_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_256_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,75)@58
    -- out out_primWireOut@61
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,710)
    redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x(BLACKBOX,305)@62
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1(DELAY,641)
    redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_constBlock_x(CONSTANT,354)
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_constBlock_x_q <= "10000000";

    -- redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,631)
    redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5(DELAY,618)
    redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 <= (others => '0');
            ELSE
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0 <= STD_LOGIC_VECTOR(redist11_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q);
            END IF;
        END IF;
    END PROCESS;
    redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1 <= redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 <= (others => '0');
            ELSE
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2 <= redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q <= redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_delay_2;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x(COUNTER,350)@61 + 1
    -- low=0, high=255, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 8);
            ELSE
                IF (redist12_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_5_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x(BITSELECT,349)@62
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_counter_x_q(7 downto 7);

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,483)@62
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b xor redist25_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x(ADD,351)@61
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("00000000" & fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_o(8 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,484)@61
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoad_x_q(7 downto 0);

    -- redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,620)
    redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,353)@62
    fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b <= redist14_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(7 downto 7);

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x(COUNTER,141)@62 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x(BITSELECT,142)@63
    fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b <= fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q(9 downto 6);

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,595)@63
    fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_notEnable(LOGICAL,956)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_nor(LOGICAL,957)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_nor_q <= not (redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_notEnable_q or redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_q);

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_last(CONSTANT,953)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_last_q <= "01111011";

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp(LOGICAL,954)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_b <= STD_LOGIC_VECTOR("0" & redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_q);
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_q <= "1" WHEN redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_last_q = redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_b ELSE "0";

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg(REG,955)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg_q <= "0";
            ELSE
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena(REG,958)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_q <= "0";
            ELSE
                IF (redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_nor_q = "1") THEN
                    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_enaAnd(LOGICAL,959)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_enaAnd_q <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_sticky_ena_q and VCC_q;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt(COUNTER,951)
    -- low=0, high=124, step=1, init=0
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq <= '0';
            ELSE
                IF (redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i = TO_UNSIGNED(123, 7)) THEN
                    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq <= '1';
                ELSE
                    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq <= '0';
                END IF;
                IF (redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_eq = '1') THEN
                    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i + 4;
                ELSE
                    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_i, 7)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x(BLACKBOX,195)@57
    thefft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist92_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1(DELAY,667)
    redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x(BLACKBOX,196)@58
    thefft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist61_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateIm_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x(MUX,193)@58
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s, redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= redist91_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateImconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr(REG,952)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr_q <= "1111100";
            ELSE
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem(DUALMEM,950)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q);
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_aa <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_wraddr_q;
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ab <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_rdcnt_q;
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_reset0 <= not (rst);
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 125,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 125,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_reset0,
        clock1 => clk,
        address_a => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_aa,
        data_a => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_ab,
        q_b => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_iq
    );
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_q <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_iq(31 downto 0);

    -- redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0(DELAY,949)
    redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q <= (others => '0');
            ELSE
                redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,32)@57
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x(MUX,54)@57 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_notEnable(LOGICAL,967)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_nor(LOGICAL,968)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_nor_q <= not (redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_notEnable_q or redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_q);

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_last(CONSTANT,964)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_last_q <= "01111101";

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp(LOGICAL,965)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_q);
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_q <= "1" WHEN redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_last_q = redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_b ELSE "0";

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg(REG,966)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg_q <= "0";
            ELSE
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena(REG,969)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_q <= "0";
            ELSE
                IF (redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_nor_q = "1") THEN
                    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_enaAnd(LOGICAL,970)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_enaAnd_q <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_sticky_ena_q and VCC_q;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt(COUNTER,962)
    -- low=0, high=126, step=1, init=0
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '0';
            ELSE
                IF (redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i = TO_UNSIGNED(125, 7)) THEN
                    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '1';
                ELSE
                    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '0';
                END IF;
                IF (redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_eq = '1') THEN
                    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i + 2;
                ELSE
                    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_i, 7)));

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0(DELAY,960)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0_q <= (others => '0');
            ELSE
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_127_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr(REG,963)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr_q <= "1111110";
            ELSE
                redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem(DUALMEM,961)
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ia <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_inputreg0_q);
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_aa <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_wraddr_q;
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ab <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_rdcnt_q;
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_reset0 <= not (rst);
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 127,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 127,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_reset0,
        clock1 => clk,
        address_a => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_aa,
        data_a => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_ab,
        q_b => redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_iq
    );
    redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_q <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x(MUX,477)@58
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s <= redist82_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s, redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= redist65_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_256_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,76)@58
    -- out out_primWireOut@61
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,709)
    redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x(BLACKBOX,306)@62
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1(DELAY,640)
    redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,596)@63
    fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_3_extractCount_x_b) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00100100100011010011000100110010";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x(BLACKBOX,21)@63
    -- out out_primWireOut@68
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1(DELAY,717)
    redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x(BLACKBOX,308)@69
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist111_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr(REG,750)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr_q <= "11111101";
            ELSE
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr_q <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem(DUALMEM,748)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut);
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_aa <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_wraddr_q;
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ab <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_rdcnt_q;
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_reset0 <= not (rst);
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 254,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 254,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_reset0,
        clock1 => clk,
        address_a => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_aa,
        data_a => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_ab,
        q_b => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_iq
    );
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_q <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_iq(31 downto 0);

    -- redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0(DELAY,747)
    redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q <= (others => '0');
            ELSE
                redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,44)@69
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6(DELAY,629)
    redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b, xout => redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x(COUNTER,204)@68 + 1
    -- low=0, high=511, step=1, init=511
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i <= TO_UNSIGNED(511, 9);
            ELSE
                IF (redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i, 9)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x(BITSELECT,203)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q(8 downto 8);

    -- redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7(DELAY,630)
    redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= (others => '0');
            ELSE
                redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= STD_LOGIC_VECTOR(redist23_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_6_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x(LOGICAL,202)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q <= redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_q and fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b;

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x(MUX,66)@69 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_notEnable(LOGICAL,765)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_nor(LOGICAL,766)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_nor_q <= not (redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_notEnable_q or redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_q);

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_last(CONSTANT,762)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_last_q <= "011111100";

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp(LOGICAL,763)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_b <= STD_LOGIC_VECTOR("0" & redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_q);
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_q <= "1" WHEN redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_last_q = redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_b ELSE "0";

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg(REG,764)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg_q <= "0";
            ELSE
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg_q <= STD_LOGIC_VECTOR(redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena(REG,767)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_q <= "0";
            ELSE
                IF (redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_nor_q = "1") THEN
                    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_q <= STD_LOGIC_VECTOR(redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_enaAnd(LOGICAL,768)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_enaAnd_q <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_sticky_ena_q and VCC_q;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt(COUNTER,760)
    -- low=0, high=253, step=1, init=0
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq <= '0';
            ELSE
                IF (redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i = TO_UNSIGNED(252, 8)) THEN
                    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq <= '1';
                ELSE
                    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq <= '0';
                END IF;
                IF (redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_eq = '1') THEN
                    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i + 3;
                ELSE
                    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_i, 8)));

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0(DELAY,758)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0_q <= (others => '0');
            ELSE
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0_q <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_256_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr(REG,761)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr_q <= "11111101";
            ELSE
                redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr_q <= STD_LOGIC_VECTOR(redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem(DUALMEM,759)
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ia <= STD_LOGIC_VECTOR(redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_inputreg0_q);
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_aa <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_wraddr_q;
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ab <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_rdcnt_q;
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_reset0 <= not (rst);
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 254,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 254,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_reset0,
        clock1 => clk,
        address_a => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_aa,
        data_a => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_ab,
        q_b => redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_iq
    );
    redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_q <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,546)@69 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist31_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_512_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,88)@70
    -- out out_primWireOut@73
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,694)
    redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_notEnable(LOGICAL,776)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_nor(LOGICAL,777)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_nor_q <= not (redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_notEnable_q or redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_q);

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_last(CONSTANT,773)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_last_q <= "011111100";

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp(LOGICAL,774)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_q);
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_q <= "1" WHEN redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_last_q = redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_b ELSE "0";

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg(REG,775)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg_q <= "0";
            ELSE
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg_q <= STD_LOGIC_VECTOR(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena(REG,778)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_q <= "0";
            ELSE
                IF (redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_nor_q = "1") THEN
                    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_enaAnd(LOGICAL,779)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_enaAnd_q <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_sticky_ena_q and VCC_q;

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt(COUNTER,771)
    -- low=0, high=253, step=1, init=0
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '0';
            ELSE
                IF (redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i = TO_UNSIGNED(252, 8)) THEN
                    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '1';
                ELSE
                    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '0';
                END IF;
                IF (redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_eq = '1') THEN
                    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i + 3;
                ELSE
                    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_i, 8)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x(BLACKBOX,20)@63
    -- out out_primWireOut@68
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist35_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist34_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1(DELAY,718)
    redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x(BLACKBOX,307)@69
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist112_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr(REG,772)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr_q <= "11111101";
            ELSE
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr_q <= STD_LOGIC_VECTOR(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem(DUALMEM,770)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut);
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_aa <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_wraddr_q;
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ab <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_rdcnt_q;
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_reset0 <= not (rst);
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 254,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 254,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_reset0,
        clock1 => clk,
        address_a => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_aa,
        data_a => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_ab,
        q_b => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_iq
    );
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_q <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_iq(31 downto 0);

    -- redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0(DELAY,769)
    redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q <= (others => '0');
            ELSE
                redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q <= STD_LOGIC_VECTOR(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,43)@69
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(MUX,65)@69 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_notEnable(LOGICAL,787)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_nor(LOGICAL,788)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_nor_q <= not (redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_notEnable_q or redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_q);

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_last(CONSTANT,784)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_last_q <= "011111100";

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp(LOGICAL,785)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_b <= STD_LOGIC_VECTOR("0" & redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_q);
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_q <= "1" WHEN redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_last_q = redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_b ELSE "0";

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg(REG,786)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg_q <= "0";
            ELSE
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg_q <= STD_LOGIC_VECTOR(redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena(REG,789)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_q <= "0";
            ELSE
                IF (redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_nor_q = "1") THEN
                    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_q <= STD_LOGIC_VECTOR(redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_enaAnd(LOGICAL,790)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_enaAnd_q <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_sticky_ena_q and VCC_q;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt(COUNTER,782)
    -- low=0, high=253, step=1, init=0
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq <= '0';
            ELSE
                IF (redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i = TO_UNSIGNED(252, 8)) THEN
                    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq <= '1';
                ELSE
                    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq <= '0';
                END IF;
                IF (redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_eq = '1') THEN
                    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i + 3;
                ELSE
                    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_i, 8)));

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0(DELAY,780)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0_q <= (others => '0');
            ELSE
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0_q <= STD_LOGIC_VECTOR(redist32_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_256_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr(REG,783)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr_q <= "11111101";
            ELSE
                redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr_q <= STD_LOGIC_VECTOR(redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem(DUALMEM,781)
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ia <= STD_LOGIC_VECTOR(redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_inputreg0_q);
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_aa <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_wraddr_q;
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ab <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_rdcnt_q;
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_reset0 <= not (rst);
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 254,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 254,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_reset0,
        clock1 => clk,
        address_a => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_aa,
        data_a => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_ab,
        q_b => redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_iq
    );
    redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_q <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,545)@69 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist33_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_512_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,87)@70
    -- out out_primWireOut@73
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,695)
    redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,696)
    redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,509)
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "100000000";

    -- redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,615)
    redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,505)@69 + 1
    -- low=0, high=511, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 9);
            ELSE
                IF (redist24_fft_fftLight_FFTPipe_FFT4Block_3_delayValid_pulseMultiplier_bitExtract_x_b_7_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_i, 9)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,504)@70
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_counter_x_q(8 downto 8);

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,552)@70
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist9_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,506)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("000000000" & fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(9 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,553)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(8 downto 0);

    -- redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,609)
    redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,508)@70
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist3_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(8 downto 8);

    -- redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3(DELAY,613)
    redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 <= (others => '0');
            ELSE
                redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;
    redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1 <= redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q <= (others => '0');
            ELSE
                redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q <= redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_counter_x(COUNTER,130)@73 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select(BITSELECT,601)@74
    fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q(8 downto 8);
    fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q(9 downto 9);

    -- fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x(LOGICAL,126)@74 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x(MUX,208)@75
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s, redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= redist90_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr(REG,886)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr_q <= "111111100";
            ELSE
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem(DUALMEM,884)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q);
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_aa <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_wraddr_q;
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ab <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_rdcnt_q;
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_reset0 <= not (rst);
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 509,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 509,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_reset0,
        clock1 => clk,
        address_a => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_aa,
        data_a => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_ab,
        q_b => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_iq
    );
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_q <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_iq(31 downto 0);

    -- redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0(DELAY,883)
    redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q <= (others => '0');
            ELSE
                redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,33)@74
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4(DELAY,614)
    redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q <= (others => '0');
            ELSE
                redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q <= STD_LOGIC_VECTOR(redist7_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x(LOGICAL,125)@74
    fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q <= redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q and fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(MUX,55)@74 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_notEnable(LOGICAL,901)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_nor(LOGICAL,902)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_nor_q <= not (redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_notEnable_q or redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_q);

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_last(CONSTANT,898)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_last_q <= "0111111101";

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp(LOGICAL,899)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_b <= STD_LOGIC_VECTOR("0" & redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_q);
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_q <= "1" WHEN redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_last_q = redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_b ELSE "0";

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg(REG,900)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg_q <= "0";
            ELSE
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena(REG,903)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_q <= "0";
            ELSE
                IF (redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_nor_q = "1") THEN
                    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_enaAnd(LOGICAL,904)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_enaAnd_q <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_sticky_ena_q and VCC_q;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt(COUNTER,896)
    -- low=0, high=510, step=1, init=0
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq <= '0';
            ELSE
                IF (redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i = TO_UNSIGNED(509, 9)) THEN
                    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq <= '1';
                ELSE
                    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq <= '0';
                END IF;
                IF (redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_eq = '1') THEN
                    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i + 2;
                ELSE
                    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_i, 9)));

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0(DELAY,894)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0_q <= (others => '0');
            ELSE
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_511_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr(REG,897)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr_q <= "111111110";
            ELSE
                redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem(DUALMEM,895)
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ia <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_inputreg0_q);
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_aa <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_wraddr_q;
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ab <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_rdcnt_q;
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_reset0 <= not (rst);
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 511,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 511,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_reset0,
        clock1 => clk,
        address_a => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_aa,
        data_a => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_ab,
        q_b => redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_iq
    );
    redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_q <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_iq(31 downto 0);

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1(DELAY,687)
    redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x(MUX,494)@75
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s <= redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s, redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_q, fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= redist58_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1024_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,77)@75
    -- out out_primWireOut@78
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_notEnable(LOGICAL,912)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_nor(LOGICAL,913)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_nor_q <= not (redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_notEnable_q or redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_q);

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_last(CONSTANT,909)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_last_q <= "0111111011";

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp(LOGICAL,910)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_b <= STD_LOGIC_VECTOR("0" & redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_q);
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_q <= "1" WHEN redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_last_q = redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_b ELSE "0";

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg(REG,911)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg_q <= "0";
            ELSE
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena(REG,914)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_q <= "0";
            ELSE
                IF (redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_nor_q = "1") THEN
                    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_enaAnd(LOGICAL,915)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_enaAnd_q <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_sticky_ena_q and VCC_q;

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt(COUNTER,907)
    -- low=0, high=508, step=1, init=0
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq <= '0';
            ELSE
                IF (redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i = TO_UNSIGNED(507, 9)) THEN
                    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq <= '1';
                ELSE
                    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq <= '0';
                END IF;
                IF (redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_eq = '1') THEN
                    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i + 4;
                ELSE
                    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_i, 9)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x(BLACKBOX,209)@74
    thefft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist89_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1(DELAY,662)
    redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x(BLACKBOX,210)@75
    thefft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_castBlock_typeSFloatIEEE_23_8_ty00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist56_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateIm_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x(MUX,207)@75
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s, redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= redist88_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateImconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr(REG,908)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr_q <= "111111100";
            ELSE
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem(DUALMEM,906)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q);
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_aa <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_wraddr_q;
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ab <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_rdcnt_q;
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_reset0 <= not (rst);
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 509,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 509,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_reset0,
        clock1 => clk,
        address_a => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_aa,
        data_a => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_ab,
        q_b => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_iq
    );
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_q <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_iq(31 downto 0);

    -- redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0(DELAY,905)
    redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q <= (others => '0');
            ELSE
                redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,34)@74
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_negateBlock_typeSFloatIEEE_23_8_00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(MUX,56)@74 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_notEnable(LOGICAL,923)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_nor(LOGICAL,924)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_nor_q <= not (redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_notEnable_q or redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_q);

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_last(CONSTANT,920)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_last_q <= "0111111101";

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp(LOGICAL,921)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_b <= STD_LOGIC_VECTOR("0" & redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_q);
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_q <= "1" WHEN redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_last_q = redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_b ELSE "0";

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg(REG,922)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg_q <= "0";
            ELSE
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg_q <= STD_LOGIC_VECTOR(redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena(REG,925)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_q <= "0";
            ELSE
                IF (redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_nor_q = "1") THEN
                    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_q <= STD_LOGIC_VECTOR(redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_enaAnd(LOGICAL,926)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_enaAnd_q <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_sticky_ena_q and VCC_q;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt(COUNTER,918)
    -- low=0, high=510, step=1, init=0
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq <= '0';
            ELSE
                IF (redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i = TO_UNSIGNED(509, 9)) THEN
                    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq <= '1';
                ELSE
                    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq <= '0';
                END IF;
                IF (redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_eq = '1') THEN
                    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i + 2;
                ELSE
                    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_i, 9)));

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0(DELAY,916)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0_q <= (others => '0');
            ELSE
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_511_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr(REG,919)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr_q <= "111111110";
            ELSE
                redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr_q <= STD_LOGIC_VECTOR(redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem(DUALMEM,917)
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ia <= STD_LOGIC_VECTOR(redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_inputreg0_q);
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_aa <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_wraddr_q;
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ab <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_rdcnt_q;
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_reset0 <= not (rst);
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 511,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 511,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_reset0,
        clock1 => clk,
        address_a => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_aa,
        data_a => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_ab,
        q_b => redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_iq
    );
    redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_q <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x(MUX,495)@75
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s <= redist81_fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s, redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_q, fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= redist60_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1024_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,78)@75
    -- out out_primWireOut@78
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x : flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_addBlock_typeSFloatIEEE_23_8_typ0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist87_fft_latch_0L_mux_x_q_24_notEnable(LOGICAL,1066)
    redist87_fft_latch_0L_mux_x_q_24_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist87_fft_latch_0L_mux_x_q_24_nor(LOGICAL,1067)
    redist87_fft_latch_0L_mux_x_q_24_nor_q <= not (redist87_fft_latch_0L_mux_x_q_24_notEnable_q or redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q);

    -- redist87_fft_latch_0L_mux_x_q_24_mem_last(CONSTANT,1063)
    redist87_fft_latch_0L_mux_x_q_24_mem_last_q <= "010011";

    -- redist87_fft_latch_0L_mux_x_q_24_cmp(LOGICAL,1064)
    redist87_fft_latch_0L_mux_x_q_24_cmp_b <= STD_LOGIC_VECTOR("0" & redist87_fft_latch_0L_mux_x_q_24_rdcnt_q);
    redist87_fft_latch_0L_mux_x_q_24_cmp_q <= "1" WHEN redist87_fft_latch_0L_mux_x_q_24_mem_last_q = redist87_fft_latch_0L_mux_x_q_24_cmp_b ELSE "0";

    -- redist87_fft_latch_0L_mux_x_q_24_cmpReg(REG,1065)
    redist87_fft_latch_0L_mux_x_q_24_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_latch_0L_mux_x_q_24_cmpReg_q <= "0";
            ELSE
                redist87_fft_latch_0L_mux_x_q_24_cmpReg_q <= STD_LOGIC_VECTOR(redist87_fft_latch_0L_mux_x_q_24_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_latch_0L_mux_x_q_24_sticky_ena(REG,1068)
    redist87_fft_latch_0L_mux_x_q_24_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q <= "0";
            ELSE
                IF (redist87_fft_latch_0L_mux_x_q_24_nor_q = "1") THEN
                    redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q <= STD_LOGIC_VECTOR(redist87_fft_latch_0L_mux_x_q_24_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_latch_0L_mux_x_q_24_enaAnd(LOGICAL,1069)
    redist87_fft_latch_0L_mux_x_q_24_enaAnd_q <= redist87_fft_latch_0L_mux_x_q_24_sticky_ena_q and VCC_q;

    -- redist87_fft_latch_0L_mux_x_q_24_rdcnt(COUNTER,1061)
    -- low=0, high=20, step=1, init=0
    redist87_fft_latch_0L_mux_x_q_24_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_latch_0L_mux_x_q_24_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq <= '0';
            ELSE
                IF (redist87_fft_latch_0L_mux_x_q_24_rdcnt_i = TO_UNSIGNED(19, 5)) THEN
                    redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq <= '1';
                ELSE
                    redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq <= '0';
                END IF;
                IF (redist87_fft_latch_0L_mux_x_q_24_rdcnt_eq = '1') THEN
                    redist87_fft_latch_0L_mux_x_q_24_rdcnt_i <= redist87_fft_latch_0L_mux_x_q_24_rdcnt_i + 12;
                ELSE
                    redist87_fft_latch_0L_mux_x_q_24_rdcnt_i <= redist87_fft_latch_0L_mux_x_q_24_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist87_fft_latch_0L_mux_x_q_24_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist87_fft_latch_0L_mux_x_q_24_rdcnt_i, 5)));

    -- redist133_chanIn_cunroll_x_channelIn_54_notEnable(LOGICAL,1077)
    redist133_chanIn_cunroll_x_channelIn_54_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist133_chanIn_cunroll_x_channelIn_54_nor(LOGICAL,1078)
    redist133_chanIn_cunroll_x_channelIn_54_nor_q <= not (redist133_chanIn_cunroll_x_channelIn_54_notEnable_q or redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q);

    -- redist133_chanIn_cunroll_x_channelIn_54_mem_last(CONSTANT,1074)
    redist133_chanIn_cunroll_x_channelIn_54_mem_last_q <= "010001";

    -- redist133_chanIn_cunroll_x_channelIn_54_cmp(LOGICAL,1075)
    redist133_chanIn_cunroll_x_channelIn_54_cmp_b <= STD_LOGIC_VECTOR("0" & redist133_chanIn_cunroll_x_channelIn_54_rdcnt_q);
    redist133_chanIn_cunroll_x_channelIn_54_cmp_q <= "1" WHEN redist133_chanIn_cunroll_x_channelIn_54_mem_last_q = redist133_chanIn_cunroll_x_channelIn_54_cmp_b ELSE "0";

    -- redist133_chanIn_cunroll_x_channelIn_54_cmpReg(REG,1076)
    redist133_chanIn_cunroll_x_channelIn_54_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_cmpReg_q <= "0";
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_cmpReg_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_sticky_ena(REG,1079)
    redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q <= "0";
            ELSE
                IF (redist133_chanIn_cunroll_x_channelIn_54_nor_q = "1") THEN
                    redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_enaAnd(LOGICAL,1080)
    redist133_chanIn_cunroll_x_channelIn_54_enaAnd_q <= redist133_chanIn_cunroll_x_channelIn_54_sticky_ena_q and VCC_q;

    -- redist133_chanIn_cunroll_x_channelIn_54_rdcnt(COUNTER,1072)
    -- low=0, high=18, step=1, init=0
    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq <= '0';
            ELSE
                IF (redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i = TO_UNSIGNED(17, 5)) THEN
                    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq <= '1';
                ELSE
                    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq <= '0';
                END IF;
                IF (redist133_chanIn_cunroll_x_channelIn_54_rdcnt_eq = '1') THEN
                    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i <= redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i + 14;
                ELSE
                    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i <= redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist133_chanIn_cunroll_x_channelIn_54_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist133_chanIn_cunroll_x_channelIn_54_rdcnt_i, 5)));

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_nor(LOGICAL,1090)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_nor_q <= not (redist133_chanIn_cunroll_x_channelIn_54_notEnable_q or redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q);

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_last(CONSTANT,1086)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_last_q <= "011100";

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp(LOGICAL,1087)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_q);
    redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_q <= "1" WHEN redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_last_q = redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_b ELSE "0";

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg(REG,1088)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_q <= "0";
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena(REG,1091)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q <= "0";
            ELSE
                IF (redist133_chanIn_cunroll_x_channelIn_54_split_0_nor_q = "1") THEN
                    redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_enaAnd(LOGICAL,1092)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_enaAnd_q <= redist133_chanIn_cunroll_x_channelIn_54_split_0_sticky_ena_q and VCC_q;

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt(COUNTER,1084)
    -- low=0, high=29, step=1, init=0
    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq <= '0';
            ELSE
                IF (redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq <= '1';
                ELSE
                    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq <= '0';
                END IF;
                IF (redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_eq = '1') THEN
                    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i <= redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i + 3;
                ELSE
                    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i <= redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_i, 5)));

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0(DELAY,1081)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0_q <= (others => '0');
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0_q <= STD_LOGIC_VECTOR(channelIn);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr(REG,1085)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr_q <= "11101";
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_mem(DUALMEM,1083)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ia <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_inputreg0_q);
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_aa <= redist133_chanIn_cunroll_x_channelIn_54_split_0_wraddr_q;
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ab <= redist133_chanIn_cunroll_x_channelIn_54_split_0_rdcnt_q;
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_reset0 <= not (rst);
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 30,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 30,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist133_chanIn_cunroll_x_channelIn_54_split_0_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_reset0,
        clock1 => clk,
        address_a => redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_aa,
        data_a => redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_ab,
        q_b => redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_iq
    );
    redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_q <= redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_iq(7 downto 0);

    -- redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0(DELAY,1082)
    redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0_q <= (others => '0');
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_inputreg0(DELAY,1070)
    redist133_chanIn_cunroll_x_channelIn_54_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_inputreg0_q <= (others => '0');
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_inputreg0_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_split_0_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_wraddr(REG,1073)
    redist133_chanIn_cunroll_x_channelIn_54_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_channelIn_54_wraddr_q <= "10010";
            ELSE
                redist133_chanIn_cunroll_x_channelIn_54_wraddr_q <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist133_chanIn_cunroll_x_channelIn_54_mem(DUALMEM,1071)
    redist133_chanIn_cunroll_x_channelIn_54_mem_ia <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_channelIn_54_inputreg0_q);
    redist133_chanIn_cunroll_x_channelIn_54_mem_aa <= redist133_chanIn_cunroll_x_channelIn_54_wraddr_q;
    redist133_chanIn_cunroll_x_channelIn_54_mem_ab <= redist133_chanIn_cunroll_x_channelIn_54_rdcnt_q;
    redist133_chanIn_cunroll_x_channelIn_54_mem_reset0 <= not (rst);
    redist133_chanIn_cunroll_x_channelIn_54_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 19,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 19,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist133_chanIn_cunroll_x_channelIn_54_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist133_chanIn_cunroll_x_channelIn_54_mem_reset0,
        clock1 => clk,
        address_a => redist133_chanIn_cunroll_x_channelIn_54_mem_aa,
        data_a => redist133_chanIn_cunroll_x_channelIn_54_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist133_chanIn_cunroll_x_channelIn_54_mem_ab,
        q_b => redist133_chanIn_cunroll_x_channelIn_54_mem_iq
    );
    redist133_chanIn_cunroll_x_channelIn_54_mem_q <= redist133_chanIn_cunroll_x_channelIn_54_mem_iq(7 downto 0);

    -- redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1(DELAY,692)
    redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_pulseDivider_counter_x(COUNTER,93)@53 + 1
    -- low=0, high=2047, step=1, init=0
    fft_fftLight_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 11);
            ELSE
                IF (redist132_chanIn_cunroll_x_validIn_53_q = "1") THEN
                    fft_fftLight_pulseDivider_counter_x_i <= fft_fftLight_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_pulseDivider_counter_x_i, 11)));

    -- fft_fftLight_pulseDivider_bitExtract1_x(BITSELECT,92)@54
    fft_fftLight_pulseDivider_bitExtract1_x_b <= fft_fftLight_pulseDivider_counter_x_q(10 downto 10);

    -- fft_fftLight_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,144)@54
    fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_pulseDivider_bitExtract1_x_b xor redist86_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_latch_0L_mux_x(MUX,90)@54 + 1
    fft_latch_0L_mux_x_s <= fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q;
    fft_latch_0L_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_latch_0L_mux_x_q <= (others => '0');
            ELSE
                CASE (fft_latch_0L_mux_x_s) IS
                    WHEN "0" => fft_latch_0L_mux_x_q <= fft_latch_0L_mux_x_q;
                    WHEN "1" => fft_latch_0L_mux_x_q <= redist133_chanIn_cunroll_x_channelIn_54_mem_q;
                    WHEN OTHERS => fft_latch_0L_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_latch_0L_mux_x_q_24_wraddr(REG,1062)
    redist87_fft_latch_0L_mux_x_q_24_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_latch_0L_mux_x_q_24_wraddr_q <= "10100";
            ELSE
                redist87_fft_latch_0L_mux_x_q_24_wraddr_q <= STD_LOGIC_VECTOR(redist87_fft_latch_0L_mux_x_q_24_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_latch_0L_mux_x_q_24_mem(DUALMEM,1060)
    redist87_fft_latch_0L_mux_x_q_24_mem_ia <= STD_LOGIC_VECTOR(fft_latch_0L_mux_x_q);
    redist87_fft_latch_0L_mux_x_q_24_mem_aa <= redist87_fft_latch_0L_mux_x_q_24_wraddr_q;
    redist87_fft_latch_0L_mux_x_q_24_mem_ab <= redist87_fft_latch_0L_mux_x_q_24_rdcnt_q;
    redist87_fft_latch_0L_mux_x_q_24_mem_reset0 <= not (rst);
    redist87_fft_latch_0L_mux_x_q_24_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 21,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 21,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex"
    )
    PORT MAP (
        clocken1 => redist87_fft_latch_0L_mux_x_q_24_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist87_fft_latch_0L_mux_x_q_24_mem_reset0,
        clock1 => clk,
        address_a => redist87_fft_latch_0L_mux_x_q_24_mem_aa,
        data_a => redist87_fft_latch_0L_mux_x_q_24_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist87_fft_latch_0L_mux_x_q_24_mem_ab,
        q_b => redist87_fft_latch_0L_mux_x_q_24_mem_iq
    );
    redist87_fft_latch_0L_mux_x_q_24_mem_q <= redist87_fft_latch_0L_mux_x_q_24_mem_iq(7 downto 0);

    -- redist87_fft_latch_0L_mux_x_q_24_outputreg0(DELAY,1059)
    redist87_fft_latch_0L_mux_x_q_24_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_latch_0L_mux_x_q_24_outputreg0_q <= (others => '0');
            ELSE
                redist87_fft_latch_0L_mux_x_q_24_outputreg0_q <= STD_LOGIC_VECTOR(redist87_fft_latch_0L_mux_x_q_24_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_constBlock_x(CONSTANT,364)
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_constBlock_x_q <= "1000000000";

    -- redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4(DELAY,628)
    redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4_q <= (others => '0');
            ELSE
                redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4_q <= STD_LOGIC_VECTOR(redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x(COUNTER,360)@74 + 1
    -- low=0, high=1023, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 10);
            ELSE
                IF (redist8_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x(BITSELECT,359)@75
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_counter_x_q(9 downto 9);

    -- redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3(DELAY,627)
    redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_0 <= (others => '0');
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;
    redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_1 <= redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_q <= (others => '0');
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_q <= redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,501)@78
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= redist21_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_3_q xor redist22_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_bitExtract1_x_b_4_q;

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x(ADD,361)@77
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("0000000000" & fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_o(10 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,502)@77
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoad_x_q(9 downto 0);

    -- redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,616)
    redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,363)@78
    fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_bitExtract_x_b <= redist10_fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(9 downto 9);

    -- chanOut_cunroll_x(GPOUT,11)@78
    validOut <= fft_fftLight_FFTPipe_FFT4Block_4_delayValid_pulseMultiplier_bitExtract_x_b;
    channelOut <= redist87_fft_latch_0L_mux_x_q_24_outputreg0_q;
    out_q_real_tpl <= dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
    out_q_imag_tpl <= dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;

END normal;
