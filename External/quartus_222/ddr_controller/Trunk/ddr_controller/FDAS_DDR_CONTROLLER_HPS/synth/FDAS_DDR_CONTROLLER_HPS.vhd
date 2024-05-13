-- FDAS_DDR_CONTROLLER_HPS.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
library altera_emif_fm_261;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FDAS_DDR_CONTROLLER_HPS is
	port (
		local_reset_req           : in    std_logic                       := '0';             --           local_reset_req.local_reset_req,         Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		local_reset_done          : out   std_logic;                                          --        local_reset_status.local_reset_done,        Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
		pll_ref_clk               : in    std_logic                       := '0';             --               pll_ref_clk.clk,                     PLL reference clock input
		oct_rzqin                 : in    std_logic                       := '0';             --                       oct.oct_rzqin,               Calibrated On-Chip Termination (OCT) RZQ input pin
		mem_ck                    : out   std_logic_vector(0 downto 0);                       --                       mem.mem_ck,                  CK clock
		mem_ck_n                  : out   std_logic_vector(0 downto 0);                       --                          .mem_ck_n,                CK clock (negative leg)
		mem_a                     : out   std_logic_vector(16 downto 0);                      --                          .mem_a,                   Address
		mem_act_n                 : out   std_logic_vector(0 downto 0);                       --                          .mem_act_n,               Activation command
		mem_ba                    : out   std_logic_vector(1 downto 0);                       --                          .mem_ba,                  Bank address
		mem_bg                    : out   std_logic_vector(1 downto 0);                       --                          .mem_bg,                  Bank group
		mem_cke                   : out   std_logic_vector(0 downto 0);                       --                          .mem_cke,                 Clock enable
		mem_cs_n                  : out   std_logic_vector(0 downto 0);                       --                          .mem_cs_n,                Chip select
		mem_odt                   : out   std_logic_vector(0 downto 0);                       --                          .mem_odt,                 On-die termination
		mem_reset_n               : out   std_logic_vector(0 downto 0);                       --                          .mem_reset_n,             Asynchronous reset
		mem_par                   : out   std_logic_vector(0 downto 0);                       --                          .mem_par,                 Command and address parity
		mem_alert_n               : in    std_logic_vector(0 downto 0)    := (others => '0'); --                          .mem_alert_n,             Alert flag
		mem_dqs                   : inout std_logic_vector(8 downto 0)    := (others => '0'); --                          .mem_dqs,                 Data strobe
		mem_dqs_n                 : inout std_logic_vector(8 downto 0)    := (others => '0'); --                          .mem_dqs_n,               Data strobe (negative leg)
		mem_dq                    : inout std_logic_vector(71 downto 0)   := (others => '0'); --                          .mem_dq,                  Read/write data
		mem_dbi_n                 : inout std_logic_vector(8 downto 0)    := (others => '0'); --                          .mem_dbi_n,               Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		local_cal_success         : out   std_logic;                                          --                    status.local_cal_success,       When high, indicates that PHY calibration was successful
		local_cal_fail            : out   std_logic;                                          --                          .local_cal_fail,          When high, indicates that PHY calibration failed
		calbus_read               : in    std_logic                       := '0';             --               emif_calbus.calbus_read,             EMIF Calibration component bus for read
		calbus_write              : in    std_logic                       := '0';             --                          .calbus_write,            EMIF Calibration component bus for write
		calbus_address            : in    std_logic_vector(19 downto 0)   := (others => '0'); --                          .calbus_address,          EMIF Calibration component bus for address
		calbus_wdata              : in    std_logic_vector(31 downto 0)   := (others => '0'); --                          .calbus_wdata,            EMIF Calibration component bus for write data
		calbus_rdata              : out   std_logic_vector(31 downto 0);                      --                          .calbus_rdata,            EMIF Calibration component bus for read data
		calbus_seq_param_tbl      : out   std_logic_vector(4095 downto 0);                    --                          .calbus_seq_param_tbl,    EMIF Calibration component bus for parameter table data
		calbus_clk                : in    std_logic                       := '0';             --           emif_calbus_clk.clk,                     EMIF Calibration component bus for the clock
		emif_usr_reset_n          : out   std_logic;                                          --          emif_usr_reset_n.reset_n,                 Reset for the user clock domain. Asynchronous assertion and synchronous deassertion
		emif_usr_clk              : out   std_logic;                                          --              emif_usr_clk.clk,                     User clock domain
		ctrl_ecc_user_interrupt_0 : out   std_logic;                                          -- ctrl_ecc_user_interrupt_0.ctrl_ecc_user_interrupt, Controller ECC user interrupt signal to determine whether there is a bit error
		amm_ready_0               : out   std_logic;                                          --                ctrl_amm_0.waitrequest_n,           Wait-request is asserted when controller is busy
		amm_read_0                : in    std_logic                       := '0';             --                          .read,                    Read request signal
		amm_write_0               : in    std_logic                       := '0';             --                          .write,                   Write request signal
		amm_address_0             : in    std_logic_vector(26 downto 0)   := (others => '0'); --                          .address,                 Address for the read/write request
		amm_readdata_0            : out   std_logic_vector(511 downto 0);                     --                          .readdata,                Read data
		amm_writedata_0           : in    std_logic_vector(511 downto 0)  := (others => '0'); --                          .writedata,               Write data
		amm_burstcount_0          : in    std_logic_vector(6 downto 0)    := (others => '0'); --                          .burstcount,              Number of transfers in each read/write burst
		amm_byteenable_0          : in    std_logic_vector(63 downto 0)   := (others => '0'); --                          .byteenable,              Byte-enable for write data
		amm_readdatavalid_0       : out   std_logic                                           --                          .readdatavalid,           Indicates whether read data is valid
	);
end entity FDAS_DDR_CONTROLLER_HPS;

architecture rtl of FDAS_DDR_CONTROLLER_HPS is
	component FDAS_DDR_CONTROLLER_HPS_altera_emif_fm_261_lhg4c6i_cmp is
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
	end component FDAS_DDR_CONTROLLER_HPS_altera_emif_fm_261_lhg4c6i_cmp;

	for emif_fm_0 : FDAS_DDR_CONTROLLER_HPS_altera_emif_fm_261_lhg4c6i_cmp
		use entity altera_emif_fm_261.FDAS_DDR_CONTROLLER_HPS_altera_emif_fm_261_lhg4c6i;
begin

	emif_fm_0 : component FDAS_DDR_CONTROLLER_HPS_altera_emif_fm_261_lhg4c6i_cmp
		port map (
			local_reset_req           => local_reset_req,           --           local_reset_req.local_reset_req
			local_reset_done          => local_reset_done,          --        local_reset_status.local_reset_done
			pll_ref_clk               => pll_ref_clk,               --               pll_ref_clk.clk
			oct_rzqin                 => oct_rzqin,                 --                       oct.oct_rzqin
			mem_ck                    => mem_ck,                    --                       mem.mem_ck
			mem_ck_n                  => mem_ck_n,                  --                          .mem_ck_n
			mem_a                     => mem_a,                     --                          .mem_a
			mem_act_n                 => mem_act_n,                 --                          .mem_act_n
			mem_ba                    => mem_ba,                    --                          .mem_ba
			mem_bg                    => mem_bg,                    --                          .mem_bg
			mem_cke                   => mem_cke,                   --                          .mem_cke
			mem_cs_n                  => mem_cs_n,                  --                          .mem_cs_n
			mem_odt                   => mem_odt,                   --                          .mem_odt
			mem_reset_n               => mem_reset_n,               --                          .mem_reset_n
			mem_par                   => mem_par,                   --                          .mem_par
			mem_alert_n               => mem_alert_n,               --                          .mem_alert_n
			mem_dqs                   => mem_dqs,                   --                          .mem_dqs
			mem_dqs_n                 => mem_dqs_n,                 --                          .mem_dqs_n
			mem_dq                    => mem_dq,                    --                          .mem_dq
			mem_dbi_n                 => mem_dbi_n,                 --                          .mem_dbi_n
			local_cal_success         => local_cal_success,         --                    status.local_cal_success
			local_cal_fail            => local_cal_fail,            --                          .local_cal_fail
			calbus_read               => calbus_read,               --               emif_calbus.calbus_read
			calbus_write              => calbus_write,              --                          .calbus_write
			calbus_address            => calbus_address,            --                          .calbus_address
			calbus_wdata              => calbus_wdata,              --                          .calbus_wdata
			calbus_rdata              => calbus_rdata,              --                          .calbus_rdata
			calbus_seq_param_tbl      => calbus_seq_param_tbl,      --                          .calbus_seq_param_tbl
			calbus_clk                => calbus_clk,                --           emif_calbus_clk.clk
			emif_usr_reset_n          => emif_usr_reset_n,          --          emif_usr_reset_n.reset_n
			emif_usr_clk              => emif_usr_clk,              --              emif_usr_clk.clk
			ctrl_ecc_user_interrupt_0 => ctrl_ecc_user_interrupt_0, -- ctrl_ecc_user_interrupt_0.ctrl_ecc_user_interrupt
			amm_ready_0               => amm_ready_0,               --                ctrl_amm_0.waitrequest_n
			amm_read_0                => amm_read_0,                --                          .read
			amm_write_0               => amm_write_0,               --                          .write
			amm_address_0             => amm_address_0,             --                          .address
			amm_readdata_0            => amm_readdata_0,            --                          .readdata
			amm_writedata_0           => amm_writedata_0,           --                          .writedata
			amm_burstcount_0          => amm_burstcount_0,          --                          .burstcount
			amm_byteenable_0          => amm_byteenable_0,          --                          .byteenable
			amm_readdatavalid_0       => amm_readdatavalid_0        --                          .readdatavalid
		);

end architecture rtl; -- of FDAS_DDR_CONTROLLER_HPS
