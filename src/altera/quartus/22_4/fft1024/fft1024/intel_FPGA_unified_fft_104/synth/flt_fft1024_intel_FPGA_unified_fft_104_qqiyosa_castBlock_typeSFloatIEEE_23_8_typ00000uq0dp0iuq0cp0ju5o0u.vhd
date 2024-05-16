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

-- VHDL created from flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typeSFloatIEEE_23_8_castModeConvert_395c31if3ik7pg7vh9vt98pfeqhe3hqnc063065665c64i60u64u62164762jc5v622642i1k64k60qc4360uq5ux5gv8ylj56c00uq0dp0iuq0cp0ju5o0u
-- VHDL created on Tue Feb 28 09:43:20 2023


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

entity flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        rst : in std_logic
    );
end flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u;

architecture normal of flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    

begin


    -- out_primWireOut(GPOUT,4)@0
    out_primWireOut <= in_0;

END normal;
