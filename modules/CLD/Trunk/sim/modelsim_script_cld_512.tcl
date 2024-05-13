#############################################################
#EXAMPLE FOR CLD
#############################################################

# Set the path to the VHDL
set CLD_DIR "E:/UOM/SKA/FDAS/CLD/cld_lib/hdl"
set CLD_DIR_TB "E:/UOM/SKA/FDAS/CLD/cld_tb_lib/hdl"

# change to the CLD_SIM directory where I'm going to run the SIM
cd E:/UOM/SKA/FDAS/CLD_SIM

# create the cld_lib library (with mapping to it - what ever that means!)
vlib cld_lib
vmap cld_lib cld_lib

# create the cld_lib library (with mapping to it - what ever that means!)
vlib work
vmap work work

# complile the CLD design into the modelsim/questa "cld_lib" library
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_ddr_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_ddr_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_wag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_wag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/dual_port_ram_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/dual_port_ram_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/ram_mux_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/ram_mux_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_fifo_scm.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $CLD_DIR/cld_scm.vhd

# complile the CLD Test Bench into the modelsim/questa "work" library
eval vcom -reportprogress 300 -work work $CLD_DIR_TB/cld_tb.vhd
eval vcom -reportprogress 300 -work work $CLD_DIR_TB/cld_tb_stim_512.vhd

# Select the test bench for simulation
vsim -voptargs=+acc work.cld_tb

# load the waveform signals
do E:/UOM/SKA/FDAS/CLD_SIM/wave_512.do

# restart and run the sim
restart
run -all