module fp_add (
		input  wire [31:0] fp32_adder_a, // fp32_adder_a.fp32_adder_a
		input  wire [31:0] fp32_adder_b, // fp32_adder_b.fp32_adder_b
		input  wire        clr0,         //         clr0.reset
		input  wire        clr1,         //         clr1.reset
		input  wire        clk,          //          clk.clk
		input  wire [2:0]  ena,          //          ena.ena
		output wire [31:0] fp32_result   //  fp32_result.fp32_result
	);
endmodule

