	component ed_synth is
		port (
			emif_fm_0_pll_ref_clk_clk          : in    std_logic                     := 'X';             -- clk
			emif_fm_0_oct_oct_rzqin            : in    std_logic                     := 'X';             -- oct_rzqin
			emif_fm_0_mem_mem_ck               : out   std_logic_vector(0 downto 0);                     -- mem_ck
			emif_fm_0_mem_mem_ck_n             : out   std_logic_vector(0 downto 0);                     -- mem_ck_n
			emif_fm_0_mem_mem_a                : out   std_logic_vector(16 downto 0);                    -- mem_a
			emif_fm_0_mem_mem_act_n            : out   std_logic_vector(0 downto 0);                     -- mem_act_n
			emif_fm_0_mem_mem_ba               : out   std_logic_vector(1 downto 0);                     -- mem_ba
			emif_fm_0_mem_mem_bg               : out   std_logic_vector(1 downto 0);                     -- mem_bg
			emif_fm_0_mem_mem_cke              : out   std_logic_vector(0 downto 0);                     -- mem_cke
			emif_fm_0_mem_mem_cs_n             : out   std_logic_vector(0 downto 0);                     -- mem_cs_n
			emif_fm_0_mem_mem_odt              : out   std_logic_vector(0 downto 0);                     -- mem_odt
			emif_fm_0_mem_mem_reset_n          : out   std_logic_vector(0 downto 0);                     -- mem_reset_n
			emif_fm_0_mem_mem_par              : out   std_logic_vector(0 downto 0);                     -- mem_par
			emif_fm_0_mem_mem_alert_n          : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_alert_n
			emif_fm_0_mem_mem_dqs              : inout std_logic_vector(8 downto 0)  := (others => 'X'); -- mem_dqs
			emif_fm_0_mem_mem_dqs_n            : inout std_logic_vector(8 downto 0)  := (others => 'X'); -- mem_dqs_n
			emif_fm_0_mem_mem_dq               : inout std_logic_vector(71 downto 0) := (others => 'X'); -- mem_dq
			emif_fm_0_mem_mem_dbi_n            : inout std_logic_vector(8 downto 0)  := (others => 'X'); -- mem_dbi_n
			emif_fm_0_status_local_cal_success : out   std_logic;                                        -- local_cal_success
			emif_fm_0_status_local_cal_fail    : out   std_logic;                                        -- local_cal_fail
			local_reset_req                    : in    std_logic                     := 'X';             -- local_reset_req
			local_reset_done                   : out   std_logic;                                        -- local_reset_done
			emif_fm_0_tg_0_traffic_gen_pass    : out   std_logic;                                        -- traffic_gen_pass
			emif_fm_0_tg_0_traffic_gen_fail    : out   std_logic;                                        -- traffic_gen_fail
			emif_fm_0_tg_0_traffic_gen_timeout : out   std_logic                                         -- traffic_gen_timeout
		);
	end component ed_synth;

	u0 : component ed_synth
		port map (
			emif_fm_0_pll_ref_clk_clk          => CONNECTED_TO_emif_fm_0_pll_ref_clk_clk,          -- emif_fm_0_pll_ref_clk.clk
			emif_fm_0_oct_oct_rzqin            => CONNECTED_TO_emif_fm_0_oct_oct_rzqin,            --         emif_fm_0_oct.oct_rzqin
			emif_fm_0_mem_mem_ck               => CONNECTED_TO_emif_fm_0_mem_mem_ck,               --         emif_fm_0_mem.mem_ck
			emif_fm_0_mem_mem_ck_n             => CONNECTED_TO_emif_fm_0_mem_mem_ck_n,             --                      .mem_ck_n
			emif_fm_0_mem_mem_a                => CONNECTED_TO_emif_fm_0_mem_mem_a,                --                      .mem_a
			emif_fm_0_mem_mem_act_n            => CONNECTED_TO_emif_fm_0_mem_mem_act_n,            --                      .mem_act_n
			emif_fm_0_mem_mem_ba               => CONNECTED_TO_emif_fm_0_mem_mem_ba,               --                      .mem_ba
			emif_fm_0_mem_mem_bg               => CONNECTED_TO_emif_fm_0_mem_mem_bg,               --                      .mem_bg
			emif_fm_0_mem_mem_cke              => CONNECTED_TO_emif_fm_0_mem_mem_cke,              --                      .mem_cke
			emif_fm_0_mem_mem_cs_n             => CONNECTED_TO_emif_fm_0_mem_mem_cs_n,             --                      .mem_cs_n
			emif_fm_0_mem_mem_odt              => CONNECTED_TO_emif_fm_0_mem_mem_odt,              --                      .mem_odt
			emif_fm_0_mem_mem_reset_n          => CONNECTED_TO_emif_fm_0_mem_mem_reset_n,          --                      .mem_reset_n
			emif_fm_0_mem_mem_par              => CONNECTED_TO_emif_fm_0_mem_mem_par,              --                      .mem_par
			emif_fm_0_mem_mem_alert_n          => CONNECTED_TO_emif_fm_0_mem_mem_alert_n,          --                      .mem_alert_n
			emif_fm_0_mem_mem_dqs              => CONNECTED_TO_emif_fm_0_mem_mem_dqs,              --                      .mem_dqs
			emif_fm_0_mem_mem_dqs_n            => CONNECTED_TO_emif_fm_0_mem_mem_dqs_n,            --                      .mem_dqs_n
			emif_fm_0_mem_mem_dq               => CONNECTED_TO_emif_fm_0_mem_mem_dq,               --                      .mem_dq
			emif_fm_0_mem_mem_dbi_n            => CONNECTED_TO_emif_fm_0_mem_mem_dbi_n,            --                      .mem_dbi_n
			emif_fm_0_status_local_cal_success => CONNECTED_TO_emif_fm_0_status_local_cal_success, --      emif_fm_0_status.local_cal_success
			emif_fm_0_status_local_cal_fail    => CONNECTED_TO_emif_fm_0_status_local_cal_fail,    --                      .local_cal_fail
			local_reset_req                    => CONNECTED_TO_local_reset_req,                    --       local_reset_req.local_reset_req
			local_reset_done                   => CONNECTED_TO_local_reset_done,                   --    local_reset_status.local_reset_done
			emif_fm_0_tg_0_traffic_gen_pass    => CONNECTED_TO_emif_fm_0_tg_0_traffic_gen_pass,    --        emif_fm_0_tg_0.traffic_gen_pass
			emif_fm_0_tg_0_traffic_gen_fail    => CONNECTED_TO_emif_fm_0_tg_0_traffic_gen_fail,    --                      .traffic_gen_fail
			emif_fm_0_tg_0_traffic_gen_timeout => CONNECTED_TO_emif_fm_0_tg_0_traffic_gen_timeout  --                      .traffic_gen_timeout
		);

