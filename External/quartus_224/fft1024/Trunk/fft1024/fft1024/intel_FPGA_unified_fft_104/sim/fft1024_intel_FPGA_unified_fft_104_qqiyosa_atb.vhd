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

-- VHDL created from fft1024_intel_FPGA_unified_fft_104_qqiyosa
-- VHDL created on Tue Feb 28 09:43:18 2023


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
use work.dspba_sim_library_package.all;
entity fft1024_intel_FPGA_unified_fft_104_qqiyosa_atb is
end;

architecture normal of fft1024_intel_FPGA_unified_fft_104_qqiyosa_atb is

component fft1024_intel_FPGA_unified_fft_104_qqiyosa is
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
end component;

component fft1024_intel_FPGA_unified_fft_104_qqiyosa_stm is
    port (
        validIn_stm : out std_logic_vector(0 downto 0);
        channelIn_stm : out std_logic_vector(7 downto 0);
        in_d_real_tpl_stm : out std_logic_vector(31 downto 0);
        in_d_imag_tpl_stm : out std_logic_vector(31 downto 0);
        validOut_stm : out std_logic_vector(0 downto 0);
        channelOut_stm : out std_logic_vector(7 downto 0);
        out_q_real_tpl_stm : out std_logic_vector(31 downto 0);
        out_q_imag_tpl_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        rst : out std_logic
    );
end component;

signal validIn_stm : STD_LOGIC_VECTOR (0 downto 0);
signal channelIn_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_d_real_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_d_imag_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal validOut_stm : STD_LOGIC_VECTOR (0 downto 0);
signal channelOut_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_q_real_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_q_imag_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal validIn_dut : STD_LOGIC_VECTOR (0 downto 0);
signal channelIn_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_d_real_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_d_imag_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal validOut_dut : STD_LOGIC_VECTOR (0 downto 0);
signal channelOut_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_q_real_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal out_q_imag_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
        signal clk : std_logic;
        signal rst : std_logic;

begin

-- General Purpose data in real output
checkchanIn_cunroll_x : process (clk, rst, validIn_dut, validIn_stm, channelIn_dut, channelIn_stm, in_d_real_tpl_dut, in_d_real_tpl_stm, in_d_imag_tpl_dut, in_d_imag_tpl_stm)
variable in_d_real_tpl_real : REAL := 0.0;
variable in_d_real_tpl_stm_real : REAL := 0.0;
variable in_d_imag_tpl_real : REAL := 0.0;
variable in_d_imag_tpl_stm_real : REAL := 0.0;
begin
 in_d_real_tpl_real := vIEEE_2_real(in_d_real_tpl_dut, 8, 23, false);
 in_d_real_tpl_stm_real := vIEEE_2_real(in_d_real_tpl_stm, 8, 23, false);
 in_d_imag_tpl_real := vIEEE_2_real(in_d_imag_tpl_dut, 8, 23, false);
 in_d_imag_tpl_stm_real := vIEEE_2_real(in_d_imag_tpl_stm, 8, 23, false);
END PROCESS;


-- General Purpose data out check
checkchanOut_cunroll_x : process (clk, rst)
variable mismatch_validOut : BOOLEAN := FALSE;
variable mismatch_channelOut : BOOLEAN := FALSE;
variable mismatch_out_q_real_tpl : BOOLEAN := FALSE;
variable out_q_real_tpl_real : REAL := 0.0;
variable out_q_real_tpl_stm_real : REAL := 0.0;
variable mismatch_out_q_imag_tpl : BOOLEAN := FALSE;
variable out_q_imag_tpl_real : REAL := 0.0;
variable out_q_imag_tpl_stm_real : REAL := 0.0;
variable ok : BOOLEAN := TRUE;
variable fstatus : file_open_status;
file data_file : text;
begin
    file_open(fstatus, data_file, "fft1024_intel_FPGA_unified_fft_104_qqiyosa_chanOut_cunroll_x.stm",  read_mode);
    file_close(data_file);

    IF (rst = '0') THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        IF (fstatus /= name_error) THEN
            -- Only check output if output stimulus file exists.
            ok := TRUE;
            mismatch_validOut := FALSE;
            mismatch_channelOut := FALSE;
            mismatch_out_q_real_tpl := FALSE;
            mismatch_out_q_imag_tpl := FALSE;
   out_q_real_tpl_real := vIEEE_2_real(out_q_real_tpl_dut, 8, 23, false);
   out_q_real_tpl_stm_real := vIEEE_2_real(out_q_real_tpl_stm, 8, 23, false);
   out_q_imag_tpl_real := vIEEE_2_real(out_q_imag_tpl_dut, 8, 23, false);
   out_q_imag_tpl_stm_real := vIEEE_2_real(out_q_imag_tpl_stm, 8, 23, false);
            IF ( (validOut_dut /= validOut_stm)) THEN
                mismatch_validOut := TRUE;
                report "Mismatch on device output pin validOut" severity Warning;
            END IF;
            IF ( (abs(signed(channelOut_dut) - signed(channelOut_stm)) > 3)) THEN
                mismatch_channelOut := TRUE;
                report "Mismatch on device output pin channelOut" severity Warning;
            END IF;
            IF ( not vIEEEisEqual(out_q_real_tpl_dut, out_q_real_tpl_stm, 8, 23)) THEN
                mismatch_out_q_real_tpl := TRUE;
                report "Mismatch on device output pin out_q_real_tpl" severity Warning;
            END IF;
            IF ( not vIEEEisEqual(out_q_imag_tpl_dut, out_q_imag_tpl_stm, 8, 23)) THEN
                mismatch_out_q_imag_tpl := TRUE;
                report "Mismatch on device output pin out_q_imag_tpl" severity Warning;
            END IF;
            IF (mismatch_validOut or mismatch_channelOut or mismatch_out_q_real_tpl or mismatch_out_q_imag_tpl) THEN
                ok := FALSE;
            END IF;
            assert (ok)
            report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
        END IF;
    END IF;
END PROCESS;


dut : fft1024_intel_FPGA_unified_fft_104_qqiyosa port map (
    validIn_stm,
    channelIn_stm,
    in_d_real_tpl_stm,
    in_d_imag_tpl_stm,
    validOut_dut,
    channelOut_dut,
    out_q_real_tpl_dut,
    out_q_imag_tpl_dut,
        clk,
        rst
);

sim : fft1024_intel_FPGA_unified_fft_104_qqiyosa_stm port map (
    validIn_stm,
    channelIn_stm,
    in_d_real_tpl_stm,
    in_d_imag_tpl_stm,
    validOut_stm,
    channelOut_stm,
    out_q_real_tpl_stm,
    out_q_imag_tpl_stm,
        clk,
        rst
);

end normal;
