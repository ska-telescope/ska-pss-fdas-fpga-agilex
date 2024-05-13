# Tcl script to compile module and testbenches in Modelsim or Questasim.
# This script compiles all the necessary Quartus Prime Libraries each time it is run which take a while to do.



# Step #1:
# Launch Questa (2021.4 is probably OK)
# Ensure in the Questa Compile tab to use VHDL 1076-2008 as the fp_add has concatenated signal assignment on a port
# Ensure the fp_add msim_setup.tcl has the correct path to the correct Quartus Prime (msim_setup.tcl  has it on an E drive!!)
# Directory to where the Simulation will run. It should be the location of this script. For Example
# cd C:/AGILEX_BUILD_AREA/HSUM/sim
# Copy this into the Questa command window to easily change directory

# Step #2:
# In the Questa command window source this script. i.e.
# source hsum_local_msim_compiled_intel_libraries.tcl
# The downside of this method is that each time the script is run the Quartus Prime Libraries are compiled

# Step #3:
# In the Questa command window for each test chosen test bench run it using the commands in the comments
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


# set the location to where all the design files are located
set DESIGN_DIR "C:/AGILEX_BUILD_AREA"
#
# DSP
# fp_add
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.4/fp_add/sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
eval  vcom -2008 -work hsum_lib "$QSYS_SIMDIR/fp_add.vhd"

set ALTERA_LIB "C:/AGILEX_BUILD_AREA/HSUM/sim/libraries"
exec vmap altera_mf $ALTERA_LIB/altera_mf

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
