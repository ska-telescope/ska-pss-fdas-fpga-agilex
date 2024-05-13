----------------------------------------------------------------------------
-- Module Name:  FDAS_DDR_CONTROLLER_CALIBRATION_HPS
--
-- Source Path:  fdas_ddr_controller_calibration_hps_struc.vhd
--
-- Description:  Instantiates Master DDR controller IP block and the associated calibration block
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD    25/02/2022  Initial revision.
-- 0.2  RMD    12/07/2022  Updated for 8GB SDRAM
-- 0.3  RMD    21/07/2022  Updated for HDPS DDR4 Interface (Channel 1)
-- 0.4  RMD    22/09/2022  Updated to support two DDR Interfaces
-- 0.5  RMD    24/01/2023  DDR Controllers now support ECC
-- 0.6  RMD    26/01/2023  ECC not supported on FDAS_DDR_CONTROLLER as processing times
--                         improve, with data bus and byte enable
--                         widths taken care of in this wrapper
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
library fdas_ddr_controller;
library fdas_emif_calibration;

architecture struc of fdas_ddr_controller_calibration_hps is

   -- Internal signal declarations
   signal calbus_read_0_s          : std_logic;                       -- DDR#0 emif_calbus_0.calbus_read,          Calibration bus read
   signal calbus_write_0_s         : std_logic;                       -- DDR#0 .calbus_write,         Calibration bus write
   signal calbus_address_0_s       : std_logic_vector(19 downto 0);   -- DDR#0 .calbus_address,       Calibration bus address
   signal calbus_wdata_0_s         : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_wdata,         Calibration bus write data
   signal calbus_rdata_0_s         : std_logic_vector(31 downto 0);   -- DDR#0 .calbus_rdata,         Calibration bus read data
   signal calbus_seq_param_tbl_0_s : std_logic_vector(4095 downto 0); -- DDR#0 .calbus_seq_param_tbl, Calibration bus param table data
   signal amm_address_0_s          : std_logic_vector(26 downto 0);
   signal amm_writedata_0_s        : std_logic_vector(575 downto 0);
   signal amm_byteenable_0_s       : std_logic_vector(71 downto 0);
   signal amm_readdata_0_s         : std_logic_vector(575 downto 0);     
   signal calbus_read_1_s          : std_logic;                       -- DDR#1 emif_calbus_0.calbus_read,          Calibration bus read
   signal calbus_write_1_s         : std_logic;                       -- DDR#1 .calbus_write,         Calibration bus write
   signal calbus_address_1_s       : std_logic_vector(19 downto 0);   -- DDR#1 .calbus_address,       Calibration bus address
   signal calbus_wdata_1_s         : std_logic_vector(31 downto 0);   -- DDR#1 .calbus_wdata,         Calibration bus write data
   signal calbus_rdata_1_s         : std_logic_vector(31 downto 0);   -- DDR#1 .calbus_rdata,         Calibration bus read data
   signal calbus_seq_param_tbl_1_s : std_logic_vector(4095 downto 0); -- DDR#1 .calbus_seq_param_tbl, Calibration bus param table data
   signal calbus_clk_s             : std_logic;                       -- emif_calbus_clk.clk,                  Calibration bus clock
   signal amm_address_1_s          : std_logic_vector(26 downto 0);


   -- Component Declarations   
   component FDAS_DDR_CONTROLLER 
 	 port (
		local_reset_req      : in    std_logic                       := '0';             --    local_reset_req.local_reset_req,      Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		local_reset_done     : out   std_logic;                                          -- local_reset_status.local_reset_done,     Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
		pll_ref_clk          : in    std_logic                       := '0';             --        pll_ref_clk.clk,                  PLL reference clock input
		oct_rzqin            : in    std_logic                       := '0';             --                oct.oct_rzqin,            Calibrated On-Chip Termination (OCT) RZQ input pin
		mem_ck               : out   std_logic_vector(0 downto 0);                       --                mem.mem_ck,               CK clock
		mem_ck_n             : out   std_logic_vector(0 downto 0);                       --                   .mem_ck_n,             CK clock (negative leg)
		mem_a                : out   std_logic_vector(16 downto 0);                      --                   .mem_a,                Address
		mem_act_n            : out   std_logic_vector(0 downto 0);                       --                   .mem_act_n,            Activation command
		mem_ba               : out   std_logic_vector(1 downto 0);                       --                   .mem_ba,               Bank address
		mem_bg               : out   std_logic_vector(1 downto 0);                       --                   .mem_bg,               Bank group
		mem_cke              : out   std_logic_vector(0 downto 0);                       --                   .mem_cke,              Clock enable
		mem_cs_n             : out   std_logic_vector(0 downto 0);                       --                   .mem_cs_n,             Chip select
		mem_odt              : out   std_logic_vector(0 downto 0);                       --                   .mem_odt,              On-die termination
		mem_reset_n          : out   std_logic_vector(0 downto 0);                       --                   .mem_reset_n,          Asynchronous reset
		mem_par              : out   std_logic_vector(0 downto 0);                       --                   .mem_par,              Command and address parity
		mem_alert_n          : in    std_logic_vector(0 downto 0)    := (others => '0'); --                   .mem_alert_n,          Alert flag
		mem_dqs              : inout std_logic_vector(8 downto 0)    := (others => '0'); --                   .mem_dqs,              Data strobe
		mem_dqs_n            : inout std_logic_vector(8 downto 0)    := (others => '0'); --                   .mem_dqs_n,            Data strobe (negative leg)
		mem_dq               : inout std_logic_vector(71 downto 0)   := (others => '0'); --                   .mem_dq,               Read/write data
		mem_dbi_n            : inout std_logic_vector(8 downto 0)    := (others => '0'); --                   .mem_dbi_n,            Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		local_cal_success    : out   std_logic;                                          --             status.local_cal_success,    When high, indicates that PHY calibration was successful
		local_cal_fail       : out   std_logic;                                          --                   .local_cal_fail,       When high, indicates that PHY calibration failed
		emif_usr_reset_n     : out   std_logic;                                          --   emif_usr_reset_n.reset_n,              Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		emif_usr_clk         : out   std_logic;                                          --       emif_usr_clk.clk,                  User clock domain
		amm_ready_0          : out   std_logic;                                          --         ctrl_amm_0.waitrequest_n,        Wait-request is asserted when controller is busy
		amm_read_0           : in    std_logic                       := '0';             --                   .read,                 Read request signal
		amm_write_0          : in    std_logic                       := '0';             --                   .write,                Write request signal
		amm_address_0        : in    std_logic_vector(26 downto 0)   := (others => '0'); --                   .address,              Address for the read/write request
		amm_readdata_0       : out   std_logic_vector(575 downto 0);                     --                   .readdata,             Read data
		amm_writedata_0      : in    std_logic_vector(575 downto 0)  := (others => '0'); --                   .writedata,            Write data
		amm_burstcount_0     : in    std_logic_vector(6 downto 0)    := (others => '0'); --                   .burstcount,           Number of transfers in each read/write burst
		amm_byteenable_0     : in    std_logic_vector(71 downto 0)   := (others => '0'); --                   .byteenable,           Byte-enable for write data
		amm_readdatavalid_0  : out   std_logic;                                          --                   .readdatavalid,        Indicates whether read data is valid
		calbus_read          : in    std_logic                       := '0';             --        emif_calbus.calbus_read,          Calibration bus read
		calbus_write         : in    std_logic                       := '0';             --                   .calbus_write,         Calibration bus write
		calbus_address       : in    std_logic_vector(19 downto 0)   := (others => '0'); --                   .calbus_address,       Calibration bus address
		calbus_wdata         : in    std_logic_vector(31 downto 0)   := (others => '0'); --                   .calbus_wdata,         Calibration bus write data
		calbus_rdata         : out   std_logic_vector(31 downto 0);                      --                   .calbus_rdata,         Calibration bus read data
		calbus_seq_param_tbl : out   std_logic_vector(4095 downto 0);                    --                   .calbus_seq_param_tbl, Calibration bus param table data
		calbus_clk           : in    std_logic                       := '0'              --    emif_calbus_clk.clk,                  Calibration bus clock
	 );
   end component;      
   

   -- Component Declarations   
	component FDAS_DDR_CONTROLLER_HPS is
		port (
			local_reset_req           : in    std_logic                       := 'X';             -- local_reset_req
			local_reset_done          : out   std_logic;                                          -- local_reset_done
			pll_ref_clk               : in    std_logic                       := 'X';             -- clk
			oct_rzqin                 : in    std_logic                       := 'X';             -- oct_rzqin
			mem_ck                    : out   std_logic_vector(0 downto 0);                       -- mem_ck
			mem_ck_n                  : out   std_logic_vector(0 downto 0);                       -- mem_ck_n
			mem_a                     : out   std_logic_vector(16 downto 0);                      -- mem_a
			mem_act_n                 : out   std_logic_vector(0 downto 0);                       -- mem_act_n
			mem_ba                    : out   std_logic_vector(1 downto 0);                       -- mem_ba
			mem_bg                    : out   std_logic_vector(1 downto 0);                       -- mem_bg
			mem_cke                   : out   std_logic_vector(0 downto 0);                       -- mem_cke
			mem_cs_n                  : out   std_logic_vector(0 downto 0);                       -- mem_cs_n
			mem_odt                   : out   std_logic_vector(0 downto 0);                       -- mem_odt
			mem_reset_n               : out   std_logic_vector(0 downto 0);                       -- mem_reset_n
			mem_par                   : out   std_logic_vector(0 downto 0);                       -- mem_par
			mem_alert_n               : in    std_logic_vector(0 downto 0)    := (others => 'X'); -- mem_alert_n
			mem_dqs                   : inout std_logic_vector(8 downto 0)    := (others => 'X'); -- mem_dqs
			mem_dqs_n                 : inout std_logic_vector(8 downto 0)    := (others => 'X'); -- mem_dqs_n
			mem_dq                    : inout std_logic_vector(71 downto 0)   := (others => 'X'); -- mem_dq
			mem_dbi_n                 : inout std_logic_vector(8 downto 0)    := (others => 'X'); -- mem_dbi_n
			local_cal_success         : out   std_logic;                                          -- local_cal_success
			local_cal_fail            : out   std_logic;                                          -- local_cal_fail
			calbus_read               : in    std_logic                       := 'X';             -- calbus_read
			calbus_write              : in    std_logic                       := 'X';             -- calbus_write
			calbus_address            : in    std_logic_vector(19 downto 0)   := (others => 'X'); -- calbus_address
			calbus_wdata              : in    std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_wdata
			calbus_rdata              : out   std_logic_vector(31 downto 0);                      -- calbus_rdata
			calbus_seq_param_tbl      : out   std_logic_vector(4095 downto 0);                    -- calbus_seq_param_tbl
			calbus_clk                : in    std_logic                       := 'X';             -- clk
			emif_usr_reset_n          : out   std_logic;                                          -- reset_n
			emif_usr_clk              : out   std_logic;                                          -- clk
			ctrl_ecc_user_interrupt_0 : out   std_logic;                                          -- ctrl_ecc_user_interrupt
			amm_ready_0               : out   std_logic;                                          -- waitrequest_n
			amm_read_0                : in    std_logic                       := 'X';             -- read
			amm_write_0               : in    std_logic                       := 'X';             -- write
			amm_address_0             : in    std_logic_vector(26 downto 0)   := (others => 'X'); -- address
			amm_readdata_0            : out   std_logic_vector(511 downto 0);                     -- readdata
			amm_writedata_0           : in    std_logic_vector(511 downto 0)  := (others => 'X'); -- writedata
			amm_burstcount_0          : in    std_logic_vector(6 downto 0)    := (others => 'X'); -- burstcount
			amm_byteenable_0          : in    std_logic_vector(63 downto 0)   := (others => 'X'); -- byteenable
			amm_readdatavalid_0       : out   std_logic                                           -- readdatavalid
		);
	end component FDAS_DDR_CONTROLLER_HPS;
   
   component FDAS_EMIF_CALIBRATION 
	 port (
			calbus_read_0          : out std_logic;                                          -- calbus_read
			calbus_write_0         : out std_logic;                                          -- calbus_write
			calbus_address_0       : out std_logic_vector(19 downto 0);                      -- calbus_address
			calbus_wdata_0         : out std_logic_vector(31 downto 0);                      -- calbus_wdata
			calbus_rdata_0         : in  std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_rdata
			calbus_seq_param_tbl_0 : in  std_logic_vector(4095 downto 0) := (others => 'X'); -- calbus_seq_param_tbl
			calbus_read_1          : out std_logic;                                          -- calbus_read
			calbus_write_1         : out std_logic;                                          -- calbus_write
			calbus_address_1       : out std_logic_vector(19 downto 0);                      -- calbus_address
			calbus_wdata_1         : out std_logic_vector(31 downto 0);                      -- calbus_wdata
			calbus_rdata_1         : in  std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_rdata
			calbus_seq_param_tbl_1 : in  std_logic_vector(4095 downto 0) := (others => 'X'); -- calbus_seq_param_tbl
			calbus_clk             : out std_logic                                           -- clk
      );
    end component;   
   
   
   
   

begin

      
      
   emif_cal_i : fdas_emif_calibration
	  port map (
		calbus_read_0          => calbus_read_0_s,          -- emif_calbus_0.calbus_read,          Calibration bus read
		calbus_write_0         => calbus_write_0_s,         -- .calbus_write,         Calibration bus write
		calbus_address_0       => calbus_address_0_s,       -- .calbus_address,       Calibration bus address
		calbus_wdata_0         => calbus_wdata_0_s,         -- .calbus_wdata,         Calibration bus write data
		calbus_rdata_0         => calbus_rdata_0_s,         -- .calbus_rdata,         Calibration bus read data
		calbus_seq_param_tbl_0 => calbus_seq_param_tbl_0_s, -- .calbus_seq_param_tbl, Calibration bus param table data
		calbus_read_1          => calbus_read_1_s,          -- emif_calbus_0.calbus_read,          Calibration bus read
		calbus_write_1         => calbus_write_1_s,         -- .calbus_write,         Calibration bus write
		calbus_address_1       => calbus_address_1_s,       -- .calbus_address,       Calibration bus address
		calbus_wdata_1         => calbus_wdata_1_s,         -- .calbus_wdata,         Calibration bus write data
		calbus_rdata_1         => calbus_rdata_1_s,         -- .calbus_rdata,         Calibration bus read data
		calbus_seq_param_tbl_1 => calbus_seq_param_tbl_1_s, -- .calbus_seq_param_tbl, Calibration bus param table data
		calbus_clk             => calbus_clk_s              -- emif_calbus_clk.clk,                  Calibration bus clock
      );      
   
      
      
   ddr_0 : fdas_ddr_controller
      port map (
		local_reset_req      => LOCAL_RESET_REQ_0_I,             -- Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		local_reset_done     => LOCAL_RESET_DONE_0_O,            -- Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
		pll_ref_clk          => PLL_REF_CLK_0_I,                 -- PLL reference clock input
		oct_rzqin            => OCT_RZQIN0_I,                   -- Calibrated On-Chip Termination (OCT) RZQ input pin
		mem_ck               => MEM0_CK_O,                      -- CK clock
		mem_ck_n             => MEM0_CK_N_O,                    -- CK clock (negative leg)
		mem_a                => MEM0_A_O,                       -- Address
		mem_act_n            => MEM0_ACT_N_O,                   -- Activation command
		mem_ba               => MEM0_BA_O,                      -- Bank address
		mem_bg               => MEM0_BG_O,                      -- Bank group
		mem_cke              => MEM0_CKE_O,                     -- Clock enable
		mem_cs_n             => MEM0_CS_N_O,                    -- Chip select
		mem_odt              => MEM0_ODT_O,                     -- On-die termination
		mem_reset_n          => MEM0_RESET_N_O,                 -- Asynchronous reset
		mem_par              => MEM0_PAR_O,                     -- Command and address parity
		mem_alert_n          => MEM0_ALERT_N_I,                 -- Alert flag
		mem_dqs              => MEM0_DQS_IO,                    -- Data strobe
		mem_dqs_n            => MEM0_DQS_N_IO,                  -- Data strobe (negative leg)
		mem_dq               => MEM0_DQ_IO,                     -- Read/write data
		mem_dbi_n            => MEM0_DBI_N_IO,                  -- Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		local_cal_success    => LOCAL_CAL_SUCCESS_0_O,           -- When high, indicates that PHY calibration was successful
		local_cal_fail       => LOCAL_CAL_FAIL_0_O,              -- When high, indicates that PHY calibration failed
		emif_usr_reset_n     => EMIF_USER_RESET_N_0_O,           -- Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		emif_usr_clk         => EMIF_USR_CLK_0_O,                -- User clock domain
		amm_ready_0          => AMM_READY_0_O,                   -- Wait-request is asserted when controller is busy
		amm_read_0           => AMM_READ_0_I,                    -- Read request signal
		amm_write_0          => AMM_WRITE_0_I,                   -- Write request signal
		amm_address_0        => amm_address_0_s,                 -- Address for the read/write request
		amm_readdata_0       => amm_readdata_0_s,                -- Read data
		amm_writedata_0      => amm_writedata_0_s,               -- Write data
		amm_burstcount_0     => AMM_BURSTCOUNT_0_I,              -- Number of transfers in each read/write burst
		amm_byteenable_0     => amm_byteenable_0_s,              -- Byte-enable for write data
		amm_readdatavalid_0  => AMM_READDATAVALID_0_O,           -- Indicates whether read data is valid
		calbus_read          => calbus_read_0_s,               --  emif_calbus.calbus_read,          Calibration bus read
		calbus_write         => calbus_write_0_s,              --  .calbus_write,         Calibration bus write
		calbus_address       => calbus_address_0_s,            --  .calbus_address,       Calibration bus address
		calbus_wdata         => calbus_wdata_0_s,              --  .calbus_wdata,         Calibration bus write data
		calbus_rdata         => calbus_rdata_0_s,              --  .calbus_rdata,         Calibration bus read data
		calbus_seq_param_tbl => calbus_seq_param_tbl_0_s,      --  .calbus_seq_param_tbl, Calibration bus param table data
		calbus_clk           => calbus_clk_s                   --  emif_calbus_clk.clk,                  Calibration bus clock      
      );      
 
   ddr_1 : fdas_ddr_controller_hps
      port map (
		local_reset_req      => LOCAL_RESET_REQ_1_I,             -- Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		local_reset_done     => LOCAL_RESET_DONE_1_O,            -- Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
		pll_ref_clk          => PLL_REF_CLK_1_I,                 -- PLL reference clock input
		oct_rzqin            => OCT_RZQIN1_I,                   -- Calibrated On-Chip Termination (OCT) RZQ input pin
		mem_ck               => MEM1_CK_O,                      -- CK clock
		mem_ck_n             => MEM1_CK_N_O,                    -- CK clock (negative leg)
		mem_a                => MEM1_A_O,                       -- Address
		mem_act_n            => MEM1_ACT_N_O,                   -- Activation command
		mem_ba               => MEM1_BA_O,                      -- Bank address
		mem_bg               => MEM1_BG_O,                      -- Bank group
		mem_cke              => MEM1_CKE_O,                     -- Clock enable
		mem_cs_n             => MEM1_CS_N_O,                    -- Chip select
		mem_odt              => MEM1_ODT_O,                     -- On-die termination
		mem_reset_n          => MEM1_RESET_N_O,                 -- Asynchronous reset
		mem_par              => MEM1_PAR_O,                     -- Command and address parity
		mem_alert_n          => MEM1_ALERT_N_I,                 -- Alert flag
		mem_dqs              => MEM1_DQS_IO,                    -- Data strobe
		mem_dqs_n            => MEM1_DQS_N_IO,                  -- Data strobe (negative leg)
		mem_dq               => MEM1_DQ_IO,                     -- Read/write data
		mem_dbi_n            => MEM1_DBI_N_IO,                  -- Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		local_cal_success    => LOCAL_CAL_SUCCESS_1_O,           -- When high, indicates that PHY calibration was successful
		local_cal_fail       => LOCAL_CAL_FAIL_1_O,              -- When high, indicates that PHY calibration failed
		emif_usr_reset_n     => EMIF_USER_RESET_N_1_O,           -- Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		emif_usr_clk         => EMIF_USR_CLK_1_O,                -- User clock domain
		amm_ready_0          => AMM_READY_1_O,                   -- Wait-request is asserted when controller is busy
		amm_read_0           => AMM_READ_1_I,                    -- Read request signal
		amm_write_0          => AMM_WRITE_1_I,                   -- Write request signal
		amm_address_0        => amm_address_1_s,                 -- Address for the read/write request
		amm_readdata_0       => AMM_READDATA_1_O,                -- Read data
		amm_writedata_0      => AMM_WRITEDATA_1_I,               -- Write data
		amm_burstcount_0     => AMM_BURSTCOUNT_1_I,              -- Number of transfers in each read/write burst
		amm_byteenable_0     => AMM_BYTEENABLE_1_I,              -- Byte-enable for write data
		amm_readdatavalid_0  => AMM_READDATAVALID_1_O,           -- Indicates whether read data is valid
		calbus_read          => calbus_read_1_s,               --  emif_calbus.calbus_read,          Calibration bus read
		calbus_write         => calbus_write_1_s,              --  .calbus_write,         Calibration bus write
		calbus_address       => calbus_address_1_s,            --  .calbus_address,       Calibration bus address
		calbus_wdata         => calbus_wdata_1_s,              --  .calbus_wdata,         Calibration bus write data
		calbus_rdata         => calbus_rdata_1_s,              --  .calbus_rdata,         Calibration bus read data
		calbus_seq_param_tbl => calbus_seq_param_tbl_1_s,      --  .calbus_seq_param_tbl, Calibration bus param table data
		calbus_clk           => calbus_clk_s                   --  emif_calbus_clk.clk,                  Calibration bus clock      
      );            
      
      
      
-- concurrent assignment
amm_addr_0 : amm_address_0_s <= '0' & AMM_ADDRESS_0_I;
amm_writedata_0: amm_writedata_0_s <= "0000000000000000000000000000000000000000000000000000000000000000" & AMM_WRITEDATA_0_I;
amm_byteenable_0: amm_byteenable_0_s <= "00000000" & AMM_BYTEENABLE_0_I;
amm_readdata_0: AMM_READDATA_0_O <= amm_readdata_0_s(511 downto 0);
amm_addr_1 : amm_address_1_s <= '0' & AMM_ADDRESS_1_I;

end struc; -- of fdas_ddr_controller_calibration_hps
