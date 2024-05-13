-- (C) 2001-2022 Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions and other 
-- software and tools, and its AMPP partner logic functions, and any output 
-- files from any of the foregoing (including device programming or simulation 
-- files), and any associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License Subscription 
-- Agreement, Intel FPGA IP License Agreement, or other applicable 
-- license agreement, including, without limitation, that your use is for the 
-- sole purpose of programming logic devices manufactured by Intel and sold by 
-- Intel or its authorized distributors.  Please refer to the applicable 
-- agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY tennm;
USE tennm.tennm_components.tennm_fp_mac;

ENTITY multsub_fp_ci_s20_native_floating_point_dsp_1910_xbnuxwa IS
    PORT
    (
        clk       : IN STD_LOGIC ;
        clr0       : IN STD_LOGIC ;
        clr1       : IN STD_LOGIC ;
        ena       : IN STD_LOGIC_VECTOR (2 DOWNTO 0) ;
        fp32_chainin       : IN STD_LOGIC_VECTOR (31 DOWNTO 0) ;
        fp32_mult_a       : IN STD_LOGIC_VECTOR (31 DOWNTO 0) ;
        fp32_mult_b       : IN STD_LOGIC_VECTOR (31 DOWNTO 0) ;
        fp32_result       : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) 
    );
	
END multsub_fp_ci_s20_native_floating_point_dsp_1910_xbnuxwa;

ARCHITECTURE SYN OF multsub_fp_ci_s20_native_floating_point_dsp_1910_xbnuxwa IS


    SIGNAL sub_wire0    : STD_LOGIC_VECTOR (31 DOWNTO 0) ;

BEGIN
    fp32_result     <= sub_wire0(31 DOWNTO 0);

    tennm_fp_mac_component : tennm_fp_mac
	
    GENERIC MAP (
            operation_mode  => "fp32_mult_add",
            fp16_mode  => "flushed",
            fp16_input_width  => 16,
            use_chainin  => "true",
            fp32_adder_subtract  => "true",
            fp16_adder_subtract  => "false",
            clear_type  => "sclr",
            accumulate_clken  => "no_reg",
            accum_adder_clken  => "no_reg",
            adder_input_clken  => "0",
            adder_pl_clken  => "no_reg",
            fp16_mult_input_clken  => "no_reg",
            fp32_adder_a_clken  => "no_reg",
            fp32_adder_b_clken  => "no_reg",
            fp32_mult_a_clken  => "0",
            fp32_mult_b_clken  => "0",
            fp32_adder_a_chainin_pl_clken  => "no_reg",
            fp32_adder_a_chainin_2nd_pl_clken  => "no_reg",
            output_clken  => "0",
            accum_pipeline_clken  => "no_reg",
            mult_pipeline_clken  => "no_reg",
            accum_2nd_pipeline_clken  => "no_reg",
            mult_2nd_pipeline_clken  => "0"
    )
	
    PORT MAP (
        clk => clk,
        clr => clr1 & clr0,
        ena => ena,
        fp32_chainin => fp32_chainin,
        fp32_mult_a => fp32_mult_a,
        fp32_mult_b => fp32_mult_b,
        fp32_result => sub_wire0
    );
END SYN;

