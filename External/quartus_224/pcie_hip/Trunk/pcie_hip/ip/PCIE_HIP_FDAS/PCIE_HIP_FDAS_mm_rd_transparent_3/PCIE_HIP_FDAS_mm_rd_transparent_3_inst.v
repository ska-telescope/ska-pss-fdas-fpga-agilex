	PCIE_HIP_FDAS_mm_rd_transparent_3 #(
		.DATA_WIDTH       (INTEGER_VALUE_FOR_DATA_WIDTH),
		.BYTE_SIZE        (INTEGER_VALUE_FOR_BYTE_SIZE),
		.ADDRESS_WIDTH    (INTEGER_VALUE_FOR_ADDRESS_WIDTH),
		.BURSTCOUNT_WIDTH (INTEGER_VALUE_FOR_BURSTCOUNT_WIDTH)
	) u0 (
		.clk              (_connected_to_clk_),              //   input,                             width = 1, clock.clk
		.reset            (_connected_to_reset_),            //   input,                             width = 1, reset.reset
		.s0_waitrequest   (_connected_to_s0_waitrequest_),   //  output,                             width = 1,    s0.waitrequest
		.s0_readdata      (_connected_to_s0_readdata_),      //  output,        width = (((DATA_WIDTH-1)-0)+1),      .readdata
		.s0_readdatavalid (_connected_to_s0_readdatavalid_), //  output,                             width = 1,      .readdatavalid
		.s0_response      (_connected_to_s0_response_),      //  output,                             width = 2,      .response
		.s0_burstcount    (_connected_to_s0_burstcount_),    //   input,  width = (((BURSTCOUNT_WIDTH-1)-0)+1),      .burstcount
		.s0_address       (_connected_to_s0_address_),       //   input,     width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.s0_read          (_connected_to_s0_read_),          //   input,                             width = 1,      .read
		.m0_waitrequest   (_connected_to_m0_waitrequest_),   //   input,                             width = 1,    m0.waitrequest
		.m0_readdata      (_connected_to_m0_readdata_),      //   input,        width = (((DATA_WIDTH-1)-0)+1),      .readdata
		.m0_readdatavalid (_connected_to_m0_readdatavalid_), //   input,                             width = 1,      .readdatavalid
		.m0_response      (_connected_to_m0_response_),      //   input,                             width = 2,      .response
		.m0_burstcount    (_connected_to_m0_burstcount_),    //  output,  width = (((BURSTCOUNT_WIDTH-1)-0)+1),      .burstcount
		.m0_address       (_connected_to_m0_address_),       //  output,     width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.m0_read          (_connected_to_m0_read_)           //  output,                             width = 1,      .read
	);

