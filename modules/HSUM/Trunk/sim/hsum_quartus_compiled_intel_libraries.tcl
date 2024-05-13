# Tcl script to compile module and testbenches in Modelsim or Questasim.
# This script only needs to compile all the necessary Quartus Prime Libraries once via Quartus Prime using the instructions
# in step 1:. 
# Hence this script faster than  hsum_local_msim_compiled_intel_libraries.tcl


# Step 1: This only needs to be done once and again if Quartus Prime changes 
# Launch Quartus Prime
# The Intel libraries must be compiled first in Quartus Prime
# using the Quartus Library Compiler (Tools menu -> Launch Simulation Library Compiler) and set the
# paths 'alt_lib_vhdl' & 'alt_lib_ver', below, to the correct path.
# For Quartus Prime 21.3 the version of Questa to enter in the Launch Simulation Library Compiler should be 2021.4 to ensure that
# the VHDL and VERLOG compilation by Quartus Prime is successful.

# Step #2:
# Launch Questa (same version as declared in Step 1)
# Directory to where the Simulation will run. It should be the location of this script. For Example
# cd C:/AGILEX_BUILD_AREA/HSUM/sim
# Copy this into the Questa command window to easily change directory

# Step #3:
# In the Questa command window source this script. i.e.
# source hsum_quartus_compiled_intel_libraries.tcl

# Step #4:
# In the Questa command window for each test  chosen test bench run it using the commands in the comments
# at the end of this script.
# The easiest way to run any tcl scripts that check operation with different generic settings is to copy the scripts from 
# hsum_tb_lib/scripts directory to where your compiled files are and then in the Questa command line window just source the
# script, e.g source hsumddrin_tb.tcl.


transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vlib hsum_lib
vmap hsum_lib hsum_lib
vlib hsum_tb_lib
vmap hsum_tb_lib hsum_tb_lib
vlib work
vmap work work
vlib s20_native_floating_point_dsp_1910
vmap s20_native_floating_point_dsp_1910 s20_native_floating_point_dsp_1910

# set the location to where all the design files are located
set DESIGN_DIR "C:/AGILEX_BUILD_AREA"
#

# Define path to Altera compiled VHDL libraries.
set alt_lib_vhdl "E:/INTEL_QUARTUS_AGILEX_COMPILE_OUTPUT/vhdl_libs"
set alt_lib_ver "E:/INTEL_QUARTUS_AGILEX_COMPILE_OUTPUT/verilog_libs"
exec vmap altera_mf [file join $alt_lib_vhdl altera_mf]
exec vmap tennm [file join $alt_lib_vhdl tennm]



## DSP
## fp_add
set QSYS_DSP_SIMDIR "$DESIGN_DIR/altera/quartus/21.3/fp_add/s20_native_floating_point_dsp_1910/sim"
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/21.3/fp_add/sim"

eval  vcom -2008 -work s20_native_floating_point_dsp_1910 "$QSYS_DSP_SIMDIR/fp_add_s20_native_floating_point_dsp_1910_646nw2y.vhd"
eval  vcom -2008 -work hsum_lib "$QSYS_SIMDIR/fp_add.vhd"


# Compile HSUM design files
set HSUM_DIR "$DESIGN_DIR/HSUM/hsum_lib/hdl"
set HSUM_TB_DIR "$DESIGN_DIR/HSUM/hsum_tb_lib/hdl"


eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsum_pkg.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummci_pkg.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumreset_sync.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumreset_sync_synth.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtselram.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtselram_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtsel.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtsel_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhres.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhres_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumfilt.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumfilt_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumselseed.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumselseed_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumdmcount.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumdmcount_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtrep.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtrep_scm.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtree.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtree_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtgen.vhd}  
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumtgen_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummins.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummins_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhpsel.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhpsel_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumsummer.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumsummer_scm.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumretime.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumretime_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummax.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummax_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummci.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsummci_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhresram.vhd}  
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhresram_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhpselram.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumhpselram_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumfiltram.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumfiltram_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumddrinram.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumddrinram_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumddrin.vhd}
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumddrin_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumadder.vhd}  
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsumadder_synth.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsum.vhd} 
eval vcom -2008 -work hsum_lib {$HSUM_DIR/hsum_scm.vhd} 



# Compile HSUM testbench design files
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsum_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsum_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumddrin_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumddrin_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumfilt_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumfilt_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumhpsel_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumhpsel_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumhres_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumhres_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumtgen_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumtgen_tb_stim.vhd}

eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumsummer_tb.vhd}
eval vcom -2008 -work hsum_tb_lib {$HSUM_TB_DIR/hsumsummer_tb_stim.vhd}


# Elaborate top level
set TOP_LEVEL_NAME "hsum_tb_lib.hsum_tb"
eval vsim -t ps $TOP_LEVEL_NAME

# To run hsum_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsum_tb -do
# then type
# run -all

# To run hsumddrin_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumddrin_tb -do
# then type
# run -all

# To run hsumfilt_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumfilt_tb -do
# then type
# run -all

# To run hsumhpsel_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumhpsel_tb -do
# then type
# run -all

# To run hsumhres_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumhres_tb  -gharmonic_num_g=8 -gsummer_g=1 -do
# then type
# run -all

# To run hsumtgen_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumtgen_tb -do
# then type
# run -all

# To run hsumsummer_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumsummer_tb -do
# then type
# run -all




