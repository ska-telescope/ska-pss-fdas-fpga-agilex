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

-- VHDL created from flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEEE_23_8_5_5_0_correctRounding_false_false_381i92il4i37pz62uc87e8sc063060c60i65i61u65u63165760vc3860e62ei4e60k62k60360960f60uq5ux5gv8ylj56c00uq0dp0mvq0cd06o30qcz
-- VHDL created on Tue Jul 19 12:25:15 2022


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;

entity flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz_stm is
    port (
        in_0_stm : out std_logic_vector(31 downto 0);
        in_1_stm : out std_logic_vector(31 downto 0);
        in_2_stm : out std_logic_vector(31 downto 0);
        in_3_stm : out std_logic_vector(31 downto 0);
        out_primWireOut_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        rst : out std_logic
    );
end flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz_stm;

architecture normal of flt_ifft1024_intel_FPGA_unified_fft_103_ua3wp3i_scalarProductBlock_typeSFloatIEE0000uq0dp0mvq0cd06o30qcz_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal rst_stm_sig : std_logic := '0';

    function str_to_stdvec(inp: string) return std_logic_vector is
        variable temp: std_logic_vector(inp'range) := (others => 'X');
    begin
        for i in inp'range loop
            IF ((inp(i) = '1')) THEN
                temp(i) := '1';
            elsif (inp(i) = '0') then
                temp(i) := '0';
            END IF;
            end loop;
            return temp;
        end function str_to_stdvec;
        

    begin

    clk <= clk_stm_sig;
    clk_process: process 
    begin
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 1229 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 1228 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
    end process;

    rst <= rst_stm_sig;
    rst_process: process begin
        rst_stm_sig <= '0';
        wait for 2143 ps;
        wait for 1*2857 ps; -- additional reset delay
        rst_stm_sig <= '1';
        wait;
    end process;

        -- Driving gnd for in_0 signals

        in_0_stm <= (others => '0');
        -- Driving gnd for in_1 signals

        in_1_stm <= (others => '0');
        -- Driving gnd for in_2 signals

        in_2_stm <= (others => '0');
        -- Driving gnd for in_3 signals

        in_3_stm <= (others => '0');
        -- Driving gnd for out_primWireOut signals

        out_primWireOut_stm <= (others => '0');

    clk_stm_sig_stop <= '1';


    END normal;
