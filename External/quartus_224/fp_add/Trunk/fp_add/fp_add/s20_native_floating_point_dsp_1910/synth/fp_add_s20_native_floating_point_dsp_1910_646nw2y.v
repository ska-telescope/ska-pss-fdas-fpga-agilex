// (C) 2001-2022 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on

module  fp_add_s20_native_floating_point_dsp_1910_646nw2y  (

           clk,

           clr0,

           clr1,

           ena,

           fp32_adder_a,

           fp32_adder_b,

           fp32_result);

            input  clk;
            input  clr0;
            input  clr1;
            input [2:0] ena;
            input [31:0] fp32_adder_a;
            input [31:0] fp32_adder_b;
            output [31:0] fp32_result;
            wire [31:0] sub_wire0;
            wire [31:0] fp32_result = sub_wire0[31:0];    

            tennm_fp_mac        tennm_fp_mac_component (
                                        .clk (clk),
                                        .clr ({clr1,clr0}),
                                        .ena (ena),
                                        .fp32_adder_a (fp32_adder_a),
                                        .fp32_adder_b (fp32_adder_b),
                                        .fp32_result (sub_wire0));

            defparam
                    tennm_fp_mac_component.operation_mode = "fp32_add",
                    tennm_fp_mac_component.fp16_mode = "flushed",
                    tennm_fp_mac_component.fp16_input_width = 16,
                    tennm_fp_mac_component.use_chainin = "false",
                    tennm_fp_mac_component.fp32_adder_subtract = "false",
                    tennm_fp_mac_component.fp16_adder_subtract = "false",
                    tennm_fp_mac_component.clear_type = "aclr",
                    tennm_fp_mac_component.accumulate_clken = "no_reg",
                    tennm_fp_mac_component.accum_adder_clken = "no_reg",
                    tennm_fp_mac_component.adder_input_clken = "no_reg",
                    tennm_fp_mac_component.adder_pl_clken = "no_reg",
                    tennm_fp_mac_component.fp16_mult_input_clken = "no_reg",
                    tennm_fp_mac_component.fp32_adder_a_clken = "0",
                    tennm_fp_mac_component.fp32_adder_b_clken = "0",
                    tennm_fp_mac_component.fp32_mult_a_clken = "no_reg",
                    tennm_fp_mac_component.fp32_mult_b_clken = "no_reg",
                    tennm_fp_mac_component.fp32_adder_a_chainin_pl_clken = "no_reg",
                    tennm_fp_mac_component.fp32_adder_a_chainin_2nd_pl_clken = "no_reg",
                    tennm_fp_mac_component.output_clken = "0",
                    tennm_fp_mac_component.accum_pipeline_clken = "no_reg",
                    tennm_fp_mac_component.mult_pipeline_clken = "no_reg",
                    tennm_fp_mac_component.accum_2nd_pipeline_clken = "no_reg",
                    tennm_fp_mac_component.mult_2nd_pipeline_clken = "no_reg";
endmodule




