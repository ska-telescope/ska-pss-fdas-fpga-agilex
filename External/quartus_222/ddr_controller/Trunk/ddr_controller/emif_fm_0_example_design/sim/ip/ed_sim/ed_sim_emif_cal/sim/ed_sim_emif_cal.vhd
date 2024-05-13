-- ed_sim_emif_cal.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
library altera_emif_cal_261;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ed_sim_emif_cal is
	port (
		calbus_read_0          : out std_logic;                                          --   emif_calbus_0.calbus_read,          EMIF Calibration component bus for read
		calbus_write_0         : out std_logic;                                          --                .calbus_write,         EMIF Calibration component bus for write
		calbus_address_0       : out std_logic_vector(19 downto 0);                      --                .calbus_address,       EMIF Calibration component bus for address
		calbus_wdata_0         : out std_logic_vector(31 downto 0);                      --                .calbus_wdata,         EMIF Calibration component bus for write data
		calbus_rdata_0         : in  std_logic_vector(31 downto 0)   := (others => '0'); --                .calbus_rdata,         EMIF Calibration component bus for read data
		calbus_seq_param_tbl_0 : in  std_logic_vector(4095 downto 0) := (others => '0'); --                .calbus_seq_param_tbl, EMIF Calibration component bus for parameter table data
		calbus_clk             : out std_logic                                           -- emif_calbus_clk.clk,                  EMIF Calibration component bus for the clock
	);
end entity ed_sim_emif_cal;

architecture rtl of ed_sim_emif_cal is
	component ed_sim_emif_cal_altera_emif_cal_261_smtnulq_cmp is
		port (
			calbus_read_0          : out std_logic;                                          -- calbus_read
			calbus_write_0         : out std_logic;                                          -- calbus_write
			calbus_address_0       : out std_logic_vector(19 downto 0);                      -- calbus_address
			calbus_wdata_0         : out std_logic_vector(31 downto 0);                      -- calbus_wdata
			calbus_rdata_0         : in  std_logic_vector(31 downto 0)   := (others => 'X'); -- calbus_rdata
			calbus_seq_param_tbl_0 : in  std_logic_vector(4095 downto 0) := (others => 'X'); -- calbus_seq_param_tbl
			calbus_clk             : out std_logic                                           -- clk
		);
	end component ed_sim_emif_cal_altera_emif_cal_261_smtnulq_cmp;

	for emif_cal : ed_sim_emif_cal_altera_emif_cal_261_smtnulq_cmp
		use entity altera_emif_cal_261.ed_sim_emif_cal_altera_emif_cal_261_smtnulq;
begin

	emif_cal : component ed_sim_emif_cal_altera_emif_cal_261_smtnulq_cmp
		port map (
			calbus_read_0          => calbus_read_0,          --   emif_calbus_0.calbus_read
			calbus_write_0         => calbus_write_0,         --                .calbus_write
			calbus_address_0       => calbus_address_0,       --                .calbus_address
			calbus_wdata_0         => calbus_wdata_0,         --                .calbus_wdata
			calbus_rdata_0         => calbus_rdata_0,         --                .calbus_rdata
			calbus_seq_param_tbl_0 => calbus_seq_param_tbl_0, --                .calbus_seq_param_tbl
			calbus_clk             => calbus_clk              -- emif_calbus_clk.clk
		);

end architecture rtl; -- of ed_sim_emif_cal
