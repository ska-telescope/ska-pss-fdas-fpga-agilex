
proc get_design_libraries {} {
  set libraries [dict create]
  dict set libraries altera_emif_cal_iossm_261              1
  dict set libraries altera_emif_cal_261                    1
  dict set libraries ed_sim_emif_cal                        1
  dict set libraries altera_emif_arch_fm_191                1
  dict set libraries altera_emif_fm_261                     1
  dict set libraries ed_sim_emif_fm_0                       1
  dict set libraries altera_emif_local_reset_combiner_191   1
  dict set libraries ed_sim_local_reset_combiner            1
  dict set libraries altera_emif_local_reset_sim_source_191 1
  dict set libraries ed_sim_local_reset_source              1
  dict set libraries altera_emif_mem_model_core_ddr4_191    1
  dict set libraries altera_emif_mem_model_191              1
  dict set libraries ed_sim_mem                             1
  dict set libraries altera_s10_user_rst_clkgate_1932       1
  dict set libraries ed_sim_ninit_done                      1
  dict set libraries altera_avalon_clock_source_191         1
  dict set libraries ed_sim_pll_ref_clk_source              1
  dict set libraries altera_emif_sim_checker_191            1
  dict set libraries ed_sim_sim_checker                     1
  dict set libraries altera_emif_tg_avl_191                 1
  dict set libraries ed_sim_tg                              1
  dict set libraries altera_merlin_master_translator_191    1
  dict set libraries altera_merlin_slave_translator_191     1
  dict set libraries altera_mm_interconnect_1920            1
  dict set libraries altera_reset_controller_1921           1
  dict set libraries ed_sim                                 1
  return $libraries
}

proc get_memory_files {QSYS_SIMDIR} {
  set memory_files [list]
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/ed_sim_emif_cal_altera_emif_cal_iossm_261_ql6pb3a_code.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/ed_sim_emif_cal_altera_emif_cal_iossm_261_ql6pb3a_sim_global_param_tbl.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/ed_sim_emif_cal_altera_emif_cal_iossm_261_ql6pb3a_synth_global_param_tbl.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/ed_sim_emif_fm_0_altera_emif_arch_fm_191_vft647i_seq_params_synth.hex"]"
  return $memory_files
}

proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
  set design_files [dict create]
  return $design_files
}

proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
  set design_files [list]
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/altera_emif_cal_iossm.sv"]\"  -work altera_emif_cal_iossm_261"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/altera_emif_f2c_gearbox.sv"]\"  -work altera_emif_cal_iossm_261"                                               
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/ed_sim_emif_cal_altera_emif_cal_iossm_261_ql6pb3a_arch.sv"]\"  -work altera_emif_cal_iossm_261"                
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_iossm_261/sim/ed_sim_emif_cal_altera_emif_cal_iossm_261_ql6pb3a.vhd"]\"  -work altera_emif_cal_iossm_261"                           
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/altera_emif_cal_261/sim/ed_sim_emif_cal_altera_emif_cal_261_smtnulq.vhd"]\"  -work altera_emif_cal_261"                                             
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_cal/sim/ed_sim_emif_cal.vhd"]\"  -work ed_sim_emif_cal"                                                                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/ed_sim_emif_fm_0_altera_emif_arch_fm_191_vft647i_top.sv"]\"  -work altera_emif_arch_fm_191"                     
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_bufs.sv"]\"  -work altera_emif_arch_fm_191"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufis.sv"]\"  -work altera_emif_arch_fm_191"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_ufi_wrapper.sv"]\"  -work altera_emif_arch_fm_191"                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_i.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_se_o.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_i.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_df_o.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_udir_cp_i.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_df.sv"]\"  -work altera_emif_arch_fm_191"                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_bdir_se.sv"]\"  -work altera_emif_arch_fm_191"                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_buf_unused.sv"]\"  -work altera_emif_arch_fm_191"                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_cal_counter.sv"]\"  -work altera_emif_arch_fm_191"                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll.sv"]\"  -work altera_emif_arch_fm_191"                                                  
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_fast_sim.sv"]\"  -work altera_emif_arch_fm_191"                                         
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_pll_extra_clks.sv"]\"  -work altera_emif_arch_fm_191"                                       
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_oct.sv"]\"  -work altera_emif_arch_fm_191"                                                  
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_core_clks_rsts.sv"]\"  -work altera_emif_arch_fm_191"                                       
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hps_clks_rsts.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_local_reset.sv"]\"  -work altera_emif_arch_fm_191"                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles_wrap.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_tiles.sv"]\"  -work altera_emif_arch_fm_191"                                             
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_io_lane_remap.sv"]\"  -work altera_emif_arch_fm_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_avl_if.sv"]\"  -work altera_emif_arch_fm_191"                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_sideband_if.sv"]\"  -work altera_emif_arch_fm_191"                                      
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_mmr_if.sv"]\"  -work altera_emif_arch_fm_191"                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_amm_data_if.sv"]\"  -work altera_emif_arch_fm_191"                                      
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_phylite_if.sv"]\"  -work altera_emif_arch_fm_191"                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_hmc_ast_data_if.sv"]\"  -work altera_emif_arch_fm_191"                                      
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_afi_if.sv"]\"  -work altera_emif_arch_fm_191"                                               
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_seq_if.sv"]\"  -work altera_emif_arch_fm_191"                                               
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_emif_arch_fm_regs.sv"]\"  -work altera_emif_arch_fm_191"                                                 
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/altera_std_synchronizer_nocut.v"]\"  -work altera_emif_arch_fm_191"                                                 
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_arch_fm_191/sim/ed_sim_emif_fm_0_altera_emif_arch_fm_191_vft647i.vhd"]\"  -work altera_emif_arch_fm_191"                               
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/altera_emif_fm_261/sim/ed_sim_emif_fm_0_altera_emif_fm_261_cnll2ei.vhd"]\"  -work altera_emif_fm_261"                                              
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_emif_fm_0/sim/ed_sim_emif_fm_0.vhd"]\"  -work ed_sim_emif_fm_0"                                                                                              
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_local_reset_combiner/altera_emif_local_reset_combiner_191/sim/altera_emif_local_reset_combiner.sv"]\"  -work altera_emif_local_reset_combiner_191"    
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_local_reset_combiner/altera_emif_local_reset_combiner_191/sim/altera_std_synchronizer_nocut.v"]\"  -work altera_emif_local_reset_combiner_191"            
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_local_reset_combiner/sim/ed_sim_local_reset_combiner.vhd"]\"  -work ed_sim_local_reset_combiner"                                                             
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_local_reset_source/altera_emif_local_reset_sim_source_191/sim/altera_emif_local_reset_sim_source.sv"]\"  -work altera_emif_local_reset_sim_source_191"
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_local_reset_source/sim/ed_sim_local_reset_source.vhd"]\"  -work ed_sim_local_reset_source"                                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddrx_model.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddrx_model_per_ping_pong.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddrx_model_per_device.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                      
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddrx_model_rank.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                            
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddr4_model_rcd_chip.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddr4_model_db_chip.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                         
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_core_ddr4_191/sim/altera_emif_ddrx_model_bidir_delay.sv"]\"  -work altera_emif_mem_model_core_ddr4_191"                     
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/altera_emif_mem_model_191/sim/ed_sim_mem_altera_emif_mem_model_191_bu2wx3i.vhd"]\"  -work altera_emif_mem_model_191"                                     
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_mem/sim/ed_sim_mem.vhd"]\"  -work ed_sim_mem"                                                                                                                
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_ninit_done/altera_s10_user_rst_clkgate_1932/sim/altera_s10_user_rst_clkgate.sv"]\"  -work altera_s10_user_rst_clkgate_1932"                           
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_ninit_done/sim/ed_sim_ninit_done.vhd"]\"  -work ed_sim_ninit_done"                                                                                           
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_pll_ref_clk_source/altera_avalon_clock_source_191/sim/altera_avalon_clock_source.vhd"]\"  -work altera_avalon_clock_source_191"                              
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_pll_ref_clk_source/sim/ed_sim_pll_ref_clk_source.vhd"]\"  -work ed_sim_pll_ref_clk_source"                                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_sim_checker/altera_emif_sim_checker_191/sim/altera_emif_sim_checker.sv"]\"  -work altera_emif_sim_checker_191"                                        
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_sim_checker/sim/ed_sim_sim_checker.vhd"]\"  -work ed_sim_sim_checker"                                                                                        
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_std_synchronizer_nocut.v"]\"  -work altera_emif_tg_avl_191"                                                          
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_defs.sv"]\"  -work altera_emif_tg_avl_191"                                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_top.sv"]\"  -work altera_emif_tg_avl_191"                                                            
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                                       
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_avl_mm_if.sv"]\"  -work altera_emif_tg_avl_191"                                                      
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_avl_mm_srw_if.sv"]\"  -work altera_emif_tg_avl_191"                                                  
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_block_rw_stage.sv"]\"  -work altera_emif_tg_avl_191"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_burst_boundary_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_byteenable_stage.sv"]\"  -work altera_emif_tg_avl_191"                                               
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_sim_mem_validate.sv"]\"  -work altera_emif_tg_avl_191"                                        
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_simple.sv"]\"  -work altera_emif_tg_avl_191"                                                  
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver.sv"]\"  -work altera_emif_tg_avl_191"                                                         
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_fsm.sv"]\"  -work altera_emif_tg_avl_191"                                                     
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_lfsr.sv"]\"  -work altera_emif_tg_avl_191"                                                           
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_lfsr_wrapper.sv"]\"  -work altera_emif_tg_avl_191"                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                                  
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_burstcount_gen.sv"]\"  -work altera_emif_tg_avl_191"                                            
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_num_gen.sv"]\"  -work altera_emif_tg_avl_191"                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_seq_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                              
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_read_compare.sv"]\"  -work altera_emif_tg_avl_191"                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_scfifo_wrapper.sv"]\"  -work altera_emif_tg_avl_191"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_seq_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_single_rw_stage.sv"]\"  -work altera_emif_tg_avl_191"                                                
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_template_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"                                              
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_template_stage.sv"]\"  -work altera_emif_tg_avl_191"                                                 
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/altera_emif_tg_avl_191/sim/altera_emif_avl_tg_amm_1x_bridge.sv"]\"  -work altera_emif_tg_avl_191"                                                  
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../ip/ed_sim/ed_sim_tg/sim/ed_sim_tg.vhd"]\"  -work ed_sim_tg"                                                                                                                   
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/altera_merlin_master_translator_191/sim/ed_sim_altera_merlin_master_translator_191_g7h47bq.sv"]\"  -work altera_merlin_master_translator_191"                             
  lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/altera_merlin_slave_translator_191/sim/ed_sim_altera_merlin_slave_translator_191_x56fcki.sv"]\"  -work altera_merlin_slave_translator_191"                                
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/altera_mm_interconnect_1920/sim/ed_sim_altera_mm_interconnect_1920_2l4tnfq.vhd"]\"  -work altera_mm_interconnect_1920"                                                           
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/altera_reset_controller_1921/sim/mentor/altera_reset_controller.v"]\"  -work altera_reset_controller_1921"                                                                    
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/altera_reset_controller_1921/sim/mentor/altera_reset_synchronizer.v"]\"  -work altera_reset_controller_1921"                                                                  
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/sim/ed_sim.vhd"]\"  -work ed_sim"                                                                                                                                                
  return $design_files
}

proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
  set ELAB_OPTIONS ""
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  append ELAB_OPTIONS { -t fs}
  return $ELAB_OPTIONS
}


proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
  set SIM_OPTIONS ""
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  return $SIM_OPTIONS
}


proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
  set ENV_VARIABLES [dict create]
  set LD_LIBRARY_PATH [dict create]
  dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  return $ENV_VARIABLES
}


proc normalize_path {FILEPATH} {
    if {[catch { package require fileutil } err]} { 
        return $FILEPATH 
    } 
    set path [fileutil::lexnormalize [file join [pwd] $FILEPATH]]  
    if {[file pathtype $FILEPATH] eq "relative"} { 
        set path [fileutil::relative [pwd] $path] 
    } 
    return $path 
} 
