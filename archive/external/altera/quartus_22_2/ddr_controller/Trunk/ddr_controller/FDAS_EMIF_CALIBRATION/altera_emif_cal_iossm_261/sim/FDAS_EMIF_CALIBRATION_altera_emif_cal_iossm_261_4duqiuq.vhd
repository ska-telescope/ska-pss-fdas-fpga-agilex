library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq is
   generic (
      NUM_CALBUS_USED                                    : integer                                  := 0;
      USE_SYNTH_FOR_SIM                                  : integer                                  := 0;
      USE_SOFT_NIOS                                      : integer                                  := 0;
      IOSSM_SIM_NIOS_PERIOD_PS                           : integer                                  := 0;
      SEQ_GPT_GLOBAL_PAR_VER                             : integer                                  := 0;
      SEQ_GPT_NIOS_C_VER                                 : integer                                  := 0;
      SEQ_GPT_COLUMN_ID                                  : integer                                  := 0;
      SEQ_GPT_NUM_IOPACKS                                : integer                                  := 0;
      SEQ_GPT_NIOS_CLK_FREQ_KHZ                          : integer                                  := 0;
      SIM_SEQ_GPT_NIOS_CLK_FREQ_KHZ                      : integer                                  := 0;
      SEQ_GPT_PARAM_TABLE_SIZE                           : integer                                  := 0;
      SEQ_GPT_GLOBAL_SKIP_STEPS                          : integer                                  := 0;
      SIM_SEQ_GPT_GLOBAL_SKIP_STEPS                      : integer                                  := 0;
      SEQ_GPT_GLOBAL_CAL_CONFIG                          : integer                                  := 0;
      SEQ_GPT_SLAVE_CLK_DIVIDER                          : integer                                  := 0;
      PORT_CAL_DEBUG_ADDRESS_WIDTH                       : integer                                  := 0;
      PORT_CAL_DEBUG_RDATA_WIDTH                         : integer                                  := 0;
      PORT_CAL_DEBUG_WDATA_WIDTH                         : integer                                  := 0;
      PORT_CAL_DEBUG_BYTEEN_WIDTH                        : integer                                  := 0;
      PORT_CALBUS_ADDRESS_WIDTH                          : integer                                  := 0;
      PORT_CALBUS_WDATA_WIDTH                            : integer                                  := 0;
      PORT_CALBUS_RDATA_WIDTH                            : integer                                  := 0;
      PORT_CALBUS_SEQ_PARAM_TBL_WIDTH                    : integer                                  := 0;
      PORT_VJI_IR_IN_WIDTH                               : integer                                  := 0;
      PORT_VJI_IR_OUT_WIDTH                              : integer                                  := 0
   );
   port (
      cal_debug_waitrequest          : out   std_logic;
      cal_debug_read                 : in    std_logic;
      cal_debug_write                : in    std_logic;
      cal_debug_addr                 : in    std_logic_vector(26 downto 0);
      cal_debug_read_data            : out   std_logic_vector(31 downto 0);
      cal_debug_write_data           : in    std_logic_vector(31 downto 0);
      cal_debug_byteenable           : in    std_logic_vector(3 downto 0);
      cal_debug_read_data_valid      : out   std_logic;
      cal_debug_clk                  : in    std_logic;
      cal_debug_reset_n              : in    std_logic;
      calbus_read_0                  : out   std_logic;
      calbus_write_0                 : out   std_logic;
      calbus_address_0               : out   std_logic_vector(19 downto 0);
      calbus_wdata_0                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_0                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_0         : in    std_logic_vector(4095 downto 0);
      calbus_read_1                  : out   std_logic;
      calbus_write_1                 : out   std_logic;
      calbus_address_1               : out   std_logic_vector(19 downto 0);
      calbus_wdata_1                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_1                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_1         : in    std_logic_vector(4095 downto 0);
      calbus_read_2                  : out   std_logic;
      calbus_write_2                 : out   std_logic;
      calbus_address_2               : out   std_logic_vector(19 downto 0);
      calbus_wdata_2                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_2                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_2         : in    std_logic_vector(4095 downto 0);
      calbus_read_3                  : out   std_logic;
      calbus_write_3                 : out   std_logic;
      calbus_address_3               : out   std_logic_vector(19 downto 0);
      calbus_wdata_3                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_3                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_3         : in    std_logic_vector(4095 downto 0);
      calbus_read_4                  : out   std_logic;
      calbus_write_4                 : out   std_logic;
      calbus_address_4               : out   std_logic_vector(19 downto 0);
      calbus_wdata_4                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_4                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_4         : in    std_logic_vector(4095 downto 0);
      calbus_read_5                  : out   std_logic;
      calbus_write_5                 : out   std_logic;
      calbus_address_5               : out   std_logic_vector(19 downto 0);
      calbus_wdata_5                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_5                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_5         : in    std_logic_vector(4095 downto 0);
      calbus_read_6                  : out   std_logic;
      calbus_write_6                 : out   std_logic;
      calbus_address_6               : out   std_logic_vector(19 downto 0);
      calbus_wdata_6                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_6                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_6         : in    std_logic_vector(4095 downto 0);
      calbus_read_7                  : out   std_logic;
      calbus_write_7                 : out   std_logic;
      calbus_address_7               : out   std_logic_vector(19 downto 0);
      calbus_wdata_7                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_7                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_7         : in    std_logic_vector(4095 downto 0);
      calbus_read_8                  : out   std_logic;
      calbus_write_8                 : out   std_logic;
      calbus_address_8               : out   std_logic_vector(19 downto 0);
      calbus_wdata_8                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_8                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_8         : in    std_logic_vector(4095 downto 0);
      calbus_read_9                  : out   std_logic;
      calbus_write_9                 : out   std_logic;
      calbus_address_9               : out   std_logic_vector(19 downto 0);
      calbus_wdata_9                 : out   std_logic_vector(31 downto 0);
      calbus_rdata_9                 : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_9         : in    std_logic_vector(4095 downto 0);
      calbus_read_10                 : out   std_logic;
      calbus_write_10                : out   std_logic;
      calbus_address_10              : out   std_logic_vector(19 downto 0);
      calbus_wdata_10                : out   std_logic_vector(31 downto 0);
      calbus_rdata_10                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_10        : in    std_logic_vector(4095 downto 0);
      calbus_read_11                 : out   std_logic;
      calbus_write_11                : out   std_logic;
      calbus_address_11              : out   std_logic_vector(19 downto 0);
      calbus_wdata_11                : out   std_logic_vector(31 downto 0);
      calbus_rdata_11                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_11        : in    std_logic_vector(4095 downto 0);
      calbus_read_12                 : out   std_logic;
      calbus_write_12                : out   std_logic;
      calbus_address_12              : out   std_logic_vector(19 downto 0);
      calbus_wdata_12                : out   std_logic_vector(31 downto 0);
      calbus_rdata_12                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_12        : in    std_logic_vector(4095 downto 0);
      calbus_read_13                 : out   std_logic;
      calbus_write_13                : out   std_logic;
      calbus_address_13              : out   std_logic_vector(19 downto 0);
      calbus_wdata_13                : out   std_logic_vector(31 downto 0);
      calbus_rdata_13                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_13        : in    std_logic_vector(4095 downto 0);
      calbus_read_14                 : out   std_logic;
      calbus_write_14                : out   std_logic;
      calbus_address_14              : out   std_logic_vector(19 downto 0);
      calbus_wdata_14                : out   std_logic_vector(31 downto 0);
      calbus_rdata_14                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_14        : in    std_logic_vector(4095 downto 0);
      calbus_read_15                 : out   std_logic;
      calbus_write_15                : out   std_logic;
      calbus_address_15              : out   std_logic_vector(19 downto 0);
      calbus_wdata_15                : out   std_logic_vector(31 downto 0);
      calbus_rdata_15                : in    std_logic_vector(31 downto 0);
      calbus_seq_param_tbl_15        : in    std_logic_vector(4095 downto 0);
      calbus_clk                     : out   std_logic;
      vji_ir_in                      : in    std_logic_vector(1 downto 0);
      vji_ir_out                     : out   std_logic_vector(1 downto 0);
      vji_jtag_state_rti             : in    std_logic;
      vji_tck                        : in    std_logic;
      vji_tdi                        : in    std_logic;
      vji_tdo                        : out   std_logic;
      vji_virtual_state_cdr          : in    std_logic;
      vji_virtual_state_sdr          : in    std_logic;
      vji_virtual_state_udr          : in    std_logic;
      vji_virtual_state_uir          : in    std_logic
   );
end entity FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq;

architecture rtl of FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq is
   component FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_arch is
      generic (
         NUM_CALBUS_USED                                    : integer                                  := 0;
         USE_SYNTH_FOR_SIM                                  : integer                                  := 0;
         USE_SOFT_NIOS                                      : integer                                  := 0;
         IOSSM_SIM_NIOS_PERIOD_PS                           : integer                                  := 0;
         SEQ_GPT_GLOBAL_PAR_VER                             : integer                                  := 0;
         SEQ_GPT_NIOS_C_VER                                 : integer                                  := 0;
         SEQ_GPT_COLUMN_ID                                  : integer                                  := 0;
         SEQ_GPT_NUM_IOPACKS                                : integer                                  := 0;
         SEQ_GPT_NIOS_CLK_FREQ_KHZ                          : integer                                  := 0;
         SIM_SEQ_GPT_NIOS_CLK_FREQ_KHZ                      : integer                                  := 0;
         SEQ_GPT_PARAM_TABLE_SIZE                           : integer                                  := 0;
         SEQ_GPT_GLOBAL_SKIP_STEPS                          : integer                                  := 0;
         SIM_SEQ_GPT_GLOBAL_SKIP_STEPS                      : integer                                  := 0;
         SEQ_GPT_GLOBAL_CAL_CONFIG                          : integer                                  := 0;
         SEQ_GPT_SLAVE_CLK_DIVIDER                          : integer                                  := 0;
         PORT_CAL_DEBUG_ADDRESS_WIDTH                       : integer                                  := 0;
         PORT_CAL_DEBUG_RDATA_WIDTH                         : integer                                  := 0;
         PORT_CAL_DEBUG_WDATA_WIDTH                         : integer                                  := 0;
         PORT_CAL_DEBUG_BYTEEN_WIDTH                        : integer                                  := 0;
         PORT_CALBUS_ADDRESS_WIDTH                          : integer                                  := 0;
         PORT_CALBUS_WDATA_WIDTH                            : integer                                  := 0;
         PORT_CALBUS_RDATA_WIDTH                            : integer                                  := 0;
         PORT_CALBUS_SEQ_PARAM_TBL_WIDTH                    : integer                                  := 0;
         PORT_VJI_IR_IN_WIDTH                               : integer                                  := 0;
         PORT_VJI_IR_OUT_WIDTH                              : integer                                  := 0;
         SEQ_USE_SIM_PARAMS                                 : string                                   := "";
         IOSSM_CODE_HEX_FILENAME                            : string                                   := "";
         IOSSM_SIM_GPT_HEX_FILENAME                         : string                                   := "";
         IOSSM_SYNTH_GPT_HEX_FILENAME                       : string                                   := ""
      );
      port (
         cal_debug_waitrequest          : out   std_logic;
         cal_debug_read                 : in    std_logic;
         cal_debug_write                : in    std_logic;
         cal_debug_addr                 : in    std_logic_vector(26 downto 0);
         cal_debug_read_data            : out   std_logic_vector(31 downto 0);
         cal_debug_write_data           : in    std_logic_vector(31 downto 0);
         cal_debug_byteenable           : in    std_logic_vector(3 downto 0);
         cal_debug_read_data_valid      : out   std_logic;
         cal_debug_clk                  : in    std_logic;
         cal_debug_reset_n              : in    std_logic;
         calbus_read_0                  : out   std_logic;
         calbus_write_0                 : out   std_logic;
         calbus_address_0               : out   std_logic_vector(19 downto 0);
         calbus_wdata_0                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_0                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_0         : in    std_logic_vector(4095 downto 0);
         calbus_read_1                  : out   std_logic;
         calbus_write_1                 : out   std_logic;
         calbus_address_1               : out   std_logic_vector(19 downto 0);
         calbus_wdata_1                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_1                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_1         : in    std_logic_vector(4095 downto 0);
         calbus_read_2                  : out   std_logic;
         calbus_write_2                 : out   std_logic;
         calbus_address_2               : out   std_logic_vector(19 downto 0);
         calbus_wdata_2                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_2                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_2         : in    std_logic_vector(4095 downto 0);
         calbus_read_3                  : out   std_logic;
         calbus_write_3                 : out   std_logic;
         calbus_address_3               : out   std_logic_vector(19 downto 0);
         calbus_wdata_3                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_3                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_3         : in    std_logic_vector(4095 downto 0);
         calbus_read_4                  : out   std_logic;
         calbus_write_4                 : out   std_logic;
         calbus_address_4               : out   std_logic_vector(19 downto 0);
         calbus_wdata_4                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_4                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_4         : in    std_logic_vector(4095 downto 0);
         calbus_read_5                  : out   std_logic;
         calbus_write_5                 : out   std_logic;
         calbus_address_5               : out   std_logic_vector(19 downto 0);
         calbus_wdata_5                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_5                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_5         : in    std_logic_vector(4095 downto 0);
         calbus_read_6                  : out   std_logic;
         calbus_write_6                 : out   std_logic;
         calbus_address_6               : out   std_logic_vector(19 downto 0);
         calbus_wdata_6                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_6                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_6         : in    std_logic_vector(4095 downto 0);
         calbus_read_7                  : out   std_logic;
         calbus_write_7                 : out   std_logic;
         calbus_address_7               : out   std_logic_vector(19 downto 0);
         calbus_wdata_7                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_7                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_7         : in    std_logic_vector(4095 downto 0);
         calbus_read_8                  : out   std_logic;
         calbus_write_8                 : out   std_logic;
         calbus_address_8               : out   std_logic_vector(19 downto 0);
         calbus_wdata_8                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_8                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_8         : in    std_logic_vector(4095 downto 0);
         calbus_read_9                  : out   std_logic;
         calbus_write_9                 : out   std_logic;
         calbus_address_9               : out   std_logic_vector(19 downto 0);
         calbus_wdata_9                 : out   std_logic_vector(31 downto 0);
         calbus_rdata_9                 : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_9         : in    std_logic_vector(4095 downto 0);
         calbus_read_10                 : out   std_logic;
         calbus_write_10                : out   std_logic;
         calbus_address_10              : out   std_logic_vector(19 downto 0);
         calbus_wdata_10                : out   std_logic_vector(31 downto 0);
         calbus_rdata_10                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_10        : in    std_logic_vector(4095 downto 0);
         calbus_read_11                 : out   std_logic;
         calbus_write_11                : out   std_logic;
         calbus_address_11              : out   std_logic_vector(19 downto 0);
         calbus_wdata_11                : out   std_logic_vector(31 downto 0);
         calbus_rdata_11                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_11        : in    std_logic_vector(4095 downto 0);
         calbus_read_12                 : out   std_logic;
         calbus_write_12                : out   std_logic;
         calbus_address_12              : out   std_logic_vector(19 downto 0);
         calbus_wdata_12                : out   std_logic_vector(31 downto 0);
         calbus_rdata_12                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_12        : in    std_logic_vector(4095 downto 0);
         calbus_read_13                 : out   std_logic;
         calbus_write_13                : out   std_logic;
         calbus_address_13              : out   std_logic_vector(19 downto 0);
         calbus_wdata_13                : out   std_logic_vector(31 downto 0);
         calbus_rdata_13                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_13        : in    std_logic_vector(4095 downto 0);
         calbus_read_14                 : out   std_logic;
         calbus_write_14                : out   std_logic;
         calbus_address_14              : out   std_logic_vector(19 downto 0);
         calbus_wdata_14                : out   std_logic_vector(31 downto 0);
         calbus_rdata_14                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_14        : in    std_logic_vector(4095 downto 0);
         calbus_read_15                 : out   std_logic;
         calbus_write_15                : out   std_logic;
         calbus_address_15              : out   std_logic_vector(19 downto 0);
         calbus_wdata_15                : out   std_logic_vector(31 downto 0);
         calbus_rdata_15                : in    std_logic_vector(31 downto 0);
         calbus_seq_param_tbl_15        : in    std_logic_vector(4095 downto 0);
         calbus_clk                     : out   std_logic;
         vji_ir_in                      : in    std_logic_vector(1 downto 0);
         vji_ir_out                     : out   std_logic_vector(1 downto 0);
         vji_jtag_state_rti             : in    std_logic;
         vji_tck                        : in    std_logic;
         vji_tdi                        : in    std_logic;
         vji_tdo                        : out   std_logic;
         vji_virtual_state_cdr          : in    std_logic;
         vji_virtual_state_sdr          : in    std_logic;
         vji_virtual_state_udr          : in    std_logic;
         vji_virtual_state_uir          : in    std_logic
      );
   end component FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_arch;

begin
   arch_inst : component FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_arch
      generic map (
         NUM_CALBUS_USED => NUM_CALBUS_USED,
         USE_SYNTH_FOR_SIM => USE_SYNTH_FOR_SIM,
         USE_SOFT_NIOS => USE_SOFT_NIOS,
         IOSSM_SIM_NIOS_PERIOD_PS => IOSSM_SIM_NIOS_PERIOD_PS,
         SEQ_GPT_GLOBAL_PAR_VER => SEQ_GPT_GLOBAL_PAR_VER,
         SEQ_GPT_NIOS_C_VER => SEQ_GPT_NIOS_C_VER,
         SEQ_GPT_COLUMN_ID => SEQ_GPT_COLUMN_ID,
         SEQ_GPT_NUM_IOPACKS => SEQ_GPT_NUM_IOPACKS,
         SEQ_GPT_NIOS_CLK_FREQ_KHZ => SEQ_GPT_NIOS_CLK_FREQ_KHZ,
         SIM_SEQ_GPT_NIOS_CLK_FREQ_KHZ => SIM_SEQ_GPT_NIOS_CLK_FREQ_KHZ,
         SEQ_GPT_PARAM_TABLE_SIZE => SEQ_GPT_PARAM_TABLE_SIZE,
         SEQ_GPT_GLOBAL_SKIP_STEPS => SEQ_GPT_GLOBAL_SKIP_STEPS,
         SIM_SEQ_GPT_GLOBAL_SKIP_STEPS => SIM_SEQ_GPT_GLOBAL_SKIP_STEPS,
         SEQ_GPT_GLOBAL_CAL_CONFIG => SEQ_GPT_GLOBAL_CAL_CONFIG,
         SEQ_GPT_SLAVE_CLK_DIVIDER => SEQ_GPT_SLAVE_CLK_DIVIDER,
         PORT_CAL_DEBUG_ADDRESS_WIDTH => PORT_CAL_DEBUG_ADDRESS_WIDTH,
         PORT_CAL_DEBUG_RDATA_WIDTH => PORT_CAL_DEBUG_RDATA_WIDTH,
         PORT_CAL_DEBUG_WDATA_WIDTH => PORT_CAL_DEBUG_WDATA_WIDTH,
         PORT_CAL_DEBUG_BYTEEN_WIDTH => PORT_CAL_DEBUG_BYTEEN_WIDTH,
         PORT_CALBUS_ADDRESS_WIDTH => PORT_CALBUS_ADDRESS_WIDTH,
         PORT_CALBUS_WDATA_WIDTH => PORT_CALBUS_WDATA_WIDTH,
         PORT_CALBUS_RDATA_WIDTH => PORT_CALBUS_RDATA_WIDTH,
         PORT_CALBUS_SEQ_PARAM_TBL_WIDTH => PORT_CALBUS_SEQ_PARAM_TBL_WIDTH,
         PORT_VJI_IR_IN_WIDTH => PORT_VJI_IR_IN_WIDTH,
         PORT_VJI_IR_OUT_WIDTH => PORT_VJI_IR_OUT_WIDTH,
         SEQ_USE_SIM_PARAMS => "on",
         IOSSM_CODE_HEX_FILENAME => "FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_code.hex",
         IOSSM_SIM_GPT_HEX_FILENAME => "FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_sim_global_param_tbl.hex",
         IOSSM_SYNTH_GPT_HEX_FILENAME => "FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_261_4duqiuq_synth_global_param_tbl.hex"
      )
      port map (
         cal_debug_waitrequest => cal_debug_waitrequest,
         cal_debug_read => cal_debug_read,
         cal_debug_write => cal_debug_write,
         cal_debug_addr => cal_debug_addr,
         cal_debug_read_data => cal_debug_read_data,
         cal_debug_write_data => cal_debug_write_data,
         cal_debug_byteenable => cal_debug_byteenable,
         cal_debug_read_data_valid => cal_debug_read_data_valid,
         cal_debug_clk => cal_debug_clk,
         cal_debug_reset_n => cal_debug_reset_n,
         calbus_read_0 => calbus_read_0,
         calbus_write_0 => calbus_write_0,
         calbus_address_0 => calbus_address_0,
         calbus_wdata_0 => calbus_wdata_0,
         calbus_rdata_0 => calbus_rdata_0,
         calbus_seq_param_tbl_0 => calbus_seq_param_tbl_0,
         calbus_read_1 => calbus_read_1,
         calbus_write_1 => calbus_write_1,
         calbus_address_1 => calbus_address_1,
         calbus_wdata_1 => calbus_wdata_1,
         calbus_rdata_1 => calbus_rdata_1,
         calbus_seq_param_tbl_1 => calbus_seq_param_tbl_1,
         calbus_read_2 => calbus_read_2,
         calbus_write_2 => calbus_write_2,
         calbus_address_2 => calbus_address_2,
         calbus_wdata_2 => calbus_wdata_2,
         calbus_rdata_2 => calbus_rdata_2,
         calbus_seq_param_tbl_2 => calbus_seq_param_tbl_2,
         calbus_read_3 => calbus_read_3,
         calbus_write_3 => calbus_write_3,
         calbus_address_3 => calbus_address_3,
         calbus_wdata_3 => calbus_wdata_3,
         calbus_rdata_3 => calbus_rdata_3,
         calbus_seq_param_tbl_3 => calbus_seq_param_tbl_3,
         calbus_read_4 => calbus_read_4,
         calbus_write_4 => calbus_write_4,
         calbus_address_4 => calbus_address_4,
         calbus_wdata_4 => calbus_wdata_4,
         calbus_rdata_4 => calbus_rdata_4,
         calbus_seq_param_tbl_4 => calbus_seq_param_tbl_4,
         calbus_read_5 => calbus_read_5,
         calbus_write_5 => calbus_write_5,
         calbus_address_5 => calbus_address_5,
         calbus_wdata_5 => calbus_wdata_5,
         calbus_rdata_5 => calbus_rdata_5,
         calbus_seq_param_tbl_5 => calbus_seq_param_tbl_5,
         calbus_read_6 => calbus_read_6,
         calbus_write_6 => calbus_write_6,
         calbus_address_6 => calbus_address_6,
         calbus_wdata_6 => calbus_wdata_6,
         calbus_rdata_6 => calbus_rdata_6,
         calbus_seq_param_tbl_6 => calbus_seq_param_tbl_6,
         calbus_read_7 => calbus_read_7,
         calbus_write_7 => calbus_write_7,
         calbus_address_7 => calbus_address_7,
         calbus_wdata_7 => calbus_wdata_7,
         calbus_rdata_7 => calbus_rdata_7,
         calbus_seq_param_tbl_7 => calbus_seq_param_tbl_7,
         calbus_read_8 => calbus_read_8,
         calbus_write_8 => calbus_write_8,
         calbus_address_8 => calbus_address_8,
         calbus_wdata_8 => calbus_wdata_8,
         calbus_rdata_8 => calbus_rdata_8,
         calbus_seq_param_tbl_8 => calbus_seq_param_tbl_8,
         calbus_read_9 => calbus_read_9,
         calbus_write_9 => calbus_write_9,
         calbus_address_9 => calbus_address_9,
         calbus_wdata_9 => calbus_wdata_9,
         calbus_rdata_9 => calbus_rdata_9,
         calbus_seq_param_tbl_9 => calbus_seq_param_tbl_9,
         calbus_read_10 => calbus_read_10,
         calbus_write_10 => calbus_write_10,
         calbus_address_10 => calbus_address_10,
         calbus_wdata_10 => calbus_wdata_10,
         calbus_rdata_10 => calbus_rdata_10,
         calbus_seq_param_tbl_10 => calbus_seq_param_tbl_10,
         calbus_read_11 => calbus_read_11,
         calbus_write_11 => calbus_write_11,
         calbus_address_11 => calbus_address_11,
         calbus_wdata_11 => calbus_wdata_11,
         calbus_rdata_11 => calbus_rdata_11,
         calbus_seq_param_tbl_11 => calbus_seq_param_tbl_11,
         calbus_read_12 => calbus_read_12,
         calbus_write_12 => calbus_write_12,
         calbus_address_12 => calbus_address_12,
         calbus_wdata_12 => calbus_wdata_12,
         calbus_rdata_12 => calbus_rdata_12,
         calbus_seq_param_tbl_12 => calbus_seq_param_tbl_12,
         calbus_read_13 => calbus_read_13,
         calbus_write_13 => calbus_write_13,
         calbus_address_13 => calbus_address_13,
         calbus_wdata_13 => calbus_wdata_13,
         calbus_rdata_13 => calbus_rdata_13,
         calbus_seq_param_tbl_13 => calbus_seq_param_tbl_13,
         calbus_read_14 => calbus_read_14,
         calbus_write_14 => calbus_write_14,
         calbus_address_14 => calbus_address_14,
         calbus_wdata_14 => calbus_wdata_14,
         calbus_rdata_14 => calbus_rdata_14,
         calbus_seq_param_tbl_14 => calbus_seq_param_tbl_14,
         calbus_read_15 => calbus_read_15,
         calbus_write_15 => calbus_write_15,
         calbus_address_15 => calbus_address_15,
         calbus_wdata_15 => calbus_wdata_15,
         calbus_rdata_15 => calbus_rdata_15,
         calbus_seq_param_tbl_15 => calbus_seq_param_tbl_15,
         calbus_clk => calbus_clk,
         vji_ir_in => vji_ir_in,
         vji_ir_out => vji_ir_out,
         vji_jtag_state_rti => vji_jtag_state_rti,
         vji_tck => vji_tck,
         vji_tdi => vji_tdi,
         vji_tdo => vji_tdo,
         vji_virtual_state_cdr => vji_virtual_state_cdr,
         vji_virtual_state_sdr => vji_virtual_state_sdr,
         vji_virtual_state_udr => vji_virtual_state_udr,
         vji_virtual_state_uir => vji_virtual_state_uir
      );
end architecture rtl;
