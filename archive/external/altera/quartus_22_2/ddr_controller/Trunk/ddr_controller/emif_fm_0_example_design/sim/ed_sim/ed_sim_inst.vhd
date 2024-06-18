	component ed_sim is
		port (
			sim_checker_traffic_gen_pass         : out std_logic;  -- traffic_gen_pass
			sim_checker_traffic_gen_fail         : out std_logic;  -- traffic_gen_fail
			sim_checker_traffic_gen_timeout      : out std_logic;  -- traffic_gen_timeout
			cal_status_checker_local_cal_success : out std_logic;  -- local_cal_success
			cal_status_checker_local_cal_fail    : out std_logic   -- local_cal_fail
		);
	end component ed_sim;

	u0 : component ed_sim
		port map (
			sim_checker_traffic_gen_pass         => CONNECTED_TO_sim_checker_traffic_gen_pass,         --        sim_checker.traffic_gen_pass
			sim_checker_traffic_gen_fail         => CONNECTED_TO_sim_checker_traffic_gen_fail,         --                   .traffic_gen_fail
			sim_checker_traffic_gen_timeout      => CONNECTED_TO_sim_checker_traffic_gen_timeout,      --                   .traffic_gen_timeout
			cal_status_checker_local_cal_success => CONNECTED_TO_cal_status_checker_local_cal_success, -- cal_status_checker.local_cal_success
			cal_status_checker_local_cal_fail    => CONNECTED_TO_cal_status_checker_local_cal_fail     --                   .local_cal_fail
		);

