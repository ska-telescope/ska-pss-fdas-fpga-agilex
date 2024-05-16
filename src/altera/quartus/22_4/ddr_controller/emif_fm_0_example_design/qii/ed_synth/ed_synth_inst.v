	ed_synth u0 (
		.emif_fm_0_pll_ref_clk_clk          (_connected_to_emif_fm_0_pll_ref_clk_clk_),          //   input,   width = 1, emif_fm_0_pll_ref_clk.clk
		.emif_fm_0_oct_oct_rzqin            (_connected_to_emif_fm_0_oct_oct_rzqin_),            //   input,   width = 1,         emif_fm_0_oct.oct_rzqin
		.emif_fm_0_mem_mem_ck               (_connected_to_emif_fm_0_mem_mem_ck_),               //  output,   width = 1,         emif_fm_0_mem.mem_ck
		.emif_fm_0_mem_mem_ck_n             (_connected_to_emif_fm_0_mem_mem_ck_n_),             //  output,   width = 1,                      .mem_ck_n
		.emif_fm_0_mem_mem_a                (_connected_to_emif_fm_0_mem_mem_a_),                //  output,  width = 17,                      .mem_a
		.emif_fm_0_mem_mem_act_n            (_connected_to_emif_fm_0_mem_mem_act_n_),            //  output,   width = 1,                      .mem_act_n
		.emif_fm_0_mem_mem_ba               (_connected_to_emif_fm_0_mem_mem_ba_),               //  output,   width = 2,                      .mem_ba
		.emif_fm_0_mem_mem_bg               (_connected_to_emif_fm_0_mem_mem_bg_),               //  output,   width = 2,                      .mem_bg
		.emif_fm_0_mem_mem_cke              (_connected_to_emif_fm_0_mem_mem_cke_),              //  output,   width = 1,                      .mem_cke
		.emif_fm_0_mem_mem_cs_n             (_connected_to_emif_fm_0_mem_mem_cs_n_),             //  output,   width = 1,                      .mem_cs_n
		.emif_fm_0_mem_mem_odt              (_connected_to_emif_fm_0_mem_mem_odt_),              //  output,   width = 1,                      .mem_odt
		.emif_fm_0_mem_mem_reset_n          (_connected_to_emif_fm_0_mem_mem_reset_n_),          //  output,   width = 1,                      .mem_reset_n
		.emif_fm_0_mem_mem_par              (_connected_to_emif_fm_0_mem_mem_par_),              //  output,   width = 1,                      .mem_par
		.emif_fm_0_mem_mem_alert_n          (_connected_to_emif_fm_0_mem_mem_alert_n_),          //   input,   width = 1,                      .mem_alert_n
		.emif_fm_0_mem_mem_dqs              (_connected_to_emif_fm_0_mem_mem_dqs_),              //   inout,   width = 9,                      .mem_dqs
		.emif_fm_0_mem_mem_dqs_n            (_connected_to_emif_fm_0_mem_mem_dqs_n_),            //   inout,   width = 9,                      .mem_dqs_n
		.emif_fm_0_mem_mem_dq               (_connected_to_emif_fm_0_mem_mem_dq_),               //   inout,  width = 72,                      .mem_dq
		.emif_fm_0_mem_mem_dbi_n            (_connected_to_emif_fm_0_mem_mem_dbi_n_),            //   inout,   width = 9,                      .mem_dbi_n
		.emif_fm_0_status_local_cal_success (_connected_to_emif_fm_0_status_local_cal_success_), //  output,   width = 1,      emif_fm_0_status.local_cal_success
		.emif_fm_0_status_local_cal_fail    (_connected_to_emif_fm_0_status_local_cal_fail_),    //  output,   width = 1,                      .local_cal_fail
		.local_reset_req                    (_connected_to_local_reset_req_),                    //   input,   width = 1,       local_reset_req.local_reset_req
		.local_reset_done                   (_connected_to_local_reset_done_),                   //  output,   width = 1,    local_reset_status.local_reset_done
		.emif_fm_0_tg_0_traffic_gen_pass    (_connected_to_emif_fm_0_tg_0_traffic_gen_pass_),    //  output,   width = 1,        emif_fm_0_tg_0.traffic_gen_pass
		.emif_fm_0_tg_0_traffic_gen_fail    (_connected_to_emif_fm_0_tg_0_traffic_gen_fail_),    //  output,   width = 1,                      .traffic_gen_fail
		.emif_fm_0_tg_0_traffic_gen_timeout (_connected_to_emif_fm_0_tg_0_traffic_gen_timeout_)  //  output,   width = 1,                      .traffic_gen_timeout
	);

