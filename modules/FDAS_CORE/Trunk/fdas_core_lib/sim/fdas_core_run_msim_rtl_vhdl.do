transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vlib conv_lib
vmap conv_lib conv_lib
vlib dsp_prim_lib
vmap dsp_prim_lib dsp_prim_lib
vlib cld_lib
vmap cld_lib cld_lib
vlib mci_top_lib
vmap mci_top_lib mci_top_lib
vlib ctrl_lib
vmap ctrl_lib ctrl_lib
vlib pcif_lib
vmap pcif_lib pcif_lib
vlib ddrif2_lib
vmap ddrif2_lib ddrif2_lib
vlib msix_lib
vmap msix_lib msix_lib
vlib hsum_lib
vmap hsum_lib hsum_lib
vlib fdas_core_lib
vmap fdas_core_lib fdas_core_lib
vlib fdas_top_lib
vmap fdas_top_lib fdas_top_lib
vlib fdas_core_tb_lib
vmap fdas_core_tb_lib fdas_core_tb_lib

  set QUARTUS_INSTALL_DIR "E:/intelfpga_pro/22.2/quartus"

  set DESIGN_DIR "E:/Projects/SKA/FDAS2_dev"

# IP
#set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/ddr_controller/emif_fm_0_example_design/sim/ed_sim"
set QSYS_SIMDIR "E:/Projects/SKA/FDAS2_dev/altera/quartus/22.2"
source ./mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com

  
# DSP
# mult_fp_co
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/mult_fp_co/mult_fp_co/sim/mult_fp_co.vhd"

# multadd_fp_ci
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/multadd_fp_ci/multadd_fp_ci/sim/multadd_fp_ci.vhd"

# multsub_fp_ci
eval  vcom -work dsp_prim_lib "$QSYS_SIMDIR/multsub_fp_ci/multsub_fp_ci/sim/multsub_fp_ci.vhd"                                                            

# Compile DSP_PRIM design files
vcom -2008 -work dsp_prim_lib $DESIGN_DIR/DSP_PRIM/hdl/cmplxmult_fp.vhd
vcom -2008 -work dsp_prim_lib $DESIGN_DIR/DSP_PRIM/hdl/cmplxmult_fp_scm.vhd

# fp_add
#eval  vcom -work hsum_lib "$QSYS_SIMDIR/fp_add.vhd"                                                            

# FFT1024
eval  vcom -work conv_lib "$QSYS_SIMDIR/fft1024/fft1024/sim/fft1024.vhd"                                                            


# IFFT1024
eval  vcom -work conv_lib "$QSYS_SIMDIR/ifft1024/ifft1024/sim/ifft1024.vhd"                                                            

# Compile CONV design files
set conv_dir "$DESIGN_DIR/CONV/hdl"
eval vcom -93 -work conv_lib {$conv_dir/cmplx_pkg.vhd}
eval vcom -93 -work conv_lib {$conv_dir/convmci_pkg.vhd}
eval vcom -93 -work conv_lib {$conv_dir/convmci.vhd}
eval vcom -93 -work conv_lib {$conv_dir/convmci_synth.vhd}

eval vcom -93 -work conv_lib {$conv_dir/conv_fft.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_fft_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_fft_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_fft_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_ifft.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_ifft_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/retime.vhd}
eval vcom -93 -work conv_lib {$conv_dir/retime_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_coef_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_coef_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_mult.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_mult_scm.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_result_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_result_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_pwr.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_pwr_scm.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_ifft_ctrl.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_ifft_ctrl_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/fop_str.vhd}
eval vcom -93 -work conv_lib {$conv_dir/fop_str_synth.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv.vhd}
eval vcom -93 -work conv_lib {$conv_dir/conv_scm.vhd}

# Compile CLD design files
# Set the path to the VHDL
set cld_dir "$DESIGN_DIR/CLD/hdl"

# complile the CLD design into the modelsim/questa "cld_lib" library
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_ddr_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_ddr_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_wag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_wag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/dual_port_ram_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/dual_port_ram_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/ram_mux_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/ram_mux_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_fifo_scm.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/cld_scm.vhd

# Compile MCI_TOP design files
# Set the path to the VHDL
set mci_top_dir "$DESIGN_DIR/MCI_TOP/hdl"

eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_topmci.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_topmci_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_dataor.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_dataor_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_decodemci.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_decodemci_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_reset.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_reset_synth.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top.vhd
eval vcom -reportprogress 300 -work mci_top_lib $mci_top_dir/mci_top_scm.vhd

# Compile CTRL design files
# Set the path to the VHDL
set ctrl_dir "$DESIGN_DIR/CTRL/hdl"

eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrlmci.vhd
eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrlmci_synth.vhd
eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrl_func.vhd
eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrl_func_synth.vhd
eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrl.vhd
eval vcom -reportprogress 300 -work ctrl_lib $ctrl_dir/ctrl_scm.vhd

# Compile PCIF design files
# Set the path to the VHDL
set pcif_dir "$DESIGN_DIR/PCIF/hdl"

eval vcom -reportprogress 300 -work pcif_lib $pcif_dir/pcif_mcif.vhd
eval vcom -reportprogress 300 -work pcif_lib $pcif_dir/pcif_mcif_synth.vhd
eval vcom -reportprogress 300 -work pcif_lib $pcif_dir/pcif.vhd
eval vcom -reportprogress 300 -work pcif_lib $pcif_dir/pcif_scm.vhd

# Compile DDRIF2 design files
# Set the path to the VHDL
set ddrif2_dir "$DESIGN_DIR/DDRIF2/hdl"

# complile the DDRIF2 design into the modelsim/questa "ddrif2_lib" library
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_combine.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_combine_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_ddr_mux.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_ddr_mux_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_if_sel.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_if_sel_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_muxin.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_muxin_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rag_in.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rag_in_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rag_out_512.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rag_out_512_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_mux.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_mux_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_pcie_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_pcie_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_proc_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_proc_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_ram_en.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_ram_en_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_tx_pcie_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_tx_pcie_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_tx_proc_if.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_tx_proc_if_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_wag_in.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_wag_in_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_wag_out.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_wag_out_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/dual_port_ram_dual_clock.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/dual_port_ram_dual_clock_synth.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_fifo.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_rx_fifo_scm.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_data_fifo_512.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_data_fifo_512_scm.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2.vhd
eval vcom -reportprogress 300 -work ddrif2_lib $ddrif2_dir/ddrif2_scm.vhd

# ed_sim_mem
set QSYS_SIMDIR "$DESIGN_DIR/altera/quartus/22.2/ddr_controller/emif_fm_0_example_design/sim/ed_sim"
source $QSYS_SIMDIR/mentor/msim_setup.tcl
# Compile all the design files and elaborate
#ld
dev_com
com
#eval  vcom -work conv_lib "$QSYS_SIMDIR/sim/ed_sim.vhd"                                                            

# Compile MSIX design files
# Set the path to the VHDL
set msix_dir "$DESIGN_DIR/MSIX/hdl"

eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixtxint.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixtxint_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixpulsedet.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixpulsedet_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixmci.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msixmci_synth.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msix.vhd
eval vcom -reportprogress 300 -work msix_lib $msix_dir/msix_scm.vhd

# Compile HSUM design files
# Set the path to the VHDL
set hsum_dir "$DESIGN_DIR/HSUM/hdl"

eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsum_pkg.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummci_pkg.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumadder.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumadder_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumddrinram.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumddrinram_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumddrin.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumddrin_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumdmcount.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumdmcount_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumfiltram.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumfiltram_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumfilt.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumfilt_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhpselram.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhpselram_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhpsel.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhpsel_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhresram.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhresram_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhres.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumhres_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummax.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummax_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummci.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummci_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummins.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsummins_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumretime.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumretime_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumselseed.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumselseed_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtgen.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtgen_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtree.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtree_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtrep.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtrep_scm.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtselram.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtselram_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtsel.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumtsel_synth.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumsummer.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsumsummer_scm.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsum.vhd
eval vcom -reportprogress 300 -work hsum_lib $hsum_dir/hsum_scm.vhd


# Compile FDAS_CORE design files
# Set the path to the VHDL
set fdas_core_dir "$DESIGN_DIR/FDAS_CORE/hdl"

eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/reset_sync.vhd
eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/reset_sync_synth.vhd
eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/core_reconf.vhd
eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/core_reconf_scm.vhd
eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/fdas_core.vhd
eval vcom -reportprogress 300 -work fdas_core_lib $fdas_core_dir/fdas_core_scm.vhd

# Compile FDAS_TOP design files
# Set the path to the VHDL
set fdas_top_dir "$DESIGN_DIR/FDAS_TOP/hdl"
eval vcom -reportprogress 300 -work fdas_top_lib $fdas_top_dir/fdas_ddr_controller_calibration.vhd
eval vcom -reportprogress 300 -work fdas_top_lib $fdas_top_dir/fdas_ddr_controller_calibration_struc.vhd

# Compile Test Bench files
set TOP_LEVEL_NAME "fdas_core_tb_lib.fdas_core_tb"
# Set the path to the VHDL
set fdas_core_tb_dir "$DESIGN_DIR/FDAS_CORE/tb/hdl"
# Compile DDRIF2_CLD_CONV testbench design files
eval vcom -93 -work fdas_core_tb_lib {$fdas_core_tb_dir/fdas_core_tb.vhd}
eval vcom -93 -work fdas_core_tb_lib {$fdas_core_tb_dir/fdas_core_tb_bhv.vhd}

# Elaborate top level
#eval vsim -t ps -L work -L work_lib -L altera_emif_arch_nf_170 -L altera_avalon_mm_bridge_170 -L altera_avalon_onchip_memory2_170 -L altera_merlin_master_translator_170 -L altera_merlin_slave_translator_170 -L altera_mm_interconnect_170 -L altera_reset_controller_170 -L altera_emif_cal_slave_nf_170 -L altera_emif_170 -L DDR_CONTROLLER_17_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L twentynm_ver -L twentynm_hssi_ver -L twentynm_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L twentynm -L twentynm_hssi -L twentynm_hip -L altera_emif_mem_model_core_ddr4_170 -L altera_emif_mem_model_170 -L ed_sim_mem -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L twentynm_ver -L twentynm_hssi_ver -L twentynm_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L twentynm -L twentynm_hssi -L twentynm_hip fdas_core_tb_lib.fdas_core_tb
#eval vsim -t ps $TOP_LEVEL_NAME
elab
add wave -position insertpoint sim:/fdas_core_tb/fdas_core_i/core_reconf_i/conv_i/*
add wave -position insertpoint sim:/fdas_core_tb/fdas_core_i/core_reconf_i/cld_i/*
add wave -position insertpoint sim:/fdas_core_tb/*
add wave -position insertpoint sim:/fdas_core_tb/fdas_core_i/ddrif0_i/*
add wave -position insertpoint sim:/fdas_core_tb/fdas_core_i/ddrif1_i/*
run -all
