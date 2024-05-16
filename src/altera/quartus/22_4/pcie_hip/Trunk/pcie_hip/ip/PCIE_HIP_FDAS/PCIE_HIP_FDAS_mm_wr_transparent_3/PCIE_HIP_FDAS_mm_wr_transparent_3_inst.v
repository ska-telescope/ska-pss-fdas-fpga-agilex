	PCIE_HIP_FDAS_mm_wr_transparent_3 #(
		.DATA_WIDTH       (INTEGER_VALUE_FOR_DATA_WIDTH),
		.BYTE_SIZE        (INTEGER_VALUE_FOR_BYTE_SIZE),
		.ADDRESS_WIDTH    (INTEGER_VALUE_FOR_ADDRESS_WIDTH),
		.BURSTCOUNT_WIDTH (INTEGER_VALUE_FOR_BURSTCOUNT_WIDTH)
	) u0 (
		.clk            (_connected_to_clk_),            //   input,                                   width = 1, clock.clk
		.reset          (_connected_to_reset_),          //   input,                                   width = 1, reset.reset
		.s0_waitrequest (_connected_to_s0_waitrequest_), //  output,                                   width = 1,    s0.waitrequest
		.s0_burstcount  (_connected_to_s0_burstcount_),  //   input,        width = (((BURSTCOUNT_WIDTH-1)-0)+1),      .burstcount
		.s0_writedata   (_connected_to_s0_writedata_),   //   input,              width = (((DATA_WIDTH-1)-0)+1),      .writedata
		.s0_address     (_connected_to_s0_address_),     //   input,           width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.s0_write       (_connected_to_s0_write_),       //   input,                                   width = 1,      .write
		.s0_byteenable  (_connected_to_s0_byteenable_),  //   input,  width = ((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1),      .byteenable
		.m0_waitrequest (_connected_to_m0_waitrequest_), //   input,                                   width = 1,    m0.waitrequest
		.m0_burstcount  (_connected_to_m0_burstcount_),  //  output,        width = (((BURSTCOUNT_WIDTH-1)-0)+1),      .burstcount
		.m0_writedata   (_connected_to_m0_writedata_),   //  output,              width = (((DATA_WIDTH-1)-0)+1),      .writedata
		.m0_address     (_connected_to_m0_address_),     //  output,           width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.m0_write       (_connected_to_m0_write_),       //  output,                                   width = 1,      .write
		.m0_byteenable  (_connected_to_m0_byteenable_)   //  output,  width = ((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1),      .byteenable
	);

