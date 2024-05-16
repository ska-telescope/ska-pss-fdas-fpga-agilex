module PCIE_HIP_FDAS_mm_wr_transparent_2 #(
		parameter DATA_WIDTH       = 512,
		parameter BYTE_SIZE        = 8,
		parameter ADDRESS_WIDTH    = 26,
		parameter BURSTCOUNT_WIDTH = 4
	) (
		input  wire                                          clk,            // clock.clk
		input  wire                                          reset,          // reset.reset
		output wire                                          s0_waitrequest, //    s0.waitrequest
		input  wire [(((BURSTCOUNT_WIDTH-1)-0)+1)-1:0]       s0_burstcount,  //      .burstcount
		input  wire [(((DATA_WIDTH-1)-0)+1)-1:0]             s0_writedata,   //      .writedata
		input  wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]          s0_address,     //      .address
		input  wire                                          s0_write,       //      .write
		input  wire [((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1:0] s0_byteenable,  //      .byteenable
		input  wire                                          m0_waitrequest, //    m0.waitrequest
		output wire [(((BURSTCOUNT_WIDTH-1)-0)+1)-1:0]       m0_burstcount,  //      .burstcount
		output wire [(((DATA_WIDTH-1)-0)+1)-1:0]             m0_writedata,   //      .writedata
		output wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]          m0_address,     //      .address
		output wire                                          m0_write,       //      .write
		output wire [((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1:0] m0_byteenable   //      .byteenable
	);
endmodule

