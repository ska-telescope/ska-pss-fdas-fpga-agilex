onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ctrl_tb/clk_sys_s
add wave -noupdate /ctrl_tb/rst_sys_n_s
add wave -noupdate /ctrl_tb/conv_wr_en_gap_s
add wave -noupdate /ctrl_tb/conv_waitreq_gap_s
add wave -noupdate /ctrl_tb/enable_conv_access_s
add wave -noupdate /ctrl_tb/enable_conv_access_ret_1_s
add wave -noupdate /ctrl_tb/enable_conv_access_ret_2_s
add wave -noupdate /ctrl_tb/conv_count_en_s
add wave -noupdate /ctrl_tb/conv_wr_en_gap_cnt_s
add wave -noupdate /ctrl_tb/conv_waitreq_gap_cnt_s
add wave -noupdate /ctrl_tb/conv_wr_en_s
add wave -noupdate /ctrl_tb/conv_waitreq_s
add wave -noupdate /ctrl_tb/conv_request_cnt_s
add wave -noupdate /ctrl_tb/hsum_rd_en_gap_s
add wave -noupdate /ctrl_tb/hsum_waitreq_gap_s
add wave -noupdate /ctrl_tb/enable_hsum_read_access_s
add wave -noupdate /ctrl_tb/enable_hsum_read_access_ret_1_s
add wave -noupdate /ctrl_tb/enable_hsum_read_access_ret_2_s
add wave -noupdate /ctrl_tb/hsum_read_count_en_s
add wave -noupdate /ctrl_tb/hsum_rd_en_gap_cnt_s
add wave -noupdate /ctrl_tb/hsum_waitreq_gap_cnt_s
add wave -noupdate /ctrl_tb/hsum_rd_en_s
add wave -noupdate /ctrl_tb/hsum_waitreq_s
add wave -noupdate /ctrl_tb/hsum_request_cnt_s
add wave -noupdate /ctrl_tb/hsum_valid_gap_s
add wave -noupdate /ctrl_tb/enable_hsum_valid_access_s
add wave -noupdate /ctrl_tb/enable_hsum_valid_access_ret_1_s
add wave -noupdate /ctrl_tb/enable_hsum_valid_access_ret_2_s
add wave -noupdate /ctrl_tb/hsum_valid_count_en_s
add wave -noupdate /ctrl_tb/hsum_valid_gap_cnt_s
add wave -noupdate /ctrl_tb/hsum_valid_s
add wave -noupdate /ctrl_tb/hsum_valid_cnt_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1097 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
configure wave -valuecolwidth 132
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {10179 ns} {32728 ns}
