#######################################################################################################
#### DDRIF2 Simulation Compile Script
#######################################################################################################

#Set the path to the VHDL
set MSIX_DIR "C:/FDAS_AGILEX/Projects/SKA/MSIX/msix_lib/hdl"
set MSIX_TB_DIR "C:/FDAS_AGILEX/Projects/SKA/MSIX/msix_tb_lib/hdl"

# Change Directory to where the Simulation will run
cd C:/FDAS_AGILEX/Projects/SKA/MSIX/MSIX_SIM

# Create and map the simulation libraries
vlib msix_lib
vmap msix_lib msix_lib

vlib work
vmap work work

#Compile the design files
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixtxint.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixtxint_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixpulsedet.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixpulsedet_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixmci.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msixmci_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msix.vhd
eval vcom -reportprogress 300 -work msix_lib $MSIX_DIR/msix_scm.vhd


# Compile the Test Bench files
eval vcom -reportprogress 300 -work work $MSIX_TB_DIR/msix_tb.vhd
eval vcom -reportprogress 300 -work work $MSIX_TB_DIR/msix_tb_stim.vhd


# Select the Test Bench to simulate
vsim -voptargs=+acc work.msix_tb

# Load the wave form files
do C:/FDAS_AGILEX/Projects/SKA/MSIX/MSIX_SIM/wave.do




# Run the simulation
restart
run -all

