source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_local_reset_source/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_ninit_done/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_mem/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_emif_fm_0/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_pll_ref_clk_source/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_emif_cal/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_tg/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_local_reset_combiner/sim/common/modelsim_files.tcl]
source [file join [file dirname [info script]] ./../../../ip/ed_sim/ed_sim_sim_checker/sim/common/modelsim_files.tcl]

namespace eval ed_sim {
  proc get_design_libraries {} {
    set libraries [dict create]
    set libraries [dict merge $libraries [ed_sim_local_reset_source::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_ninit_done::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_mem::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_emif_fm_0::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_pll_ref_clk_source::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_emif_cal::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_tg::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_local_reset_combiner::get_design_libraries]]
    set libraries [dict merge $libraries [ed_sim_sim_checker::get_design_libraries]]
    dict set libraries altera_merlin_master_translator_191 1
    dict set libraries altera_merlin_slave_translator_191  1
    dict set libraries altera_mm_interconnect_1920         1
    dict set libraries altera_reset_controller_1921        1
    dict set libraries ed_sim                              1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    set memory_files [concat $memory_files [ed_sim_local_reset_source::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_source/sim/"]]
    set memory_files [concat $memory_files [ed_sim_ninit_done::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_ninit_done/sim/"]]
    set memory_files [concat $memory_files [ed_sim_mem::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_mem/sim/"]]
    set memory_files [concat $memory_files [ed_sim_emif_fm_0::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_fm_0/sim/"]]
    set memory_files [concat $memory_files [ed_sim_pll_ref_clk_source::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_pll_ref_clk_source/sim/"]]
    set memory_files [concat $memory_files [ed_sim_emif_cal::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_cal/sim/"]]
    set memory_files [concat $memory_files [ed_sim_tg::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_tg/sim/"]]
    set memory_files [concat $memory_files [ed_sim_local_reset_combiner::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_combiner/sim/"]]
    set memory_files [concat $memory_files [ed_sim_sim_checker::get_memory_files "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_sim_checker/sim/"]]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    set design_files [dict merge $design_files [ed_sim_local_reset_source::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_source/sim/"]]
    set design_files [dict merge $design_files [ed_sim_ninit_done::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_ninit_done/sim/"]]
    set design_files [dict merge $design_files [ed_sim_mem::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_mem/sim/"]]
    set design_files [dict merge $design_files [ed_sim_emif_fm_0::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_fm_0/sim/"]]
    set design_files [dict merge $design_files [ed_sim_pll_ref_clk_source::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_pll_ref_clk_source/sim/"]]
    set design_files [dict merge $design_files [ed_sim_emif_cal::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_cal/sim/"]]
    set design_files [dict merge $design_files [ed_sim_tg::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_tg/sim/"]]
    set design_files [dict merge $design_files [ed_sim_local_reset_combiner::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_combiner/sim/"]]
    set design_files [dict merge $design_files [ed_sim_sim_checker::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_sim_checker/sim/"]]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    set design_files [concat $design_files [ed_sim_local_reset_source::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_source/sim/"]]
    set design_files [concat $design_files [ed_sim_ninit_done::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_ninit_done/sim/"]]
    set design_files [concat $design_files [ed_sim_mem::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_mem/sim/"]]
    set design_files [concat $design_files [ed_sim_emif_fm_0::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_fm_0/sim/"]]
    set design_files [concat $design_files [ed_sim_pll_ref_clk_source::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_pll_ref_clk_source/sim/"]]
    set design_files [concat $design_files [ed_sim_emif_cal::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_emif_cal/sim/"]]
    set design_files [concat $design_files [ed_sim_tg::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_tg/sim/"]]
    set design_files [concat $design_files [ed_sim_local_reset_combiner::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_local_reset_combiner/sim/"]]
    set design_files [concat $design_files [ed_sim_sim_checker::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR/../../ip/ed_sim/ed_sim_sim_checker/sim/"]]
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_master_translator_191/sim/ed_sim_altera_merlin_master_translator_191_g7h47bq.sv"]\"  -work altera_merlin_master_translator_191"
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_merlin_slave_translator_191/sim/ed_sim_altera_merlin_slave_translator_191_x56fcki.sv"]\"  -work altera_merlin_slave_translator_191"   
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_mm_interconnect_1920/sim/ed_sim_altera_mm_interconnect_1920_2l4tnfq.vhd"]\"  -work altera_mm_interconnect_1920"                              
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1921/sim/mentor/altera_reset_controller.v"]\"  -work altera_reset_controller_1921"                                       
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_reset_controller_1921/sim/mentor/altera_reset_synchronizer.v"]\"  -work altera_reset_controller_1921"                                     
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/ed_sim.vhd"]\"  -work ed_sim"                                                                                                                          
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    append ELAB_OPTIONS [ed_sim_local_reset_source::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_ninit_done::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_mem::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_emif_fm_0::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_pll_ref_clk_source::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_emif_cal::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_tg::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_local_reset_combiner::get_elab_options $SIMULATOR_TOOL_BITNESS]
    append ELAB_OPTIONS [ed_sim_sim_checker::get_elab_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    append ELAB_OPTIONS { -t fs}
    return $ELAB_OPTIONS
  }
  
  
  proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
    set SIM_OPTIONS ""
    append SIM_OPTIONS [ed_sim_local_reset_source::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_ninit_done::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_mem::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_emif_fm_0::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_pll_ref_clk_source::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_emif_cal::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_tg::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_local_reset_combiner::get_sim_options $SIMULATOR_TOOL_BITNESS]
    append SIM_OPTIONS [ed_sim_sim_checker::get_sim_options $SIMULATOR_TOOL_BITNESS]
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
    return $SIM_OPTIONS
  }
  
  
  proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
    set ENV_VARIABLES [dict create]
    set LD_LIBRARY_PATH [dict create]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_local_reset_source::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_ninit_done::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_mem::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_emif_fm_0::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_pll_ref_clk_source::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_emif_cal::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_tg::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_local_reset_combiner::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
    set LD_LIBRARY_PATH [dict merge $LD_LIBRARY_PATH [dict get [ed_sim_sim_checker::get_env_variables $SIMULATOR_TOOL_BITNESS] "LD_LIBRARY_PATH"]]
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
