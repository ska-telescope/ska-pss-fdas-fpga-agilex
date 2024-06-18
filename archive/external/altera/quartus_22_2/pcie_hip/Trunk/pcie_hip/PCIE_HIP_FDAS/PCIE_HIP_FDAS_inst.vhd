	component PCIE_HIP_FDAS is
		port (
			clk_out_clk                                      : out std_logic;                                         -- clk
			rd_dma_0_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			rd_dma_0_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			rd_dma_0_writedata                               : out std_logic_vector(511 downto 0);                    -- writedata
			rd_dma_0_address                                 : out std_logic_vector(25 downto 0);                     -- address
			rd_dma_0_write                                   : out std_logic;                                         -- write
			rd_dma_0_byteenable                              : out std_logic_vector(63 downto 0);                     -- byteenable
			rd_dma_1_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			rd_dma_1_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			rd_dma_1_writedata                               : out std_logic_vector(511 downto 0);                    -- writedata
			rd_dma_1_address                                 : out std_logic_vector(25 downto 0);                     -- address
			rd_dma_1_write                                   : out std_logic;                                         -- write
			rd_dma_1_byteenable                              : out std_logic_vector(63 downto 0);                     -- byteenable
			rd_dma_2_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			rd_dma_2_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			rd_dma_2_writedata                               : out std_logic_vector(511 downto 0);                    -- writedata
			rd_dma_2_address                                 : out std_logic_vector(25 downto 0);                     -- address
			rd_dma_2_write                                   : out std_logic;                                         -- write
			rd_dma_2_byteenable                              : out std_logic_vector(63 downto 0);                     -- byteenable
			rd_dma_3_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			rd_dma_3_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			rd_dma_3_writedata                               : out std_logic_vector(511 downto 0);                    -- writedata
			rd_dma_3_address                                 : out std_logic_vector(25 downto 0);                     -- address
			rd_dma_3_write                                   : out std_logic;                                         -- write
			rd_dma_3_byteenable                              : out std_logic_vector(63 downto 0);                     -- byteenable
			wr_dma_0_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			wr_dma_0_readdata                                : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			wr_dma_0_readdatavalid                           : in  std_logic                      := 'X';             -- readdatavalid
			wr_dma_0_response                                : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			wr_dma_0_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			wr_dma_0_address                                 : out std_logic_vector(25 downto 0);                     -- address
			wr_dma_0_read                                    : out std_logic;                                         -- read
			wr_dma_1_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			wr_dma_1_readdata                                : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			wr_dma_1_readdatavalid                           : in  std_logic                      := 'X';             -- readdatavalid
			wr_dma_1_response                                : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			wr_dma_1_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			wr_dma_1_address                                 : out std_logic_vector(25 downto 0);                     -- address
			wr_dma_1_read                                    : out std_logic;                                         -- read
			wr_dma_2_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			wr_dma_2_readdata                                : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			wr_dma_2_readdatavalid                           : in  std_logic                      := 'X';             -- readdatavalid
			wr_dma_2_response                                : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			wr_dma_2_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			wr_dma_2_address                                 : out std_logic_vector(25 downto 0);                     -- address
			wr_dma_2_read                                    : out std_logic;                                         -- read
			wr_dma_3_waitrequest                             : in  std_logic                      := 'X';             -- waitrequest
			wr_dma_3_readdata                                : in  std_logic_vector(511 downto 0) := (others => 'X'); -- readdata
			wr_dma_3_readdatavalid                           : in  std_logic                      := 'X';             -- readdatavalid
			wr_dma_3_response                                : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			wr_dma_3_burstcount                              : out std_logic_vector(3 downto 0);                      -- burstcount
			wr_dma_3_address                                 : out std_logic_vector(25 downto 0);                     -- address
			wr_dma_3_read                                    : out std_logic;                                         -- read
			intel_pcie_ptile_mcdma_0_usr_msix_valid          : in  std_logic                      := 'X';             -- valid
			intel_pcie_ptile_mcdma_0_usr_msix_ready          : out std_logic;                                         -- ready
			intel_pcie_ptile_mcdma_0_usr_msix_data           : in  std_logic_vector(15 downto 0)  := (others => 'X'); -- data
			intel_pcie_ptile_mcdma_0_p0_pld_pld_warm_rst_rdy : in  std_logic                      := 'X';             -- pld_warm_rst_rdy
			intel_pcie_ptile_mcdma_0_p0_pld_link_req_rst_n   : out std_logic;                                         -- link_req_rst_n
			intel_pcie_ptile_mcdma_0_refclk0_clk             : in  std_logic                      := 'X';             -- clk
			intel_pcie_ptile_mcdma_0_refclk1_clk             : in  std_logic                      := 'X';             -- clk
			intel_pcie_ptile_mcdma_0_ninit_done_reset        : in  std_logic                      := 'X';             -- reset
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in0     : in  std_logic                      := 'X';             -- rx_n_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in1     : in  std_logic                      := 'X';             -- rx_n_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in2     : in  std_logic                      := 'X';             -- rx_n_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in3     : in  std_logic                      := 'X';             -- rx_n_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in4     : in  std_logic                      := 'X';             -- rx_n_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in5     : in  std_logic                      := 'X';             -- rx_n_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in6     : in  std_logic                      := 'X';             -- rx_n_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in7     : in  std_logic                      := 'X';             -- rx_n_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in8     : in  std_logic                      := 'X';             -- rx_n_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in9     : in  std_logic                      := 'X';             -- rx_n_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in10    : in  std_logic                      := 'X';             -- rx_n_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in11    : in  std_logic                      := 'X';             -- rx_n_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in12    : in  std_logic                      := 'X';             -- rx_n_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in13    : in  std_logic                      := 'X';             -- rx_n_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in14    : in  std_logic                      := 'X';             -- rx_n_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in15    : in  std_logic                      := 'X';             -- rx_n_in15
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in0     : in  std_logic                      := 'X';             -- rx_p_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in1     : in  std_logic                      := 'X';             -- rx_p_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in2     : in  std_logic                      := 'X';             -- rx_p_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in3     : in  std_logic                      := 'X';             -- rx_p_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in4     : in  std_logic                      := 'X';             -- rx_p_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in5     : in  std_logic                      := 'X';             -- rx_p_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in6     : in  std_logic                      := 'X';             -- rx_p_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in7     : in  std_logic                      := 'X';             -- rx_p_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in8     : in  std_logic                      := 'X';             -- rx_p_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in9     : in  std_logic                      := 'X';             -- rx_p_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in10    : in  std_logic                      := 'X';             -- rx_p_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in11    : in  std_logic                      := 'X';             -- rx_p_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in12    : in  std_logic                      := 'X';             -- rx_p_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in13    : in  std_logic                      := 'X';             -- rx_p_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in14    : in  std_logic                      := 'X';             -- rx_p_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in15    : in  std_logic                      := 'X';             -- rx_p_in15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out0    : out std_logic;                                         -- tx_n_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out1    : out std_logic;                                         -- tx_n_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out2    : out std_logic;                                         -- tx_n_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out3    : out std_logic;                                         -- tx_n_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out4    : out std_logic;                                         -- tx_n_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out5    : out std_logic;                                         -- tx_n_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out6    : out std_logic;                                         -- tx_n_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out7    : out std_logic;                                         -- tx_n_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out8    : out std_logic;                                         -- tx_n_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out9    : out std_logic;                                         -- tx_n_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out10   : out std_logic;                                         -- tx_n_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out11   : out std_logic;                                         -- tx_n_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out12   : out std_logic;                                         -- tx_n_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out13   : out std_logic;                                         -- tx_n_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out14   : out std_logic;                                         -- tx_n_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out15   : out std_logic;                                         -- tx_n_out15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out0    : out std_logic;                                         -- tx_p_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out1    : out std_logic;                                         -- tx_p_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out2    : out std_logic;                                         -- tx_p_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out3    : out std_logic;                                         -- tx_p_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out4    : out std_logic;                                         -- tx_p_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out5    : out std_logic;                                         -- tx_p_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out6    : out std_logic;                                         -- tx_p_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out7    : out std_logic;                                         -- tx_p_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out8    : out std_logic;                                         -- tx_p_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out9    : out std_logic;                                         -- tx_p_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out10   : out std_logic;                                         -- tx_p_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out11   : out std_logic;                                         -- tx_p_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out12   : out std_logic;                                         -- tx_p_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out13   : out std_logic;                                         -- tx_p_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out14   : out std_logic;                                         -- tx_p_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out15   : out std_logic;                                         -- tx_p_out15
			intel_pcie_ptile_mcdma_0_pin_perst_reset_n       : in  std_logic                      := 'X';             -- reset_n
			reset_out_reset_n                                : out std_logic;                                         -- reset_n
			rxm_bar2_0_m0_waitrequest                        : in  std_logic                      := 'X';             -- waitrequest
			rxm_bar2_0_m0_readdata                           : in  std_logic_vector(63 downto 0)  := (others => 'X'); -- readdata
			rxm_bar2_0_m0_readdatavalid                      : in  std_logic                      := 'X';             -- readdatavalid
			rxm_bar2_0_m0_writeresponsevalid                 : in  std_logic                      := 'X';             -- writeresponsevalid
			rxm_bar2_0_m0_response                           : in  std_logic_vector(1 downto 0)   := (others => 'X'); -- response
			rxm_bar2_0_m0_writedata                          : out std_logic_vector(63 downto 0);                     -- writedata
			rxm_bar2_0_m0_address                            : out std_logic_vector(21 downto 0);                     -- address
			rxm_bar2_0_m0_write                              : out std_logic;                                         -- write
			rxm_bar2_0_m0_read                               : out std_logic;                                         -- read
			rxm_bar2_0_m0_byteenable                         : out std_logic_vector(7 downto 0)                       -- byteenable
		);
	end component PCIE_HIP_FDAS;

	u0 : component PCIE_HIP_FDAS
		port map (
			clk_out_clk                                      => CONNECTED_TO_clk_out_clk,                                      --                             clk_out.clk
			rd_dma_0_waitrequest                             => CONNECTED_TO_rd_dma_0_waitrequest,                             --                            rd_dma_0.waitrequest
			rd_dma_0_burstcount                              => CONNECTED_TO_rd_dma_0_burstcount,                              --                                    .burstcount
			rd_dma_0_writedata                               => CONNECTED_TO_rd_dma_0_writedata,                               --                                    .writedata
			rd_dma_0_address                                 => CONNECTED_TO_rd_dma_0_address,                                 --                                    .address
			rd_dma_0_write                                   => CONNECTED_TO_rd_dma_0_write,                                   --                                    .write
			rd_dma_0_byteenable                              => CONNECTED_TO_rd_dma_0_byteenable,                              --                                    .byteenable
			rd_dma_1_waitrequest                             => CONNECTED_TO_rd_dma_1_waitrequest,                             --                            rd_dma_1.waitrequest
			rd_dma_1_burstcount                              => CONNECTED_TO_rd_dma_1_burstcount,                              --                                    .burstcount
			rd_dma_1_writedata                               => CONNECTED_TO_rd_dma_1_writedata,                               --                                    .writedata
			rd_dma_1_address                                 => CONNECTED_TO_rd_dma_1_address,                                 --                                    .address
			rd_dma_1_write                                   => CONNECTED_TO_rd_dma_1_write,                                   --                                    .write
			rd_dma_1_byteenable                              => CONNECTED_TO_rd_dma_1_byteenable,                              --                                    .byteenable
			rd_dma_2_waitrequest                             => CONNECTED_TO_rd_dma_2_waitrequest,                             --                            rd_dma_2.waitrequest
			rd_dma_2_burstcount                              => CONNECTED_TO_rd_dma_2_burstcount,                              --                                    .burstcount
			rd_dma_2_writedata                               => CONNECTED_TO_rd_dma_2_writedata,                               --                                    .writedata
			rd_dma_2_address                                 => CONNECTED_TO_rd_dma_2_address,                                 --                                    .address
			rd_dma_2_write                                   => CONNECTED_TO_rd_dma_2_write,                                   --                                    .write
			rd_dma_2_byteenable                              => CONNECTED_TO_rd_dma_2_byteenable,                              --                                    .byteenable
			rd_dma_3_waitrequest                             => CONNECTED_TO_rd_dma_3_waitrequest,                             --                            rd_dma_3.waitrequest
			rd_dma_3_burstcount                              => CONNECTED_TO_rd_dma_3_burstcount,                              --                                    .burstcount
			rd_dma_3_writedata                               => CONNECTED_TO_rd_dma_3_writedata,                               --                                    .writedata
			rd_dma_3_address                                 => CONNECTED_TO_rd_dma_3_address,                                 --                                    .address
			rd_dma_3_write                                   => CONNECTED_TO_rd_dma_3_write,                                   --                                    .write
			rd_dma_3_byteenable                              => CONNECTED_TO_rd_dma_3_byteenable,                              --                                    .byteenable
			wr_dma_0_waitrequest                             => CONNECTED_TO_wr_dma_0_waitrequest,                             --                            wr_dma_0.waitrequest
			wr_dma_0_readdata                                => CONNECTED_TO_wr_dma_0_readdata,                                --                                    .readdata
			wr_dma_0_readdatavalid                           => CONNECTED_TO_wr_dma_0_readdatavalid,                           --                                    .readdatavalid
			wr_dma_0_response                                => CONNECTED_TO_wr_dma_0_response,                                --                                    .response
			wr_dma_0_burstcount                              => CONNECTED_TO_wr_dma_0_burstcount,                              --                                    .burstcount
			wr_dma_0_address                                 => CONNECTED_TO_wr_dma_0_address,                                 --                                    .address
			wr_dma_0_read                                    => CONNECTED_TO_wr_dma_0_read,                                    --                                    .read
			wr_dma_1_waitrequest                             => CONNECTED_TO_wr_dma_1_waitrequest,                             --                            wr_dma_1.waitrequest
			wr_dma_1_readdata                                => CONNECTED_TO_wr_dma_1_readdata,                                --                                    .readdata
			wr_dma_1_readdatavalid                           => CONNECTED_TO_wr_dma_1_readdatavalid,                           --                                    .readdatavalid
			wr_dma_1_response                                => CONNECTED_TO_wr_dma_1_response,                                --                                    .response
			wr_dma_1_burstcount                              => CONNECTED_TO_wr_dma_1_burstcount,                              --                                    .burstcount
			wr_dma_1_address                                 => CONNECTED_TO_wr_dma_1_address,                                 --                                    .address
			wr_dma_1_read                                    => CONNECTED_TO_wr_dma_1_read,                                    --                                    .read
			wr_dma_2_waitrequest                             => CONNECTED_TO_wr_dma_2_waitrequest,                             --                            wr_dma_2.waitrequest
			wr_dma_2_readdata                                => CONNECTED_TO_wr_dma_2_readdata,                                --                                    .readdata
			wr_dma_2_readdatavalid                           => CONNECTED_TO_wr_dma_2_readdatavalid,                           --                                    .readdatavalid
			wr_dma_2_response                                => CONNECTED_TO_wr_dma_2_response,                                --                                    .response
			wr_dma_2_burstcount                              => CONNECTED_TO_wr_dma_2_burstcount,                              --                                    .burstcount
			wr_dma_2_address                                 => CONNECTED_TO_wr_dma_2_address,                                 --                                    .address
			wr_dma_2_read                                    => CONNECTED_TO_wr_dma_2_read,                                    --                                    .read
			wr_dma_3_waitrequest                             => CONNECTED_TO_wr_dma_3_waitrequest,                             --                            wr_dma_3.waitrequest
			wr_dma_3_readdata                                => CONNECTED_TO_wr_dma_3_readdata,                                --                                    .readdata
			wr_dma_3_readdatavalid                           => CONNECTED_TO_wr_dma_3_readdatavalid,                           --                                    .readdatavalid
			wr_dma_3_response                                => CONNECTED_TO_wr_dma_3_response,                                --                                    .response
			wr_dma_3_burstcount                              => CONNECTED_TO_wr_dma_3_burstcount,                              --                                    .burstcount
			wr_dma_3_address                                 => CONNECTED_TO_wr_dma_3_address,                                 --                                    .address
			wr_dma_3_read                                    => CONNECTED_TO_wr_dma_3_read,                                    --                                    .read
			intel_pcie_ptile_mcdma_0_usr_msix_valid          => CONNECTED_TO_intel_pcie_ptile_mcdma_0_usr_msix_valid,          --   intel_pcie_ptile_mcdma_0_usr_msix.valid
			intel_pcie_ptile_mcdma_0_usr_msix_ready          => CONNECTED_TO_intel_pcie_ptile_mcdma_0_usr_msix_ready,          --                                    .ready
			intel_pcie_ptile_mcdma_0_usr_msix_data           => CONNECTED_TO_intel_pcie_ptile_mcdma_0_usr_msix_data,           --                                    .data
			intel_pcie_ptile_mcdma_0_p0_pld_pld_warm_rst_rdy => CONNECTED_TO_intel_pcie_ptile_mcdma_0_p0_pld_pld_warm_rst_rdy, --     intel_pcie_ptile_mcdma_0_p0_pld.pld_warm_rst_rdy
			intel_pcie_ptile_mcdma_0_p0_pld_link_req_rst_n   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_p0_pld_link_req_rst_n,   --                                    .link_req_rst_n
			intel_pcie_ptile_mcdma_0_refclk0_clk             => CONNECTED_TO_intel_pcie_ptile_mcdma_0_refclk0_clk,             --    intel_pcie_ptile_mcdma_0_refclk0.clk
			intel_pcie_ptile_mcdma_0_refclk1_clk             => CONNECTED_TO_intel_pcie_ptile_mcdma_0_refclk1_clk,             --    intel_pcie_ptile_mcdma_0_refclk1.clk
			intel_pcie_ptile_mcdma_0_ninit_done_reset        => CONNECTED_TO_intel_pcie_ptile_mcdma_0_ninit_done_reset,        -- intel_pcie_ptile_mcdma_0_ninit_done.reset
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in0     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in0,     -- intel_pcie_ptile_mcdma_0_hip_serial.rx_n_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in1     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in1,     --                                    .rx_n_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in2     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in2,     --                                    .rx_n_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in3     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in3,     --                                    .rx_n_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in4     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in4,     --                                    .rx_n_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in5     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in5,     --                                    .rx_n_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in6     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in6,     --                                    .rx_n_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in7     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in7,     --                                    .rx_n_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in8     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in8,     --                                    .rx_n_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in9     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in9,     --                                    .rx_n_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in10    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in10,    --                                    .rx_n_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in11    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in11,    --                                    .rx_n_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in12    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in12,    --                                    .rx_n_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in13    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in13,    --                                    .rx_n_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in14    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in14,    --                                    .rx_n_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in15    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in15,    --                                    .rx_n_in15
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in0     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in0,     --                                    .rx_p_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in1     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in1,     --                                    .rx_p_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in2     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in2,     --                                    .rx_p_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in3     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in3,     --                                    .rx_p_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in4     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in4,     --                                    .rx_p_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in5     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in5,     --                                    .rx_p_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in6     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in6,     --                                    .rx_p_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in7     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in7,     --                                    .rx_p_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in8     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in8,     --                                    .rx_p_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in9     => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in9,     --                                    .rx_p_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in10    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in10,    --                                    .rx_p_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in11    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in11,    --                                    .rx_p_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in12    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in12,    --                                    .rx_p_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in13    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in13,    --                                    .rx_p_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in14    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in14,    --                                    .rx_p_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in15    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in15,    --                                    .rx_p_in15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out0    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out0,    --                                    .tx_n_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out1    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out1,    --                                    .tx_n_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out2    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out2,    --                                    .tx_n_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out3    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out3,    --                                    .tx_n_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out4    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out4,    --                                    .tx_n_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out5    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out5,    --                                    .tx_n_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out6    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out6,    --                                    .tx_n_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out7    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out7,    --                                    .tx_n_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out8    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out8,    --                                    .tx_n_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out9    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out9,    --                                    .tx_n_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out10   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out10,   --                                    .tx_n_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out11   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out11,   --                                    .tx_n_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out12   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out12,   --                                    .tx_n_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out13   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out13,   --                                    .tx_n_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out14   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out14,   --                                    .tx_n_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out15   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out15,   --                                    .tx_n_out15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out0    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out0,    --                                    .tx_p_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out1    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out1,    --                                    .tx_p_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out2    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out2,    --                                    .tx_p_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out3    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out3,    --                                    .tx_p_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out4    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out4,    --                                    .tx_p_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out5    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out5,    --                                    .tx_p_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out6    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out6,    --                                    .tx_p_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out7    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out7,    --                                    .tx_p_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out8    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out8,    --                                    .tx_p_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out9    => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out9,    --                                    .tx_p_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out10   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out10,   --                                    .tx_p_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out11   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out11,   --                                    .tx_p_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out12   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out12,   --                                    .tx_p_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out13   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out13,   --                                    .tx_p_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out14   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out14,   --                                    .tx_p_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out15   => CONNECTED_TO_intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out15,   --                                    .tx_p_out15
			intel_pcie_ptile_mcdma_0_pin_perst_reset_n       => CONNECTED_TO_intel_pcie_ptile_mcdma_0_pin_perst_reset_n,       --  intel_pcie_ptile_mcdma_0_pin_perst.reset_n
			reset_out_reset_n                                => CONNECTED_TO_reset_out_reset_n,                                --                           reset_out.reset_n
			rxm_bar2_0_m0_waitrequest                        => CONNECTED_TO_rxm_bar2_0_m0_waitrequest,                        --                       rxm_bar2_0_m0.waitrequest
			rxm_bar2_0_m0_readdata                           => CONNECTED_TO_rxm_bar2_0_m0_readdata,                           --                                    .readdata
			rxm_bar2_0_m0_readdatavalid                      => CONNECTED_TO_rxm_bar2_0_m0_readdatavalid,                      --                                    .readdatavalid
			rxm_bar2_0_m0_writeresponsevalid                 => CONNECTED_TO_rxm_bar2_0_m0_writeresponsevalid,                 --                                    .writeresponsevalid
			rxm_bar2_0_m0_response                           => CONNECTED_TO_rxm_bar2_0_m0_response,                           --                                    .response
			rxm_bar2_0_m0_writedata                          => CONNECTED_TO_rxm_bar2_0_m0_writedata,                          --                                    .writedata
			rxm_bar2_0_m0_address                            => CONNECTED_TO_rxm_bar2_0_m0_address,                            --                                    .address
			rxm_bar2_0_m0_write                              => CONNECTED_TO_rxm_bar2_0_m0_write,                              --                                    .write
			rxm_bar2_0_m0_read                               => CONNECTED_TO_rxm_bar2_0_m0_read,                               --                                    .read
			rxm_bar2_0_m0_byteenable                         => CONNECTED_TO_rxm_bar2_0_m0_byteenable                          --                                    .byteenable
		);

