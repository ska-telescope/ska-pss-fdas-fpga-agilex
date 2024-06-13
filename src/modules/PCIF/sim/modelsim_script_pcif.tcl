######################################################################
### PCIF Simulation Script
######################################################################

#Set the path to the VHDL
set PCIF_DIR "E:/UOM/SKA/FDAS/PCIF/pcif_lib/hdl"
set PCIF_TB_DIR "E:/UOM/SKA/FDAS/PCIF/pcif_tb_lib/hdl"


# Change Directory to where the simulation will run from
cd E:/UOM/SKA/FDAS/PCIF_SIM

#Create and map thee Libraries
vlib pcif_lib
vmap pcif_lib pcif_lib
vlib work
vmap work work


# Compile the design files
eval vcom -reportprogress 300 -work pcif_lib $PCIF_DIR/pcif_mcif.vhd
eval vcom -reportprogress 300 -work pcif_lib $PCIF_DIR/pcif_mcif_synth.vhd
eval vcom -reportprogress 300 -work pcif_lib $PCIF_DIR/pcif.vhd
eval vcom -reportprogress 300 -work pcif_lib $PCIF_DIR/pcif_scm.vhd


# Compile the Test Bench files
eval vcom -reportprogress 300 -work work $PCIF_TB_DIR/pcif_tb.vhd
eval vcom -reportprogress 300 -work work $PCIF_TB_DIR/pcif_tb_stim.vhd


# Select the Test Bench for Simulation
vsim -voptargs=+acc work.pcif_tb


# Load the waveform
do E:/UOM/SKA/FDAS/PCIF_SIM/wave.do


#Restart and run
restart
run -all
 
