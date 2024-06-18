	mult_fp_co u0 (
		.fp32_mult_a   (_connected_to_fp32_mult_a_),   //   input,  width = 32,   fp32_mult_a.fp32_mult_a
		.fp32_mult_b   (_connected_to_fp32_mult_b_),   //   input,  width = 32,   fp32_mult_b.fp32_mult_b
		.clr0          (_connected_to_clr0_),          //   input,   width = 1,          clr0.reset
		.clr1          (_connected_to_clr1_),          //   input,   width = 1,          clr1.reset
		.clk           (_connected_to_clk_),           //   input,   width = 1,           clk.clk
		.ena           (_connected_to_ena_),           //   input,   width = 3,           ena.ena
		.fp32_result   (_connected_to_fp32_result_),   //  output,  width = 32,   fp32_result.fp32_result
		.fp32_chainout (_connected_to_fp32_chainout_)  //  output,  width = 32, fp32_chainout.fp32_chainout
	);

