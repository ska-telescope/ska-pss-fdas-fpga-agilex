	ed_synth_local_reset_combiner u0 (
		.local_reset_req_out_0 (_connected_to_local_reset_req_out_0_), //  output,  width = 1,   local_reset_req_out_0.local_reset_req
		.local_reset_done_in_0 (_connected_to_local_reset_done_in_0_), //   input,  width = 1, local_reset_status_in_0.local_reset_done
		.clk                   (_connected_to_clk_),                   //   input,  width = 1,             generic_clk.clk
		.reset_n               (_connected_to_reset_n_),               //   input,  width = 1, generic_conduit_reset_n.pll_locked
		.local_reset_req       (_connected_to_local_reset_req_),       //   input,  width = 1,         local_reset_req.local_reset_req
		.local_reset_done      (_connected_to_local_reset_done_)       //  output,  width = 1,      local_reset_status.local_reset_done
	);

