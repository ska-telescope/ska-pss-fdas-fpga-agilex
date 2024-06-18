	ed_sim_local_reset_source u0 (
		.local_reset_req  (_connected_to_local_reset_req_),  //  output,  width = 1,    local_reset_req.local_reset_req
		.local_reset_done (_connected_to_local_reset_done_)  //   input,  width = 1, local_reset_status.local_reset_done
	);

