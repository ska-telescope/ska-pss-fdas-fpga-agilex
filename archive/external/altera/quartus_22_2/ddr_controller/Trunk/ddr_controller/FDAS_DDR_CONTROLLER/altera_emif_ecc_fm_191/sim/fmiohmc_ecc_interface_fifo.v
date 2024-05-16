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


`timescale 1 ps / 1 ps

(* altera_attribute = "-name AUTO_RAM_RECOGNITION OFF; -name INFER_RAMS_FROM_RAW_LOGIC OFF" *)
module fmiohmc_ecc_interface_fifo
#(
    parameter DATA_WIDTH    = 'd1,
    parameter RESERVE_ENTRY = 0
)
(
    clk,
    reset_n,
    
    in_ready,
    in_valid,
    in_data,
    
    out_ready,
    out_valid,
    out_data
);

localparam ENTRY              = 2 + RESERVE_ENTRY; 
localparam PTR_WIDTH          = (ENTRY > 8 && ENTRY <= 16) ? 4 :
                                (ENTRY > 4 && ENTRY <= 8) ? 3 :
                                (ENTRY > 2 && ENTRY <= 4) ? 2 : 1;
localparam COUNTER_WIDTH      = PTR_WIDTH + 1;                                
localparam ENTRY_ALMOST_FULL  = 2;

input                                       clk;
input                                       reset_n;

output                                      in_ready;
input                                       in_valid;
input  [DATA_WIDTH - 1 : 0]                 in_data;

input                                       out_ready;
output                                      out_valid;
output [DATA_WIDTH - 1 : 0]                 out_data;

reg  [DATA_WIDTH  - 1 : 0]                  data_reg [ENTRY - 1 : 0];

(* altera_attribute = {"-name MAX_FANOUT 20"}*) reg  [PTR_WIDTH - 1 : 0] write_ptr;
(* altera_attribute = {"-name MAX_FANOUT 20"}*) reg  [PTR_WIDTH - 1 : 0] read_ptr;
(* altera_attribute = {"-name MAX_FANOUT 5"}*)  reg  [COUNTER_WIDTH - 1 : 0] counter;
(* altera_attribute = {"-name MAX_FANOUT 1"}*)  reg  empty;

wire                                        in_ready;
reg                                         almost_full;
wire                                        out_valid;
wire [DATA_WIDTH - 1 : 0]                   out_data;
wire                                        read_en;
wire                                        write_en;

assign in_ready  = ~almost_full;
assign read_en   = ~empty && out_ready;
assign write_en  = in_valid;
assign out_valid = ~empty;
assign out_data  = data_reg [read_ptr];

always @(posedge clk)
begin
   if (!reset_n) begin
      write_ptr   <= {PTR_WIDTH{1'b0}};
      read_ptr    <= {PTR_WIDTH{1'b0}};
      counter     <= {COUNTER_WIDTH{1'b0}};
      almost_full <= 1'b0;
      empty       <= 1'b1;
   end
   else begin
      if (write_en) begin
         if (write_ptr == ENTRY - 1) begin
            write_ptr <= {PTR_WIDTH{1'b0}};
         end else begin
            write_ptr <= write_ptr + 1'b1;
         end
      end

      if (read_en) begin
         if (read_ptr == ENTRY - 1) begin
            read_ptr <= {PTR_WIDTH{1'b0}};
         end else begin
            read_ptr <= read_ptr + 1'b1;
         end
      end

      if (write_en && !read_en) begin
         counter     <= counter + 1'b1;
         almost_full <= (counter >= (ENTRY_ALMOST_FULL - 1));
         empty       <= 1'b0;
      end
      else if (read_en && !write_en) begin
         counter     <= counter - 1'b1;
         almost_full <= (counter >= (ENTRY_ALMOST_FULL + 1));
         empty       <= (counter == 1);
      end
   end
end

always @(posedge clk)
begin
   if (write_en) begin
      data_reg[write_ptr] <= in_data;
   end
end

endmodule
