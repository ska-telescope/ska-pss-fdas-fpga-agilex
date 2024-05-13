onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mci_top_tb/testbench_passed_v
add wave -noupdate /mci_top_tb/test_finished
add wave -noupdate /mci_top_tb/clk_mc_s
add wave -noupdate /mci_top_tb/rst_mc_n_s
add wave -noupdate -radix hexadecimal /mci_top_tb/product_id_s
add wave -noupdate /mci_top_tb/core_revision_s
add wave -noupdate /mci_top_tb/core_version_s
add wave -noupdate /mci_top_tb/top_revision_s
add wave -noupdate /mci_top_tb/top_version_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcaddr_pcif_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdatain_pcif_s
add wave -noupdate /mci_top_tb/mcrwn_pcif_s
add wave -noupdate /mci_top_tb/mccs_pcif_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdataout_pcif_s
add wave -noupdate /mci_top_tb/mcms_ctrl_s
add wave -noupdate /mci_top_tb/mcms_conv_s
add wave -noupdate /mci_top_tb/mcms_hsum_s
add wave -noupdate /mci_top_tb/mcms_msix_s
add wave -noupdate /mci_top_tb/resetn_s
add wave -noupdate /mci_top_tb/ctrl_resetn_s
add wave -noupdate /mci_top_tb/cld_resetn_s
add wave -noupdate /mci_top_tb/conv_resetn_s
add wave -noupdate /mci_top_tb/hsum_resetn_s
add wave -noupdate /mci_top_tb/msix_resetn_s
add wave -noupdate /mci_top_tb/ddrif_1_resetn_s
add wave -noupdate /mci_top_tb/ddrif_2_resetn_s
add wave -noupdate /mci_top_tb/ddr_1_resetn_s
add wave -noupdate /mci_top_tb/ddr_2_resetn_s
add wave -noupdate /mci_top_tb/ddr_1_reset_done_s
add wave -noupdate /mci_top_tb/ddr_1_cal_fail_s
add wave -noupdate /mci_top_tb/ddr_1_cal_pass_s
add wave -noupdate /mci_top_tb/ddr_2_cal_fail_s
add wave -noupdate /mci_top_tb/ddr_2_cal_pass_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdataout_ctrl_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdataout_conv_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdataout_hsum_s
add wave -noupdate -radix hexadecimal /mci_top_tb/mcdataout_msix_s
add wave -noupdate /mci_top_tb/mcdataout_msix_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {341 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {1291 ns} {2301 ns}
