
namespace eval FDAS_EMIF_CALIBRATION {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries altera_emif_cal_iossm_262 1
    dict set libraries altera_emif_cal_262       1
    dict set libraries FDAS_EMIF_CALIBRATION     1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_262_7er3wya_code.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_262_7er3wya_sim_global_param_tbl.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_262_7er3wya_synth_global_param_tbl.hex"]"
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/altera_emif_cal_iossm.sv"]\"  -work altera_emif_cal_iossm_262"                                       
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/altera_emif_f2c_gearbox.sv"]\"  -work altera_emif_cal_iossm_262"                                     
    lappend design_files "vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_262_7er3wya_arch.sv"]\"  -work altera_emif_cal_iossm_262"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_iossm_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_iossm_262_7er3wya.vhd"]\"  -work altera_emif_cal_iossm_262"        
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../altera_emif_cal_262/sim/FDAS_EMIF_CALIBRATION_altera_emif_cal_262_c4fgnxa.vhd"]\"  -work altera_emif_cal_262"                          
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/FDAS_EMIF_CALIBRATION.vhd"]\"  -work FDAS_EMIF_CALIBRATION"                                                                               
    return $design_files
  }
  
  proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
    set ELAB_OPTIONS ""
    if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
    } else {
    }
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
