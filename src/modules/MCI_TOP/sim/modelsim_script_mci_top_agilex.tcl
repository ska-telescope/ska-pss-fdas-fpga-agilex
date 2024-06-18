#######################################################################################################
#### DDRIF2 Simulation Compile Script
#######################################################################################################

#Set the path to the VHDL
set MCI_TOP_DIR "C:/FDAS_AGILEX/Projects/SKA/MCI_TOP/mci_top_lib/hdl"
set MCI_TOP_TB_DIR "C:/FDAS_AGILEX/Projects/SKA/MCI_TOP/mci_top_tb_lib/hdl"

# Change Directory to where the Simulation will run
cd C:/FDAS_AGILEX/Projects/SKA/MCI_TOP/MCI_TOP_SIM

#Create and Map the libraries
vlib mci_top_lib
vmap mci_top_lib mci_top_lib

vlib work
vmap work work

#Compile the design
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_dataor.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_dataor_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_decodemci.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_decodemci_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_topmci.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_topmci_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_reset.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_reset_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top.vhd
eval vcom -reportprogress 300 -work mci_top_lib $MCI_TOP_DIR/mci_top_scm.vhd

#Compile the Test Bench
eval vcom -reportprogress 300 -work work $MCI_TOP_TB_DIR/mci_top_tb.vhd
eval vcom -reportprogress 300 -work work $MCI_TOP_TB_DIR/mci_top_tb_stim.vhd


#Select the Test Bench for simulation
vsim -voptargs=+acc work.mci_top_tb

#Load the waveform
do C:/FDAS_AGILEX/Projects/SKA/MCI_TOP/MCI_TOP_SIM/wave.do


# Run the simulation
restart
run -all
