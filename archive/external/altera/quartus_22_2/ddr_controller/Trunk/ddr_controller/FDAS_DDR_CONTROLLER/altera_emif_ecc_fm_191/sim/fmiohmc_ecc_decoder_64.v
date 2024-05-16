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







// synthesis VERILOG_INPUT_VERSION VERILOG_2001
//altera message_off 10463




`timescale 1 ps / 1 ps
module fmiohmc_ecc_decoder_64 (
	data,
	err_corrected,
	err_detected,
	err_fatal,
	err_sbe,
	q)/* synthesis synthesis_clearbox = 1 */;

	input	[71:0]  data;
	output	  err_corrected;
	output	  err_detected;
	output	  err_fatal;
	output	  err_sbe;
	output	[63:0]  q;

	wire  sub_wire0;
	wire  sub_wire1;
	wire  sub_wire2;
	wire  sub_wire4;
	wire [63:0] sub_wire3;
	wire  err_detected = sub_wire0;
	wire  err_fatal = sub_wire1;
	wire  err_corrected = sub_wire2;
	wire  err_sbe = sub_wire4;
	wire [63:0] q = sub_wire3[63:0];

	fmiohmc_ecc_decoder_64_altecc_decoder	iohmc_ecc_decoder_64_altecc_decoder_component (
				.data (data),
				.err_detected (sub_wire0),
				.err_fatal (sub_wire1),
				.err_corrected (sub_wire2),
				.err_sbe (sub_wire4),
				.q (sub_wire3));

endmodule

