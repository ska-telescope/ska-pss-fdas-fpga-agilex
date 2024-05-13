onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /msix_tb/testbench_passed_v
add wave -noupdate /msix_tb/test_finished
add wave -noupdate /msix_tb/clk_sys_s
add wave -noupdate /msix_tb/clk_pcie_s
add wave -noupdate /msix_tb/clk_mc_s
add wave -noupdate /msix_tb/mcms_s
add wave -noupdate /msix_tb/mcrwn_s
add wave -noupdate /msix_tb/mcaddr_s
add wave -noupdate /msix_tb/mcdatain_s
add wave -noupdate /msix_tb/mcdataout_s
add wave -noupdate /msix_tb/cld_done_s
add wave -noupdate /msix_tb/msix_i/pulsedet_1/cld_toggle_s
add wave -noupdate /msix_tb/conv_done_s
add wave -noupdate /msix_tb/msix_i/pulsedet_1/conv_toggle
add wave -noupdate /msix_tb/hsum_done_s
add wave -noupdate /msix_tb/msix_i/pulsedet_1/hsum_toggle
add wave -noupdate /msix_tb/usr_event_msix_ready_s
add wave -noupdate /msix_tb/usr_event_msix_valid_s
add wave -noupdate /msix_tb/usr_event_msix_data_s
add wave -noupdate /msix_tb/usr_event_msix_valid_latch_s
add wave -noupdate /msix_tb/enable_msix_check_single_s
add wave -noupdate /msix_tb/enable_msix_check_single_ret_s
add wave -noupdate /msix_tb/usr_event_msix_ready_cnt_s
add wave -noupdate /msix_tb/enable_msix_check_single_s
add wave -noupdate /msix_tb/enable_msix_check_multiple_ret_s
add wave -noupdate /msix_tb/enable_msix_check_multiple_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2665 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
configure wave -valuecolwidth 144
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
WaveRestoreZoom {2641 ns} {2681 ns}
