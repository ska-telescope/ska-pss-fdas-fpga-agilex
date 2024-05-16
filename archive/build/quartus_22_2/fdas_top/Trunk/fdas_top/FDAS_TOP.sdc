# Virtually all constraints are created by the SDC files included by the IP macros.


set_false_path -from [get_ports {PIN_PERST_N}]
set_false_path -from fdas_core_i|core_reconf_i|rst_hsum_i|reset_n_s[2]
set_false_path -from fdas_core_i|rst_ddrif_pcie|reset_n_s[2]
set_false_path -from fdas_core_i|rst_ddrif_23_i|reset_n_s[2]
set_false_path -to fdas_core_i|ddrif0_i|data_fifo_512_2|*|*|*|*|*|aclr
set_false_path -to fdas_core_i|ddrif2_i|data_fifo_512_2|*|*|*|*|*|aclr
set_false_path -to fdas_core_i|ddrif3_i|data_fifo_512_2|*|*|*|*|*|aclr
set_false_path -to fdas_core_i|ddrif0_i|data_fifo_512_1|*|*|*|*|*|aclr
set_false_path -to fdas_core_i|ddrif2_i|data_fifo_512_1|*|*|*|*|*|aclr
set_false_path -to fdas_core_i|ddrif3_i|data_fifo_512_1|*|*|*|*|*|aclr

set_clock_groups -asynchronous \
  -group {clkgen_i|clkgen_macro|iopll_0_outclk0 } \
  -group {pcie_i|pcie_hard_ip_macro|intel_pcie_ptile_mcdma_0|intel_pcie_ptile_mcdma_0|ast_hip|intel_pcie_ptile_ast_hip|inst|inst|maib_and_tile|xcvr_hip_native|rx_ch15} \
  -group {ddr_controller_01|ddr_0|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_01|ddr_1|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_23|ddr_2|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_23|ddr_3|emif_fm_0_core_usr_clk}




# Constrain asynchronous paths in DDRIF.
set_max_delay -to [get_pins fdas_core_i|ddrif*|*|wcode_rt*|*d*] 4.0
set_max_delay -to [get_pins fdas_core_i|ddrif*|*|rcode_rt*|*d*] 4.0
