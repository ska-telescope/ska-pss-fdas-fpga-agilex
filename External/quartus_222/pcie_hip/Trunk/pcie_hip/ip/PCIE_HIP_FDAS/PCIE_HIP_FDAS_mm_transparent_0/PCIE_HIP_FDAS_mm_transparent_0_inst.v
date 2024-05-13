	PCIE_HIP_FDAS_mm_transparent_0 u0 (
		.clk              (_connected_to_clk_),              //   input,   width = 1, clock.clk
		.reset            (_connected_to_reset_),            //   input,   width = 1, reset.reset
		.s0_waitrequest   (_connected_to_s0_waitrequest_),   //  output,   width = 1,    s0.waitrequest
		.s0_readdata      (_connected_to_s0_readdata_),      //  output,  width = 64,      .readdata
		.s0_readdatavalid (_connected_to_s0_readdatavalid_), //  output,   width = 1,      .readdatavalid
		.s0_burstcount    (_connected_to_s0_burstcount_),    //   input,   width = 1,      .burstcount
		.s0_writedata     (_connected_to_s0_writedata_),     //   input,  width = 64,      .writedata
		.s0_address       (_connected_to_s0_address_),       //   input,  width = 22,      .address
		.s0_write         (_connected_to_s0_write_),         //   input,   width = 1,      .write
		.s0_read          (_connected_to_s0_read_),          //   input,   width = 1,      .read
		.s0_byteenable    (_connected_to_s0_byteenable_),    //   input,   width = 8,      .byteenable
		.m0_waitrequest   (_connected_to_m0_waitrequest_),   //   input,   width = 1,    m0.waitrequest
		.m0_readdata      (_connected_to_m0_readdata_),      //   input,  width = 64,      .readdata
		.m0_readdatavalid (_connected_to_m0_readdatavalid_), //   input,   width = 1,      .readdatavalid
		.m0_burstcount    (_connected_to_m0_burstcount_),    //  output,   width = 1,      .burstcount
		.m0_writedata     (_connected_to_m0_writedata_),     //  output,  width = 64,      .writedata
		.m0_address       (_connected_to_m0_address_),       //  output,  width = 22,      .address
		.m0_write         (_connected_to_m0_write_),         //  output,   width = 1,      .write
		.m0_read          (_connected_to_m0_read_),          //  output,   width = 1,      .read
		.m0_byteenable    (_connected_to_m0_byteenable_)     //  output,   width = 8,      .byteenable
	);

