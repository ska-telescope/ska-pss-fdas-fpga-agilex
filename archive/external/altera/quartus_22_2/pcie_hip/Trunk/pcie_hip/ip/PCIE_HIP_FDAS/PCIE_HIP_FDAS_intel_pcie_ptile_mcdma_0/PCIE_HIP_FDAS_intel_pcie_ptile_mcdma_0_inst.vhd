	component PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0 is
		port (
			app_clk                     : out std_logic;                                         -- clk
			app_rst_n                   : out std_logic;                                         -- reset_n
			rx_pio_waitrequest_i        : in  std_logic                      := 'X';             -- waitrequest
			rx_pio_address_o            : out std_logic_vector(27 downto 0);                     -- address
			rx_pio_byteenable_o         : out std_logic_vector(7 downto 0);                      -- byteenable
			rx_pio_read_o               : out std_logic;                                         -- read
			rx_pio_readdata_i           : in  std_logic_vector(63 downto 0)  := (others => 'X'); -- readdata
			rx_pio_readdatavalid_i      : in  std_logic                      := 'X';             -- readdatavalid
			rx_pio_write_o              : out std_logic;                                         -- write
			rx_pio_writedata_o          : out std_logic_vector(63 downto 0);                     -- writedata
			rx_pio_burstcount_o         : out std_logic_vector(3 downto 0);                      -- burstcount
			rx_pio_response_i           : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			rx_pio_writeresponsevalid_i : in  std_logic                      := 'X';             -- writeresponsevalid
			d2hdm_waitrequest_i         : in  std_logic                      := 'X';             -- waitrequest
			d2hdm_read_o                : out std_logic;                                         -- read
			d2hdm_address_o             : out std_logic_vector(63 downto 0);                     -- address
			d2hdm_burstcount_o          : out std_logic_vector(3 downto 0);                      -- burstcount
			d2hdm_byteenable_o          : out std_logic_vector(63 downto 0);                     -- byteenable
			d2hdm_readdatavalid_i       : in  std_logic                      := 'X';             -- readdatavalid
			d2hdm_readdata_i            : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			d2hdm_response_i            : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			h2ddm_waitrequest_i         : in  std_logic                      := 'X';             -- waitrequest
			h2ddm_write_o               : out std_logic;                                         -- write
			h2ddm_address_o             : out std_logic_vector(63 downto 0);                     -- address
			h2ddm_burstcount_o          : out std_logic_vector(3 downto 0);                      -- burstcount
			h2ddm_byteenable_o          : out std_logic_vector(63 downto 0);                     -- byteenable
			h2ddm_writedata_o           : out std_logic_vector(511 downto 0);                    -- writedata
			usr_event_msix_valid_i      : in  std_logic                      := 'X';             -- valid
			usr_event_msix_ready_o      : out std_logic;                                         -- ready
			usr_event_msix_data_i       : in  std_logic_vector(15 downto 0)  := (others => 'X'); -- data
			usr_hip_tl_cfg_func_o       : out std_logic_vector(2 downto 0);                      -- tl_cfg_func
			usr_hip_tl_cfg_add_o        : out std_logic_vector(4 downto 0);                      -- tl_cfg_add
			usr_hip_tl_cfg_ctl_o        : out std_logic_vector(15 downto 0);                     -- tl_cfg_ctl
			p0_pld_warm_rst_rdy_i       : in  std_logic                      := 'X';             -- pld_warm_rst_rdy
			p0_pld_link_req_rst_o       : out std_logic;                                         -- link_req_rst_n
			p0_link_up_o                : out std_logic;                                         -- link_up
			p0_dl_up_o                  : out std_logic;                                         -- dl_up
			p0_surprise_down_err_o      : out std_logic;                                         -- surprise_down_err
			p0_ltssm_state_o            : out std_logic_vector(5 downto 0);                      -- ltssmstate
			refclk0                     : in  std_logic                      := 'X';             -- clk
			refclk1                     : in  std_logic                      := 'X';             -- clk
			ninit_done                  : in  std_logic                      := 'X';             -- reset
			rx_n_in0                    : in  std_logic                      := 'X';             -- rx_n_in0
			rx_n_in1                    : in  std_logic                      := 'X';             -- rx_n_in1
			rx_n_in2                    : in  std_logic                      := 'X';             -- rx_n_in2
			rx_n_in3                    : in  std_logic                      := 'X';             -- rx_n_in3
			rx_n_in4                    : in  std_logic                      := 'X';             -- rx_n_in4
			rx_n_in5                    : in  std_logic                      := 'X';             -- rx_n_in5
			rx_n_in6                    : in  std_logic                      := 'X';             -- rx_n_in6
			rx_n_in7                    : in  std_logic                      := 'X';             -- rx_n_in7
			rx_n_in8                    : in  std_logic                      := 'X';             -- rx_n_in8
			rx_n_in9                    : in  std_logic                      := 'X';             -- rx_n_in9
			rx_n_in10                   : in  std_logic                      := 'X';             -- rx_n_in10
			rx_n_in11                   : in  std_logic                      := 'X';             -- rx_n_in11
			rx_n_in12                   : in  std_logic                      := 'X';             -- rx_n_in12
			rx_n_in13                   : in  std_logic                      := 'X';             -- rx_n_in13
			rx_n_in14                   : in  std_logic                      := 'X';             -- rx_n_in14
			rx_n_in15                   : in  std_logic                      := 'X';             -- rx_n_in15
			rx_p_in0                    : in  std_logic                      := 'X';             -- rx_p_in0
			rx_p_in1                    : in  std_logic                      := 'X';             -- rx_p_in1
			rx_p_in2                    : in  std_logic                      := 'X';             -- rx_p_in2
			rx_p_in3                    : in  std_logic                      := 'X';             -- rx_p_in3
			rx_p_in4                    : in  std_logic                      := 'X';             -- rx_p_in4
			rx_p_in5                    : in  std_logic                      := 'X';             -- rx_p_in5
			rx_p_in6                    : in  std_logic                      := 'X';             -- rx_p_in6
			rx_p_in7                    : in  std_logic                      := 'X';             -- rx_p_in7
			rx_p_in8                    : in  std_logic                      := 'X';             -- rx_p_in8
			rx_p_in9                    : in  std_logic                      := 'X';             -- rx_p_in9
			rx_p_in10                   : in  std_logic                      := 'X';             -- rx_p_in10
			rx_p_in11                   : in  std_logic                      := 'X';             -- rx_p_in11
			rx_p_in12                   : in  std_logic                      := 'X';             -- rx_p_in12
			rx_p_in13                   : in  std_logic                      := 'X';             -- rx_p_in13
			rx_p_in14                   : in  std_logic                      := 'X';             -- rx_p_in14
			rx_p_in15                   : in  std_logic                      := 'X';             -- rx_p_in15
			tx_n_out0                   : out std_logic;                                         -- tx_n_out0
			tx_n_out1                   : out std_logic;                                         -- tx_n_out1
			tx_n_out2                   : out std_logic;                                         -- tx_n_out2
			tx_n_out3                   : out std_logic;                                         -- tx_n_out3
			tx_n_out4                   : out std_logic;                                         -- tx_n_out4
			tx_n_out5                   : out std_logic;                                         -- tx_n_out5
			tx_n_out6                   : out std_logic;                                         -- tx_n_out6
			tx_n_out7                   : out std_logic;                                         -- tx_n_out7
			tx_n_out8                   : out std_logic;                                         -- tx_n_out8
			tx_n_out9                   : out std_logic;                                         -- tx_n_out9
			tx_n_out10                  : out std_logic;                                         -- tx_n_out10
			tx_n_out11                  : out std_logic;                                         -- tx_n_out11
			tx_n_out12                  : out std_logic;                                         -- tx_n_out12
			tx_n_out13                  : out std_logic;                                         -- tx_n_out13
			tx_n_out14                  : out std_logic;                                         -- tx_n_out14
			tx_n_out15                  : out std_logic;                                         -- tx_n_out15
			tx_p_out0                   : out std_logic;                                         -- tx_p_out0
			tx_p_out1                   : out std_logic;                                         -- tx_p_out1
			tx_p_out2                   : out std_logic;                                         -- tx_p_out2
			tx_p_out3                   : out std_logic;                                         -- tx_p_out3
			tx_p_out4                   : out std_logic;                                         -- tx_p_out4
			tx_p_out5                   : out std_logic;                                         -- tx_p_out5
			tx_p_out6                   : out std_logic;                                         -- tx_p_out6
			tx_p_out7                   : out std_logic;                                         -- tx_p_out7
			tx_p_out8                   : out std_logic;                                         -- tx_p_out8
			tx_p_out9                   : out std_logic;                                         -- tx_p_out9
			tx_p_out10                  : out std_logic;                                         -- tx_p_out10
			tx_p_out11                  : out std_logic;                                         -- tx_p_out11
			tx_p_out12                  : out std_logic;                                         -- tx_p_out12
			tx_p_out13                  : out std_logic;                                         -- tx_p_out13
			tx_p_out14                  : out std_logic;                                         -- tx_p_out14
			tx_p_out15                  : out std_logic;                                         -- tx_p_out15
			pin_perst_n                 : in  std_logic                      := 'X'              -- reset_n
		);
	end component PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0;

	u0 : component PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0
		port map (
			app_clk                     => CONNECTED_TO_app_clk,                     --           app_clk.clk
			app_rst_n                   => CONNECTED_TO_app_rst_n,                   -- app_nreset_status.reset_n
			rx_pio_waitrequest_i        => CONNECTED_TO_rx_pio_waitrequest_i,        --     rx_pio_master.waitrequest
			rx_pio_address_o            => CONNECTED_TO_rx_pio_address_o,            --                  .address
			rx_pio_byteenable_o         => CONNECTED_TO_rx_pio_byteenable_o,         --                  .byteenable
			rx_pio_read_o               => CONNECTED_TO_rx_pio_read_o,               --                  .read
			rx_pio_readdata_i           => CONNECTED_TO_rx_pio_readdata_i,           --                  .readdata
			rx_pio_readdatavalid_i      => CONNECTED_TO_rx_pio_readdatavalid_i,      --                  .readdatavalid
			rx_pio_write_o              => CONNECTED_TO_rx_pio_write_o,              --                  .write
			rx_pio_writedata_o          => CONNECTED_TO_rx_pio_writedata_o,          --                  .writedata
			rx_pio_burstcount_o         => CONNECTED_TO_rx_pio_burstcount_o,         --                  .burstcount
			rx_pio_response_i           => CONNECTED_TO_rx_pio_response_i,           --                  .response
			rx_pio_writeresponsevalid_i => CONNECTED_TO_rx_pio_writeresponsevalid_i, --                  .writeresponsevalid
			d2hdm_waitrequest_i         => CONNECTED_TO_d2hdm_waitrequest_i,         --      d2hdm_master.waitrequest
			d2hdm_read_o                => CONNECTED_TO_d2hdm_read_o,                --                  .read
			d2hdm_address_o             => CONNECTED_TO_d2hdm_address_o,             --                  .address
			d2hdm_burstcount_o          => CONNECTED_TO_d2hdm_burstcount_o,          --                  .burstcount
			d2hdm_byteenable_o          => CONNECTED_TO_d2hdm_byteenable_o,          --                  .byteenable
			d2hdm_readdatavalid_i       => CONNECTED_TO_d2hdm_readdatavalid_i,       --                  .readdatavalid
			d2hdm_readdata_i            => CONNECTED_TO_d2hdm_readdata_i,            --                  .readdata
			d2hdm_response_i            => CONNECTED_TO_d2hdm_response_i,            --                  .response
			h2ddm_waitrequest_i         => CONNECTED_TO_h2ddm_waitrequest_i,         --      h2ddm_master.waitrequest
			h2ddm_write_o               => CONNECTED_TO_h2ddm_write_o,               --                  .write
			h2ddm_address_o             => CONNECTED_TO_h2ddm_address_o,             --                  .address
			h2ddm_burstcount_o          => CONNECTED_TO_h2ddm_burstcount_o,          --                  .burstcount
			h2ddm_byteenable_o          => CONNECTED_TO_h2ddm_byteenable_o,          --                  .byteenable
			h2ddm_writedata_o           => CONNECTED_TO_h2ddm_writedata_o,           --                  .writedata
			usr_event_msix_valid_i      => CONNECTED_TO_usr_event_msix_valid_i,      --          usr_msix.valid
			usr_event_msix_ready_o      => CONNECTED_TO_usr_event_msix_ready_o,      --                  .ready
			usr_event_msix_data_i       => CONNECTED_TO_usr_event_msix_data_i,       --                  .data
			usr_hip_tl_cfg_func_o       => CONNECTED_TO_usr_hip_tl_cfg_func_o,       --     usr_config_tl.tl_cfg_func
			usr_hip_tl_cfg_add_o        => CONNECTED_TO_usr_hip_tl_cfg_add_o,        --                  .tl_cfg_add
			usr_hip_tl_cfg_ctl_o        => CONNECTED_TO_usr_hip_tl_cfg_ctl_o,        --                  .tl_cfg_ctl
			p0_pld_warm_rst_rdy_i       => CONNECTED_TO_p0_pld_warm_rst_rdy_i,       --            p0_pld.pld_warm_rst_rdy
			p0_pld_link_req_rst_o       => CONNECTED_TO_p0_pld_link_req_rst_o,       --                  .link_req_rst_n
			p0_link_up_o                => CONNECTED_TO_p0_link_up_o,                --     p0_hip_status.link_up
			p0_dl_up_o                  => CONNECTED_TO_p0_dl_up_o,                  --                  .dl_up
			p0_surprise_down_err_o      => CONNECTED_TO_p0_surprise_down_err_o,      --                  .surprise_down_err
			p0_ltssm_state_o            => CONNECTED_TO_p0_ltssm_state_o,            --                  .ltssmstate
			refclk0                     => CONNECTED_TO_refclk0,                     --           refclk0.clk
			refclk1                     => CONNECTED_TO_refclk1,                     --           refclk1.clk
			ninit_done                  => CONNECTED_TO_ninit_done,                  --        ninit_done.reset
			rx_n_in0                    => CONNECTED_TO_rx_n_in0,                    --        hip_serial.rx_n_in0
			rx_n_in1                    => CONNECTED_TO_rx_n_in1,                    --                  .rx_n_in1
			rx_n_in2                    => CONNECTED_TO_rx_n_in2,                    --                  .rx_n_in2
			rx_n_in3                    => CONNECTED_TO_rx_n_in3,                    --                  .rx_n_in3
			rx_n_in4                    => CONNECTED_TO_rx_n_in4,                    --                  .rx_n_in4
			rx_n_in5                    => CONNECTED_TO_rx_n_in5,                    --                  .rx_n_in5
			rx_n_in6                    => CONNECTED_TO_rx_n_in6,                    --                  .rx_n_in6
			rx_n_in7                    => CONNECTED_TO_rx_n_in7,                    --                  .rx_n_in7
			rx_n_in8                    => CONNECTED_TO_rx_n_in8,                    --                  .rx_n_in8
			rx_n_in9                    => CONNECTED_TO_rx_n_in9,                    --                  .rx_n_in9
			rx_n_in10                   => CONNECTED_TO_rx_n_in10,                   --                  .rx_n_in10
			rx_n_in11                   => CONNECTED_TO_rx_n_in11,                   --                  .rx_n_in11
			rx_n_in12                   => CONNECTED_TO_rx_n_in12,                   --                  .rx_n_in12
			rx_n_in13                   => CONNECTED_TO_rx_n_in13,                   --                  .rx_n_in13
			rx_n_in14                   => CONNECTED_TO_rx_n_in14,                   --                  .rx_n_in14
			rx_n_in15                   => CONNECTED_TO_rx_n_in15,                   --                  .rx_n_in15
			rx_p_in0                    => CONNECTED_TO_rx_p_in0,                    --                  .rx_p_in0
			rx_p_in1                    => CONNECTED_TO_rx_p_in1,                    --                  .rx_p_in1
			rx_p_in2                    => CONNECTED_TO_rx_p_in2,                    --                  .rx_p_in2
			rx_p_in3                    => CONNECTED_TO_rx_p_in3,                    --                  .rx_p_in3
			rx_p_in4                    => CONNECTED_TO_rx_p_in4,                    --                  .rx_p_in4
			rx_p_in5                    => CONNECTED_TO_rx_p_in5,                    --                  .rx_p_in5
			rx_p_in6                    => CONNECTED_TO_rx_p_in6,                    --                  .rx_p_in6
			rx_p_in7                    => CONNECTED_TO_rx_p_in7,                    --                  .rx_p_in7
			rx_p_in8                    => CONNECTED_TO_rx_p_in8,                    --                  .rx_p_in8
			rx_p_in9                    => CONNECTED_TO_rx_p_in9,                    --                  .rx_p_in9
			rx_p_in10                   => CONNECTED_TO_rx_p_in10,                   --                  .rx_p_in10
			rx_p_in11                   => CONNECTED_TO_rx_p_in11,                   --                  .rx_p_in11
			rx_p_in12                   => CONNECTED_TO_rx_p_in12,                   --                  .rx_p_in12
			rx_p_in13                   => CONNECTED_TO_rx_p_in13,                   --                  .rx_p_in13
			rx_p_in14                   => CONNECTED_TO_rx_p_in14,                   --                  .rx_p_in14
			rx_p_in15                   => CONNECTED_TO_rx_p_in15,                   --                  .rx_p_in15
			tx_n_out0                   => CONNECTED_TO_tx_n_out0,                   --                  .tx_n_out0
			tx_n_out1                   => CONNECTED_TO_tx_n_out1,                   --                  .tx_n_out1
			tx_n_out2                   => CONNECTED_TO_tx_n_out2,                   --                  .tx_n_out2
			tx_n_out3                   => CONNECTED_TO_tx_n_out3,                   --                  .tx_n_out3
			tx_n_out4                   => CONNECTED_TO_tx_n_out4,                   --                  .tx_n_out4
			tx_n_out5                   => CONNECTED_TO_tx_n_out5,                   --                  .tx_n_out5
			tx_n_out6                   => CONNECTED_TO_tx_n_out6,                   --                  .tx_n_out6
			tx_n_out7                   => CONNECTED_TO_tx_n_out7,                   --                  .tx_n_out7
			tx_n_out8                   => CONNECTED_TO_tx_n_out8,                   --                  .tx_n_out8
			tx_n_out9                   => CONNECTED_TO_tx_n_out9,                   --                  .tx_n_out9
			tx_n_out10                  => CONNECTED_TO_tx_n_out10,                  --                  .tx_n_out10
			tx_n_out11                  => CONNECTED_TO_tx_n_out11,                  --                  .tx_n_out11
			tx_n_out12                  => CONNECTED_TO_tx_n_out12,                  --                  .tx_n_out12
			tx_n_out13                  => CONNECTED_TO_tx_n_out13,                  --                  .tx_n_out13
			tx_n_out14                  => CONNECTED_TO_tx_n_out14,                  --                  .tx_n_out14
			tx_n_out15                  => CONNECTED_TO_tx_n_out15,                  --                  .tx_n_out15
			tx_p_out0                   => CONNECTED_TO_tx_p_out0,                   --                  .tx_p_out0
			tx_p_out1                   => CONNECTED_TO_tx_p_out1,                   --                  .tx_p_out1
			tx_p_out2                   => CONNECTED_TO_tx_p_out2,                   --                  .tx_p_out2
			tx_p_out3                   => CONNECTED_TO_tx_p_out3,                   --                  .tx_p_out3
			tx_p_out4                   => CONNECTED_TO_tx_p_out4,                   --                  .tx_p_out4
			tx_p_out5                   => CONNECTED_TO_tx_p_out5,                   --                  .tx_p_out5
			tx_p_out6                   => CONNECTED_TO_tx_p_out6,                   --                  .tx_p_out6
			tx_p_out7                   => CONNECTED_TO_tx_p_out7,                   --                  .tx_p_out7
			tx_p_out8                   => CONNECTED_TO_tx_p_out8,                   --                  .tx_p_out8
			tx_p_out9                   => CONNECTED_TO_tx_p_out9,                   --                  .tx_p_out9
			tx_p_out10                  => CONNECTED_TO_tx_p_out10,                  --                  .tx_p_out10
			tx_p_out11                  => CONNECTED_TO_tx_p_out11,                  --                  .tx_p_out11
			tx_p_out12                  => CONNECTED_TO_tx_p_out12,                  --                  .tx_p_out12
			tx_p_out13                  => CONNECTED_TO_tx_p_out13,                  --                  .tx_p_out13
			tx_p_out14                  => CONNECTED_TO_tx_p_out14,                  --                  .tx_p_out14
			tx_p_out15                  => CONNECTED_TO_tx_p_out15,                  --                  .tx_p_out15
			pin_perst_n                 => CONNECTED_TO_pin_perst_n                  --         pin_perst.reset_n
		);

