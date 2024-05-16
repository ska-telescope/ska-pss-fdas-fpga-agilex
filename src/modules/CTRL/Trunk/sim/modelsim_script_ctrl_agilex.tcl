##################################################################
#### CTRL Simulation Script
##################################################################

#Set the path to the VHDL
set CTRL_DIR "C:/FDAS_AGILEX/Projects/SKA/CTRL/ctrl_lib/hdl"
set CTRL_TB_DIR "C:/FDAS_AGILEX/Projects/SKA/CTRL/ctrl_tb_lib/hdl"


# Change Directory to where the simulation will run from
cd C:/FDAS_AGILEX/Projects/SKA/CTRL/CTRL_SIM

#Create and Map the libraries
vlib ctrl_lib
vmap ctrl_lib ctrl_lib

vlib work
vmap work work

#Compile the design
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrl_func.vhd
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrl_func_synth.vhd
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrlmci.vhd
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrlmci_synth.vhd
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrl.vhd
eval vcom -reportprogress 300 -work ctrl_lib $CTRL_DIR/ctrl_scm.vhd

#Compile the Test Bench
eval vcom -reportprogress 300 -work work $CTRL_TB_DIR/ctrl_tb.vhd
eval vcom -reportprogress 300 -work work $CTRL_TB_DIR/ctrl_tb_stim.vhd


#Select the Test Bench for simulation
vsim -voptargs=+acc work.ctrl_tb

#Load the waveform
do C:/FDAS_AGILEX/Projects/SKA/CTRL/CTRL_SIM/wave.do
do C:/FDAS_AGILEX/Projects/SKA/CTRL/CTRL_SIM/ddr_access_wave.do

#Restart and run
restart
run -all
