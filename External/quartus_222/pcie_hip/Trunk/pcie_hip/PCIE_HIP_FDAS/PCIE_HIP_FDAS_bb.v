module PCIE_HIP_FDAS (
		output wire         clk_out_clk,                                      //                             clk_out.clk
		input  wire         rd_dma_0_waitrequest,                             //                            rd_dma_0.waitrequest
		output wire [3:0]   rd_dma_0_burstcount,                              //                                    .burstcount
		output wire [511:0] rd_dma_0_writedata,                               //                                    .writedata
		output wire [25:0]  rd_dma_0_address,                                 //                                    .address
		output wire         rd_dma_0_write,                                   //                                    .write
		output wire [63:0]  rd_dma_0_byteenable,                              //                                    .byteenable
		input  wire         rd_dma_1_waitrequest,                             //                            rd_dma_1.waitrequest
		output wire [3:0]   rd_dma_1_burstcount,                              //                                    .burstcount
		output wire [511:0] rd_dma_1_writedata,                               //                                    .writedata
		output wire [25:0]  rd_dma_1_address,                                 //                                    .address
		output wire         rd_dma_1_write,                                   //                                    .write
		output wire [63:0]  rd_dma_1_byteenable,                              //                                    .byteenable
		input  wire         rd_dma_2_waitrequest,                             //                            rd_dma_2.waitrequest
		output wire [3:0]   rd_dma_2_burstcount,                              //                                    .burstcount
		output wire [511:0] rd_dma_2_writedata,                               //                                    .writedata
		output wire [25:0]  rd_dma_2_address,                                 //                                    .address
		output wire         rd_dma_2_write,                                   //                                    .write
		output wire [63:0]  rd_dma_2_byteenable,                              //                                    .byteenable
		input  wire         rd_dma_3_waitrequest,                             //                            rd_dma_3.waitrequest
		output wire [3:0]   rd_dma_3_burstcount,                              //                                    .burstcount
		output wire [511:0] rd_dma_3_writedata,                               //                                    .writedata
		output wire [25:0]  rd_dma_3_address,                                 //                                    .address
		output wire         rd_dma_3_write,                                   //                                    .write
		output wire [63:0]  rd_dma_3_byteenable,                              //                                    .byteenable
		input  wire         wr_dma_0_waitrequest,                             //                            wr_dma_0.waitrequest
		input  wire [511:0] wr_dma_0_readdata,                                //                                    .readdata
		input  wire         wr_dma_0_readdatavalid,                           //                                    .readdatavalid
		input  wire [1:0]   wr_dma_0_response,                                //                                    .response
		output wire [3:0]   wr_dma_0_burstcount,                              //                                    .burstcount
		output wire [25:0]  wr_dma_0_address,                                 //                                    .address
		output wire         wr_dma_0_read,                                    //                                    .read
		input  wire         wr_dma_1_waitrequest,                             //                            wr_dma_1.waitrequest
		input  wire [511:0] wr_dma_1_readdata,                                //                                    .readdata
		input  wire         wr_dma_1_readdatavalid,                           //                                    .readdatavalid
		input  wire [1:0]   wr_dma_1_response,                                //                                    .response
		output wire [3:0]   wr_dma_1_burstcount,                              //                                    .burstcount
		output wire [25:0]  wr_dma_1_address,                                 //                                    .address
		output wire         wr_dma_1_read,                                    //                                    .read
		input  wire         wr_dma_2_waitrequest,                             //                            wr_dma_2.waitrequest
		input  wire [511:0] wr_dma_2_readdata,                                //                                    .readdata
		input  wire         wr_dma_2_readdatavalid,                           //                                    .readdatavalid
		input  wire [1:0]   wr_dma_2_response,                                //                                    .response
		output wire [3:0]   wr_dma_2_burstcount,                              //                                    .burstcount
		output wire [25:0]  wr_dma_2_address,                                 //                                    .address
		output wire         wr_dma_2_read,                                    //                                    .read
		input  wire         wr_dma_3_waitrequest,                             //                            wr_dma_3.waitrequest
		input  wire [511:0] wr_dma_3_readdata,                                //                                    .readdata
		input  wire         wr_dma_3_readdatavalid,                           //                                    .readdatavalid
		input  wire [1:0]   wr_dma_3_response,                                //                                    .response
		output wire [3:0]   wr_dma_3_burstcount,                              //                                    .burstcount
		output wire [25:0]  wr_dma_3_address,                                 //                                    .address
		output wire         wr_dma_3_read,                                    //                                    .read
		input  wire         intel_pcie_ptile_mcdma_0_usr_msix_valid,          //   intel_pcie_ptile_mcdma_0_usr_msix.valid
		output wire         intel_pcie_ptile_mcdma_0_usr_msix_ready,          //                                    .ready
		input  wire [15:0]  intel_pcie_ptile_mcdma_0_usr_msix_data,           //                                    .data
		input  wire         intel_pcie_ptile_mcdma_0_p0_pld_pld_warm_rst_rdy, //     intel_pcie_ptile_mcdma_0_p0_pld.pld_warm_rst_rdy
		output wire         intel_pcie_ptile_mcdma_0_p0_pld_link_req_rst_n,   //                                    .link_req_rst_n
		input  wire         intel_pcie_ptile_mcdma_0_refclk0_clk,             //    intel_pcie_ptile_mcdma_0_refclk0.clk
		input  wire         intel_pcie_ptile_mcdma_0_refclk1_clk,             //    intel_pcie_ptile_mcdma_0_refclk1.clk
		input  wire         intel_pcie_ptile_mcdma_0_ninit_done_reset,        // intel_pcie_ptile_mcdma_0_ninit_done.reset
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in0,     // intel_pcie_ptile_mcdma_0_hip_serial.rx_n_in0
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in1,     //                                    .rx_n_in1
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in2,     //                                    .rx_n_in2
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in3,     //                                    .rx_n_in3
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in4,     //                                    .rx_n_in4
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in5,     //                                    .rx_n_in5
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in6,     //                                    .rx_n_in6
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in7,     //                                    .rx_n_in7
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in8,     //                                    .rx_n_in8
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in9,     //                                    .rx_n_in9
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in10,    //                                    .rx_n_in10
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in11,    //                                    .rx_n_in11
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in12,    //                                    .rx_n_in12
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in13,    //                                    .rx_n_in13
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in14,    //                                    .rx_n_in14
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in15,    //                                    .rx_n_in15
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in0,     //                                    .rx_p_in0
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in1,     //                                    .rx_p_in1
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in2,     //                                    .rx_p_in2
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in3,     //                                    .rx_p_in3
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in4,     //                                    .rx_p_in4
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in5,     //                                    .rx_p_in5
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in6,     //                                    .rx_p_in6
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in7,     //                                    .rx_p_in7
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in8,     //                                    .rx_p_in8
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in9,     //                                    .rx_p_in9
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in10,    //                                    .rx_p_in10
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in11,    //                                    .rx_p_in11
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in12,    //                                    .rx_p_in12
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in13,    //                                    .rx_p_in13
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in14,    //                                    .rx_p_in14
		input  wire         intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in15,    //                                    .rx_p_in15
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out0,    //                                    .tx_n_out0
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out1,    //                                    .tx_n_out1
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out2,    //                                    .tx_n_out2
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out3,    //                                    .tx_n_out3
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out4,    //                                    .tx_n_out4
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out5,    //                                    .tx_n_out5
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out6,    //                                    .tx_n_out6
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out7,    //                                    .tx_n_out7
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out8,    //                                    .tx_n_out8
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out9,    //                                    .tx_n_out9
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out10,   //                                    .tx_n_out10
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out11,   //                                    .tx_n_out11
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out12,   //                                    .tx_n_out12
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out13,   //                                    .tx_n_out13
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out14,   //                                    .tx_n_out14
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out15,   //                                    .tx_n_out15
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out0,    //                                    .tx_p_out0
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out1,    //                                    .tx_p_out1
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out2,    //                                    .tx_p_out2
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out3,    //                                    .tx_p_out3
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out4,    //                                    .tx_p_out4
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out5,    //                                    .tx_p_out5
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out6,    //                                    .tx_p_out6
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out7,    //                                    .tx_p_out7
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out8,    //                                    .tx_p_out8
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out9,    //                                    .tx_p_out9
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out10,   //                                    .tx_p_out10
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out11,   //                                    .tx_p_out11
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out12,   //                                    .tx_p_out12
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out13,   //                                    .tx_p_out13
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out14,   //                                    .tx_p_out14
		output wire         intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out15,   //                                    .tx_p_out15
		input  wire         intel_pcie_ptile_mcdma_0_pin_perst_reset_n,       //  intel_pcie_ptile_mcdma_0_pin_perst.reset_n
		output wire         reset_out_reset_n,                                //                           reset_out.reset_n
		input  wire         rxm_bar2_0_m0_waitrequest,                        //                       rxm_bar2_0_m0.waitrequest
		input  wire [63:0]  rxm_bar2_0_m0_readdata,                           //                                    .readdata
		input  wire         rxm_bar2_0_m0_readdatavalid,                      //                                    .readdatavalid
		input  wire         rxm_bar2_0_m0_writeresponsevalid,                 //                                    .writeresponsevalid
		input  wire [1:0]   rxm_bar2_0_m0_response,                           //                                    .response
		output wire [63:0]  rxm_bar2_0_m0_writedata,                          //                                    .writedata
		output wire [21:0]  rxm_bar2_0_m0_address,                            //                                    .address
		output wire         rxm_bar2_0_m0_write,                              //                                    .write
		output wire         rxm_bar2_0_m0_read,                               //                                    .read
		output wire [7:0]   rxm_bar2_0_m0_byteenable                          //                                    .byteenable
	);
endmodule

