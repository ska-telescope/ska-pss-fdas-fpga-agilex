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

-- VHDL created from fft1024_intel_FPGA_unified_fft_103_4ahuvxq
-- VHDL created on Tue Jul 19 12:46:03 2022


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

entity fft1024_intel_FPGA_unified_fft_103_4ahuvxq is
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
end fft1024_intel_FPGA_unified_fft_103_4ahuvxq;

architecture normal of fft1024_intel_FPGA_unified_fft_103_4ahuvxq is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;



    component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz is
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


    component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz is
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








    component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clk : in std_logic;
            rst : in std_logic
        );
    end component;





















    component flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw is
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
    signal fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i : UNSIGNED (7 downto 0);
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
    signal fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i : signal is true;
    signal fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
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
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (9 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i : signal is true;
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q : STD_LOGIC_VECTOR (6 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b : STD_LOGIC_VECTOR (5 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q : STD_LOGIC_VECTOR (31 downto 0);
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
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
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
    signal redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist131_chanIn_cunroll_x_validIn_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist132_chanIn_cunroll_x_channelIn_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist132_chanIn_cunroll_x_channelIn_2_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist133_chanIn_cunroll_x_in_d_real_tpl_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist136_chanIn_cunroll_x_in_d_imag_tpl_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_reset0 : std_logic;
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i : signal is true;
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq : signal is true;
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_q : signal is true;
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q : signal is true;
    signal redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_reset0 : std_logic;
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i : signal is true;
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq : signal is true;
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_q : signal is true;
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q : signal is true;
    signal redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_reset0 : std_logic;
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i : signal is true;
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq : signal is true;
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_q : signal is true;
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q : signal is true;
    signal redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_reset0 : std_logic;
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i : signal is true;
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq : signal is true;
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_q : signal is true;
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q : signal is true;
    signal redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0 : std_logic;
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i : signal is true;
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq : signal is true;
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q : signal is true;
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q : signal is true;
    signal redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_reset0 : std_logic;
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i : signal is true;
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq : signal is true;
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_q : signal is true;
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q : signal is true;
    signal redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0 : std_logic;
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i : signal is true;
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq : signal is true;
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q : signal is true;
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q : signal is true;
    signal redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_reset0 : std_logic;
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i : signal is true;
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq : signal is true;
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_q : signal is true;
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q : signal is true;
    signal redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_reset0 : std_logic;
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i : signal is true;
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq : signal is true;
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_reset0 : std_logic;
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i : signal is true;
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq : signal is true;
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_reset0 : std_logic;
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i : signal is true;
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq : signal is true;
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_reset0 : std_logic;
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i : UNSIGNED (6 downto 0);
    attribute preserve_syn_only of redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i : signal is true;
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq : signal is true;
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_last_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_b : STD_LOGIC_VECTOR (7 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_reset0 : std_logic;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_q : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q : signal is true;
    signal redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_reset0 : std_logic;
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i : signal is true;
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_q : signal is true;
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q : signal is true;
    signal redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_reset0 : std_logic;
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i : signal is true;
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq : signal is true;
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_q : signal is true;
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q : signal is true;
    signal redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_reset0 : std_logic;
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i : signal is true;
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq : signal is true;
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_q : signal is true;
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q : signal is true;
    signal redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_reset0 : std_logic;
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i : signal is true;
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq : signal is true;
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_q : signal is true;
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q : signal is true;
    signal redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_reset0 : std_logic;
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i : signal is true;
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq : signal is true;
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_q : signal is true;
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q : signal is true;
    signal redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_reset0 : std_logic;
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i : signal is true;
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq : signal is true;
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_reset0 : std_logic;
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i : signal is true;
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq : signal is true;
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_reset0 : std_logic;
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i : signal is true;
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq : signal is true;
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_reset0 : std_logic;
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_aa : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ab : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i : UNSIGNED (5 downto 0);
    attribute preserve_syn_only of redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i : signal is true;
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq : signal is true;
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_last_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_b : STD_LOGIC_VECTOR (6 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_reset0 : std_logic;
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i : signal is true;
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq : signal is true;
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_reset0 : std_logic;
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i : signal is true;
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq : signal is true;
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_reset0 : std_logic;
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i : signal is true;
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq : signal is true;
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_reset0 : std_logic;
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i : UNSIGNED (7 downto 0);
    attribute preserve_syn_only of redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i : signal is true;
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq : signal is true;
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_last_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_b : STD_LOGIC_VECTOR (8 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_inputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_reset0 : std_logic;
    signal redist99_fft_latch_0L_mux_x_q_77_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_rdcnt_i : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_cmpReg_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_reset0 : std_logic;
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i : signal is true;
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq : signal is true;
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist134_chanIn_cunroll_x_in_d_real_tpl_513_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_reset0 : std_logic;
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i : signal is true;
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq : signal is true;
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist135_chanIn_cunroll_x_in_d_real_tpl_1025_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_reset0 : std_logic;
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i : signal is true;
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq : signal is true;
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist137_chanIn_cunroll_x_in_d_imag_tpl_513_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_reset0 : std_logic;
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i : UNSIGNED (8 downto 0);
    attribute preserve_syn_only of redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i : signal is true;
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq : signal is true;
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr_q : STD_LOGIC_VECTOR (8 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_last_q : STD_LOGIC_VECTOR (9 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_b : STD_LOGIC_VECTOR (9 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_reset0 : std_logic;
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_0_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_reset0 : std_logic;
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q : signal is true;
    signal redist99_fft_latch_0L_mux_x_q_77_split_1_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_notEnable(LOGICAL,753)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_nor(LOGICAL,754)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_nor_q <= not (redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_notEnable_q or redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q);

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_last(CONSTANT,750)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_last_q <= "0100";

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp(LOGICAL,751)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_q);
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_q <= "1" WHEN redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_last_q = redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_b ELSE "0";

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg(REG,752)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_q <= "0";
            ELSE
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_q <= STD_LOGIC_VECTOR(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena(REG,755)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q <= "0";
            ELSE
                IF (redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_nor_q = "1") THEN
                    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_enaAnd(LOGICAL,756)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_enaAnd_q <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_sticky_ena_q and VCC_q;

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt(COUNTER,748)
    -- low=0, high=5, step=1, init=0
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq <= '0';
            ELSE
                IF (redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq <= '1';
                ELSE
                    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq <= '0';
                END IF;
                IF (redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_eq = '1') THEN
                    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i + 3;
                ELSE
                    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_i, 3)));

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_notEnable(LOGICAL,905)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_nor(LOGICAL,906)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_nor_q <= not (redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_notEnable_q or redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q);

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_last(CONSTANT,902)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_last_q <= "01011";

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp(LOGICAL,903)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_b <= STD_LOGIC_VECTOR("0" & redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_q);
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_q <= "1" WHEN redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_last_q = redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_b ELSE "0";

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg(REG,904)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_q <= "0";
            ELSE
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_q <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena(REG,907)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q <= "0";
            ELSE
                IF (redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_nor_q = "1") THEN
                    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_enaAnd(LOGICAL,908)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_enaAnd_q <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_sticky_ena_q and VCC_q;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt(COUNTER,900)
    -- low=0, high=12, step=1, init=0
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq <= '0';
            ELSE
                IF (redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i = TO_UNSIGNED(11, 4)) THEN
                    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq <= '1';
                ELSE
                    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq <= '0';
                END IF;
                IF (redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_eq = '1') THEN
                    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i + 4;
                ELSE
                    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_i, 4)));

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable(LOGICAL,797)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor(LOGICAL,798)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q <= not (redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_notEnable_q or redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q);

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last(CONSTANT,794)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q <= "011100";

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp(LOGICAL,795)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q);
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q <= "1" WHEN redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_last_q = redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_b ELSE "0";

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg(REG,796)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q <= "0";
            ELSE
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q <= STD_LOGIC_VECTOR(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena(REG,799)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q <= "0";
            ELSE
                IF (redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_nor_q = "1") THEN
                    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd(LOGICAL,800)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_sticky_ena_q and VCC_q;

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt(COUNTER,792)
    -- low=0, high=29, step=1, init=0
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '0';
            ELSE
                IF (redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '1';
                ELSE
                    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq <= '0';
                END IF;
                IF (redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_eq = '1') THEN
                    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i + 3;
                ELSE
                    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_i, 5)));

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_notEnable(LOGICAL,949)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_nor(LOGICAL,950)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_nor_q <= not (redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_notEnable_q or redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_q);

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_last(CONSTANT,946)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_last_q <= "0111011";

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp(LOGICAL,947)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_b <= STD_LOGIC_VECTOR("0" & redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_q);
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_q <= "1" WHEN redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_last_q = redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_b ELSE "0";

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg(REG,948)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg_q <= "0";
            ELSE
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg_q <= STD_LOGIC_VECTOR(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena(REG,951)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_q <= "0";
            ELSE
                IF (redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_nor_q = "1") THEN
                    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_q <= STD_LOGIC_VECTOR(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_enaAnd(LOGICAL,952)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_enaAnd_q <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_sticky_ena_q and VCC_q;

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt(COUNTER,944)
    -- low=0, high=60, step=1, init=0
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq <= '0';
            ELSE
                IF (redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i = TO_UNSIGNED(59, 6)) THEN
                    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq <= '1';
                ELSE
                    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq <= '0';
                END IF;
                IF (redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_eq = '1') THEN
                    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i + 4;
                ELSE
                    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_i, 6)));

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_notEnable(LOGICAL,841)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_nor(LOGICAL,842)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_nor_q <= not (redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_notEnable_q or redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_q);

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_last(CONSTANT,838)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_last_q <= "01111100";

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp(LOGICAL,839)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_q);
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_q <= "1" WHEN redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_last_q = redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_b ELSE "0";

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg(REG,840)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg_q <= "0";
            ELSE
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena(REG,843)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_q <= "0";
            ELSE
                IF (redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_nor_q = "1") THEN
                    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_enaAnd(LOGICAL,844)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_enaAnd_q <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_sticky_ena_q and VCC_q;

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt(COUNTER,836)
    -- low=0, high=125, step=1, init=0
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '0';
            ELSE
                IF (redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i = TO_UNSIGNED(124, 7)) THEN
                    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '1';
                ELSE
                    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq <= '0';
                END IF;
                IF (redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_eq = '1') THEN
                    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i + 3;
                ELSE
                    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_i, 7)));

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_notEnable(LOGICAL,993)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_nor(LOGICAL,994)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_nor_q <= not (redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_notEnable_q or redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_q);

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_last(CONSTANT,990)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_last_q <= "011111011";

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp(LOGICAL,991)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_b <= STD_LOGIC_VECTOR("0" & redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_q);
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_q <= "1" WHEN redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_last_q = redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_b ELSE "0";

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg(REG,992)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg_q <= "0";
            ELSE
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg_q <= STD_LOGIC_VECTOR(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena(REG,995)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_q <= "0";
            ELSE
                IF (redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_nor_q = "1") THEN
                    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_q <= STD_LOGIC_VECTOR(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_enaAnd(LOGICAL,996)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_enaAnd_q <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_sticky_ena_q and VCC_q;

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt(COUNTER,988)
    -- low=0, high=252, step=1, init=0
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq <= '0';
            ELSE
                IF (redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i = TO_UNSIGNED(251, 8)) THEN
                    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq <= '1';
                ELSE
                    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq <= '0';
                END IF;
                IF (redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_eq = '1') THEN
                    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i + 4;
                ELSE
                    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_i, 8)));

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_notEnable(LOGICAL,1049)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_nor(LOGICAL,1050)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_nor_q <= not (redist134_chanIn_cunroll_x_in_d_real_tpl_513_notEnable_q or redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_q);

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_last(CONSTANT,1046)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_last_q <= "0111111100";

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp(LOGICAL,1047)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_b <= STD_LOGIC_VECTOR("0" & redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_q);
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_q <= "1" WHEN redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_last_q = redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_b ELSE "0";

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg(REG,1048)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg_q <= "0";
            ELSE
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena(REG,1051)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_q <= "0";
            ELSE
                IF (redist134_chanIn_cunroll_x_in_d_real_tpl_513_nor_q = "1") THEN
                    redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_513_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_enaAnd(LOGICAL,1052)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_enaAnd_q <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_sticky_ena_q and VCC_q;

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt(COUNTER,1044)
    -- low=0, high=509, step=1, init=0
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq <= '0';
            ELSE
                IF (redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i = TO_UNSIGNED(508, 9)) THEN
                    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq <= '1';
                ELSE
                    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq <= '0';
                END IF;
                IF (redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_eq = '1') THEN
                    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i + 3;
                ELSE
                    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_i, 9)));

    -- redist133_chanIn_cunroll_x_in_d_real_tpl_1(DELAY,738)
    redist133_chanIn_cunroll_x_in_d_real_tpl_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist133_chanIn_cunroll_x_in_d_real_tpl_1_q <= (others => '0');
            ELSE
                redist133_chanIn_cunroll_x_in_d_real_tpl_1_q <= STD_LOGIC_VECTOR(in_d_real_tpl);
            END IF;
        END IF;
    END PROCESS;

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr(REG,1045)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr_q <= "111111101";
            ELSE
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem(DUALMEM,1043)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ia <= STD_LOGIC_VECTOR(redist133_chanIn_cunroll_x_in_d_real_tpl_1_q);
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_aa <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_wraddr_q;
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ab <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_rdcnt_q;
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_reset0 <= not (rst);
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 510,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 510,
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
        clocken1 => redist134_chanIn_cunroll_x_in_d_real_tpl_513_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_reset0,
        clock1 => clk,
        address_a => redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_aa,
        data_a => redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_ab,
        q_b => redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_iq
    );
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_q <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_iq(31 downto 0);

    -- redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0(DELAY,1042)
    redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q <= (others => '0');
            ELSE
                redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_513_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,36)@1
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x(COUNTER,148)@0 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (validIn = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_i, 10)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_bitExtract_x(BITSELECT,147)@1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_counterBlock_x_q(9 downto 9);

    -- redist131_chanIn_cunroll_x_validIn_1(DELAY,736)
    redist131_chanIn_cunroll_x_validIn_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist131_chanIn_cunroll_x_validIn_1_q <= (others => '0');
            ELSE
                redist131_chanIn_cunroll_x_validIn_1_q <= STD_LOGIC_VECTOR(validIn);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x(LOGICAL,146)@1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q <= redist131_chanIn_cunroll_x_validIn_1_q and fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_bitExtract_x_b;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_notEnable(LOGICAL,1060)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_nor(LOGICAL,1061)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_nor_q <= not (redist135_chanIn_cunroll_x_in_d_real_tpl_1025_notEnable_q or redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_q);

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_last(CONSTANT,1057)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_last_q <= "0111111100";

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp(LOGICAL,1058)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_b <= STD_LOGIC_VECTOR("0" & redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_q);
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_q <= "1" WHEN redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_last_q = redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_b ELSE "0";

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg(REG,1059)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg_q <= "0";
            ELSE
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg_q <= STD_LOGIC_VECTOR(redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena(REG,1062)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_q <= "0";
            ELSE
                IF (redist135_chanIn_cunroll_x_in_d_real_tpl_1025_nor_q = "1") THEN
                    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_q <= STD_LOGIC_VECTOR(redist135_chanIn_cunroll_x_in_d_real_tpl_1025_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_enaAnd(LOGICAL,1063)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_enaAnd_q <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_sticky_ena_q and VCC_q;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt(COUNTER,1055)
    -- low=0, high=509, step=1, init=0
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq <= '0';
            ELSE
                IF (redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i = TO_UNSIGNED(508, 9)) THEN
                    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq <= '1';
                ELSE
                    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq <= '0';
                END IF;
                IF (redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_eq = '1') THEN
                    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i + 3;
                ELSE
                    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_i, 9)));

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0(DELAY,1053)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0_q <= (others => '0');
            ELSE
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0_q <= STD_LOGIC_VECTOR(redist134_chanIn_cunroll_x_in_d_real_tpl_513_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr(REG,1056)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr_q <= "111111101";
            ELSE
                redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr_q <= STD_LOGIC_VECTOR(redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem(DUALMEM,1054)
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ia <= STD_LOGIC_VECTOR(redist135_chanIn_cunroll_x_in_d_real_tpl_1025_inputreg0_q);
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_aa <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_wraddr_q;
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ab <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_rdcnt_q;
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_reset0 <= not (rst);
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 510,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 510,
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
        clocken1 => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_reset0,
        clock1 => clk,
        address_a => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_aa,
        data_a => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_ab,
        q_b => redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_iq
    );
    redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_q <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,513)@1 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist135_chanIn_cunroll_x_in_d_real_tpl_1025_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist133_chanIn_cunroll_x_in_d_real_tpl_1_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,80)@2
    -- out out_primWireOut@5
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,717)
    redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x(BLACKBOX,155)@6
    thefft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1(DELAY,693)
    redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x(BLACKBOX,156)@7
    thefft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist88_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateRe_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_notEnable(LOGICAL,1071)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_nor(LOGICAL,1072)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_nor_q <= not (redist137_chanIn_cunroll_x_in_d_imag_tpl_513_notEnable_q or redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_q);

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_last(CONSTANT,1068)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_last_q <= "0111111100";

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp(LOGICAL,1069)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_b <= STD_LOGIC_VECTOR("0" & redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_q);
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_q <= "1" WHEN redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_last_q = redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_b ELSE "0";

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg(REG,1070)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg_q <= "0";
            ELSE
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena(REG,1073)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_q <= "0";
            ELSE
                IF (redist137_chanIn_cunroll_x_in_d_imag_tpl_513_nor_q = "1") THEN
                    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_enaAnd(LOGICAL,1074)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_enaAnd_q <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_sticky_ena_q and VCC_q;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt(COUNTER,1066)
    -- low=0, high=509, step=1, init=0
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq <= '0';
            ELSE
                IF (redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i = TO_UNSIGNED(508, 9)) THEN
                    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq <= '1';
                ELSE
                    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq <= '0';
                END IF;
                IF (redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_eq = '1') THEN
                    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i + 3;
                ELSE
                    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_i, 9)));

    -- redist136_chanIn_cunroll_x_in_d_imag_tpl_1(DELAY,741)
    redist136_chanIn_cunroll_x_in_d_imag_tpl_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist136_chanIn_cunroll_x_in_d_imag_tpl_1_q <= (others => '0');
            ELSE
                redist136_chanIn_cunroll_x_in_d_imag_tpl_1_q <= STD_LOGIC_VECTOR(in_d_imag_tpl);
            END IF;
        END IF;
    END PROCESS;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr(REG,1067)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr_q <= "111111101";
            ELSE
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem(DUALMEM,1065)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ia <= STD_LOGIC_VECTOR(redist136_chanIn_cunroll_x_in_d_imag_tpl_1_q);
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_aa <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_wraddr_q;
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ab <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_rdcnt_q;
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_reset0 <= not (rst);
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 510,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 510,
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
        clocken1 => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_reset0,
        clock1 => clk,
        address_a => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_aa,
        data_a => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_ab,
        q_b => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_iq
    );
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_q <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_iq(31 downto 0);

    -- redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0(DELAY,1064)
    redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q <= (others => '0');
            ELSE
                redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,35)@1
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_notEnable(LOGICAL,1082)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_nor(LOGICAL,1083)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_nor_q <= not (redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_notEnable_q or redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_q);

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_last(CONSTANT,1079)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_last_q <= "0111111100";

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp(LOGICAL,1080)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_b <= STD_LOGIC_VECTOR("0" & redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_q);
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_q <= "1" WHEN redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_last_q = redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_b ELSE "0";

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg(REG,1081)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg_q <= "0";
            ELSE
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg_q <= STD_LOGIC_VECTOR(redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena(REG,1084)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_q <= "0";
            ELSE
                IF (redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_nor_q = "1") THEN
                    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_q <= STD_LOGIC_VECTOR(redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_enaAnd(LOGICAL,1085)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_enaAnd_q <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_sticky_ena_q and VCC_q;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt(COUNTER,1077)
    -- low=0, high=509, step=1, init=0
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i <= TO_UNSIGNED(0, 9);
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq <= '0';
            ELSE
                IF (redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i = TO_UNSIGNED(508, 9)) THEN
                    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq <= '1';
                ELSE
                    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq <= '0';
                END IF;
                IF (redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_eq = '1') THEN
                    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i + 3;
                ELSE
                    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_i, 9)));

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0(DELAY,1075)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0_q <= (others => '0');
            ELSE
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0_q <= STD_LOGIC_VECTOR(redist137_chanIn_cunroll_x_in_d_imag_tpl_513_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr(REG,1078)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr_q <= "111111101";
            ELSE
                redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr_q <= STD_LOGIC_VECTOR(redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem(DUALMEM,1076)
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ia <= STD_LOGIC_VECTOR(redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_inputreg0_q);
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_aa <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_wraddr_q;
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ab <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_rdcnt_q;
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_reset0 <= not (rst);
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 510,
        width_b => 32,
        widthad_b => 9,
        numwords_b => 510,
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
        clocken1 => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_reset0,
        clock1 => clk,
        address_a => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_aa,
        data_a => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_ab,
        q_b => redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_iq
    );
    redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_q <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,512)@1 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist138_chanIn_cunroll_x_in_d_imag_tpl_1025_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist136_chanIn_cunroll_x_in_d_imag_tpl_1_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,79)@2
    -- out out_primWireOut@5
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,718)
    redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,719)
    redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,460)
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "1000000000";

    -- redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,622)
    redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,456)@1 + 1
    -- low=0, high=1023, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 10);
            ELSE
                IF (redist131_chanIn_cunroll_x_validIn_1_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,455)@2
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_counter_x_q(9 downto 9);

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,519)@2
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist17_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,457)@1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("0000000000" & fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(10 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,520)@1
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(9 downto 0);

    -- redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,611)
    redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,459)@2
    fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist6_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(9 downto 9);

    -- redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3(DELAY,619)
    redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 <= (others => '0');
            ELSE
                redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;
    redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1 <= redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q <= (others => '0');
            ELSE
                redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q <= redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_counter_x(COUNTER,102)@5 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select(BITSELECT,596)@6
    fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q(9 downto 9);
    fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_0_counter_x_q(8 downto 8);

    -- fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x(LOGICAL,98)@6
    fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c;

    -- redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1(DELAY,701)
    redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1_q <= (others => '0');
            ELSE
                redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x(MUX,152)@7
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s <= redist96_fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s, redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= redist114_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_negateReconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr(REG,989)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr_q <= "11111100";
            ELSE
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr_q <= STD_LOGIC_VECTOR(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem(DUALMEM,987)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q);
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_aa <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_wraddr_q;
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ab <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_rdcnt_q;
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_reset0 <= not (rst);
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 253,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 253,
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
        clocken1 => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_reset0,
        clock1 => clk,
        address_a => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_aa,
        data_a => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_ab,
        q_b => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_iq
    );
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_q <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_iq(31 downto 0);

    -- redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0(DELAY,986)
    redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q <= (others => '0');
            ELSE
                redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q <= STD_LOGIC_VECTOR(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,25)@6
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4(DELAY,620)
    redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q <= (others => '0');
            ELSE
                redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q <= STD_LOGIC_VECTOR(redist14_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_3_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x(LOGICAL,97)@6
    fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q <= redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q and fft_fftLight_FFTPipe_FFT4Block_0_bitExtract1_x_merged_bit_select_c;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_notEnable(LOGICAL,1004)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_nor(LOGICAL,1005)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_nor_q <= not (redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_notEnable_q or redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_q);

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_last(CONSTANT,1001)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_last_q <= "011111101";

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp(LOGICAL,1002)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_b <= STD_LOGIC_VECTOR("0" & redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_q);
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_q <= "1" WHEN redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_last_q = redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_b ELSE "0";

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg(REG,1003)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg_q <= "0";
            ELSE
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg_q <= STD_LOGIC_VECTOR(redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena(REG,1006)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_q <= "0";
            ELSE
                IF (redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_nor_q = "1") THEN
                    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_q <= STD_LOGIC_VECTOR(redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_enaAnd(LOGICAL,1007)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_enaAnd_q <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_sticky_ena_q and VCC_q;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt(COUNTER,999)
    -- low=0, high=254, step=1, init=0
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq <= '0';
            ELSE
                IF (redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i = TO_UNSIGNED(253, 8)) THEN
                    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq <= '1';
                ELSE
                    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq <= '0';
                END IF;
                IF (redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_eq = '1') THEN
                    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i + 2;
                ELSE
                    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_i, 8)));

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0(DELAY,997)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0_q <= (others => '0');
            ELSE
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0_q <= STD_LOGIC_VECTOR(redist89_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_255_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr(REG,1000)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr_q <= "11111110";
            ELSE
                redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr_q <= STD_LOGIC_VECTOR(redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem(DUALMEM,998)
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ia <= STD_LOGIC_VECTOR(redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_inputreg0_q);
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_aa <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_wraddr_q;
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ab <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_rdcnt_q;
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_reset0 <= not (rst);
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 255,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 255,
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
        clocken1 => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_reset0,
        clock1 => clk,
        address_a => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_aa,
        data_a => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_ab,
        q_b => redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_iq
    );
    redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_q <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_iq(31 downto 0);

    -- redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1(DELAY,702)
    redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x(MUX,445)@7
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s <= redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s, redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= redist90_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q_512_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,69)@7
    -- out out_primWireOut@10
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,727)
    redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x(BLACKBOX,215)@11
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist122_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1(DELAY,672)
    redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_constBlock_x(CONSTANT,340)
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_constBlock_x_q <= "100000000";

    -- redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,646)
    redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8(DELAY,621)
    redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_0 <= (others => '0');
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_0 <= STD_LOGIC_VECTOR(redist15_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_4_q);
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_1 <= redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_2 <= (others => '0');
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_2 <= redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_q <= redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_delay_2;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x(COUNTER,336)@10 + 1
    -- low=0, high=511, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 9);
            ELSE
                IF (redist16_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_8_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_i, 9)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x(BITSELECT,335)@11
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_counter_x_q(8 downto 8);

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,452)@11
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b xor redist41_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x(ADD,337)@10
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("000000000" & fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_o(9 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,453)@10
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoad_x_q(8 downto 0);

    -- redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,623)
    redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,339)@11
    fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b <= redist18_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(8 downto 8);

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x(COUNTER,132)@11 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x(BITSELECT,133)@12
    fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b <= fft_fftLight_FFTPipe_TwiddleBlock_0_counter_x_q(9 downto 6);

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,590)@12
    fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111100000000000000000000000";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_notEnable(LOGICAL,1015)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_nor(LOGICAL,1016)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_nor_q <= not (redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_notEnable_q or redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_q);

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_last(CONSTANT,1012)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_last_q <= "011111011";

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp(LOGICAL,1013)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_q);
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_q <= "1" WHEN redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_last_q = redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_b ELSE "0";

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg(REG,1014)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg_q <= "0";
            ELSE
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg_q <= STD_LOGIC_VECTOR(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena(REG,1017)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_q <= "0";
            ELSE
                IF (redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_nor_q = "1") THEN
                    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_enaAnd(LOGICAL,1018)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_enaAnd_q <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_sticky_ena_q and VCC_q;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt(COUNTER,1010)
    -- low=0, high=252, step=1, init=0
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '0';
            ELSE
                IF (redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i = TO_UNSIGNED(251, 8)) THEN
                    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '1';
                ELSE
                    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq <= '0';
                END IF;
                IF (redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_eq = '1') THEN
                    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i + 4;
                ELSE
                    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x(MUX,151)@6 + 1
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_0_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= redist112_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= redist113_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr(REG,1011)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr_q <= "11111100";
            ELSE
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr_q <= STD_LOGIC_VECTOR(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem(DUALMEM,1009)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q);
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_aa <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_wraddr_q;
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ab <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_rdcnt_q;
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_reset0 <= not (rst);
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 253,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 253,
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
        clocken1 => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_reset0,
        clock1 => clk,
        address_a => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_aa,
        data_a => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_ab,
        q_b => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_iq
    );
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_q <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_iq(31 downto 0);

    -- redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0(DELAY,1008)
    redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q <= (others => '0');
            ELSE
                redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q <= STD_LOGIC_VECTOR(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,26)@6
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_notEnable(LOGICAL,1026)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_nor(LOGICAL,1027)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_nor_q <= not (redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_notEnable_q or redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_q);

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_last(CONSTANT,1023)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_last_q <= "011111101";

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp(LOGICAL,1024)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_b <= STD_LOGIC_VECTOR("0" & redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_q);
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_q <= "1" WHEN redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_last_q = redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_b ELSE "0";

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg(REG,1025)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg_q <= "0";
            ELSE
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg_q <= STD_LOGIC_VECTOR(redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena(REG,1028)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_q <= "0";
            ELSE
                IF (redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_nor_q = "1") THEN
                    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_q <= STD_LOGIC_VECTOR(redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_enaAnd(LOGICAL,1029)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_enaAnd_q <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_sticky_ena_q and VCC_q;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt(COUNTER,1021)
    -- low=0, high=254, step=1, init=0
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i <= TO_UNSIGNED(0, 8);
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq <= '0';
            ELSE
                IF (redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i = TO_UNSIGNED(253, 8)) THEN
                    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq <= '1';
                ELSE
                    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq <= '0';
                END IF;
                IF (redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_eq = '1') THEN
                    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i + 2;
                ELSE
                    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_i, 8)));

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0(DELAY,1019)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0_q <= (others => '0');
            ELSE
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0_q <= STD_LOGIC_VECTOR(redist91_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_256_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr(REG,1022)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr_q <= "11111110";
            ELSE
                redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr_q <= STD_LOGIC_VECTOR(redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem(DUALMEM,1020)
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ia <= STD_LOGIC_VECTOR(redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_inputreg0_q);
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_aa <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_wraddr_q;
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ab <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_rdcnt_q;
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_reset0 <= not (rst);
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 255,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 255,
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
        clocken1 => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_reset0,
        clock1 => clk,
        address_a => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_aa,
        data_a => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_ab,
        q_b => redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_iq
    );
    redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_q <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x(MUX,446)@7
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s <= redist97_fft_fftLight_FFTPipe_FFT4Block_0_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s, redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_q, fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= redist92_fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q_513_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_0_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,70)@7
    -- out out_primWireOut@10
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,726)
    redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x(BLACKBOX,216)@11
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist121_dupName_2_fft_fftLight_FFTPipe_FFT4Block_0_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1(DELAY,671)
    redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,591)@12
    fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_0_extractCount_x_b) IS
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
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1(DELAY,734)
    redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x(BLACKBOX,218)@18
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist129_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr(REG,837)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr_q <= "1111101";
            ELSE
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem(DUALMEM,835)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut);
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_aa <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_wraddr_q;
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ab <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_rdcnt_q;
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_reset0 <= not (rst);
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 126,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 126,
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
        clocken1 => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_reset0,
        clock1 => clk,
        address_a => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_aa,
        data_a => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_ab,
        q_b => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_iq
    );
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_q <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_iq(31 downto 0);

    -- redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0(DELAY,834)
    redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q <= (others => '0');
            ELSE
                redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,38)@18
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6(DELAY,643)
    redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b, xout => redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x(COUNTER,162)@17 + 1
    -- low=0, high=255, step=1, init=255
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i <= TO_UNSIGNED(255, 8);
            ELSE
                IF (redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x(BITSELECT,161)@18
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_counterBlock_x_q(7 downto 7);

    -- redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7(DELAY,644)
    redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= (others => '0');
            ELSE
                redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_q <= STD_LOGIC_VECTOR(redist38_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_6_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x(LOGICAL,160)@18
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q <= redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_q and fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_bitExtract_x_b;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_notEnable(LOGICAL,852)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_nor(LOGICAL,853)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_nor_q <= not (redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_notEnable_q or redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_q);

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_last(CONSTANT,849)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_last_q <= "01111100";

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp(LOGICAL,850)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_q);
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_q <= "1" WHEN redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_last_q = redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_b ELSE "0";

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg(REG,851)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg_q <= "0";
            ELSE
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena(REG,854)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_q <= "0";
            ELSE
                IF (redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_nor_q = "1") THEN
                    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_enaAnd(LOGICAL,855)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_enaAnd_q <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_sticky_ena_q and VCC_q;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt(COUNTER,847)
    -- low=0, high=125, step=1, init=0
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '0';
            ELSE
                IF (redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i = TO_UNSIGNED(124, 7)) THEN
                    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '1';
                ELSE
                    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq <= '0';
                END IF;
                IF (redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_eq = '1') THEN
                    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i + 3;
                ELSE
                    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_i, 7)));

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0(DELAY,845)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0_q <= (others => '0');
            ELSE
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0_q <= STD_LOGIC_VECTOR(redist62_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_128_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr(REG,848)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr_q <= "1111101";
            ELSE
                redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr_q <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem(DUALMEM,846)
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ia <= STD_LOGIC_VECTOR(redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_inputreg0_q);
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_aa <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_wraddr_q;
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ab <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_rdcnt_q;
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_reset0 <= not (rst);
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 126,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 126,
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
        clocken1 => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_reset0,
        clock1 => clk,
        address_a => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_aa,
        data_a => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_ab,
        q_b => redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_iq
    );
    redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_q <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,523)@18 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist63_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut_256_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,82)@19
    -- out out_primWireOut@22
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,714)
    redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x(BLACKBOX,169)@23
    thefft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1(DELAY,688)
    redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x(BLACKBOX,170)@24
    thefft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist83_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateRe_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_notEnable(LOGICAL,863)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_nor(LOGICAL,864)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_nor_q <= not (redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_notEnable_q or redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_q);

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_last(CONSTANT,860)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_last_q <= "01111100";

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp(LOGICAL,861)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_q);
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_q <= "1" WHEN redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_last_q = redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_b ELSE "0";

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg(REG,862)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg_q <= "0";
            ELSE
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena(REG,865)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_q <= "0";
            ELSE
                IF (redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_nor_q = "1") THEN
                    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_enaAnd(LOGICAL,866)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_enaAnd_q <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_sticky_ena_q and VCC_q;

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt(COUNTER,858)
    -- low=0, high=125, step=1, init=0
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '0';
            ELSE
                IF (redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i = TO_UNSIGNED(124, 7)) THEN
                    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '1';
                ELSE
                    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq <= '0';
                END IF;
                IF (redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_eq = '1') THEN
                    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i + 3;
                ELSE
                    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_i, 7)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x(BLACKBOX,14)@12
    -- out out_primWireOut@17
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist67_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_0_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist66_fft_fftLight_FFTPipe_TwiddleBlock_0_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1(DELAY,735)
    redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x(BLACKBOX,217)@18
    thefft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist130_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_0_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr(REG,859)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr_q <= "1111101";
            ELSE
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem(DUALMEM,857)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut);
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_aa <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_wraddr_q;
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ab <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_rdcnt_q;
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_reset0 <= not (rst);
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 126,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 126,
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
        clocken1 => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_reset0,
        clock1 => clk,
        address_a => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_aa,
        data_a => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_ab,
        q_b => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_iq
    );
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_q <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_iq(31 downto 0);

    -- redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0(DELAY,856)
    redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q <= (others => '0');
            ELSE
                redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,37)@18
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_notEnable(LOGICAL,874)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_nor(LOGICAL,875)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_nor_q <= not (redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_notEnable_q or redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_q);

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_last(CONSTANT,871)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_last_q <= "01111100";

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp(LOGICAL,872)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_b <= STD_LOGIC_VECTOR("0" & redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_q);
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_q <= "1" WHEN redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_last_q = redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_b ELSE "0";

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg(REG,873)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg_q <= "0";
            ELSE
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena(REG,876)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_q <= "0";
            ELSE
                IF (redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_nor_q = "1") THEN
                    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_enaAnd(LOGICAL,877)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_enaAnd_q <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_sticky_ena_q and VCC_q;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt(COUNTER,869)
    -- low=0, high=125, step=1, init=0
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= TO_UNSIGNED(0, 7);
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '0';
            ELSE
                IF (redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i = TO_UNSIGNED(124, 7)) THEN
                    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '1';
                ELSE
                    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq <= '0';
                END IF;
                IF (redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_eq = '1') THEN
                    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i + 3;
                ELSE
                    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_i, 7)));

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0(DELAY,867)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0_q <= (others => '0');
            ELSE
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0_q <= STD_LOGIC_VECTOR(redist64_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_128_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr(REG,870)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr_q <= "1111101";
            ELSE
                redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr_q <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem(DUALMEM,868)
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ia <= STD_LOGIC_VECTOR(redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_inputreg0_q);
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_aa <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_wraddr_q;
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ab <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_rdcnt_q;
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_reset0 <= not (rst);
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 7,
        numwords_a => 126,
        width_b => 32,
        widthad_b => 7,
        numwords_b => 126,
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
        clocken1 => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_reset0,
        clock1 => clk,
        address_a => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_aa,
        data_a => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_ab,
        q_b => redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_iq
    );
    redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_q <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,522)@18 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist65_fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut_256_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_0_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,81)@19
    -- out out_primWireOut@22
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,716)
    redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,478)
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "10000000";

    -- redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,617)
    redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10(DELAY,645)
    redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 <= (others => '0');
            ELSE
                redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0 <= STD_LOGIC_VECTOR(redist39_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_7_q);
            END IF;
        END IF;
    END PROCESS;
    redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1 <= redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_q <= (others => '0');
            ELSE
                redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_q <= redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,474)@21 + 1
    -- low=0, high=255, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 8);
            ELSE
                IF (redist40_fft_fftLight_FFTPipe_FFT4Block_0_delayValid_pulseMultiplier_bitExtract_x_b_10_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,473)@22
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_counter_x_q(7 downto 7);

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,529)@22
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist12_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,475)@21
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("00000000" & fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(8 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,530)@21
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(7 downto 0);

    -- redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,610)
    redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,477)@22
    fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist5_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(7 downto 7);

    -- fft_fftLight_FFTPipe_FFT4Block_1_counter_x(COUNTER,109)@22 + 1
    -- low=0, high=255, step=1, init=255
    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i <= TO_UNSIGNED(255, 8);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_counter_x_i, 8)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select(BITSELECT,597)@23
    fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q(7 downto 7);
    fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_1_counter_x_q(6 downto 6);

    -- fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x(LOGICAL,105)@23 + 1
    fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x(MUX,166)@24
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s, redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_negateReconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr(REG,945)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr_q <= "111100";
            ELSE
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr_q <= STD_LOGIC_VECTOR(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem(DUALMEM,943)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q);
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_aa <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_wraddr_q;
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ab <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_rdcnt_q;
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_reset0 <= not (rst);
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 61,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 61,
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
        clocken1 => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_reset0,
        clock1 => clk,
        address_a => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_aa,
        data_a => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_ab,
        q_b => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_iq
    );
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_q <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_iq(31 downto 0);

    -- redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0(DELAY,942)
    redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q <= (others => '0');
            ELSE
                redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q <= STD_LOGIC_VECTOR(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,27)@23
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1(DELAY,616)
    redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= (others => '0');
            ELSE
                redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x(LOGICAL,104)@23
    fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q <= redist11_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q and fft_fftLight_FFTPipe_FFT4Block_1_bitExtract1_x_merged_bit_select_c;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_notEnable(LOGICAL,960)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_nor(LOGICAL,961)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_nor_q <= not (redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_notEnable_q or redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_q);

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_last(CONSTANT,957)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_last_q <= "0111101";

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp(LOGICAL,958)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_q);
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_q <= "1" WHEN redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_last_q = redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_b ELSE "0";

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg(REG,959)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg_q <= "0";
            ELSE
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg_q <= STD_LOGIC_VECTOR(redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena(REG,962)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_q <= "0";
            ELSE
                IF (redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_nor_q = "1") THEN
                    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_enaAnd(LOGICAL,963)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_enaAnd_q <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_sticky_ena_q and VCC_q;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt(COUNTER,955)
    -- low=0, high=62, step=1, init=0
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq <= '0';
            ELSE
                IF (redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i = TO_UNSIGNED(61, 6)) THEN
                    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq <= '1';
                ELSE
                    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq <= '0';
                END IF;
                IF (redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_eq = '1') THEN
                    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i + 2;
                ELSE
                    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_i, 6)));

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0(DELAY,953)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0_q <= (others => '0');
            ELSE
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0_q <= STD_LOGIC_VECTOR(redist84_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_63_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr(REG,956)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr_q <= "111110";
            ELSE
                redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr_q <= STD_LOGIC_VECTOR(redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem(DUALMEM,954)
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ia <= STD_LOGIC_VECTOR(redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_inputreg0_q);
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_aa <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_wraddr_q;
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ab <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_rdcnt_q;
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_reset0 <= not (rst);
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 63,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 63,
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
        clocken1 => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_reset0,
        clock1 => clk,
        address_a => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_aa,
        data_a => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_ab,
        q_b => redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_iq
    );
    redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_q <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_iq(31 downto 0);

    -- redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1(DELAY,700)
    redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x(MUX,463)@24
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s <= redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s, redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= redist85_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q_128_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,71)@24
    -- out out_primWireOut@27
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,725)
    redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x(BLACKBOX,245)@28
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist120_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1(DELAY,666)
    redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut);
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

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select(BITSELECT,603)@25
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q(7 downto 0);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_subBlock_x_q(8 downto 8);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1(DELAY,1109)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q <= (others => '0');
            ELSE
                fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q <= STD_LOGIC_VECTOR(redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr(LOGICAL,1110)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_extOr_q <= redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q or fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ext1_q;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const(CONSTANT,555)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_zeroDataConst_x_q_const_q <= "00000000000000000000000000000000";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_constBlock_x(CONSTANT,350)
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_constBlock_x_q <= "1000000";

    -- redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,642)
    redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x(COUNTER,346)@22 + 1
    -- low=0, high=127, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 7);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_i, 7)));

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x(BITSELECT,345)@23
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_counter_x_q(6 downto 6);

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,470)@23
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b xor redist37_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x(ADD,347)@22
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("0000000" & fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_o(7 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,471)@22
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoad_x_q(6 downto 0);

    -- redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,618)
    redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,349)@23
    fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b <= redist13_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(6 downto 6);

    -- redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1(DELAY,638)
    redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= (others => '0');
            ELSE
                redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2(DELAY,639)
    redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q <= (others => '0');
            ELSE
                redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q <= STD_LOGIC_VECTOR(redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x(CONSTANT,400)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q <= "0000000000";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x(CONSTANT,402)
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q <= "000000";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x(COUNTER,135)@23 + 1
    -- low=0, high=1023, step=1, init=1023
    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i <= TO_UNSIGNED(1023, 10);
            ELSE
                IF (fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_i, 10)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select(BITSELECT,601)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q(9 downto 6);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c <= fft_fftLight_FFTPipe_TwiddleBlock_1_counter_x_q(5 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x(LOGICAL,395)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q <= "1" WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_c = fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroIndex_x_q ELSE "0";

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x(LOGICAL,394)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(0 downto 0) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(1 downto 1) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(2 downto 2) & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_extractPivot_x_merged_bit_select_b(3 downto 3);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x(MUX,398)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s <= redist33_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_1_q;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q, fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q;
            WHEN "1" => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= STD_LOGIC_VECTOR("000000" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_bitReverse_x_q);
            WHEN OTHERS => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x(ADD,392)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_mux_x_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_zeroAngle_x_q);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1 <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_i WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q = "1" ELSE fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_cmpEQ_x_q = "1" ELSE fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b;
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_b1));
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_o(10 downto 0);

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x(BITSELECT,511)@24
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoad_x_q(9 downto 0);

    -- redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1(DELAY,612)
    redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select(BITSELECT,604)@25
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b <= redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q(9 downto 8);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_c <= redist7_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleAngle_TAImpl_addSLoadPostCast_sel_x_b_1_q(7 downto 0);

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
        init_file => "fft1024_intel_FPGA_unified_fft_103_4ahuvxq_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x.hex",
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
        rden_a => redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q(0),
        address_b => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ab,
        wren_b => '0',
        q_b => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_iq,
        rden_b => redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q(0)
    );
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_iq(31 downto 0);
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_r <= fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x_ir(31 downto 0);

    -- redist1_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_SAddr_x_merged_bit_select_c_2(DELAY,606)
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

    -- redist0_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_bitExtract_x_merged_bit_select_b_2(DELAY,605)
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

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select(BITSELECT,602)@27
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
    thefft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1(DELAY,659)
    redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_castNegateSin_x(BLACKBOX,13)@28
    thedupName_0_castNegateSin_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist54_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateSin_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_castNegateSin_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist19_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux2_x_q_1(DELAY,624)
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

    -- redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1(DELAY,607)
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
    fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_xnorBlock_x_q <= not (redist2_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_Q13Block_x_merged_bit_select_c_1_q xor GND_q);

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

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_notEnable(LOGICAL,971)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_nor(LOGICAL,972)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_nor_q <= not (redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_notEnable_q or redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_q);

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_last(CONSTANT,968)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_last_q <= "0111011";

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp(LOGICAL,969)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_b <= STD_LOGIC_VECTOR("0" & redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_q);
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_q <= "1" WHEN redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_last_q = redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_b ELSE "0";

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg(REG,970)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg_q <= "0";
            ELSE
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg_q <= STD_LOGIC_VECTOR(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena(REG,973)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_q <= "0";
            ELSE
                IF (redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_nor_q = "1") THEN
                    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_q <= STD_LOGIC_VECTOR(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_enaAnd(LOGICAL,974)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_enaAnd_q <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_sticky_ena_q and VCC_q;

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt(COUNTER,966)
    -- low=0, high=60, step=1, init=0
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq <= '0';
            ELSE
                IF (redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i = TO_UNSIGNED(59, 6)) THEN
                    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq <= '1';
                ELSE
                    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq <= '0';
                END IF;
                IF (redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_eq = '1') THEN
                    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i + 4;
                ELSE
                    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_i, 6)));

    -- redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,715)
    redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist109_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x(MUX,165)@24
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_1_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s, redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= redist110_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= redist111_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr(REG,967)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr_q <= "111100";
            ELSE
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr_q <= STD_LOGIC_VECTOR(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem(DUALMEM,965)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q);
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_aa <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_wraddr_q;
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ab <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_rdcnt_q;
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_reset0 <= not (rst);
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 61,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 61,
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
        clocken1 => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_reset0,
        clock1 => clk,
        address_a => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_aa,
        data_a => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_ab,
        q_b => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_iq
    );
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_q <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_iq(31 downto 0);

    -- redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0(DELAY,964)
    redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q <= (others => '0');
            ELSE
                redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q <= STD_LOGIC_VECTOR(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,28)@23
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_notEnable(LOGICAL,982)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_nor(LOGICAL,983)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_nor_q <= not (redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_notEnable_q or redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_q);

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_last(CONSTANT,979)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_last_q <= "0111101";

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp(LOGICAL,980)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_b <= STD_LOGIC_VECTOR("0" & redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_q);
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_q <= "1" WHEN redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_last_q = redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_b ELSE "0";

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg(REG,981)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg_q <= "0";
            ELSE
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg_q <= STD_LOGIC_VECTOR(redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena(REG,984)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_q <= "0";
            ELSE
                IF (redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_nor_q = "1") THEN
                    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_q <= STD_LOGIC_VECTOR(redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_enaAnd(LOGICAL,985)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_enaAnd_q <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_sticky_ena_q and VCC_q;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt(COUNTER,977)
    -- low=0, high=62, step=1, init=0
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i <= TO_UNSIGNED(0, 6);
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq <= '0';
            ELSE
                IF (redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i = TO_UNSIGNED(61, 6)) THEN
                    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq <= '1';
                ELSE
                    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq <= '0';
                END IF;
                IF (redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_eq = '1') THEN
                    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i + 2;
                ELSE
                    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_i, 6)));

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0(DELAY,975)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0_q <= (others => '0');
            ELSE
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0_q <= STD_LOGIC_VECTOR(redist86_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_63_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr(REG,978)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr_q <= "111110";
            ELSE
                redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr_q <= STD_LOGIC_VECTOR(redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem(DUALMEM,976)
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ia <= STD_LOGIC_VECTOR(redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_inputreg0_q);
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_aa <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_wraddr_q;
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ab <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_rdcnt_q;
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_reset0 <= not (rst);
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 6,
        numwords_a => 63,
        width_b => 32,
        widthad_b => 6,
        numwords_b => 63,
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
        clocken1 => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_reset0,
        clock1 => clk,
        address_a => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_aa,
        data_a => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_ab,
        q_b => redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_iq
    );
    redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_q <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x(MUX,464)@24
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s <= redist95_fft_fftLight_FFTPipe_FFT4Block_1_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s, redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_q, fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= redist87_fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q_128_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_1_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,72)@24
    -- out out_primWireOut@27
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,724)
    redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x(BLACKBOX,246)@28
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist119_dupName_2_fft_fftLight_FFTPipe_FFT4Block_1_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1(DELAY,665)
    redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut);
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
    thefft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1(DELAY,660)
    redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_castNegateCos_x(BLACKBOX,12)@28
    thedupName_0_castNegateCos_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist55_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_negateCos_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_castNegateCos_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist20_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_swapSinCos_mux1_x_q_1(DELAY,625)
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
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q,
        in_1 => redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q,
        in_3 => redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1(DELAY,732)
    redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x(BLACKBOX,248)@35
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist127_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr(REG,793)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q <= "11101";
            ELSE
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q <= STD_LOGIC_VECTOR(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem(DUALMEM,791)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut);
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_wraddr_q;
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_rdcnt_q;
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0 <= not (rst);
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 30,
        width_b => 32,
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
        clocken1 => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_reset0,
        clock1 => clk,
        address_a => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_aa,
        data_a => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_ab,
        q_b => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq
    );
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_iq(31 downto 0);

    -- redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0(DELAY,790)
    redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q <= (others => '0');
            ELSE
                redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q <= STD_LOGIC_VECTOR(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,40)@35
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11(DELAY,640)
    redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist34_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_2_q, xout => redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x(COUNTER,176)@34 + 1
    -- low=0, high=63, step=1, init=63
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i <= TO_UNSIGNED(63, 6);
            ELSE
                IF (redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_i, 6)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x(BITSELECT,175)@35
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_counterBlock_x_q(5 downto 5);

    -- redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12(DELAY,641)
    redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_q <= (others => '0');
            ELSE
                redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_q <= STD_LOGIC_VECTOR(redist35_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_11_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x(LOGICAL,174)@35
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q <= redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_q and fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_bitExtract_x_b;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_notEnable(LOGICAL,808)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_nor(LOGICAL,809)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_nor_q <= not (redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_notEnable_q or redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q);

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_last(CONSTANT,805)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_last_q <= "011100";

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp(LOGICAL,806)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_q);
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_q <= "1" WHEN redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_last_q = redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_b ELSE "0";

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg(REG,807)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_q <= "0";
            ELSE
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena(REG,810)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q <= "0";
            ELSE
                IF (redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_nor_q = "1") THEN
                    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_enaAnd(LOGICAL,811)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_enaAnd_q <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_sticky_ena_q and VCC_q;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt(COUNTER,803)
    -- low=0, high=29, step=1, init=0
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '0';
            ELSE
                IF (redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '1';
                ELSE
                    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq <= '0';
                END IF;
                IF (redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_eq = '1') THEN
                    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i + 3;
                ELSE
                    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_i, 5)));

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0(DELAY,801)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0_q <= (others => '0');
            ELSE
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0_q <= STD_LOGIC_VECTOR(redist56_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_32_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr(REG,804)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr_q <= "11101";
            ELSE
                redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr_q <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem(DUALMEM,802)
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ia <= STD_LOGIC_VECTOR(redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_inputreg0_q);
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_aa <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_wraddr_q;
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ab <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_rdcnt_q;
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_reset0 <= not (rst);
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 30,
        width_b => 32,
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
        clocken1 => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_reset0,
        clock1 => clk,
        address_a => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_aa,
        data_a => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_ab,
        q_b => redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_iq
    );
    redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_q <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,533)@35 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist57_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut_64_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,84)@36
    -- out out_primWireOut@39
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,711)
    redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x(BLACKBOX,183)@40
    thefft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1(DELAY,683)
    redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x(BLACKBOX,184)@41
    thefft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist78_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateRe_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable(LOGICAL,819)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor(LOGICAL,820)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q <= not (redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_notEnable_q or redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q);

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last(CONSTANT,816)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q <= "011100";

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp(LOGICAL,817)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q);
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q <= "1" WHEN redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_last_q = redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_b ELSE "0";

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg(REG,818)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q <= "0";
            ELSE
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena(REG,821)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q <= "0";
            ELSE
                IF (redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_nor_q = "1") THEN
                    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd(LOGICAL,822)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_sticky_ena_q and VCC_q;

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt(COUNTER,814)
    -- low=0, high=29, step=1, init=0
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '0';
            ELSE
                IF (redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '1';
                ELSE
                    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq <= '0';
                END IF;
                IF (redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_eq = '1') THEN
                    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i + 3;
                ELSE
                    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_i, 5)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x(BLACKBOX,16)@29
    -- out out_primWireOut@34
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux2_x_q,
        in_1 => redist61_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_mux3_x_q,
        in_3 => redist60_fft_fftLight_FFTPipe_TwiddleBlock_1_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1(DELAY,733)
    redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x(BLACKBOX,247)@35
    thefft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist128_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_1_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr(REG,815)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q <= "11101";
            ELSE
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem(DUALMEM,813)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut);
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_wraddr_q;
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_rdcnt_q;
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0 <= not (rst);
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 30,
        width_b => 32,
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
        clocken1 => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_reset0,
        clock1 => clk,
        address_a => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_aa,
        data_a => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_ab,
        q_b => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq
    );
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_iq(31 downto 0);

    -- redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0(DELAY,812)
    redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q <= (others => '0');
            ELSE
                redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,39)@35
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_notEnable(LOGICAL,830)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_nor(LOGICAL,831)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_nor_q <= not (redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_notEnable_q or redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q);

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_last(CONSTANT,827)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_last_q <= "011100";

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp(LOGICAL,828)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_b <= STD_LOGIC_VECTOR("0" & redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_q);
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_q <= "1" WHEN redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_last_q = redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_b ELSE "0";

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg(REG,829)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_q <= "0";
            ELSE
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena(REG,832)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q <= "0";
            ELSE
                IF (redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_nor_q = "1") THEN
                    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_enaAnd(LOGICAL,833)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_enaAnd_q <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_sticky_ena_q and VCC_q;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt(COUNTER,825)
    -- low=0, high=29, step=1, init=0
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '0';
            ELSE
                IF (redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '1';
                ELSE
                    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq <= '0';
                END IF;
                IF (redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_eq = '1') THEN
                    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i + 3;
                ELSE
                    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_i, 5)));

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0(DELAY,823)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0_q <= (others => '0');
            ELSE
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0_q <= STD_LOGIC_VECTOR(redist58_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_32_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr(REG,826)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr_q <= "11101";
            ELSE
                redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr_q <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem(DUALMEM,824)
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ia <= STD_LOGIC_VECTOR(redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_inputreg0_q);
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_aa <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_wraddr_q;
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ab <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_rdcnt_q;
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_reset0 <= not (rst);
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 5,
        numwords_a => 30,
        width_b => 32,
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
        clocken1 => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_reset0,
        clock1 => clk,
        address_a => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_aa,
        data_a => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_ab,
        q_b => redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_iq
    );
    redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_q <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,532)@35 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist59_fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut_64_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_1_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,83)@36
    -- out out_primWireOut@39
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,713)
    redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x(CONSTANT,496)
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q <= "100000";

    -- redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,614)
    redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x(COUNTER,492)@35 + 1
    -- low=0, high=63, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 6);
            ELSE
                IF (redist36_fft_fftLight_FFTPipe_FFT4Block_1_delayValid_pulseMultiplier_bitExtract_x_b_12_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_i, 6)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x(BITSELECT,491)@36
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_counter_x_q(5 downto 5);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,539)@36 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_qi <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b xor redist9_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_bitExtract1_x_b_1_q;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q, clk => clk, aclr => rst, ena => '1' );

    -- redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3(DELAY,609)
    redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_delay_0 <= (others => '0');
            ELSE
                redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q);
            END IF;
        END IF;
    END PROCESS;
    redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_q <= redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x(ADD,493)@38
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("000000" & fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_i WHEN redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN redist4_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseDivider_edgeDetect_xorBlock_x_q_3_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_o(6 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,540)@38
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoad_x_q(5 downto 0);

    -- redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,608)
    redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,495)@39
    fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b <= redist3_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(5 downto 5);

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

    -- fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select(BITSELECT,598)@40
    fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q(5 downto 5);
    fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_2_counter_x_q(4 downto 4);

    -- fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x(LOGICAL,112)@40 + 1
    fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x(MUX,180)@41
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s, redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_negateReconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr(REG,901)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr_q <= "1100";
            ELSE
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr_q <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem(DUALMEM,899)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q);
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_aa <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_wraddr_q;
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ab <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_rdcnt_q;
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_reset0 <= not (rst);
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 13,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 13,
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
        clocken1 => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_reset0,
        clock1 => clk,
        address_a => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_aa,
        data_a => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_ab,
        q_b => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_iq
    );
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_q <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_iq(31 downto 0);

    -- redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0(DELAY,898)
    redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q <= (others => '0');
            ELSE
                redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,29)@40
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1(DELAY,613)
    redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= (others => '0');
            ELSE
                redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x(LOGICAL,111)@40
    fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q <= redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q and fft_fftLight_FFTPipe_FFT4Block_2_bitExtract1_x_merged_bit_select_c;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_notEnable(LOGICAL,916)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_nor(LOGICAL,917)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_nor_q <= not (redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_notEnable_q or redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q);

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_last(CONSTANT,913)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_last_q <= "01101";

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp(LOGICAL,914)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_q);
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_q <= "1" WHEN redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_last_q = redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_b ELSE "0";

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg(REG,915)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_q <= "0";
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_q <= STD_LOGIC_VECTOR(redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena(REG,918)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q <= "0";
            ELSE
                IF (redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_nor_q = "1") THEN
                    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_enaAnd(LOGICAL,919)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_enaAnd_q <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_sticky_ena_q and VCC_q;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt(COUNTER,911)
    -- low=0, high=14, step=1, init=0
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq <= '0';
            ELSE
                IF (redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i = TO_UNSIGNED(13, 4)) THEN
                    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq <= '1';
                ELSE
                    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq <= '0';
                END IF;
                IF (redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_eq = '1') THEN
                    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i + 2;
                ELSE
                    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_i, 4)));

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0(DELAY,909)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0_q <= (others => '0');
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0_q <= STD_LOGIC_VECTOR(redist79_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_15_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr(REG,912)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr_q <= "1110";
            ELSE
                redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr_q <= STD_LOGIC_VECTOR(redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem(DUALMEM,910)
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ia <= STD_LOGIC_VECTOR(redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_inputreg0_q);
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_aa <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_wraddr_q;
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ab <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_rdcnt_q;
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_reset0 <= not (rst);
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 15,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 15,
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
        clocken1 => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_reset0,
        clock1 => clk,
        address_a => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_aa,
        data_a => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_ab,
        q_b => redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_iq
    );
    redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_q <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_iq(31 downto 0);

    -- redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1(DELAY,699)
    redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x(MUX,481)@41
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s <= redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s, redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= redist80_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q_32_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,73)@41
    -- out out_primWireOut@44
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,723)
    redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x(BLACKBOX,275)@45
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist118_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1(DELAY,658)
    redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x(CONSTANT,360)
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q <= "10000";

    -- redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1(DELAY,637)
    redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x(COUNTER,356)@40 + 1
    -- low=0, high=31, step=1, init=0
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 5);
            ELSE
                IF (redist8_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_delayValid_pulseMultiplier_bitExtract_x_b_1_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_i, 5)));

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x(BITSELECT,355)@41
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_counter_x_q(4 downto 4);

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,488)@41
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b xor redist32_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x(ADD,357)@40
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a <= STD_LOGIC_VECTOR("0" & redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b <= STD_LOGIC_VECTOR("00000" & fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i <= STD_LOGIC_VECTOR("0" & fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_constBlock_x_q);
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1 <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_i WHEN fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1 <= (others => '0') WHEN fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseDivider_edgeDetect_xorBlock_x_q = "1" ELSE fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b;
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o <= STD_LOGIC_VECTOR(UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_a1) + UNSIGNED(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_b1));
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_o(5 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x(BITSELECT,489)@40
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b <= fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoad_x_q(4 downto 0);

    -- redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1(DELAY,615)
    redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= (others => '0');
            ELSE
                redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x(BITSELECT,359)@41
    fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b <= redist10_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_addSLoadPostCast_sel_x_b_1_q(4 downto 4);

    -- redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4(DELAY,626)
    redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_0 <= (others => '0');
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b);
            END IF;
        END IF;
    END PROCESS;
    redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_1 <= redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_2 <= (others => '0');
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_2 <= redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_q <= redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_delay_2;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x(COUNTER,138)@45 + 1
    -- low=0, high=63, step=1, init=63
    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i <= TO_UNSIGNED(63, 6);
            ELSE
                IF (redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_q = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_i, 6)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,592)@46
    fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q) IS
            WHEN "000000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "000111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "001111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "010000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "010001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110010001111100010111000010";
            WHEN "010010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "010011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111000011100011100111011010";
            WHEN "010100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "010101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010101001101101100110001";
            WHEN "010110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "010111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011110110001010010111110";
            WHEN "011000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111100000000000000000000000";
            WHEN "011001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011110110001010010111110";
            WHEN "011010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "011011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010101001101101100110001";
            WHEN "011100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "011101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111000011100011100111011010";
            WHEN "011110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "011111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110010001111100010111000010";
            WHEN "100000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "100001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111101110010001011110100110110";
            WHEN "100010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110010001111100010111000010";
            WHEN "100011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110100101001010000000110001";
            WHEN "100100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "100101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110111100010101101011101010";
            WHEN "100110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111000011100011100111011010";
            WHEN "100111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001000100110011110011001";
            WHEN "101000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "101001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010001011110010000000011";
            WHEN "101010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010101001101101100110001";
            WHEN "101011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011000011100010110011000";
            WHEN "101100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "101101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011101001111101000001011";
            WHEN "101110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011110110001010010111110";
            WHEN "101111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011111101100010001101101";
            WHEN "110000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "110001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110100101001010000000110001";
            WHEN "110010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111000011100011100111011010";
            WHEN "110011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111010001011110010000000011";
            WHEN "110100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "110101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011111101100010001101101";
            WHEN "110110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011110110001010010111110";
            WHEN "110111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011000011100010110011000";
            WHEN "111000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "111001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110111100010101101011101010";
            WHEN "111010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110010001111100010111000010";
            WHEN "111011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111101110010001011110100110110";
            WHEN "111100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN "111101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111001000100110011110011001";
            WHEN "111110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111010101001101101100110001";
            WHEN "111111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111111011101001111101000001011";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_notEnable(LOGICAL,927)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_nor(LOGICAL,928)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_nor_q <= not (redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_notEnable_q or redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q);

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_last(CONSTANT,924)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_last_q <= "01011";

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp(LOGICAL,925)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_b <= STD_LOGIC_VECTOR("0" & redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_q);
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_q <= "1" WHEN redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_last_q = redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_b ELSE "0";

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg(REG,926)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_q <= "0";
            ELSE
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_q <= STD_LOGIC_VECTOR(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena(REG,929)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q <= "0";
            ELSE
                IF (redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_nor_q = "1") THEN
                    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q <= STD_LOGIC_VECTOR(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_enaAnd(LOGICAL,930)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_enaAnd_q <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_sticky_ena_q and VCC_q;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt(COUNTER,922)
    -- low=0, high=12, step=1, init=0
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq <= '0';
            ELSE
                IF (redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i = TO_UNSIGNED(11, 4)) THEN
                    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq <= '1';
                ELSE
                    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq <= '0';
                END IF;
                IF (redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_eq = '1') THEN
                    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i + 4;
                ELSE
                    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_i, 4)));

    -- redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,712)
    redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist106_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x(MUX,179)@41
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_2_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s, redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= redist107_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= redist108_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr(REG,923)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr_q <= "1100";
            ELSE
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr_q <= STD_LOGIC_VECTOR(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem(DUALMEM,921)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q);
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_aa <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_wraddr_q;
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ab <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_rdcnt_q;
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_reset0 <= not (rst);
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 13,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 13,
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
        clocken1 => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_reset0,
        clock1 => clk,
        address_a => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_aa,
        data_a => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_ab,
        q_b => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_iq
    );
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_q <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_iq(31 downto 0);

    -- redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0(DELAY,920)
    redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q <= (others => '0');
            ELSE
                redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q <= STD_LOGIC_VECTOR(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,30)@40
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_notEnable(LOGICAL,938)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_nor(LOGICAL,939)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_nor_q <= not (redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_notEnable_q or redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q);

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_last(CONSTANT,935)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_last_q <= "01101";

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp(LOGICAL,936)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_b <= STD_LOGIC_VECTOR("0" & redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_q);
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_q <= "1" WHEN redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_last_q = redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_b ELSE "0";

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg(REG,937)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_q <= "0";
            ELSE
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_q <= STD_LOGIC_VECTOR(redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena(REG,940)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q <= "0";
            ELSE
                IF (redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_nor_q = "1") THEN
                    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q <= STD_LOGIC_VECTOR(redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_enaAnd(LOGICAL,941)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_enaAnd_q <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_sticky_ena_q and VCC_q;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt(COUNTER,933)
    -- low=0, high=14, step=1, init=0
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq <= '0';
            ELSE
                IF (redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i = TO_UNSIGNED(13, 4)) THEN
                    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq <= '1';
                ELSE
                    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq <= '0';
                END IF;
                IF (redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_eq = '1') THEN
                    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i + 2;
                ELSE
                    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_i, 4)));

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0(DELAY,931)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0_q <= (others => '0');
            ELSE
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0_q <= STD_LOGIC_VECTOR(redist81_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_15_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr(REG,934)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr_q <= "1110";
            ELSE
                redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr_q <= STD_LOGIC_VECTOR(redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem(DUALMEM,932)
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ia <= STD_LOGIC_VECTOR(redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_inputreg0_q);
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_aa <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_wraddr_q;
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ab <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_rdcnt_q;
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_reset0 <= not (rst);
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 15,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 15,
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
        clocken1 => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_reset0,
        clock1 => clk,
        address_a => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_aa,
        data_a => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_ab,
        q_b => redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_iq
    );
    redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_q <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x(MUX,482)@41
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s <= redist94_fft_fftLight_FFTPipe_FFT4Block_2_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s, redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_q, fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= redist82_fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q_32_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_2_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,74)@41
    -- out out_primWireOut@44
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,722)
    redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x(BLACKBOX,276)@45
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist117_dupName_2_fft_fftLight_FFTPipe_FFT4Block_2_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1(DELAY,657)
    redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,593)@46
    fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_2_counter_x_q) IS
            WHEN "000000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "000111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "001111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "010000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "010001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011110110001010010111110";
            WHEN "010010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "010011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "010100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "010101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111000011100011100111011010";
            WHEN "010110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "010111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110010001111100010111000010";
            WHEN "011000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00100100100011010011000100110010";
            WHEN "011001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110010001111100010111000010";
            WHEN "011010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110110000111110111100010101";
            WHEN "011011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111000011100011100111011010";
            WHEN "011100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "011101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111010101001101101100110001";
            WHEN "011110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN "011111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011110110001010010111110";
            WHEN "100000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "100001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011111101100010001101101";
            WHEN "100010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011110110001010010111110";
            WHEN "100011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011101001111101000001011";
            WHEN "100100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011011001000001101011110";
            WHEN "100101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011000011100010110011000";
            WHEN "100110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "100111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010001011110010000000011";
            WHEN "101000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001101010000010011110011";
            WHEN "101001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001000100110011110011001";
            WHEN "101010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111000011100011100111011010";
            WHEN "101011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110111100010101101011101010";
            WHEN "101100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "101101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110100101001010000000110001";
            WHEN "101110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110010001111100010111000010";
            WHEN "101111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111101110010001011110100110110";
            WHEN "110000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111100000000000000000000000";
            WHEN "110001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111011101001111101000001011";
            WHEN "110010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111010101001101101100110001";
            WHEN "110011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111111001000100110011110011001";
            WHEN "110100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111110110000111110111100010101";
            WHEN "110101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "00111101110010001011110100110110";
            WHEN "110110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110010001111100010111000010";
            WHEN "110111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110111100010101101011101010";
            WHEN "111000" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111001101010000010011110011";
            WHEN "111001" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011000011100010110011000";
            WHEN "111010" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011110110001010010111110";
            WHEN "111011" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011111101100010001101101";
            WHEN "111100" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111011011001000001101011110";
            WHEN "111101" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111010001011110010000000011";
            WHEN "111110" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111111000011100011100111011010";
            WHEN "111111" => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= "10111110100101001010000000110001";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x(BLACKBOX,19)@46
    -- out out_primWireOut@51
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1(DELAY,730)
    redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x(BLACKBOX,278)@52
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist125_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr(REG,749)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr_q <= "101";
            ELSE
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr_q <= STD_LOGIC_VECTOR(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem(DUALMEM,747)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut);
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_aa <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_wraddr_q;
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ab <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_rdcnt_q;
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_reset0 <= not (rst);
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_reset0,
        clock1 => clk,
        address_a => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_aa,
        data_a => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_ab,
        q_b => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_iq
    );
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_q <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_iq(31 downto 0);

    -- redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0(DELAY,746)
    redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q <= (others => '0');
            ELSE
                redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q <= STD_LOGIC_VECTOR(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,42)@52
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10(DELAY,627)
    redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist21_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_4_q, xout => redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x(COUNTER,190)@51 + 1
    -- low=0, high=15, step=1, init=15
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i <= TO_UNSIGNED(15, 4);
            ELSE
                IF (redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_i, 4)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x(BITSELECT,189)@52
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_counterBlock_x_q(3 downto 3);

    -- redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11(DELAY,628)
    redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_q <= (others => '0');
            ELSE
                redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_q <= STD_LOGIC_VECTOR(redist22_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_10_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x(LOGICAL,188)@52
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q <= redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_q and fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_bitExtract_x_b;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_notEnable(LOGICAL,764)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_nor(LOGICAL,765)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_nor_q <= not (redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_notEnable_q or redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q);

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_last(CONSTANT,761)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_last_q <= "0100";

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp(LOGICAL,762)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_q);
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_q <= "1" WHEN redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_last_q = redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_b ELSE "0";

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg(REG,763)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_q <= "0";
            ELSE
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_q <= STD_LOGIC_VECTOR(redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena(REG,766)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q <= "0";
            ELSE
                IF (redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_nor_q = "1") THEN
                    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_enaAnd(LOGICAL,767)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_enaAnd_q <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_sticky_ena_q and VCC_q;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt(COUNTER,759)
    -- low=0, high=5, step=1, init=0
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '0';
            ELSE
                IF (redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '1';
                ELSE
                    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq <= '0';
                END IF;
                IF (redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_eq = '1') THEN
                    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i + 3;
                ELSE
                    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_i, 3)));

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0(DELAY,757)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0_q <= (others => '0');
            ELSE
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0_q <= STD_LOGIC_VECTOR(redist48_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_8_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr(REG,760)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr_q <= "101";
            ELSE
                redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr_q <= STD_LOGIC_VECTOR(redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem(DUALMEM,758)
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ia <= STD_LOGIC_VECTOR(redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_inputreg0_q);
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_aa <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_wraddr_q;
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ab <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_rdcnt_q;
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_reset0 <= not (rst);
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_reset0,
        clock1 => clk,
        address_a => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_aa,
        data_a => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_ab,
        q_b => redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_iq
    );
    redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_q <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,543)@52 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist49_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut_16_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,86)@53
    -- out out_primWireOut@56
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,708)
    redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x(BLACKBOX,197)@57
    thefft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1(DELAY,678)
    redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x(BLACKBOX,198)@58
    thefft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist73_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateRe_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_notEnable(LOGICAL,775)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_nor(LOGICAL,776)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_nor_q <= not (redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_notEnable_q or redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q);

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_last(CONSTANT,772)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_last_q <= "0100";

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp(LOGICAL,773)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_q);
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_q <= "1" WHEN redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_last_q = redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_b ELSE "0";

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg(REG,774)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_q <= "0";
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena(REG,777)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q <= "0";
            ELSE
                IF (redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_nor_q = "1") THEN
                    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_enaAnd(LOGICAL,778)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_enaAnd_q <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_sticky_ena_q and VCC_q;

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt(COUNTER,770)
    -- low=0, high=5, step=1, init=0
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq <= '0';
            ELSE
                IF (redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq <= '1';
                ELSE
                    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq <= '0';
                END IF;
                IF (redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_eq = '1') THEN
                    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i + 3;
                ELSE
                    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_i, 3)));

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x(BLACKBOX,18)@46
    -- out out_primWireOut@51
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist53_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_2_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist52_fft_fftLight_FFTPipe_TwiddleBlock_2_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1(DELAY,731)
    redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x(BLACKBOX,277)@52
    thefft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist126_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_2_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr(REG,771)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr_q <= "101";
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem(DUALMEM,769)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ia <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut);
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_aa <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_wraddr_q;
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ab <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_rdcnt_q;
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_reset0 <= not (rst);
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_reset0,
        clock1 => clk,
        address_a => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_aa,
        data_a => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_ab,
        q_b => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_iq
    );
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_q <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_iq(31 downto 0);

    -- redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0(DELAY,768)
    redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q <= (others => '0');
            ELSE
                redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,41)@52
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_notEnable(LOGICAL,786)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_nor(LOGICAL,787)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_nor_q <= not (redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_notEnable_q or redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q);

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_last(CONSTANT,783)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_last_q <= "0100";

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp(LOGICAL,784)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_b <= STD_LOGIC_VECTOR("0" & redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_q);
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_q <= "1" WHEN redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_last_q = redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_b ELSE "0";

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg(REG,785)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_q <= "0";
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_q <= STD_LOGIC_VECTOR(redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena(REG,788)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q <= "0";
            ELSE
                IF (redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_nor_q = "1") THEN
                    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q <= STD_LOGIC_VECTOR(redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_enaAnd(LOGICAL,789)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_enaAnd_q <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_sticky_ena_q and VCC_q;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt(COUNTER,781)
    -- low=0, high=5, step=1, init=0
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '0';
            ELSE
                IF (redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '1';
                ELSE
                    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq <= '0';
                END IF;
                IF (redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_eq = '1') THEN
                    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i + 3;
                ELSE
                    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_i, 3)));

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0(DELAY,779)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0_q <= (others => '0');
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0_q <= STD_LOGIC_VECTOR(redist50_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_8_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr(REG,782)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr_q <= "101";
            ELSE
                redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr_q <= STD_LOGIC_VECTOR(redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem(DUALMEM,780)
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ia <= STD_LOGIC_VECTOR(redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_inputreg0_q);
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_aa <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_wraddr_q;
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ab <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_rdcnt_q;
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_reset0 <= not (rst);
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_reset0,
        clock1 => clk,
        address_a => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_aa,
        data_a => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_ab,
        q_b => redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_iq
    );
    redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_q <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,542)@52 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist51_fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut_16_mem_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_2_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,85)@53
    -- out out_primWireOut@56
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,710)
    redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23(DELAY,629)
    redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist23_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_11_q, xout => redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_3_counter_x(COUNTER,123)@56 + 1
    -- low=0, high=15, step=1, init=15
    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i <= TO_UNSIGNED(15, 4);
            ELSE
                IF (redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_3_counter_x_i, 4)));

    -- fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select(BITSELECT,599)@57
    fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q(3 downto 3);
    fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_3_counter_x_q(2 downto 2);

    -- fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x(LOGICAL,119)@57 + 1
    fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_qi <= fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c;
    fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1, reset_high => '0' )
    PORT MAP ( xin => fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_qi, xout => fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x(MUX,194)@58
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s, redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_negateReconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3(DELAY,679)
    redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_0 <= (others => '0');
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q);
            END IF;
        END IF;
    END PROCESS;
    redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_1 <= redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q <= (others => '0');
            ELSE
                redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q <= redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,31)@57
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24(DELAY,630)
    redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_q <= (others => '0');
            ELSE
                redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_q <= STD_LOGIC_VECTOR(redist24_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_23_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x(LOGICAL,118)@57
    fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q <= redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_q and fft_fftLight_FFTPipe_FFT4Block_3_bitExtract1_x_merged_bit_select_c;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_notEnable(LOGICAL,884)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_nor(LOGICAL,885)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_nor_q <= not (redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_notEnable_q or redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q);

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_last(CONSTANT,881)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_last_q <= "010";

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp(LOGICAL,882)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_q);
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_q <= "1" WHEN redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_last_q = redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_b ELSE "0";

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg(REG,883)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_q <= "0";
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena(REG,886)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q <= "0";
            ELSE
                IF (redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_nor_q = "1") THEN
                    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_enaAnd(LOGICAL,887)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_enaAnd_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_sticky_ena_q and VCC_q;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt(COUNTER,879)
    -- low=0, high=3, step=1, init=0
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_i, 2)));

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr(REG,880)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr_q <= "11";
            ELSE
                redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr_q <= STD_LOGIC_VECTOR(redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem(DUALMEM,878)
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ia <= STD_LOGIC_VECTOR(redist74_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_3_q);
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_aa <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_wraddr_q;
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ab <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_rdcnt_q;
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_reset0 <= not (rst);
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 4,
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
        clocken1 => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_reset0,
        clock1 => clk,
        address_a => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_aa,
        data_a => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_ab,
        q_b => redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_iq
    );
    redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_iq(31 downto 0);

    -- redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1(DELAY,698)
    redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q <= (others => '0');
            ELSE
                redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x(MUX,499)@58
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s <= redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s, redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= redist75_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q_8_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux4_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,75)@58
    -- out out_primWireOut@61
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1(DELAY,721)
    redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x(BLACKBOX,305)@62
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist116_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1(DELAY,652)
    redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33(DELAY,631)
    redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist25_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_24_q, xout => redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x(COUNTER,141)@62 + 1
    -- low=0, high=15, step=1, init=15
    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i <= TO_UNSIGNED(15, 4);
            ELSE
                IF (redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33_q = "1") THEN
                    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i <= fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_i, 4)));

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl(LOOKUP,594)@63
    fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q) IS
            WHEN "0000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "0101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "0110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111100000000000000000000000";
            WHEN "0111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1000" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1001" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111110110000111110111100010101";
            WHEN "1010" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1011" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "1100" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00000000000000000000000000000000";
            WHEN "1101" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111011011001000001101011110";
            WHEN "1110" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "10111111001101010000010011110011";
            WHEN "1111" => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= "00111110110000111110111100010101";
            WHEN OTHERS => -- unreachable
                           fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,709)
    redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist103_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x(MUX,193)@58
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_3_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s, redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= redist104_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= redist105_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3(DELAY,681)
    redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_0 <= (others => '0');
            ELSE
                redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q);
            END IF;
        END IF;
    END PROCESS;
    redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_1 <= redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q <= (others => '0');
            ELSE
                redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q <= redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_delay_1;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,32)@57
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_notEnable(LOGICAL,894)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_nor(LOGICAL,895)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_nor_q <= not (redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_notEnable_q or redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q);

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_last(CONSTANT,891)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_last_q <= "010";

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp(LOGICAL,892)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_q);
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_q <= "1" WHEN redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_last_q = redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_b ELSE "0";

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg(REG,893)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_q <= "0";
            ELSE
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_q <= STD_LOGIC_VECTOR(redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena(REG,896)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q <= "0";
            ELSE
                IF (redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_nor_q = "1") THEN
                    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_enaAnd(LOGICAL,897)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_enaAnd_q <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_sticky_ena_q and VCC_q;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt(COUNTER,889)
    -- low=0, high=3, step=1, init=0
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_i, 2)));

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr(REG,890)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr_q <= "11";
            ELSE
                redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr_q <= STD_LOGIC_VECTOR(redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem(DUALMEM,888)
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ia <= STD_LOGIC_VECTOR(redist76_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_3_q);
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_aa <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_wraddr_q;
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ab <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_rdcnt_q;
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_reset0 <= not (rst);
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 4,
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
        clocken1 => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_reset0,
        clock1 => clk,
        address_a => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_aa,
        data_a => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_ab,
        q_b => redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_iq
    );
    redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_q <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_iq(31 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x(MUX,500)@58
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s <= redist93_fft_fftLight_FFTPipe_FFT4Block_3_and1Block_x_q_1_q;
    fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s, redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_q, fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= redist77_fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q_8_mem_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_3_trivialTwiddle_mux3_x_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,76)@58
    -- out out_primWireOut@61
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,720)
    redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x(BLACKBOX,306)@62
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist115_dupName_2_fft_fftLight_FFTPipe_FFT4Block_3_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1(DELAY,651)
    redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl(LOOKUP,595)@63
    fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_combproc: PROCESS (fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q)
    BEGIN
        -- Begin reserved scope level
        CASE (fft_fftLight_FFTPipe_TwiddleBlock_3_counter_x_q) IS
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
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1(DELAY,728)
    redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x(BLACKBOX,308)@69
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist123_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_realSub_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2(DELAY,647)
    redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_q <= redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,44)@69
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39(DELAY,632)
    redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist26_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_33_q, xout => redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x(COUNTER,204)@68 + 1
    -- low=0, high=3, step=1, init=3
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i <= TO_UNSIGNED(3, 2);
            ELSE
                IF (redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_i, 2)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x(BITSELECT,203)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_counterBlock_x_q(1 downto 1);

    -- redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40(DELAY,633)
    redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_q <= (others => '0');
            ELSE
                redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_q <= STD_LOGIC_VECTOR(redist27_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_39_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x(LOGICAL,202)@69
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q <= redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_q and fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_bitExtract_x_b;

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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4(DELAY,648)
    redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_delay_0 <= (others => '0');
            ELSE
                redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_delay_0 <= STD_LOGIC_VECTOR(redist42_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_2_q);
            END IF;
        END IF;
    END PROCESS;
    redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_q <= redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x(MUX,549)@69 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= redist43_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut_4_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_real_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,88)@70
    -- out out_primWireOut@73
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1(DELAY,705)
    redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x(BLACKBOX,211)@74
    thefft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1(DELAY,673)
    redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x(BLACKBOX,212)@75
    thefft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist68_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateRe_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x(BLACKBOX,20)@63
    -- out out_primWireOut@68
    thedupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_real_x_repl_q,
        in_1 => redist47_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_imag_x_out_primWireOut_1_q,
        in_2 => fft_fftLight_FFTPipe_TwiddleBlock_3_readAccessLUTBlock_ROM_imag_x_repl_q,
        in_3 => redist46_fft_fftLight_FFTPipe_TwiddleBlock_3_convertIn_real_x_out_primWireOut_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1(DELAY,729)
    redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q <= (others => '0');
            ELSE
                redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q <= STD_LOGIC_VECTOR(dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x(BLACKBOX,307)@69
    thefft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u
    PORT MAP (
        in_0 => redist124_dupName_0_fft_fftLight_FFTPipe_TwiddleBlock_3_mult_imagAdd_x_out_primWireOut_1_q,
        out_primWireOut => fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2(DELAY,649)
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_q <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,43)@69
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_q,
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
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4(DELAY,650)
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_delay_0 <= (others => '0');
            ELSE
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_delay_0 <= STD_LOGIC_VECTOR(redist44_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_2_q);
            END IF;
        END IF;
    END PROCESS;
    redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_q <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x(MUX,548)@69 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_andBlock_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= redist45_fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut_4_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_TwiddleBlock_3_convertOut_imag_x_out_primWireOut;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,87)@70
    -- out out_primWireOut@73
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2(DELAY,707)
    redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= (others => '0');
            ELSE
                redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0 <= STD_LOGIC_VECTOR(dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut);
            END IF;
        END IF;
    END PROCESS;
    redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q <= redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47(DELAY,634)
    redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "SYNC", phase => 0, modulus => 2, reset_high => '0' )
    PORT MAP ( xin => redist28_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_40_q, xout => redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47_q, clk => clk, aclr => rst, ena => '1' );

    -- fft_fftLight_FFTPipe_FFT4Block_4_counter_x(COUNTER,130)@74 + 1
    -- low=0, high=3, step=1, init=3
    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i <= TO_UNSIGNED(3, 2);
            ELSE
                IF (redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47_q = "1") THEN
                    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_FFTPipe_FFT4Block_4_counter_x_i, 2)));

    -- fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select(BITSELECT,600)@75
    fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_b <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q(1 downto 1);
    fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c <= fft_fftLight_FFTPipe_FFT4Block_4_counter_x_q(0 downto 0);

    -- fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x(LOGICAL,126)@75
    fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_b and fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c;

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x(MUX,208)@75
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s, redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q, fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x_out_primWireOut)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_negateReconvert_x_out_primWireOut;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1(DELAY,674)
    redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q <= (others => '0');
            ELSE
                redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,33)@75
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48(DELAY,635)
    redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_q <= (others => '0');
            ELSE
                redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_q <= STD_LOGIC_VECTOR(redist29_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_47_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x(LOGICAL,125)@75
    fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q <= redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_q and fft_fftLight_FFTPipe_FFT4Block_4_bitExtract1_x_merged_bit_select_c;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(MUX,55)@75 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2(DELAY,675)
    redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2_q <= (others => '0');
            ELSE
                redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2_q <= STD_LOGIC_VECTOR(redist69_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x(MUX,505)@75 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= redist70_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q_2_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux4_x_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x(BLACKBOX,77)@76
    -- out out_primWireOut@79
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_imag_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2(DELAY,706)
    redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= (others => '0');
            ELSE
                redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q <= STD_LOGIC_VECTOR(redist100_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x(MUX,207)@75
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and2Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_combproc: PROCESS (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s, redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q, redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q)
    BEGIN
        CASE (fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_s) IS
            WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= redist101_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut_2_q;
            WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= redist102_dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_fft2Block_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut_2_q;
            WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1(DELAY,676)
    redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q <= (others => '0');
            ELSE
                redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q <= STD_LOGIC_VECTOR(fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,34)@75
    thedupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi
    PORT MAP (
        in_0 => redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q,
        out_primWireOut => dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(MUX,56)@75 + 1
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
            ELSE
                CASE (dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_s) IS
                    WHEN "0" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= dupName_0_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
                    WHEN "1" => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q;
                    WHEN OTHERS => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2(DELAY,677)
    redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2_q <= (others => '0');
            ELSE
                redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2_q <= STD_LOGIC_VECTOR(redist71_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_1_q);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x(MUX,506)@75 + 1
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s <= fft_fftLight_FFTPipe_FFT4Block_4_and1Block_x_q;
    fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
            ELSE
                CASE (fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_s) IS
                    WHEN "0" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= redist72_fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q_2_q;
                    WHEN "1" => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= fft_fftLight_FFTPipe_FFT4Block_4_trivialTwiddle_mux3_x_q;
                    WHEN OTHERS => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x(BLACKBOX,78)@76
    -- out out_primWireOut@79
    thedupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x : flt_fft1024_intel_FPGA_unified_fft_103_4ahuvxq_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw
    PORT MAP (
        in_0 => fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_muxA_real_x_q,
        in_1 => dupName_1_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_q,
        out_primWireOut => dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut,
        clk => clk,
        rst => rst
    );

    -- redist99_fft_latch_0L_mux_x_q_77_notEnable(LOGICAL,1038)
    redist99_fft_latch_0L_mux_x_q_77_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist99_fft_latch_0L_mux_x_q_77_nor(LOGICAL,1039)
    redist99_fft_latch_0L_mux_x_q_77_nor_q <= not (redist99_fft_latch_0L_mux_x_q_77_notEnable_q or redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q);

    -- redist99_fft_latch_0L_mux_x_q_77_mem_last(CONSTANT,1035)
    redist99_fft_latch_0L_mux_x_q_77_mem_last_q <= "0101";

    -- redist99_fft_latch_0L_mux_x_q_77_cmp(LOGICAL,1036)
    redist99_fft_latch_0L_mux_x_q_77_cmp_b <= STD_LOGIC_VECTOR("0" & redist99_fft_latch_0L_mux_x_q_77_rdcnt_q);
    redist99_fft_latch_0L_mux_x_q_77_cmp_q <= "1" WHEN redist99_fft_latch_0L_mux_x_q_77_mem_last_q = redist99_fft_latch_0L_mux_x_q_77_cmp_b ELSE "0";

    -- redist99_fft_latch_0L_mux_x_q_77_cmpReg(REG,1037)
    redist99_fft_latch_0L_mux_x_q_77_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_cmpReg_q <= "0";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_cmpReg_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_sticky_ena(REG,1040)
    redist99_fft_latch_0L_mux_x_q_77_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q <= "0";
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_nor_q = "1") THEN
                    redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_enaAnd(LOGICAL,1041)
    redist99_fft_latch_0L_mux_x_q_77_enaAnd_q <= redist99_fft_latch_0L_mux_x_q_77_sticky_ena_q and VCC_q;

    -- redist99_fft_latch_0L_mux_x_q_77_rdcnt(COUNTER,1033)
    -- low=0, high=6, step=1, init=0
    redist99_fft_latch_0L_mux_x_q_77_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_rdcnt_i <= TO_UNSIGNED(0, 3);
                redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq <= '0';
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_rdcnt_i = TO_UNSIGNED(5, 3)) THEN
                    redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq <= '1';
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq <= '0';
                END IF;
                IF (redist99_fft_latch_0L_mux_x_q_77_rdcnt_eq = '1') THEN
                    redist99_fft_latch_0L_mux_x_q_77_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_rdcnt_i + 2;
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist99_fft_latch_0L_mux_x_q_77_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist99_fft_latch_0L_mux_x_q_77_rdcnt_i, 3)));

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_nor(LOGICAL,1106)
    redist99_fft_latch_0L_mux_x_q_77_split_1_nor_q <= not (redist99_fft_latch_0L_mux_x_q_77_notEnable_q or redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q);

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_mem_last(CONSTANT,1102)
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_last_q <= "011100";

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_cmp(LOGICAL,1103)
    redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_b <= STD_LOGIC_VECTOR("0" & redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_q);
    redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_q <= "1" WHEN redist99_fft_latch_0L_mux_x_q_77_split_1_mem_last_q = redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_b ELSE "0";

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg(REG,1104)
    redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_q <= "0";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena(REG,1107)
    redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q <= "0";
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_split_1_nor_q = "1") THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_enaAnd(LOGICAL,1108)
    redist99_fft_latch_0L_mux_x_q_77_split_1_enaAnd_q <= redist99_fft_latch_0L_mux_x_q_77_split_1_sticky_ena_q and VCC_q;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt(COUNTER,1100)
    -- low=0, high=29, step=1, init=0
    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq <= '0';
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i = TO_UNSIGNED(28, 5)) THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq <= '1';
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq <= '0';
                END IF;
                IF (redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_eq = '1') THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i + 3;
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_i, 5)));

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_nor(LOGICAL,1094)
    redist99_fft_latch_0L_mux_x_q_77_split_0_nor_q <= not (redist99_fft_latch_0L_mux_x_q_77_notEnable_q or redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q);

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_mem_last(CONSTANT,1090)
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_last_q <= "011101";

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_cmp(LOGICAL,1091)
    redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_b <= STD_LOGIC_VECTOR("0" & redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_q);
    redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_q <= "1" WHEN redist99_fft_latch_0L_mux_x_q_77_split_0_mem_last_q = redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_b ELSE "0";

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg(REG,1092)
    redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_q <= "0";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_0_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena(REG,1095)
    redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q <= "0";
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_split_0_nor_q = "1") THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_0_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_enaAnd(LOGICAL,1096)
    redist99_fft_latch_0L_mux_x_q_77_split_0_enaAnd_q <= redist99_fft_latch_0L_mux_x_q_77_split_0_sticky_ena_q and VCC_q;

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt(COUNTER,1088)
    -- low=0, high=30, step=1, init=0
    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq <= '0';
            ELSE
                IF (redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i = TO_UNSIGNED(29, 5)) THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq <= '1';
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq <= '0';
                END IF;
                IF (redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_eq = '1') THEN
                    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i + 2;
                ELSE
                    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i <= redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_i, 5)));

    -- redist132_chanIn_cunroll_x_channelIn_2(DELAY,737)
    redist132_chanIn_cunroll_x_channelIn_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist132_chanIn_cunroll_x_channelIn_2_delay_0 <= (others => '0');
            ELSE
                redist132_chanIn_cunroll_x_channelIn_2_delay_0 <= STD_LOGIC_VECTOR(channelIn);
            END IF;
        END IF;
    END PROCESS;
    redist132_chanIn_cunroll_x_channelIn_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist132_chanIn_cunroll_x_channelIn_2_q <= redist132_chanIn_cunroll_x_channelIn_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1(DELAY,703)
    redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q <= (others => '0');
            ELSE
                redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q <= STD_LOGIC_VECTOR(fft_fftLight_pulseDivider_bitExtract1_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- fft_fftLight_pulseDivider_counter_x(COUNTER,93)@1 + 1
    -- low=0, high=2047, step=1, init=0
    fft_fftLight_pulseDivider_counter_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_fftLight_pulseDivider_counter_x_i <= TO_UNSIGNED(0, 11);
            ELSE
                IF (redist131_chanIn_cunroll_x_validIn_1_q = "1") THEN
                    fft_fftLight_pulseDivider_counter_x_i <= fft_fftLight_pulseDivider_counter_x_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    fft_fftLight_pulseDivider_counter_x_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(fft_fftLight_pulseDivider_counter_x_i, 11)));

    -- fft_fftLight_pulseDivider_bitExtract1_x(BITSELECT,92)@2
    fft_fftLight_pulseDivider_bitExtract1_x_b <= fft_fftLight_pulseDivider_counter_x_q(10 downto 10);

    -- fft_fftLight_pulseDivider_edgeDetect_xorBlock_x(LOGICAL,144)@2
    fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q <= fft_fftLight_pulseDivider_bitExtract1_x_b xor redist98_fft_fftLight_pulseDivider_bitExtract1_x_b_1_q;

    -- fft_latch_0L_mux_x(MUX,90)@2 + 1
    fft_latch_0L_mux_x_s <= fft_fftLight_pulseDivider_edgeDetect_xorBlock_x_q;
    fft_latch_0L_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                fft_latch_0L_mux_x_q <= (others => '0');
            ELSE
                CASE (fft_latch_0L_mux_x_s) IS
                    WHEN "0" => fft_latch_0L_mux_x_q <= fft_latch_0L_mux_x_q;
                    WHEN "1" => fft_latch_0L_mux_x_q <= redist132_chanIn_cunroll_x_channelIn_2_q;
                    WHEN OTHERS => fft_latch_0L_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr(REG,1089)
    redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr_q <= "11110";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_mem(DUALMEM,1087)
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ia <= STD_LOGIC_VECTOR(fft_latch_0L_mux_x_q);
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_aa <= redist99_fft_latch_0L_mux_x_q_77_split_0_wraddr_q;
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ab <= redist99_fft_latch_0L_mux_x_q_77_split_0_rdcnt_q;
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_reset0 <= not (rst);
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 31,
        width_b => 8,
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
        clocken1 => redist99_fft_latch_0L_mux_x_q_77_split_0_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist99_fft_latch_0L_mux_x_q_77_split_0_mem_reset0,
        clock1 => clk,
        address_a => redist99_fft_latch_0L_mux_x_q_77_split_0_mem_aa,
        data_a => redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist99_fft_latch_0L_mux_x_q_77_split_0_mem_ab,
        q_b => redist99_fft_latch_0L_mux_x_q_77_split_0_mem_iq
    );
    redist99_fft_latch_0L_mux_x_q_77_split_0_mem_q <= redist99_fft_latch_0L_mux_x_q_77_split_0_mem_iq(7 downto 0);

    -- redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0(DELAY,1086)
    redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0_q <= (others => '0');
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_0_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0(DELAY,1097)
    redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0_q <= (others => '0');
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_0_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr(REG,1101)
    redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr_q <= "11101";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_mem(DUALMEM,1099)
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ia <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_inputreg0_q);
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_aa <= redist99_fft_latch_0L_mux_x_q_77_split_1_wraddr_q;
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ab <= redist99_fft_latch_0L_mux_x_q_77_split_1_rdcnt_q;
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_reset0 <= not (rst);
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_dmem : altera_syncram
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
        clocken1 => redist99_fft_latch_0L_mux_x_q_77_split_1_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist99_fft_latch_0L_mux_x_q_77_split_1_mem_reset0,
        clock1 => clk,
        address_a => redist99_fft_latch_0L_mux_x_q_77_split_1_mem_aa,
        data_a => redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist99_fft_latch_0L_mux_x_q_77_split_1_mem_ab,
        q_b => redist99_fft_latch_0L_mux_x_q_77_split_1_mem_iq
    );
    redist99_fft_latch_0L_mux_x_q_77_split_1_mem_q <= redist99_fft_latch_0L_mux_x_q_77_split_1_mem_iq(7 downto 0);

    -- redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0(DELAY,1098)
    redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0_q <= (others => '0');
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_inputreg0(DELAY,1030)
    redist99_fft_latch_0L_mux_x_q_77_inputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_inputreg0_q <= (others => '0');
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_inputreg0_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_split_1_outputreg0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_wraddr(REG,1034)
    redist99_fft_latch_0L_mux_x_q_77_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_wraddr_q <= "110";
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_wraddr_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist99_fft_latch_0L_mux_x_q_77_mem(DUALMEM,1032)
    redist99_fft_latch_0L_mux_x_q_77_mem_ia <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_inputreg0_q);
    redist99_fft_latch_0L_mux_x_q_77_mem_aa <= redist99_fft_latch_0L_mux_x_q_77_wraddr_q;
    redist99_fft_latch_0L_mux_x_q_77_mem_ab <= redist99_fft_latch_0L_mux_x_q_77_rdcnt_q;
    redist99_fft_latch_0L_mux_x_q_77_mem_reset0 <= not (rst);
    redist99_fft_latch_0L_mux_x_q_77_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 7,
        width_b => 8,
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
        clocken1 => redist99_fft_latch_0L_mux_x_q_77_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        sclr => redist99_fft_latch_0L_mux_x_q_77_mem_reset0,
        clock1 => clk,
        address_a => redist99_fft_latch_0L_mux_x_q_77_mem_aa,
        data_a => redist99_fft_latch_0L_mux_x_q_77_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist99_fft_latch_0L_mux_x_q_77_mem_ab,
        q_b => redist99_fft_latch_0L_mux_x_q_77_mem_iq
    );
    redist99_fft_latch_0L_mux_x_q_77_mem_q <= redist99_fft_latch_0L_mux_x_q_77_mem_iq(7 downto 0);

    -- redist99_fft_latch_0L_mux_x_q_77_outputreg0(DELAY,1031)
    redist99_fft_latch_0L_mux_x_q_77_outputreg0_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist99_fft_latch_0L_mux_x_q_77_outputreg0_q <= (others => '0');
            ELSE
                redist99_fft_latch_0L_mux_x_q_77_outputreg0_q <= STD_LOGIC_VECTOR(redist99_fft_latch_0L_mux_x_q_77_mem_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53(DELAY,636)
    redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_0 <= (others => '0');
            ELSE
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_0 <= STD_LOGIC_VECTOR(redist30_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_48_q);
            END IF;
        END IF;
    END PROCESS;
    redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_1 <= redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_0;
            END IF;
        END IF;
    END PROCESS;
    redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_clkproc_2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_2 <= (others => '0');
            ELSE
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_2 <= redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_1;
            END IF;
        END IF;
    END PROCESS;
    redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_clkproc_3: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_3 <= redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_2;
            END IF;
        END IF;
    END PROCESS;
    redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_clkproc_4: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (rst = '0') THEN
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_q <= (others => '0');
            ELSE
                redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_q <= redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- chanOut_cunroll_x(GPOUT,11)@79
    validOut <= redist31_fft_fftLight_FFTPipe_FFT4Block_2_delayValid_pulseMultiplier_bitExtract_x_b_53_q;
    channelOut <= redist99_fft_latch_0L_mux_x_q_77_outputreg0_q;
    out_q_real_tpl <= dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_real_x_out_primWireOut;
    out_q_imag_tpl <= dupName_2_fft_fftLight_FFTPipe_FFT4Block_4_BFUBlock_BFUImpl_addSub_imag_x_out_primWireOut;

END normal;
