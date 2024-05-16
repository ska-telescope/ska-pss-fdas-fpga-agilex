
namespace eval fft1024 {
  proc get_design_libraries {} {
    set libraries [dict create]
    dict set libraries intel_FPGA_unified_fft_104 1
    dict set libraries fft1024                    1
    return $libraries
  }
  
  proc get_memory_files {QSYS_SIMDIR} {
    set memory_files [list]
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/fft1024_intel_FPGA_unified_fft_104_qqiyosa_fft_fftLight_FFTPipe_TwiddleBlock_1_twiddleRom_dualMem_x.hex"]"
    lappend memory_files "[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/fft1024_intel_FPGA_unified_fft_104_qqiyosa_chanIn_cunroll_x.stm"]"
    return $memory_files
  }
  
  proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [dict create]
    return $design_files
  }
  
  proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
    set design_files [list]
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/dspba_library_package.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                                                   
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/dspba_library.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                                                           
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/dspba_sim_library_package.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                                               
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/fft1024_intel_FPGA_unified_fft_104_qqiyosa.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                              
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/fft1024_intel_FPGA_unified_fft_104_qqiyosa_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                          
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/fft1024_intel_FPGA_unified_fft_104_qqiyosa_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"                                                          
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type00000c2463a0044c2abw_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type00000c2463a0044c2abw_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_addBlock_typeSFloatIEEE_23_8_type0000463b0c2463a0044c2abw.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ00000uq0dp0iuq0cp0ju5o0u.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ0000dp0iuq0cp0ju5o0u_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_castBlock_typeSFloatIEEE_23_8_typ0000dp0iuq0cp0ju5o0u_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_negateBlock_typeSFloatIEEE_23_8_t00006c00uq0dp0iuq0cp1jzi.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_negateBlock_typeSFloatIEEE_23_8_t0000uq0dp0iuq0cp1jzi_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_negateBlock_typeSFloatIEEE_23_8_t0000uq0dp0iuq0cp1jzi_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0000p0mvq0cd06o30qcz_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0000p0mvq0cd06o30qcz_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0000uq0dp0mvq0cd06o30qcz.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0001p0mvq0cd06o30qcz_atb.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0001p0mvq0cd06o30qcz_stm.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../intel_FPGA_unified_fft_104/sim/flt_fft1024_intel_FPGA_unified_fft_104_qqiyosa_scalarProductBlock_typeSFloatIEEE0001uq0dp0mvq0cd06o30qcz.vhd"]\"  -work intel_FPGA_unified_fft_104"
    lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/fft1024.vhd"]\"  -work fft1024"                                                                                                                                                      
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
