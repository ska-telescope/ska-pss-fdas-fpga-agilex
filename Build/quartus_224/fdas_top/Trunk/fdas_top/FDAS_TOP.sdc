# Virtually all constraints are created by the SDC files included by the IP macros.


set_false_path -from [get_ports {PIN_PERST_N}]


set_clock_groups -asynchronous \
  -group {clkgen_i|clkgen_macro|iopll_0_outclk0 } \
  -group {pcie_i|pcie_hard_ip_macro|intel_pcie_ptile_mcdma_0|intel_pcie_ptile_mcdma_0|ast_hip|intel_pcie_ptile_ast_hip|inst|inst|maib_and_tile|xcvr_hip_native|rx_ch15} \
  -group {ddr_controller_01|ddr_0|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_01|ddr_1|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_23|ddr_2|emif_fm_0_core_usr_clk} \
  -group {ddr_controller_23|ddr_3|emif_fm_0_core_usr_clk}




# Constrain asynchronous paths in DDRIF.
set_max_delay -to [get_pins fdas_core_i|ddrif*|*|wcode_rt*|*d*] 2.5
set_max_delay -to [get_pins fdas_core_i|ddrif*|*|rcode_rt*|*d*] 2.5
