----------------------------------------------------------------------------
-- Module Name:  FDAS_PCIE
--
-- Source Path:  fdas_pcie_struc.vhd
--
-- Description:  Instantiates PCIE IP block.
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD   23/06/2022  Initial revision.
-- 0.2  RMD   28/07/2022  Updated for Quartus Prime Ver 22.2 signal names
-- 0.3  RMD   26/09/2022  Update to support four DMA ports
-- 0.4  RMD   09/01/2023  Burstcount removed from the RXM PIO Interface
-- 0.5  RMD   28/02/2023  PCIe Macro updated for Intel Quartus Prime 22.4
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library pcie_hip_fdas;


architecture struc of fdas_pcie is


signal rxm_readdata_s   : std_logic_vector(63 downto 0);
signal rxm_writedata_s  : std_logic_vector(63 downto 0);
signal rxm_byteenable_s : std_logic_vector(7 downto 0);

begin

	  pcie_hard_ip_macro : entity pcie_hip_fdas.pcie_hip_fdas
		port map (
			clk_out_clk                                    => CLK_PCIE_O,                -- clk
			rd_dma_0_waitrequest                           => RD_DMA_0_WAITREQUEST_I,    -- waitrequest
			rd_dma_0_burstcount                            => RD_DMA_0_BURSTCOUNT_O,     -- burstcount
			rd_dma_0_writedata                             => RD_DMA_0_WRITEDATA_O,      -- writedata
			rd_dma_0_address                               => RD_DMA_0_ADDRESS_O,        -- address
			rd_dma_0_write                                 => RD_DMA_0_WRITE_O,          -- write
			rd_dma_0_byteenable                            => RD_DMA_0_BYTEENABLE_O,     -- byteenable
			rd_dma_1_waitrequest                           => RD_DMA_1_WAITREQUEST_I,    -- waitrequest
			rd_dma_1_burstcount                            => RD_DMA_1_BURSTCOUNT_O,     -- burstcount
			rd_dma_1_writedata                             => RD_DMA_1_WRITEDATA_O,      -- writedata
			rd_dma_1_address                               => RD_DMA_1_ADDRESS_O,        -- address
			rd_dma_1_write                                 => RD_DMA_1_WRITE_O,          -- write
			rd_dma_1_byteenable                            => RD_DMA_1_BYTEENABLE_O,     -- byteenable
			rd_dma_2_waitrequest                           => RD_DMA_2_WAITREQUEST_I,    -- waitrequest
			rd_dma_2_burstcount                            => RD_DMA_2_BURSTCOUNT_O,     -- burstcount
			rd_dma_2_writedata                             => RD_DMA_2_WRITEDATA_O,      -- writedata
			rd_dma_2_address                               => RD_DMA_2_ADDRESS_O,        -- address
			rd_dma_2_write                                 => RD_DMA_2_WRITE_O,          -- write
			rd_dma_2_byteenable                            => RD_DMA_2_BYTEENABLE_O,     -- byteenable
			rd_dma_3_waitrequest                           => RD_DMA_3_WAITREQUEST_I,    -- waitrequest
			rd_dma_3_burstcount                            => RD_DMA_3_BURSTCOUNT_O,     -- burstcount
			rd_dma_3_writedata                             => RD_DMA_3_WRITEDATA_O,      -- writedata
			rd_dma_3_address                               => RD_DMA_3_ADDRESS_O,        -- address
			rd_dma_3_write                                 => RD_DMA_3_WRITE_O,          -- write
			rd_dma_3_byteenable                            => RD_DMA_3_BYTEENABLE_O,     -- byteenable
			wr_dma_0_waitrequest                           => WR_DMA_0_WAITREQUEST_I,    -- waitrequest
			wr_dma_0_readdata                              => WR_DMA_0_READDATA_I,       -- readdata
			wr_dma_0_readdatavalid                         => WR_DMA_0_READDATAVALID_I,  -- readdatavalid
			wr_dma_0_response                              => WR_DMA_0_RESPONSE_I,       -- response
			wr_dma_0_burstcount                            => WR_DMA_0_BURSTCOUNT_O,     -- burstcount
			wr_dma_0_address                               => WR_DMA_0_ADDRESS_O,        -- address
			wr_dma_0_read                                  => WR_DMA_0_READ_O,           -- read
			wr_dma_1_waitrequest                           => WR_DMA_1_WAITREQUEST_I,    -- waitrequest
			wr_dma_1_readdata                              => WR_DMA_1_READDATA_I,       -- readdata
			wr_dma_1_readdatavalid                         => WR_DMA_1_READDATAVALID_I,  -- readdatavalid
			wr_dma_1_response                              => WR_DMA_1_RESPONSE_I,       -- response
			wr_dma_1_burstcount                            => WR_DMA_1_BURSTCOUNT_O,     -- burstcount
			wr_dma_1_address                               => WR_DMA_1_ADDRESS_O,        -- address
			wr_dma_1_read                                  => WR_DMA_1_READ_O,           -- read
			wr_dma_2_waitrequest                           => WR_DMA_2_WAITREQUEST_I,    -- waitrequest
			wr_dma_2_readdata                              => WR_DMA_2_READDATA_I,       -- readdata
			wr_dma_2_readdatavalid                         => WR_DMA_2_READDATAVALID_I,  -- readdatavalid
			wr_dma_2_response                              => WR_DMA_2_RESPONSE_I,       -- response
			wr_dma_2_burstcount                            => WR_DMA_2_BURSTCOUNT_O,     -- burstcount
			wr_dma_2_address                               => WR_DMA_2_ADDRESS_O,        -- address
			wr_dma_2_read                                  => WR_DMA_2_READ_O,           -- read
			wr_dma_3_waitrequest                           => WR_DMA_3_WAITREQUEST_I,    -- waitrequest
			wr_dma_3_readdata                              => WR_DMA_3_READDATA_I,       -- readdata
			wr_dma_3_readdatavalid                         => WR_DMA_3_READDATAVALID_I,  -- readdatavalid
			wr_dma_3_response                              => WR_DMA_3_RESPONSE_I,       -- response
			wr_dma_3_burstcount                            => WR_DMA_3_BURSTCOUNT_O,     -- burstcount
			wr_dma_3_address                               => WR_DMA_3_ADDRESS_O,        -- address
			wr_dma_3_read                                  => WR_DMA_3_READ_O,           -- read
			intel_pcie_ptile_mcdma_0_p0_usr_msix_valid     => USER_MSIX_VALID_I,         -- valid
			intel_pcie_ptile_mcdma_0_p0_usr_msix_ready     => USER_MSIX_READY_O,         -- ready
			intel_pcie_ptile_mcdma_0_p0_usr_msix_data      => USER_MSIX_DATA_I,          -- data
			intel_pcie_ptile_mcdma_0_refclk0_clk           => CLK_REF_I_0,                 -- clk
			intel_pcie_ptile_mcdma_0_refclk1_clk           => CLK_REF_I_1,                 -- clk
			intel_pcie_ptile_mcdma_0_ninit_done_reset      => NINIT_DONE_I,                -- reset
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in0   => RX_IN0_N,                    -- rx_n_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in1   => RX_IN1_N,                    -- rx_n_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in2   => RX_IN2_N,                    -- rx_n_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in3   => RX_IN3_N,                    -- rx_n_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in4   => RX_IN4_N,                    -- rx_n_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in5   => RX_IN5_N,                    -- rx_n_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in6   => RX_IN6_N,                    -- rx_n_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in7   => RX_IN7_N,                    -- rx_n_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in8   => RX_IN8_N,                    -- rx_n_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in9   => RX_IN9_N,                    -- rx_n_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in10  => RX_IN10_N,                   -- rx_n_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in11  => RX_IN11_N,                   -- rx_n_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in12  => RX_IN12_N,                   -- rx_n_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in13  => RX_IN13_N,                   -- rx_n_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in14  => RX_IN14_N,                   -- rx_n_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_n_in15  => RX_IN15_N,                   -- rx_n_in15
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in0   => RX_IN0,                      -- rx_p_in0
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in1   => RX_IN1,                      -- rx_p_in1
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in2   => RX_IN2,                      -- rx_p_in2
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in3   => RX_IN3,                      -- rx_p_in3
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in4   => RX_IN4,                      -- rx_p_in4
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in5   => RX_IN5,                      -- rx_p_in5
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in6   => RX_IN6,                      -- rx_p_in6
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in7   => RX_IN7,                      -- rx_p_in7
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in8   => RX_IN8,                      -- rx_p_in8
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in9   => RX_IN9,                      -- rx_p_in9
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in10  => RX_IN10,                     -- rx_p_in10
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in11  => RX_IN11,                     -- rx_p_in11
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in12  => RX_IN12,                     -- rx_p_in12
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in13  => RX_IN13,                     -- rx_p_in13
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in14  => RX_IN14,                     -- rx_p_in14
			intel_pcie_ptile_mcdma_0_hip_serial_rx_p_in15  => RX_IN15,                     -- rx_p_in15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out0  => TX_OUT0_N,                   -- tx_n_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out1  => TX_OUT1_N,                   -- tx_n_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out2  => TX_OUT2_N,                   -- tx_n_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out3  => TX_OUT3_N,                   -- tx_n_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out4  => TX_OUT4_N,                   -- tx_n_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out5  => TX_OUT5_N,                   -- tx_n_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out6  => TX_OUT6_N,                   -- tx_n_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out7  => TX_OUT7_N,                   -- tx_n_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out8  => TX_OUT8_N,                   -- tx_n_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out9  => TX_OUT9_N,                   -- tx_n_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out10 => TX_OUT10_N,                  -- tx_n_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out11 => TX_OUT11_N,                  -- tx_n_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out12 => TX_OUT12_N,                  -- tx_n_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out13 => TX_OUT13_N,                  -- tx_n_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out14 => TX_OUT14_N,                  -- tx_n_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_n_out15 => TX_OUT15_N,                  -- tx_n_out15
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out0  => TX_OUT0,                     -- tx_p_out0
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out1  => TX_OUT1,                     -- tx_p_out1
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out2  => TX_OUT2,                     -- tx_p_out2
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out3  => TX_OUT3,                     -- tx_p_out3
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out4  => TX_OUT4,                     -- tx_p_out4
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out5  => TX_OUT5,                     -- tx_p_out5
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out6  => TX_OUT6,                     -- tx_p_out6
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out7  => TX_OUT7,                     -- tx_p_out7
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out8  => TX_OUT8,                     -- tx_p_out8
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out9  => TX_OUT9,                     -- tx_p_out9
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out10 => TX_OUT10,                    -- tx_p_out10
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out11 => TX_OUT11,                    -- tx_p_out11
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out12 => TX_OUT12,                    -- tx_p_out12
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out13 => TX_OUT13,                    -- tx_p_out13
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out14 => TX_OUT14,                    -- tx_p_out14
			intel_pcie_ptile_mcdma_0_hip_serial_tx_p_out15 => TX_OUT15,                    -- tx_p_out15
			intel_pcie_ptile_mcdma_0_pin_perst_reset_n     => PIN_PERST_I,                 -- reset_n
			reset_out_reset_n                              => RST_PCIE_N_O,                -- reset_n
			rxm_bar2_0_m0_waitrequest                      => RXM_WAITREQUEST_I,           -- waitrequest
			rxm_bar2_0_m0_readdata                         => rxm_readdata_s,              -- readdata
			rxm_bar2_0_m0_readdatavalid                    => RXM_READDATAVALID_I,         -- readdatavalid
			rxm_bar2_0_m0_writeresponsevalid               => RXM_WRITE_RESPONSE_VALID_I,  -- writeresponsevalid
			rxm_bar2_0_m0_response                         => RXM_RESPONSE_I,              -- response
			rxm_bar2_0_m0_writedata                        => rxm_writedata_s,             -- writedata
			rxm_bar2_0_m0_address                          => RXM_ADDRESS_O,               -- address
			rxm_bar2_0_m0_write                            => RXM_WRITE_O,                 -- write
			rxm_bar2_0_m0_read                             => RXM_READ_O,                  -- read
			rxm_bar2_0_m0_byteenable                       => rxm_byteenable_s             -- byteenable		
		);		
		
		
    
	  -- Concurrent assignments
      -- The Core only uses the lower 32-bits of the rxm_bar2 pio data bus for configuration
      -- (i.e) the MCI registers are 32 bit, whereas the rxm_bar2 data bus is 64-bits 
      -- Also only the lower 22 bits of the rxm_bar2 pio address are used for configuration of the core
      assign_pio_read_data: rxm_readdata_s <= X"00000000"& RXM_READDATA_I;
      assign_pio_write_data: RXM_WRITEDATA_O <= rxm_writedata_s(31 downto 0);
      assign_pio_byteenabe: RXM_BYTEENABLE_O <= rxm_byteenable_s( 3 downto 0);
      
      
end architecture struc; -- of fdas_pcie
