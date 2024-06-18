module ed_sim_tg (
		input  wire         emif_usr_reset_n,      // emif_usr_reset_n.reset_n,            Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		input  wire         ninit_done,            //       ninit_done.reset
		input  wire         emif_usr_clk,          //     emif_usr_clk.clk,                User clock domain
		input  wire         amm_ready_0,           //       ctrl_amm_0.waitrequest_n,      Wait-request is asserted when controller is busy
		output wire         amm_read_0,            //                 .read,               Read request signal
		output wire         amm_write_0,           //                 .write,              Write request signal
		output wire [33:0]  amm_address_0,         //                 .address,            Address for the read/write request
		input  wire [575:0] amm_readdata_0,        //                 .readdata,           Read data
		output wire [575:0] amm_writedata_0,       //                 .writedata,          Write data
		output wire [6:0]   amm_burstcount_0,      //                 .burstcount,         Number of transfers in each read/write burst
		output wire [71:0]  amm_byteenable_0,      //                 .byteenable,         Byte-enable for write data
		input  wire         amm_readdatavalid_0,   //                 .readdatavalid,      Indicates whether read data is valid
		output wire         traffic_gen_pass_0,    //      tg_status_0.traffic_gen_pass
		output wire         traffic_gen_fail_0,    //                 .traffic_gen_fail
		output wire         traffic_gen_timeout_0  //                 .traffic_gen_timeout
	);
endmodule

