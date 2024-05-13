	PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0 #(
		.DATA_WIDTH     (INTEGER_VALUE_FOR_DATA_WIDTH),
		.BYTE_SIZE      (INTEGER_VALUE_FOR_BYTE_SIZE),
		.ADDRESS_WIDTH  (INTEGER_VALUE_FOR_ADDRESS_WIDTH),
		.RESPONSE_WIDTH (INTEGER_VALUE_FOR_RESPONSE_WIDTH)
	) u0 (
		.clk                   (_connected_to_clk_),                   //   input,                                   width = 1, clock.clk
		.reset                 (_connected_to_reset_),                 //   input,                                   width = 1, reset.reset
		.s0_waitrequest        (_connected_to_s0_waitrequest_),        //  output,                                   width = 1,    s0.waitrequest
		.s0_readdata           (_connected_to_s0_readdata_),           //  output,              width = (((DATA_WIDTH-1)-0)+1),      .readdata
		.s0_readdatavalid      (_connected_to_s0_readdatavalid_),      //  output,                                   width = 1,      .readdatavalid
		.s0_writeresponsevalid (_connected_to_s0_writeresponsevalid_), //  output,                                   width = 1,      .writeresponsevalid
		.s0_response           (_connected_to_s0_response_),           //  output,          width = (((RESPONSE_WIDTH-1)-0)+1),      .response
		.s0_writedata          (_connected_to_s0_writedata_),          //   input,              width = (((DATA_WIDTH-1)-0)+1),      .writedata
		.s0_address            (_connected_to_s0_address_),            //   input,           width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.s0_write              (_connected_to_s0_write_),              //   input,                                   width = 1,      .write
		.s0_read               (_connected_to_s0_read_),               //   input,                                   width = 1,      .read
		.s0_byteenable         (_connected_to_s0_byteenable_),         //   input,  width = ((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1),      .byteenable
		.m0_waitrequest        (_connected_to_m0_waitrequest_),        //   input,                                   width = 1,    m0.waitrequest
		.m0_readdata           (_connected_to_m0_readdata_),           //   input,              width = (((DATA_WIDTH-1)-0)+1),      .readdata
		.m0_readdatavalid      (_connected_to_m0_readdatavalid_),      //   input,                                   width = 1,      .readdatavalid
		.m0_writeresponsevalid (_connected_to_m0_writeresponsevalid_), //   input,                                   width = 1,      .writeresponsevalid
		.m0_response           (_connected_to_m0_response_),           //   input,          width = (((RESPONSE_WIDTH-1)-0)+1),      .response
		.m0_writedata          (_connected_to_m0_writedata_),          //  output,              width = (((DATA_WIDTH-1)-0)+1),      .writedata
		.m0_address            (_connected_to_m0_address_),            //  output,           width = (((ADDRESS_WIDTH-1)-0)+1),      .address
		.m0_write              (_connected_to_m0_write_),              //  output,                                   width = 1,      .write
		.m0_read               (_connected_to_m0_read_),               //  output,                                   width = 1,      .read
		.m0_byteenable         (_connected_to_m0_byteenable_)          //  output,  width = ((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1),      .byteenable
	);

