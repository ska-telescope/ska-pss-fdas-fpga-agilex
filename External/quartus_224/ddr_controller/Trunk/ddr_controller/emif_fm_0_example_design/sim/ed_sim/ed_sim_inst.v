	ed_sim u0 (
		.sim_checker_traffic_gen_pass         (_connected_to_sim_checker_traffic_gen_pass_),         //  output,  width = 1,        sim_checker.traffic_gen_pass
		.sim_checker_traffic_gen_fail         (_connected_to_sim_checker_traffic_gen_fail_),         //  output,  width = 1,                   .traffic_gen_fail
		.sim_checker_traffic_gen_timeout      (_connected_to_sim_checker_traffic_gen_timeout_),      //  output,  width = 1,                   .traffic_gen_timeout
		.cal_status_checker_local_cal_success (_connected_to_cal_status_checker_local_cal_success_), //  output,  width = 1, cal_status_checker.local_cal_success
		.cal_status_checker_local_cal_fail    (_connected_to_cal_status_checker_local_cal_fail_)     //  output,  width = 1,                   .local_cal_fail
	);

