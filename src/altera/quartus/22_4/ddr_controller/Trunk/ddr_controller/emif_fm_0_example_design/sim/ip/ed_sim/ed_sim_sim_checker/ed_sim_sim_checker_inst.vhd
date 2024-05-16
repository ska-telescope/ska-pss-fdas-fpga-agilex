	component ed_sim_sim_checker is
		port (
			traffic_gen_pass_0    : in  std_logic := 'X'; -- traffic_gen_pass
			traffic_gen_fail_0    : in  std_logic := 'X'; -- traffic_gen_fail
			traffic_gen_timeout_0 : in  std_logic := 'X'; -- traffic_gen_timeout
			traffic_gen_pass      : out std_logic;        -- traffic_gen_pass
			traffic_gen_fail      : out std_logic;        -- traffic_gen_fail
			traffic_gen_timeout   : out std_logic;        -- traffic_gen_timeout
			local_cal_success_0   : in  std_logic := 'X'; -- local_cal_success
			local_cal_fail_0      : in  std_logic := 'X'; -- local_cal_fail
			local_cal_success     : out std_logic;        -- local_cal_success
			local_cal_fail        : out std_logic         -- local_cal_fail
		);
	end component ed_sim_sim_checker;

	u0 : component ed_sim_sim_checker
		port map (
			traffic_gen_pass_0    => CONNECTED_TO_traffic_gen_pass_0,    -- tg_status_0.traffic_gen_pass
			traffic_gen_fail_0    => CONNECTED_TO_traffic_gen_fail_0,    --            .traffic_gen_fail
			traffic_gen_timeout_0 => CONNECTED_TO_traffic_gen_timeout_0, --            .traffic_gen_timeout
			traffic_gen_pass      => CONNECTED_TO_traffic_gen_pass,      --   tg_status.traffic_gen_pass
			traffic_gen_fail      => CONNECTED_TO_traffic_gen_fail,      --            .traffic_gen_fail
			traffic_gen_timeout   => CONNECTED_TO_traffic_gen_timeout,   --            .traffic_gen_timeout
			local_cal_success_0   => CONNECTED_TO_local_cal_success_0,   --    status_0.local_cal_success
			local_cal_fail_0      => CONNECTED_TO_local_cal_fail_0,      --            .local_cal_fail
			local_cal_success     => CONNECTED_TO_local_cal_success,     --      status.local_cal_success
			local_cal_fail        => CONNECTED_TO_local_cal_fail         --            .local_cal_fail
		);

