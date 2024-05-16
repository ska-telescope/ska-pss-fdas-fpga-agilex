	ed_sim_sim_checker u0 (
		.traffic_gen_pass_0    (_connected_to_traffic_gen_pass_0_),    //   input,  width = 1, tg_status_0.traffic_gen_pass
		.traffic_gen_fail_0    (_connected_to_traffic_gen_fail_0_),    //   input,  width = 1,            .traffic_gen_fail
		.traffic_gen_timeout_0 (_connected_to_traffic_gen_timeout_0_), //   input,  width = 1,            .traffic_gen_timeout
		.traffic_gen_pass      (_connected_to_traffic_gen_pass_),      //  output,  width = 1,   tg_status.traffic_gen_pass
		.traffic_gen_fail      (_connected_to_traffic_gen_fail_),      //  output,  width = 1,            .traffic_gen_fail
		.traffic_gen_timeout   (_connected_to_traffic_gen_timeout_),   //  output,  width = 1,            .traffic_gen_timeout
		.local_cal_success_0   (_connected_to_local_cal_success_0_),   //   input,  width = 1,    status_0.local_cal_success
		.local_cal_fail_0      (_connected_to_local_cal_fail_0_),      //   input,  width = 1,            .local_cal_fail
		.local_cal_success     (_connected_to_local_cal_success_),     //  output,  width = 1,      status.local_cal_success
		.local_cal_fail        (_connected_to_local_cal_fail_)         //  output,  width = 1,            .local_cal_fail
	);

