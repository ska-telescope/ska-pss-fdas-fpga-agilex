onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ctrl_tb/test_finished
add wave -noupdate /ctrl_tb/testbench_passed_v
add wave -noupdate /ctrl_tb/clk_sys_s
add wave -noupdate /ctrl_tb/clk_mc_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/cld_timer_enable_s
add wave -noupdate -radix unsigned /ctrl_tb/ctrl_i/func_1/cld_proc_time_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/conv_timer_enable_s
add wave -noupdate -radix unsigned /ctrl_tb/ctrl_i/func_1/conv_proc_time_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/hsum_timer_enable_s
add wave -noupdate -radix unsigned /ctrl_tb/ctrl_i/func_1/hsum_proc_time_s
add wave -noupdate /ctrl_tb/rst_sys_n_s
add wave -noupdate /ctrl_tb/rst_mc_n_s
add wave -noupdate -radix unsigned /ctrl_tb/mcaddr_s
add wave -noupdate -radix unsigned /ctrl_tb/mcdatain_s
add wave -noupdate /ctrl_tb/mcms_s
add wave -noupdate /ctrl_tb/mcrwn_s
add wave -noupdate -radix unsigned /ctrl_tb/mcdataout_s
add wave -noupdate /ctrl_tb/overlap_size_s
add wave -noupdate /ctrl_tb/fop_sample_num_s
add wave -noupdate /ctrl_tb/ifft_loop_num_s
add wave -noupdate /ctrl_tb/cld_page_s
add wave -noupdate /ctrl_tb/conv_page_s
add wave -noupdate /ctrl_tb/hsum_page_s
add wave -noupdate /ctrl_tb/cld_enable_s
add wave -noupdate /ctrl_tb/conv_enable_s
add wave -noupdate /ctrl_tb/hsum_enable_s
add wave -noupdate /ctrl_tb/cld_trigger_s
add wave -noupdate /ctrl_tb/conv_trigger_s
add wave -noupdate /ctrl_tb/hsum_trigger_s
add wave -noupdate /ctrl_tb/cld_done_s
add wave -noupdate /ctrl_tb/conv_done_s
add wave -noupdate /ctrl_tb/hsum_done_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/man_cld_trig
add wave -noupdate /ctrl_tb/ctrl_i/func_1/cld_enable_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/cld_dm_trigger_s
add wave -noupdate /ctrl_tb/ctrl_i/func_1/cld_dm_trigger_ret_1_s
add wave -noupdate /ctrl_tb/cld_pause_check_s
add wave -noupdate /ctrl_tb/cld_pause_val_s
add wave -noupdate -radix unsigned /ctrl_tb/cld_pause_cnt_s
add wave -noupdate -radix unsigned /ctrl_tb/conv_pause_cnt_s
add wave -noupdate -radix unsigned /ctrl_tb/hsum_pause_cnt_s
add wave -noupdate /ctrl_tb/conv_fft_ready_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {326937 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {326892 ns} {327564 ns}
