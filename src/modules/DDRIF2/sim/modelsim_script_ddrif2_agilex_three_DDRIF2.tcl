#######################################################################################################
#### DDRIF2 Simulation Compile Script
#######################################################################################################

#Set the path to the VHDL
set DDRIF2_DIR "C:/FDAS_AGILEX/Projects/SKA/DDRIF2/ddrif2_lib/hdl"
set DDRIF2_TB_DIR "C:/FDAS_AGILEX/Projects/SKA/DDRIF2/ddrif2_tb_lib/hdl"

# Change Directory to where the Simulation will run
cd C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM

# Create and map the simulation libraries
vlib ddrif2_lib
vmap ddrif2_lib ddrif2_lib

vlib work
vmap work work

#Compile the design files
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_combine.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_combine_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_ddr_mux.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_ddr_mux_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_if_sel.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_if_sel_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_muxin.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_muxin_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_in.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_in_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_out_512.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_out_512_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_out_3_512.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rag_out_3_512_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_mux.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_mux_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_pcie_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_pcie_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_proc_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_proc_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_ram_en.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_ram_en_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_tx_pcie_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_tx_pcie_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_tx_proc_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_tx_proc_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_wag_in.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_wag_in_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_wag_out.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_wag_out_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/dual_port_ram_dual_clock.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/dual_port_ram_dual_clock_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_fifo.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_rx_fifo_scm.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_data_fifo_512.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_data_fifo_512_scm.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $DDRIF2_DIR/ddrif2_scm.vhd

# Compile the Test Bench files
eval vcom -reportprogress 300 -work work $DDRIF2_TB_DIR/ddrif2_tb.vhd
eval vcom -reportprogress 300 -work work $DDRIF2_TB_DIR/ddrif2_tb_stim_3_instances.vhd


# Select the Test Bench to simulate
vsim -voptargs=+acc work.ddrif2_tb

# Load the wave form files
do C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM/conv_interface_three.do
do C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM/hsum_interface_three.do
do C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM/pcie_write_interface_three.do
do C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM/pcie_read_interface_three.do
do C:/FDAS_AGILEX/Projects/SKA/DDRIF2/DDRIF2_SIM/sdram_interface_three.do



# Run the simulation
restart
run -all

