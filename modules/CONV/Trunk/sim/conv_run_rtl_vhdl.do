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

# Compile CONV testbench design files
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/sincos_fp.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/sincos_fp_synth.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/conv_tb.vhd}
eval vcom -93 -work conv_tb_lib {$conv_dir/tb/hdl/conv_tb_bhv.vhd}

# Elaborate top level
set TOP_LEVEL_NAME "conv_tb_lib.conv_tb"
eval vsim -t ps $TOP_LEVEL_NAME
