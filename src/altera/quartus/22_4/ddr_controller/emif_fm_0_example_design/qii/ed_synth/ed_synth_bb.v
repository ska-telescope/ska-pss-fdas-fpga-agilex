module ed_synth (
		input  wire        emif_fm_0_pll_ref_clk_clk,          // emif_fm_0_pll_ref_clk.clk
		input  wire        emif_fm_0_oct_oct_rzqin,            //         emif_fm_0_oct.oct_rzqin
		output wire [0:0]  emif_fm_0_mem_mem_ck,               //         emif_fm_0_mem.mem_ck
		output wire [0:0]  emif_fm_0_mem_mem_ck_n,             //                      .mem_ck_n
		output wire [16:0] emif_fm_0_mem_mem_a,                //                      .mem_a
		output wire [0:0]  emif_fm_0_mem_mem_act_n,            //                      .mem_act_n
		output wire [1:0]  emif_fm_0_mem_mem_ba,               //                      .mem_ba
		output wire [1:0]  emif_fm_0_mem_mem_bg,               //                      .mem_bg
		output wire [0:0]  emif_fm_0_mem_mem_cke,              //                      .mem_cke
		output wire [0:0]  emif_fm_0_mem_mem_cs_n,             //                      .mem_cs_n
		output wire [0:0]  emif_fm_0_mem_mem_odt,              //                      .mem_odt
		output wire [0:0]  emif_fm_0_mem_mem_reset_n,          //                      .mem_reset_n
		output wire [0:0]  emif_fm_0_mem_mem_par,              //                      .mem_par
		input  wire [0:0]  emif_fm_0_mem_mem_alert_n,          //                      .mem_alert_n
		inout  wire [8:0]  emif_fm_0_mem_mem_dqs,              //                      .mem_dqs
		inout  wire [8:0]  emif_fm_0_mem_mem_dqs_n,            //                      .mem_dqs_n
		inout  wire [71:0] emif_fm_0_mem_mem_dq,               //                      .mem_dq
		inout  wire [8:0]  emif_fm_0_mem_mem_dbi_n,            //                      .mem_dbi_n
		output wire        emif_fm_0_status_local_cal_success, //      emif_fm_0_status.local_cal_success
		output wire        emif_fm_0_status_local_cal_fail,    //                      .local_cal_fail
		input  wire        local_reset_req,                    //       local_reset_req.local_reset_req
		output wire        local_reset_done,                   //    local_reset_status.local_reset_done
		output wire        emif_fm_0_tg_0_traffic_gen_pass,    //        emif_fm_0_tg_0.traffic_gen_pass
		output wire        emif_fm_0_tg_0_traffic_gen_fail,    //                      .traffic_gen_fail
		output wire        emif_fm_0_tg_0_traffic_gen_timeout  //                      .traffic_gen_timeout
	);
endmodule

