transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vlib conv_lib
vmap conv_lib conv_lib
vlib conv_tb_lib
vmap conv_tb_lib conv_tb_lib
vlib dsp_prim_lib
vmap dsp_prim_lib dsp_prim_lib

  set QUARTUS_INSTALL_DIR "E:/intelfpga_pro/22.2/quartus"
#
#  set USER_DEFINED_COMPILE_OPTIONS ""
#vlog -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv                     -work altera_lnsim     
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd         -work altera_lnsim     
#vlog -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/twentynm_atoms_ncrypt.v      -work twentynm     
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_atoms.vhd                  -work twentynm     
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_components.vhd             -work twentynm     
#vlog -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/twentynm_hssi_atoms_ncrypt.v -work twentynm_hssi
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_hssi_components.vhd        -work twentynm_hssi
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_hssi_atoms.vhd             -work twentynm_hssi
#vlog -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/twentynm_hip_atoms_ncrypt.v  -work twentynm_hip 
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_hip_components.vhd         -work twentynm_hip 
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/twentynm_hip_atoms.vhd              -work twentynm_hip 
#vlog -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v                         -work altera_mf     
#vcom -reportprogress 300 $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd            -work altera_mf     

  set DESIGN_DIR "E:/Projects/SKA/FDAS2_dev"
#
# DSP
# mult_fp_co
#set TOP_LEVEL_NAME "mult_fp_co.mult_fp_co"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/mult_fp_co/mult_fp_co/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/mult_fp_co.vhd"

# multadd_fp_ci
#set TOP_LEVEL_NAME "multadd_fp_ci.multadd_fp_ci"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/multadd_fp_ci/multadd_fp_ci/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/multadd_fp_ci.vhd"

# multsub_fp_ci
#set TOP_LEVEL_NAME "multsub_fp_ci.multsub_fp_ci"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/multsub_fp_ci/multsub_fp_ci/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/multsub_fp_ci.vhd"                                                            

# Compile DSP_PRIM design files
vcom -2008 -work dsp_prim_lib $DESIGN_DIR/DSP_PRIM/hdl/cmplxmult_fp.vhd
vcom -2008 -work dsp_prim_lib $DESIGN_DIR/DSP_PRIM/hdl/cmplxmult_fp_scm.vhd

# FFT1024
#set TOP_LEVEL_NAME "fft1024.fft1024"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/fft1024/fft1024/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -work conv_lib "$QSYS_SIMDIR/fft1024.vhd"                                                            


# IFFT1024
#set TOP_LEVEL_NAME "ifft1024.ifft1024"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/ifft1024/ifft1024/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -work conv_lib "$QSYS_SIMDIR/ifft1024.vhd"                                                            

# Compile CONV design files
#set TOP_LEVEL_NAME "conv_tb_lib.conv_tb"
set conv_dir "$DESIGN_DIR/CONV"
eval vcom -93 -work conv_lib {$conv_dir/hdl/cmplx_pkg.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/convmci_pkg.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/convmci.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/convmci_synth.vhd}

eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_fft.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_fft_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_fft_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_fft_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_ifft.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_ifft_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/retime.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/retime_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_coef_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_coef_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_mult.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_mult_scm.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_result_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_result_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_pwr.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_pwr_scm.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_ifft_ctrl.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_ifft_ctrl_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/fop_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/fop_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv.vhd}
eval vcom -93 -work conv_lib {$conv_dir/hdl/conv_scm.vhd}

# Compile CONV testbench design files
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/sincos_fp.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/sincos_fp_synth.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/conv_tb.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/conv_tb_bhv.vhd}

# Elaborate top level
set TOP_LEVEL_NAME "conv_tb_lib.conv_tb"
#eval vsim -t ps -L work -L work_lib -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L twentynm_ver -L twentynm_hssi_ver -L twentynm_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L twentynm -L twentynm_hssi -L twentynm_hip conv_tb_lib.conv_tb
#eval vsim -t ps -L work -L work_lib -L altera_fft_ii_170 -L fft1024 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L twentynm_ver -L twentynm_hssi_ver -L twentynm_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L twentynm -L twentynm_hssi -L twentynm_hip conv_tb_lib.conv_tb
eval vsim -t ps $TOP_LEVEL_NAME
