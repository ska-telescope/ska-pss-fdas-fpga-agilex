	component ed_sim_local_reset_combiner is
		port (
			local_reset_req_out_0 : out std_logic;        -- local_reset_req
			local_reset_done_in_0 : in  std_logic := 'X'; -- local_reset_done
			clk                   : in  std_logic := 'X'; -- clk
			reset_n               : in  std_logic := 'X'; -- pll_locked
			local_reset_req       : in  std_logic := 'X'; -- local_reset_req
			local_reset_done      : out std_logic         -- local_reset_done
		);
	end component ed_sim_local_reset_combiner;

	u0 : component ed_sim_local_reset_combiner
		port map (
			local_reset_req_out_0 => CONNECTED_TO_local_reset_req_out_0, --   local_reset_req_out_0.local_reset_req
			local_reset_done_in_0 => CONNECTED_TO_local_reset_done_in_0, -- local_reset_status_in_0.local_reset_done
			clk                   => CONNECTED_TO_clk,                   --             generic_clk.clk
			reset_n               => CONNECTED_TO_reset_n,               -- generic_conduit_reset_n.pll_locked
			local_reset_req       => CONNECTED_TO_local_reset_req,       --         local_reset_req.local_reset_req
			local_reset_done      => CONNECTED_TO_local_reset_done       --      local_reset_status.local_reset_done
		);

