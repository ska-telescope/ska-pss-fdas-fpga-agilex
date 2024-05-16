
namespace eval ed_sim_tg {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_emif_tg_avl_191 1
    dict set libraries ed_sim_tg              1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_std_synchronizer_nocut.v"]\"  -work altera_emif_tg_avl_191"                  
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_defs.sv"]\"  -work altera_emif_tg_avl_191"                   
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_top.sv"]\"  -work altera_emif_tg_avl_191"                    
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"               
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_avl_mm_if.sv"]\"  -work altera_emif_tg_avl_191"              
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_avl_mm_srw_if.sv"]\"  -work altera_emif_tg_avl_191"          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_block_rw_stage.sv"]\"  -work altera_emif_tg_avl_191"         
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_burst_boundary_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_byteenable_stage.sv"]\"  -work altera_emif_tg_avl_191"       
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_sim_mem_validate.sv"]\"  -work altera_emif_tg_avl_191"
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_simple.sv"]\"  -work altera_emif_tg_avl_191"          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver.sv"]\"  -work altera_emif_tg_avl_191"                 
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_driver_fsm.sv"]\"  -work altera_emif_tg_avl_191"             
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_lfsr.sv"]\"  -work altera_emif_tg_avl_191"                   
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_lfsr_wrapper.sv"]\"  -work altera_emif_tg_avl_191"           
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"          
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_burstcount_gen.sv"]\"  -work altera_emif_tg_avl_191"    
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_num_gen.sv"]\"  -work altera_emif_tg_avl_191"           
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_rand_seq_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"      
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_read_compare.sv"]\"  -work altera_emif_tg_avl_191"           
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_scfifo_wrapper.sv"]\"  -work altera_emif_tg_avl_191"         
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_seq_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"           
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_single_rw_stage.sv"]\"  -work altera_emif_tg_avl_191"        
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_template_addr_gen.sv"]\"  -work altera_emif_tg_avl_191"      
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_template_stage.sv"]\"  -work altera_emif_tg_avl_191"         
    lappend design_files "vlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_tg_avl_191/sim/altera_emif_avl_tg_amm_1x_bridge.sv"]\"  -work altera_emif_tg_avl_191"          
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/ed_sim_tg.vhd"]\"  -work ed_sim_tg"                                                                                  
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
}
