	component ed_sim_local_reset_source is
		port (
			local_reset_req  : out std_logic;        -- local_reset_req
			local_reset_done : in  std_logic := 'X'  -- local_reset_done
		);
	end component ed_sim_local_reset_source;

	u0 : component ed_sim_local_reset_source
		port map (
			local_reset_req  => CONNECTED_TO_local_reset_req,  --    local_reset_req.local_reset_req
			local_reset_done => CONNECTED_TO_local_reset_done  -- local_reset_status.local_reset_done
		);

