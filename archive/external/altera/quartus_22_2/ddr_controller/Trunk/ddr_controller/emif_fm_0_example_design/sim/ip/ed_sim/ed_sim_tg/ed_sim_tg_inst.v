	ed_sim_tg u0 (
		.emif_usr_reset_n      (_connected_to_emif_usr_reset_n_),      //   input,    width = 1, emif_usr_reset_n.reset_n
		.ninit_done            (_connected_to_ninit_done_),            //   input,    width = 1,       ninit_done.reset
		.emif_usr_clk          (_connected_to_emif_usr_clk_),          //   input,    width = 1,     emif_usr_clk.clk
		.amm_ready_0           (_connected_to_amm_ready_0_),           //   input,    width = 1,       ctrl_amm_0.waitrequest_n
		.amm_read_0            (_connected_to_amm_read_0_),            //  output,    width = 1,                 .read
		.amm_write_0           (_connected_to_amm_write_0_),           //  output,    width = 1,                 .write
		.amm_address_0         (_connected_to_amm_address_0_),         //  output,   width = 34,                 .address
		.amm_readdata_0        (_connected_to_amm_readdata_0_),        //   input,  width = 576,                 .readdata
		.amm_writedata_0       (_connected_to_amm_writedata_0_),       //  output,  width = 576,                 .writedata
		.amm_burstcount_0      (_connected_to_amm_burstcount_0_),      //  output,    width = 7,                 .burstcount
		.amm_byteenable_0      (_connected_to_amm_byteenable_0_),      //  output,   width = 72,                 .byteenable
		.amm_readdatavalid_0   (_connected_to_amm_readdatavalid_0_),   //   input,    width = 1,                 .readdatavalid
		.traffic_gen_pass_0    (_connected_to_traffic_gen_pass_0_),    //  output,    width = 1,      tg_status_0.traffic_gen_pass
		.traffic_gen_fail_0    (_connected_to_traffic_gen_fail_0_),    //  output,    width = 1,                 .traffic_gen_fail
		.traffic_gen_timeout_0 (_connected_to_traffic_gen_timeout_0_)  //  output,    width = 1,                 .traffic_gen_timeout
	);

