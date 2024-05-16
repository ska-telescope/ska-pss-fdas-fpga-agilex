module multsub_fp_ci (
		input  wire [31:0] fp32_mult_a,  //  fp32_mult_a.fp32_mult_a
		input  wire [31:0] fp32_mult_b,  //  fp32_mult_b.fp32_mult_b
		input  wire [31:0] fp32_chainin, // fp32_chainin.fp32_chainin
		input  wire        clr0,         //         clr0.reset
		input  wire        clr1,         //         clr1.reset
		input  wire        clk,          //          clk.clk
		input  wire [2:0]  ena,          //          ena.ena
		output wire [31:0] fp32_result   //  fp32_result.fp32_result
	);
endmodule

