module PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0 #(
		parameter DATA_WIDTH     = 64,
		parameter BYTE_SIZE      = 8,
		parameter ADDRESS_WIDTH  = 22,
		parameter RESPONSE_WIDTH = 2
	) (
		input  wire                                          clk,                   // clock.clk
		input  wire                                          reset,                 // reset.reset
		output wire                                          s0_waitrequest,        //    s0.waitrequest
		output wire [(((DATA_WIDTH-1)-0)+1)-1:0]             s0_readdata,           //      .readdata
		output wire                                          s0_readdatavalid,      //      .readdatavalid
		output wire                                          s0_writeresponsevalid, //      .writeresponsevalid
		output wire [(((RESPONSE_WIDTH-1)-0)+1)-1:0]         s0_response,           //      .response
		input  wire [(((DATA_WIDTH-1)-0)+1)-1:0]             s0_writedata,          //      .writedata
		input  wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]          s0_address,            //      .address
		input  wire                                          s0_write,              //      .write
		input  wire                                          s0_read,               //      .read
		input  wire [((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1:0] s0_byteenable,         //      .byteenable
		input  wire                                          m0_waitrequest,        //    m0.waitrequest
		input  wire [(((DATA_WIDTH-1)-0)+1)-1:0]             m0_readdata,           //      .readdata
		input  wire                                          m0_readdatavalid,      //      .readdatavalid
		input  wire                                          m0_writeresponsevalid, //      .writeresponsevalid
		input  wire [(((RESPONSE_WIDTH-1)-0)+1)-1:0]         m0_response,           //      .response
		output wire [(((DATA_WIDTH-1)-0)+1)-1:0]             m0_writedata,          //      .writedata
		output wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]          m0_address,            //      .address
		output wire                                          m0_write,              //      .write
		output wire                                          m0_read,               //      .read
		output wire [((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1:0] m0_byteenable          //      .byteenable
	);
endmodule

