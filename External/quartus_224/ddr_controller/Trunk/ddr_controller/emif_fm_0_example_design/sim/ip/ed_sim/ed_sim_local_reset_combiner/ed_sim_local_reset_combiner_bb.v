module ed_sim_local_reset_combiner (
		output wire  local_reset_req_out_0, //   local_reset_req_out_0.local_reset_req
		input  wire  local_reset_done_in_0, // local_reset_status_in_0.local_reset_done
		input  wire  clk,                   //             generic_clk.clk
		input  wire  reset_n,               // generic_conduit_reset_n.pll_locked
		input  wire  local_reset_req,       //         local_reset_req.local_reset_req,  Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		output wire  local_reset_done       //      local_reset_status.local_reset_done, Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
	);
endmodule

