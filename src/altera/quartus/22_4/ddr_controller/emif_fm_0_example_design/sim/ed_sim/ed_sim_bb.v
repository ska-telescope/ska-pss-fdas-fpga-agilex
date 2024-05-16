module ed_sim (
		output wire  sim_checker_traffic_gen_pass,         //        sim_checker.traffic_gen_pass
		output wire  sim_checker_traffic_gen_fail,         //                   .traffic_gen_fail
		output wire  sim_checker_traffic_gen_timeout,      //                   .traffic_gen_timeout
		output wire  cal_status_checker_local_cal_success, // cal_status_checker.local_cal_success
		output wire  cal_status_checker_local_cal_fail     //                   .local_cal_fail
	);
endmodule

