	fft1024 u0 (
		.clk        (_connected_to_clk_),        //   input,   width = 1,    clk.clk
		.rst        (_connected_to_rst_),        //   input,   width = 1,    rst.reset_n
		.validIn    (_connected_to_validIn_),    //   input,   width = 1,   sink.valid
		.channelIn  (_connected_to_channelIn_),  //   input,   width = 8,       .channel
		.d          (_connected_to_d_),          //   input,  width = 64,       .data
		.validOut   (_connected_to_validOut_),   //  output,   width = 1, source.valid
		.channelOut (_connected_to_channelOut_), //  output,   width = 8,       .channel
		.q          (_connected_to_q_)           //  output,  width = 64,       .data
	);

