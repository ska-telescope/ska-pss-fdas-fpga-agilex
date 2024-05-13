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
-- VHDL created on Tue Jul 19 12:46:04 2022


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;

entity fft1024_intel_FPGA_unified_fft_103_4ahuvxq_stm is
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
end fft1024_intel_FPGA_unified_fft_103_4ahuvxq_stm;

architecture normal of fft1024_intel_FPGA_unified_fft_103_4ahuvxq_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal rst_stm_sig : std_logic := '0';
    signal clk_chanIn_cunroll_x_stm_sig_stop : std_logic := '0';
    signal clk_chanOut_cunroll_x_stm_sig_stop : std_logic := '0';

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


        -- Generating stimulus for chanIn_cunroll_x
        chanIn_cunroll_x_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_chanIn_cunroll_x : text open read_mode is "fft1024_intel_FPGA_unified_fft_103_4ahuvxq_chanIn_cunroll_x.stm";
            variable validIn_int_0 : Integer;
            variable validIn_temp : std_logic_vector(0 downto 0);
            variable channelIn_int_0 : Integer;
            variable channelIn_temp : std_logic_vector(7 downto 0);
            variable in_d_real_tpl_int_0 : Integer;
            variable in_d_real_tpl_temp : std_logic_vector(31 downto 0);
            variable in_d_imag_tpl_int_0 : Integer;
            variable in_d_imag_tpl_temp : std_logic_vector(31 downto 0);

        begin
            -- initialize all outputs to 0
            validIn_stm <= (others => '0');
            channelIn_stm <= (others => '0');
            in_d_real_tpl_stm <= (others => '0');
            in_d_imag_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1 loop
            
                wait for 2857 ps; -- additional reset delay
                
                validIn_stm <= (others => '0');
                channelIn_stm <= (others => '0');
                in_d_real_tpl_stm <= (others => '0');
                in_d_imag_tpl_stm <= (others => '0');
            end loop;
            while true loop
            
                IF (endfile(data_file_chanIn_cunroll_x)) THEN
                    clk_chanIn_cunroll_x_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_chanIn_cunroll_x, L);
                    
                    read(L, validIn_int_0);
                    validIn_temp(0 downto 0) := std_logic_vector(to_unsigned(validIn_int_0, 1));
                    validIn_stm <= validIn_temp;
                    read(L, channelIn_int_0);
                    channelIn_temp(7 downto 0) := std_logic_vector(to_unsigned(channelIn_int_0, 8));
                    channelIn_stm <= channelIn_temp;
                    read(L, in_d_real_tpl_int_0);
                    in_d_real_tpl_temp(31 downto 0) := std_logic_vector(to_signed(in_d_real_tpl_int_0, 32));
                    in_d_real_tpl_stm <= in_d_real_tpl_temp;
                    read(L, in_d_imag_tpl_int_0);
                    in_d_imag_tpl_temp(31 downto 0) := std_logic_vector(to_signed(in_d_imag_tpl_int_0, 32));
                    in_d_imag_tpl_stm <= in_d_imag_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for chanOut_cunroll_x
        chanOut_cunroll_x_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_chanOut_cunroll_x : text;
            variable fstatus : file_open_status;
            variable validOut_int_0 : Integer;
            variable validOut_temp : std_logic_vector(0 downto 0);
            variable channelOut_int_0 : Integer;
            variable channelOut_temp : std_logic_vector(7 downto 0);
            variable out_q_real_tpl_int_0 : Integer;
            variable out_q_real_tpl_temp : std_logic_vector(31 downto 0);
            variable out_q_imag_tpl_int_0 : Integer;
            variable out_q_imag_tpl_temp : std_logic_vector(31 downto 0);

        begin
            -- initialize all outputs to 0
            validOut_stm <= (others => '0');
            channelOut_stm <= (others => '0');
            out_q_real_tpl_stm <= (others => '0');
            out_q_imag_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1*2857 ps; -- additional reset delay
            
            file_open(fstatus, data_file_chanOut_cunroll_x, "fft1024_intel_FPGA_unified_fft_103_4ahuvxq_chanOut_cunroll_x.stm",  read_mode);
            IF (fstatus = mode_error) THEN
                report "mode_error while trying to open fft1024_intel_FPGA_unified_fft_103_4ahuvxq_chanOut_cunroll_x.stm" severity Warning;
            ELSIF (fstatus = status_error) THEN
                report "status_error while trying to open fft1024_intel_FPGA_unified_fft_103_4ahuvxq_chanOut_cunroll_x.stm" severity Warning;
            END IF;

            while fstatus /= name_error loop
            
                IF (endfile(data_file_chanOut_cunroll_x)) THEN
                    clk_chanOut_cunroll_x_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_chanOut_cunroll_x, L);
                    
                    read(L, validOut_int_0);
                    validOut_temp(0 downto 0) := std_logic_vector(to_unsigned(validOut_int_0, 1));
                    validOut_stm <= validOut_temp;
                    read(L, channelOut_int_0);
                    channelOut_temp(7 downto 0) := std_logic_vector(to_unsigned(channelOut_int_0, 8));
                    channelOut_stm <= channelOut_temp;
                    read(L, out_q_real_tpl_int_0);
                    out_q_real_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_q_real_tpl_int_0, 32));
                    out_q_real_tpl_stm <= out_q_real_tpl_temp;
                    read(L, out_q_imag_tpl_int_0);
                    out_q_imag_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_q_imag_tpl_int_0, 32));
                    out_q_imag_tpl_stm <= out_q_imag_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_chanIn_cunroll_x_stm_sig_stop OR clk_chanOut_cunroll_x_stm_sig_stop OR '0';


    END normal;
