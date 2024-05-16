module ed_sim_sim_checker (
		input  wire  traffic_gen_pass_0,    // tg_status_0.traffic_gen_pass
		input  wire  traffic_gen_fail_0,    //            .traffic_gen_fail
		input  wire  traffic_gen_timeout_0, //            .traffic_gen_timeout
		output wire  traffic_gen_pass,      //   tg_status.traffic_gen_pass
		output wire  traffic_gen_fail,      //            .traffic_gen_fail
		output wire  traffic_gen_timeout,   //            .traffic_gen_timeout
		input  wire  local_cal_success_0,   //    status_0.local_cal_success,  When high, indicates that PHY calibration was successful
		input  wire  local_cal_fail_0,      //            .local_cal_fail,     When high, indicates that PHY calibration failed
		output wire  local_cal_success,     //      status.local_cal_success,  When high, indicates that PHY calibration was successful
		output wire  local_cal_fail         //            .local_cal_fail,     When high, indicates that PHY calibration failed
	);
endmodule

