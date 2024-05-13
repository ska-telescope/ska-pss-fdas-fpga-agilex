module PCIE_HIP_FDAS_mm_transparent_0 (
		input  wire        clk,              // clock.clk
		input  wire        reset,            // reset.reset
		output wire        s0_waitrequest,   //    s0.waitrequest
		output wire [63:0] s0_readdata,      //      .readdata
		output wire        s0_readdatavalid, //      .readdatavalid
		input  wire [0:0]  s0_burstcount,    //      .burstcount
		input  wire [63:0] s0_writedata,     //      .writedata
		input  wire [21:0] s0_address,       //      .address
		input  wire        s0_write,         //      .write
		input  wire        s0_read,          //      .read
		input  wire [7:0]  s0_byteenable,    //      .byteenable
		input  wire        m0_waitrequest,   //    m0.waitrequest
		input  wire [63:0] m0_readdata,      //      .readdata
		input  wire        m0_readdatavalid, //      .readdatavalid
		output wire [0:0]  m0_burstcount,    //      .burstcount
		output wire [63:0] m0_writedata,     //      .writedata
		output wire [21:0] m0_address,       //      .address
		output wire        m0_write,         //      .write
		output wire        m0_read,          //      .read
		output wire [7:0]  m0_byteenable     //      .byteenable
	);
endmodule

