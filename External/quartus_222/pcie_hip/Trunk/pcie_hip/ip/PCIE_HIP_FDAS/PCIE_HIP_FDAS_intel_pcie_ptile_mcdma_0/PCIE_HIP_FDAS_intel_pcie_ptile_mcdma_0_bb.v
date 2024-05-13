module PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0 (
		output wire         app_clk,                     //           app_clk.clk,                Check User Guide for details
		output wire         app_rst_n,                   // app_nreset_status.reset_n,            Check User Guide for details
		input  wire         rx_pio_waitrequest_i,        //     rx_pio_master.waitrequest,        Check User Guide for details
		output wire [27:0]  rx_pio_address_o,            //                  .address,            Check User Guide for details
		output wire [7:0]   rx_pio_byteenable_o,         //                  .byteenable,         Check User Guide for details
		output wire         rx_pio_read_o,               //                  .read,               Check User Guide for details
		input  wire [63:0]  rx_pio_readdata_i,           //                  .readdata,           Check User Guide for details
		input  wire         rx_pio_readdatavalid_i,      //                  .readdatavalid,      Check User Guide for details
		output wire         rx_pio_write_o,              //                  .write,              Check User Guide for details
		output wire [63:0]  rx_pio_writedata_o,          //                  .writedata,          Check User Guide for details
		output wire [3:0]   rx_pio_burstcount_o,         //                  .burstcount,         Check User Guide for details
		input  wire [1:0]   rx_pio_response_i,           //                  .response,           Check User Guide for details
		input  wire         rx_pio_writeresponsevalid_i, //                  .writeresponsevalid, Check User Guide for details
		input  wire         d2hdm_waitrequest_i,         //      d2hdm_master.waitrequest,        Check User Guide for details
		output wire         d2hdm_read_o,                //                  .read,               Check User Guide for details
		output wire [63:0]  d2hdm_address_o,             //                  .address,            Check User Guide for details
		output wire [3:0]   d2hdm_burstcount_o,          //                  .burstcount,         Check User Guide for details
		output wire [63:0]  d2hdm_byteenable_o,          //                  .byteenable,         Check User Guide for details
		input  wire         d2hdm_readdatavalid_i,       //                  .readdatavalid,      Check User Guide for details
		input  wire [511:0] d2hdm_readdata_i,            //                  .readdata,           Check User Guide for details
		input  wire [1:0]   d2hdm_response_i,            //                  .response,           Check User Guide for details
		input  wire         h2ddm_waitrequest_i,         //      h2ddm_master.waitrequest,        Check User Guide for details
		output wire         h2ddm_write_o,               //                  .write,              Check User Guide for details
		output wire [63:0]  h2ddm_address_o,             //                  .address,            Check User Guide for details
		output wire [3:0]   h2ddm_burstcount_o,          //                  .burstcount,         Check User Guide for details
		output wire [63:0]  h2ddm_byteenable_o,          //                  .byteenable,         Check User Guide for details
		output wire [511:0] h2ddm_writedata_o,           //                  .writedata,          Check User Guide for details
		input  wire         usr_event_msix_valid_i,      //          usr_msix.valid,              Check User Guide for details
		output wire         usr_event_msix_ready_o,      //                  .ready,              Check User Guide for details
		input  wire [15:0]  usr_event_msix_data_i,       //                  .data,               Check User Guide for details
		output wire [2:0]   usr_hip_tl_cfg_func_o,       //     usr_config_tl.tl_cfg_func,        Check User Guide for details
		output wire [4:0]   usr_hip_tl_cfg_add_o,        //                  .tl_cfg_add,         Check User Guide for details
		output wire [15:0]  usr_hip_tl_cfg_ctl_o,        //                  .tl_cfg_ctl,         Check User Guide for details
		input  wire         p0_pld_warm_rst_rdy_i,       //            p0_pld.pld_warm_rst_rdy,   Check User Guide for details
		output wire         p0_pld_link_req_rst_o,       //                  .link_req_rst_n,     Check User Guide for details
		output wire         p0_link_up_o,                //     p0_hip_status.link_up,            Check User Guide for details
		output wire         p0_dl_up_o,                  //                  .dl_up,              Check User Guide for details
		output wire         p0_surprise_down_err_o,      //                  .surprise_down_err,  Check User Guide for details
		output wire [5:0]   p0_ltssm_state_o,            //                  .ltssmstate,         Check User Guide for details
		input  wire         refclk0,                     //           refclk0.clk,                Check User Guide for details
		input  wire         refclk1,                     //           refclk1.clk,                Check User Guide for details
		input  wire         ninit_done,                  //        ninit_done.reset,              Its a Init_done signal should be connected to Reset release IP
		input  wire         rx_n_in0,                    //        hip_serial.rx_n_in0,           Check User Guide for details
		input  wire         rx_n_in1,                    //                  .rx_n_in1,           Check User Guide for details
		input  wire         rx_n_in2,                    //                  .rx_n_in2,           Check User Guide for details
		input  wire         rx_n_in3,                    //                  .rx_n_in3,           Check User Guide for details
		input  wire         rx_n_in4,                    //                  .rx_n_in4,           Check User Guide for details
		input  wire         rx_n_in5,                    //                  .rx_n_in5,           Check User Guide for details
		input  wire         rx_n_in6,                    //                  .rx_n_in6,           Check User Guide for details
		input  wire         rx_n_in7,                    //                  .rx_n_in7,           Check User Guide for details
		input  wire         rx_n_in8,                    //                  .rx_n_in8,           Check User Guide for details
		input  wire         rx_n_in9,                    //                  .rx_n_in9,           Check User Guide for details
		input  wire         rx_n_in10,                   //                  .rx_n_in10,          Check User Guide for details
		input  wire         rx_n_in11,                   //                  .rx_n_in11,          Check User Guide for details
		input  wire         rx_n_in12,                   //                  .rx_n_in12,          Check User Guide for details
		input  wire         rx_n_in13,                   //                  .rx_n_in13,          Check User Guide for details
		input  wire         rx_n_in14,                   //                  .rx_n_in14,          Check User Guide for details
		input  wire         rx_n_in15,                   //                  .rx_n_in15,          Check User Guide for details
		input  wire         rx_p_in0,                    //                  .rx_p_in0,           Check User Guide for details
		input  wire         rx_p_in1,                    //                  .rx_p_in1,           Check User Guide for details
		input  wire         rx_p_in2,                    //                  .rx_p_in2,           Check User Guide for details
		input  wire         rx_p_in3,                    //                  .rx_p_in3,           Check User Guide for details
		input  wire         rx_p_in4,                    //                  .rx_p_in4,           Check User Guide for details
		input  wire         rx_p_in5,                    //                  .rx_p_in5,           Check User Guide for details
		input  wire         rx_p_in6,                    //                  .rx_p_in6,           Check User Guide for details
		input  wire         rx_p_in7,                    //                  .rx_p_in7,           Check User Guide for details
		input  wire         rx_p_in8,                    //                  .rx_p_in8,           Check User Guide for details
		input  wire         rx_p_in9,                    //                  .rx_p_in9,           Check User Guide for details
		input  wire         rx_p_in10,                   //                  .rx_p_in10,          Check User Guide for details
		input  wire         rx_p_in11,                   //                  .rx_p_in11,          Check User Guide for details
		input  wire         rx_p_in12,                   //                  .rx_p_in12,          Check User Guide for details
		input  wire         rx_p_in13,                   //                  .rx_p_in13,          Check User Guide for details
		input  wire         rx_p_in14,                   //                  .rx_p_in14,          Check User Guide for details
		input  wire         rx_p_in15,                   //                  .rx_p_in15,          Check User Guide for details
		output wire         tx_n_out0,                   //                  .tx_n_out0,          Check User Guide for details
		output wire         tx_n_out1,                   //                  .tx_n_out1,          Check User Guide for details
		output wire         tx_n_out2,                   //                  .tx_n_out2,          Check User Guide for details
		output wire         tx_n_out3,                   //                  .tx_n_out3,          Check User Guide for details
		output wire         tx_n_out4,                   //                  .tx_n_out4,          Check User Guide for details
		output wire         tx_n_out5,                   //                  .tx_n_out5,          Check User Guide for details
		output wire         tx_n_out6,                   //                  .tx_n_out6,          Check User Guide for details
		output wire         tx_n_out7,                   //                  .tx_n_out7,          Check User Guide for details
		output wire         tx_n_out8,                   //                  .tx_n_out8,          Check User Guide for details
		output wire         tx_n_out9,                   //                  .tx_n_out9,          Check User Guide for details
		output wire         tx_n_out10,                  //                  .tx_n_out10,         Check User Guide for details
		output wire         tx_n_out11,                  //                  .tx_n_out11,         Check User Guide for details
		output wire         tx_n_out12,                  //                  .tx_n_out12,         Check User Guide for details
		output wire         tx_n_out13,                  //                  .tx_n_out13,         Check User Guide for details
		output wire         tx_n_out14,                  //                  .tx_n_out14,         Check User Guide for details
		output wire         tx_n_out15,                  //                  .tx_n_out15,         Check User Guide for details
		output wire         tx_p_out0,                   //                  .tx_p_out0,          Check User Guide for details
		output wire         tx_p_out1,                   //                  .tx_p_out1,          Check User Guide for details
		output wire         tx_p_out2,                   //                  .tx_p_out2,          Check User Guide for details
		output wire         tx_p_out3,                   //                  .tx_p_out3,          Check User Guide for details
		output wire         tx_p_out4,                   //                  .tx_p_out4,          Check User Guide for details
		output wire         tx_p_out5,                   //                  .tx_p_out5,          Check User Guide for details
		output wire         tx_p_out6,                   //                  .tx_p_out6,          Check User Guide for details
		output wire         tx_p_out7,                   //                  .tx_p_out7,          Check User Guide for details
		output wire         tx_p_out8,                   //                  .tx_p_out8,          Check User Guide for details
		output wire         tx_p_out9,                   //                  .tx_p_out9,          Check User Guide for details
		output wire         tx_p_out10,                  //                  .tx_p_out10,         Check User Guide for details
		output wire         tx_p_out11,                  //                  .tx_p_out11,         Check User Guide for details
		output wire         tx_p_out12,                  //                  .tx_p_out12,         Check User Guide for details
		output wire         tx_p_out13,                  //                  .tx_p_out13,         Check User Guide for details
		output wire         tx_p_out14,                  //                  .tx_p_out14,         Check User Guide for details
		output wire         tx_p_out15,                  //                  .tx_p_out15,         Check User Guide for details
		input  wire         pin_perst_n                  //         pin_perst.reset_n,            Check User Guide for details
	);
endmodule

