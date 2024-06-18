module fft1024 (
		input  wire        clk,        //    clk.clk
		input  wire        rst,        //    rst.reset_n
		input  wire [0:0]  validIn,    //   sink.valid
		input  wire [7:0]  channelIn,  //       .channel
		input  wire [63:0] d,          //       .data
		output wire [0:0]  validOut,   // source.valid
		output wire [7:0]  channelOut, //       .channel
		output wire [63:0] q           //       .data
	);
endmodule

