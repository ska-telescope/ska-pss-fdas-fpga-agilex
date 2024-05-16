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



///////////////////////////////////////////////////////////////////////////////
// EMIF example design component to drive local_reset_req
//
// This component is only intended to be used by the EMIF example design.
///////////////////////////////////////////////////////////////////////////////

module altera_emif_local_reset_sim_source (
   output logic local_reset_req,
   input  logic local_reset_done
);
   timeunit 1ns;
   timeprecision 1ps;
   
   assign local_reset_req = 1'b0;
endmodule
