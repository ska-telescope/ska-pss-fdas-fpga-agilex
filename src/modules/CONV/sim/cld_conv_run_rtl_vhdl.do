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
vlib cld_lib
vmap cld_lib cld_lib

set QUARTUS_INSTALL_DIR "C:/intelfpga_pro/22.2/quartus"

set DESIGN_DIR "E:/Projects/SKA/FDAS2_dev"

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

# Compile CLD design files
set cld_dir "$DESIGN_DIR/CLD"
# complile the CLD design into the modelsim/questa "cld_lib" library
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_ddr_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_ddr_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_rag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_rag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_wag_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_wag_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/dual_port_ram_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/dual_port_ram_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/ram_mux_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/ram_mux_synth.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_fifo_scm.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_entity.vhd
eval vcom -reportprogress 300 -work cld_lib $cld_dir/hdl/cld_scm.vhd

# Compile CLD_CONV testbench design files
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/cld_conv_tb.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/cld_conv_tb_bhv.vhd}

# Elaborate top level
set TOP_LEVEL_NAME "conv_tb_lib.cld_conv_tb"
eval vsim -t ps $TOP_LEVEL_NAME
