module PCIE_HIP_FDAS_mm_rd_transparent_0 #(
		parameter DATA_WIDTH       = 512,
		parameter BYTE_SIZE        = 8,
		parameter ADDRESS_WIDTH    = 26,
		parameter BURSTCOUNT_WIDTH = 4
	) (
		input  wire                                    clk,              // clock.clk
		input  wire                                    reset,            // reset.reset
		output wire                                    s0_waitrequest,   //    s0.waitrequest
		output wire [(((DATA_WIDTH-1)-0)+1)-1:0]       s0_readdata,      //      .readdata
		output wire                                    s0_readdatavalid, //      .readdatavalid
		output wire [1:0]                              s0_response,      //      .response
		input  wire [(((BURSTCOUNT_WIDTH-1)-0)+1)-1:0] s0_burstcount,    //      .burstcount
		input  wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]    s0_address,       //      .address
		input  wire                                    s0_read,          //      .read
		input  wire                                    m0_waitrequest,   //    m0.waitrequest
		input  wire [(((DATA_WIDTH-1)-0)+1)-1:0]       m0_readdata,      //      .readdata
		input  wire                                    m0_readdatavalid, //      .readdatavalid
		input  wire [1:0]                              m0_response,      //      .response
		output wire [(((BURSTCOUNT_WIDTH-1)-0)+1)-1:0] m0_burstcount,    //      .burstcount
		output wire [(((ADDRESS_WIDTH-1)-0)+1)-1:0]    m0_address,       //      .address
		output wire                                    m0_read           //      .read
	);
endmodule

