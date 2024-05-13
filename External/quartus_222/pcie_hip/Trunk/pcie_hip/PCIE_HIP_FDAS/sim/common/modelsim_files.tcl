source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_clock_bridge_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_1/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_2/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_3/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_3/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_1/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_2/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_reset_bridge_0/sim/common/modelsim_files.tcl]

namespace eval PCIE_HIP_FDAS {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_clock_bridge_0::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_rd_transparent_1::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_rd_transparent_0::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_rd_transparent_2::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_rd_transparent_3::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_wr_transparent_3::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_wr_transparent_1::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_wr_transparent_2::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_wr_transparent_0::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_design_libraries]]
    set libraries [dict merge $libraries [PCIE_HIP_FDAS_reset_bridge_0::get_design_libraries]]
    dict set libraries altera_merlin_master_translator_191   1
    dict set libraries altera_merlin_slave_translator_191    1
    dict set libraries altera_merlin_master_agent_191        1
    dict set libraries altera_merlin_slave_agent_191         1
    dict set libraries altera_avalon_sc_fifo_1931            1
    dict set libraries altera_merlin_router_1921             1
    dict set libraries altera_merlin_traffic_limiter_191     1
    dict set libraries altera_merlin_demultiplexer_1921      1
    dict set libraries altera_merlin_multiplexer_1921        1
    dict set libraries altera_merlin_waitrequest_adapter_191 1
    dict set libraries altera_mm_interconnect_1920           1
    dict set libraries altera_avalon_st_pipeline_stage_1920  1
    dict set libraries altera_merlin_burst_adapter_1922      1
    dict set libraries PCIE_HIP_FDAS                         1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_clock_bridge_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_clock_bridge_0/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_rd_transparent_1::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_1/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_rd_transparent_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_0/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_rd_transparent_2::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_2/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_rd_transparent_3::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_3/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_wr_transparent_3::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_3/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_wr_transparent_1::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_1/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_wr_transparent_2::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_2/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_wr_transparent_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_0/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0/sim/"]]
    set memory_files [concat $memory_files [PCIE_HIP_FDAS_reset_bridge_0::get_memory_files "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_reset_bridge_0/sim/"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_clock_bridge_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_clock_bridge_0/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_rd_transparent_1::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_1/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_rd_transparent_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_0/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_rd_transparent_2::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_2/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_rd_transparent_3::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_3/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_wr_transparent_3::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_3/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_wr_transparent_1::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_1/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_wr_transparent_2::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_2/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_wr_transparent_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_0/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0/sim/"]]
    set design_files [dict merge $design_files [PCIE_HIP_FDAS_reset_bridge_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_reset_bridge_0/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    set design_files [concat $design_files [PCIE_HIP_FDAS_clock_bridge_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_clock_bridge_0/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_rd_transparent_1::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_1/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_rd_transparent_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_0/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_rd_transparent_2::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_2/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_rd_transparent_3::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_rd_transparent_3/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_wr_transparent_3::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_3/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_wr_transparent_1::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_1/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_wr_transparent_2::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_2/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_wr_transparent_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_wr_transparent_0/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0/sim/"]]
    set design_files [concat $design_files [PCIE_HIP_FDAS_reset_bridge_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/PCIE_HIP_FDAS/PCIE_HIP_FDAS_reset_bridge_0/sim/"]]
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/PCIE_HIP_FDAS_altera_merlin_master_translator_191_k2xt5fq.sv"]\"  -work altera_merlin_master_translator_191"                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/PCIE_HIP_FDAS_altera_merlin_slave_translator_191_x56fcki.sv"]\"  -work altera_merlin_slave_translator_191"                    
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_master_agent_191/sim/PCIE_HIP_FDAS_altera_merlin_master_agent_191_mpbm6tq.sv"]\"  -work altera_merlin_master_agent_191"                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_agent_191/sim/PCIE_HIP_FDAS_altera_merlin_slave_agent_191_ncfkfri.sv"]\"  -work altera_merlin_slave_agent_191"                                   
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_agent_191/sim/altera_merlin_burst_uncompressor.sv"]\"  -work altera_merlin_slave_agent_191"                                                      
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_sc_fifo_1931/sim/PCIE_HIP_FDAS_altera_avalon_sc_fifo_1931_vhmcgqy.v"]\"  -work altera_avalon_sc_fifo_1931"                                                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_p6xnp3a.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_yiuwvbq.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/PCIE_HIP_FDAS_altera_merlin_traffic_limiter_altera_avalon_sc_fifo_191_7rxde4i.vhd"]\"  -work altera_merlin_traffic_limiter_191"       
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/altera_merlin_reorder_memory.sv"]\"  -work altera_merlin_traffic_limiter_191"                                                  
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/altera_avalon_st_pipeline_base.v"]\"  -work altera_merlin_traffic_limiter_191"                                                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_traffic_limiter_191/sim/PCIE_HIP_FDAS_altera_merlin_traffic_limiter_191_6blplji.sv"]\"  -work altera_merlin_traffic_limiter_191"                       
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_demultiplexer_1921_maph7pi.sv"]\"  -work altera_merlin_demultiplexer_1921"                          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_multiplexer_1921_jqhnmri.sv"]\"  -work altera_merlin_multiplexer_1921"                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1921"                                                            
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_demultiplexer_1921_aex32mq.sv"]\"  -work altera_merlin_demultiplexer_1921"                          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_multiplexer_1921_li4dm4i.sv"]\"  -work altera_merlin_multiplexer_1921"                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1921"                                                            
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_waitrequest_adapter_191/sim/altera_merlin_waitrequest_adapter.v"]\"  -work altera_merlin_waitrequest_adapter_191"                                          
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_waitrequest_adapter_191/sim/altera_avalon_sc_fifo.v"]\"  -work altera_merlin_waitrequest_adapter_191"                                                      
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_mm_interconnect_1920/sim/PCIE_HIP_FDAS_altera_mm_interconnect_1920_u7axxza.vhd"]\"  -work altera_mm_interconnect_1920"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/PCIE_HIP_FDAS_altera_merlin_master_translator_191_q6cbhvi.sv"]\"  -work altera_merlin_master_translator_191"                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_22ekohy.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_j3ubbhi.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_demultiplexer_1921_wzxjsgi.sv"]\"  -work altera_merlin_demultiplexer_1921"                          
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_mm_interconnect_1920/sim/PCIE_HIP_FDAS_altera_mm_interconnect_1920_zfbcyaq.vhd"]\"  -work altera_mm_interconnect_1920"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/PCIE_HIP_FDAS_altera_merlin_master_translator_191_g7h47bq.sv"]\"  -work altera_merlin_master_translator_191"                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_p3tohby.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_router_1921/sim/PCIE_HIP_FDAS_altera_merlin_router_1921_uygknla.sv"]\"  -work altera_merlin_router_1921"                                               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_1920/sim/PCIE_HIP_FDAS_altera_avalon_st_pipeline_stage_1920_zterisq.sv"]\"  -work altera_avalon_st_pipeline_stage_1920"              
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_avalon_st_pipeline_stage_1920/sim/altera_avalon_st_pipeline_base.v"]\"  -work altera_avalon_st_pipeline_stage_1920"                                           
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/PCIE_HIP_FDAS_altera_merlin_burst_adapter_altera_avalon_st_pipeline_stage_1922_wyh7ycq.vhd"]\"  -work altera_merlin_burst_adapter_1922"
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/PCIE_HIP_FDAS_altera_merlin_burst_adapter_1922_yda6ubq.sv"]\"  -work altera_merlin_burst_adapter_1922"                          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_merlin_burst_adapter_uncmpr.sv"]\"  -work altera_merlin_burst_adapter_1922"                                              
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_merlin_burst_adapter_13_1.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_merlin_burst_adapter_new.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_incr_burst_converter.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                     
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_wrap_burst_converter.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                     
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_default_burst_converter.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                  
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_burst_adapter_1922/sim/altera_merlin_address_alignment.sv"]\"  -work altera_merlin_burst_adapter_1922"                                                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_demultiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_demultiplexer_1921_stkzihq.sv"]\"  -work altera_merlin_demultiplexer_1921"                          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_multiplexer_1921_zqlsx3q.sv"]\"  -work altera_merlin_multiplexer_1921"                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1921"                                                            
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/PCIE_HIP_FDAS_altera_merlin_multiplexer_1921_z42dfda.sv"]\"  -work altera_merlin_multiplexer_1921"                                
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_multiplexer_1921/sim/altera_merlin_arbitrator.sv"]\"  -work altera_merlin_multiplexer_1921"                                                            
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_mm_interconnect_1920/sim/PCIE_HIP_FDAS_altera_mm_interconnect_1920_j5ntm2y.vhd"]\"  -work altera_mm_interconnect_1920"                                               
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/PCIE_HIP_FDAS.vhd"]\"  -work PCIE_HIP_FDAS"                                                                                                                                    
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    append ELAB_OPTIONS [PCIE_HIP_FDAS_clock_bridge_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_1::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_2::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_3::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_3::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_1::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_2::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [PCIE_HIP_FDAS_reset_bridge_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    append ELAB_OPTIONS { -t fs}
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [PCIE_HIP_FDAS_clock_bridge_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_1::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_2::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_rd_transparent_3::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_3::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_1::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_2::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_wr_transparent_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [PCIE_HIP_FDAS_reset_bridge_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_clock_bridge_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_rd_transparent_1::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_rd_transparent_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_rd_transparent_2::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_rd_transparent_3::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_intel_pcie_ptile_mcdma_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_wr_transparent_3::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_wr_transparent_1::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_wr_transparent_2::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_wr_transparent_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [PCIE_HIP_FDAS_reset_bridge_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
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
}
