	component ed_synth_tg is
		port (
			emif_usr_reset_n      : in  std_logic                      := 'X';             -- reset_n
			ninit_done            : in  std_logic                      := 'X';             -- reset
			emif_usr_clk          : in  std_logic                      := 'X';             -- clk
			amm_ready_0           : in  std_logic                      := 'X';             -- waitrequest_n
			amm_read_0            : out std_logic;                                         -- read
			amm_write_0           : out std_logic;                                         -- write
			amm_address_0         : out std_logic_vector(33 downto 0);                     -- address
			amm_readdata_0        : in  std_logic_vector(575 downto 0) := (others => 'X'); -- readdata
			amm_writedata_0       : out std_logic_vector(575 downto 0);                    -- writedata
			amm_burstcount_0      : out std_logic_vector(6 downto 0);                      -- burstcount
			amm_byteenable_0      : out std_logic_vector(71 downto 0);                     -- byteenable
			amm_readdatavalid_0   : in  std_logic                      := 'X';             -- readdatavalid
			traffic_gen_pass_0    : out std_logic;                                         -- traffic_gen_pass
			traffic_gen_fail_0    : out std_logic;                                         -- traffic_gen_fail
			traffic_gen_timeout_0 : out std_logic                                          -- traffic_gen_timeout
		);
	end component ed_synth_tg;

	u0 : component ed_synth_tg
		port map (
			emif_usr_reset_n      => CONNECTED_TO_emif_usr_reset_n,      -- emif_usr_reset_n.reset_n
			ninit_done            => CONNECTED_TO_ninit_done,            --       ninit_done.reset
			emif_usr_clk          => CONNECTED_TO_emif_usr_clk,          --     emif_usr_clk.clk
			amm_ready_0           => CONNECTED_TO_amm_ready_0,           --       ctrl_amm_0.waitrequest_n
			amm_read_0            => CONNECTED_TO_amm_read_0,            --                 .read
			amm_write_0           => CONNECTED_TO_amm_write_0,           --                 .write
			amm_address_0         => CONNECTED_TO_amm_address_0,         --                 .address
			amm_readdata_0        => CONNECTED_TO_amm_readdata_0,        --                 .readdata
			amm_writedata_0       => CONNECTED_TO_amm_writedata_0,       --                 .writedata
			amm_burstcount_0      => CONNECTED_TO_amm_burstcount_0,      --                 .burstcount
			amm_byteenable_0      => CONNECTED_TO_amm_byteenable_0,      --                 .byteenable
			amm_readdatavalid_0   => CONNECTED_TO_amm_readdatavalid_0,   --                 .readdatavalid
			traffic_gen_pass_0    => CONNECTED_TO_traffic_gen_pass_0,    --      tg_status_0.traffic_gen_pass
			traffic_gen_fail_0    => CONNECTED_TO_traffic_gen_fail_0,    --                 .traffic_gen_fail
			traffic_gen_timeout_0 => CONNECTED_TO_traffic_gen_timeout_0  --                 .traffic_gen_timeout
		);

