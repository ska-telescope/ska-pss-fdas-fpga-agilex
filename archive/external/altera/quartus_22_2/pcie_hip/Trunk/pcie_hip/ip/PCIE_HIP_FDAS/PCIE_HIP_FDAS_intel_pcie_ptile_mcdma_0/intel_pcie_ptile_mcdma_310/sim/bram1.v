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


/* ##########################################################################
 * INTEL CONFIDENTIAL
 * Copyright 2009 2016 Intel Corporation
 *
 * The source code contained or described herein and all documents related
 * to the source code ("Material") are owned by Intel Corporation or
 * its suppliers or licensors. Title to the Material remains with Intel
 * Corporation or its suppliers and licensors. The Material contains trade
 * secrets and proprietary and confidential information of Intel or its
 * suppliers and licensors. The Material is protected by worldwide copyright
 * and trade secret laws and treaty provisions. No part of the Material
 * may be used, copied, reproduced, modified, published, uploaded, posted,
 * transmitted, distributed, or disclosed in any way without Intel's prior
 * express written permission.
 *
 * No license under any patent, copyright, trade secret or other intellectual
 * property right is granted to or conferred upon you by disclosure or
 * delivery of the Materials, either expressly, by implication, inducement,
 * estoppel or otherwise. Any license under such intellectual property
 * rights must be express and approved by Intel in writing.
 * ##########################################################################
 */
//-----------------------------------------------------------------------------
// Revision history:-
//
// 28/Apr/2018  | Creation. True dule port ram
//              |
// 20/Jun/2018  | Change the default DEVICE_FAMILY to Stratix 10 device.
//-----------------------------------------------------------------------------


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module  bram1 
    #(
      parameter DEVICE_FAMILY = "Stratix 10",
      parameter LOG2_DEPTH    = 8,        // Number of locations = 2^LOG2_DEPTH.
      parameter WIDTH         = 32,       // Width in bits of each location.
      parameter RDW_LOGIC = "FALSE",      // "FALSE" = No read during write logic; "TRUE" = read during write logic included.
      parameter RDW_MODE = "NEW_DATA_NO_NBE_READ",      // "NEW_DATA_NO_NBE_READ", "NEW_DATA_WITH_NBE_READ", "OLD_DATA", "DONT_CARE"
      parameter RST_LOGIC = "FALSE",      // "FALSE" = No reset write logic; "TRUE" = reset write logic included.
      parameter OUT_REG = "UNREGISTERED", // "UNREGISTERED" = no registers at out_data_a/b; "REGISTERED" = registers at out_data_a/b.
      parameter UNINITIALIZED = "FALSE")  // "FALSE" = simulation model is initialised; "TRUE" = model is uninitialised.
    (
     rst_n,
     address_a,
     address_b,
     byteena_a,
     byteena_b,
     clock,
     data_a,
     data_b,
     rden_a,
     rden_b,
     wren_a,
     wren_b,
     q_a,
     q_b);

    input                    rst_n;
    input  [LOG2_DEPTH-1:0]  address_a;
    input [LOG2_DEPTH-1:0]   address_b;
    input [WIDTH/8-1:0]      byteena_a;
    input [WIDTH/8-1:0]      byteena_b;
    input                    clock;
    input [WIDTH-1:0]        data_a;
    input [WIDTH-1:0]        data_b;
    input                    rden_a;
    input                    rden_b;
    input                    wren_a;
    input                    wren_b;
    output [WIDTH-1:0]       q_a;
    output [WIDTH-1:0]       q_b;
`ifndef ALTERA_RESERVED_QIS
    // synopsys translate_off
`endif
    tri1 [WIDTH/8-1:0]       byteena_a;
    tri1 [WIDTH/8-1:0]       byteena_b;
    tri1                     clock;
    tri1                     rden_a;
    tri1                     rden_b;
    tri0                     wren_a;
    tri0                     wren_b;
`ifndef ALTERA_RESERVED_QIS
    // synopsys translate_on
`endif

    reg                      read_b_duing_write_a;
    reg                      read_b_duing_write_a_1d;
    reg [WIDTH-1:0]          data_a_1d;
    reg [WIDTH-1:0]          data_a_2d;

    reg                      read_a_duing_write_b;
    reg                      read_a_duing_write_b_1d;
    reg [WIDTH-1:0]          data_b_1d;
    reg [WIDTH-1:0]          data_b_2d;

    wire [WIDTH-1:0]         sub_wire0;
    wire [WIDTH-1:0]         sub_wire1;
    wire [WIDTH-1:0]         q_a = (OUT_REG=="CLOCK0") ? (read_a_duing_write_b_1d ? data_b_2d : sub_wire0[WIDTH-1:0]):
                                                         (read_a_duing_write_b    ? data_b_1d : sub_wire0[WIDTH-1:0]);
    wire [WIDTH-1:0]         q_b = (OUT_REG=="CLOCK0") ? (read_b_duing_write_a_1d ? data_a_2d : sub_wire1[WIDTH-1:0]):
                                                         (read_b_duing_write_a    ? data_a_1d : sub_wire1[WIDTH-1:0]);
    reg                      mem_rst_in_progress,rst_wren;
    reg [LOG2_DEPTH-1:0]     addr_cnt;
    reg [LOG2_DEPTH-1:0]     address_rst_a,address_rst_b;

generate
   if (RDW_LOGIC == "TRUE") begin 
      always @(posedge clock) begin
        if (rden_b && wren_a && address_a == address_b)
             read_b_duing_write_a <= 1'b1;
        else read_b_duing_write_a <= 1'b0;
        read_b_duing_write_a_1d <= read_b_duing_write_a;
        
        if (wren_a) data_a_1d <= data_a;
        data_a_2d <= data_a_1d;
      end

      always @(posedge clock) begin
        if (rden_a && wren_b && address_b == address_a)
             read_a_duing_write_b <= 1'b1;
        else read_a_duing_write_b <= 1'b0;
        read_a_duing_write_b_1d <= read_a_duing_write_b;
        
        if (wren_b) data_b_1d <= data_b;
        data_b_2d <= data_b_1d;
      end
   end
   else begin 
      always @(posedge clock) begin
         read_b_duing_write_a    <= 1'b0;
         read_a_duing_write_b    <= 1'b0;
         read_b_duing_write_a_1d <= 1'b0;
         read_a_duing_write_b_1d <= 1'b0;
         data_b_2d               <= 'x;
         data_b_1d               <= 'x;
         data_a_2d               <= 'x;
         data_a_1d               <= 'x;
      end
   end
endgenerate
generate
   localparam RST_ADDR_CNT = 2**LOG2_DEPTH;
   if (RST_LOGIC == "TRUE") begin 
      always @(posedge clock) begin
        if (!rst_n) begin
           addr_cnt <= '0;
           mem_rst_in_progress <= 1'b1;
           rst_wren <= 1'b0;
        end
        else if (addr_cnt == RST_ADDR_CNT/2) begin 
           addr_cnt <= '0;
           mem_rst_in_progress <= 1'b0;
           rst_wren <= 1'b0;
        end
        else if (mem_rst_in_progress == 1'b1)begin  
           addr_cnt <= addr_cnt+1;
           rst_wren <= 1'b1;
        end
         address_rst_a <= {1'b0,addr_cnt[LOG2_DEPTH-2:0]};
         address_rst_b <= {1'b1,addr_cnt[LOG2_DEPTH-2:0]};
      end
   end
   else begin 
      always @(posedge clock) begin
         addr_cnt <= '0;
         mem_rst_in_progress <= 1'b0;
         rst_wren <= 1'b0;
         address_rst_a <= '0;
         address_rst_b <= '0;
      end
   end
endgenerate

    altera_syncram  altera_syncram_component 
        (
         .address_a (mem_rst_in_progress ? address_rst_a : address_a),
         .address_b (mem_rst_in_progress ? address_rst_b : address_b),
         .byteena_a (1'b1),
         .byteena_b (1'b1),
         .clock0 (clock),
         .data_a (mem_rst_in_progress ? '0 : data_a),
         .data_b (mem_rst_in_progress ? '0 : data_b),
         .rden_a (rden_a),
         .rden_b (rden_b),
         .wren_a (mem_rst_in_progress ? rst_wren : wren_a),
         .wren_b (mem_rst_in_progress ? rst_wren : wren_b),
         .q_a (sub_wire0),
         .q_b (sub_wire1),
         .aclr0 (1'b0),
         .aclr1 (1'b0),
         .address2_a (1'b1),
         .address2_b (1'b1),
         .addressstall_a (1'b0),
         .addressstall_b (1'b0),
         .clock1 (1'b1),
         .clocken0 (1'b1),
         .clocken1 (1'b1),
         .clocken2 (1'b1),
         .clocken3 (1'b1),
         .eccencbypass (1'b0),
         .eccencparity (8'b0),
         .eccstatus (),
         .sclr (1'b0));
    defparam
        altera_syncram_component.address_reg_b  = "CLOCK0",
        altera_syncram_component.byte_size  = 8,
        altera_syncram_component.clock_enable_input_a  = "BYPASS",
        altera_syncram_component.clock_enable_input_b  = "BYPASS",
        altera_syncram_component.clock_enable_output_a  = "BYPASS",
        altera_syncram_component.clock_enable_output_b  = "BYPASS",
        altera_syncram_component.indata_reg_b  = "CLOCK0",
        altera_syncram_component.intended_device_family  = DEVICE_FAMILY,
        altera_syncram_component.lpm_type  = "altera_syncram",
        altera_syncram_component.numwords_a  = 2**LOG2_DEPTH,
        altera_syncram_component.numwords_b  = 2**LOG2_DEPTH,
        altera_syncram_component.operation_mode  = "BIDIR_DUAL_PORT",
        altera_syncram_component.outdata_aclr_a  = "NONE",
        altera_syncram_component.outdata_sclr_a  = "NONE",
        altera_syncram_component.outdata_aclr_b  = "NONE",
        altera_syncram_component.outdata_sclr_b  = "NONE",
        altera_syncram_component.outdata_reg_a  = OUT_REG,
        altera_syncram_component.outdata_reg_b  = OUT_REG,
        altera_syncram_component.power_up_uninitialized  = UNINITIALIZED,
        //altera_syncram_component.ram_block_type  = "AUTO",
        altera_syncram_component.read_during_write_mode_mixed_ports  = "DONT_CARE",
        altera_syncram_component.read_during_write_mode_port_a  = RDW_MODE,
        altera_syncram_component.read_during_write_mode_port_b  = RDW_MODE,
        altera_syncram_component.widthad_a  = LOG2_DEPTH,
        altera_syncram_component.widthad_b  = LOG2_DEPTH,
        altera_syncram_component.width_a  = WIDTH,
        altera_syncram_component.width_b  = WIDTH,
		altera_syncram_component.width_byteena_a  = 1,
		altera_syncram_component.width_byteena_b  = 1;

endmodule


