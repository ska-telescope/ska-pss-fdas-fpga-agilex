onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pcif_tb/test_finished
add wave -noupdate /pcif_tb/testbench_passed_v
add wave -noupdate /pcif_tb/clk_mc_s
add wave -noupdate /pcif_tb/rst_mc_n_s
add wave -noupdate /pcif_tb/clk_pcie_s
add wave -noupdate /pcif_tb/rst_pcie_n_s
add wave -noupdate -radix unsigned /pcif_tb/pcif_i/mcif_1/timeout_cnt_s
add wave -noupdate /pcif_tb/rxm_wait_request_s
add wave -noupdate /pcif_tb/rxm_wait_request_ret_1_s
add wave -noupdate /pcif_tb/rxm_wait_request_ret_2_s
add wave -noupdate /pcif_tb/pcie_cnt_en_s
add wave -noupdate /pcif_tb/rxm_write_s
add wave -noupdate /pcif_tb/rxm_read_s
add wave -noupdate -radix unsigned /pcif_tb/rxm_address_s
add wave -noupdate -radix unsigned /pcif_tb/rxm_write_data_s
add wave -noupdate -radix unsigned /pcif_tb/rxm_byte_enable_s
add wave -noupdate /pcif_tb/rxm_write_response_valid_s
add wave -noupdate /pcif_tb/rxm_response_s
add wave -noupdate -radix unsigned /pcif_tb/mcaddr_s
add wave -noupdate /pcif_tb/mccs_s
add wave -noupdate /pcif_tb/mcrwn_s
add wave -noupdate -radix unsigned /pcif_tb/mcdatain_s
add wave -noupdate -radix unsigned /pcif_tb/mcdataout_s
add wave -noupdate /pcif_tb/pcie_en_s
add wave -noupdate /pcif_tb/pcie_en_rt_1_s
add wave -noupdate -radix unsigned /pcif_tb/pcie_ba_addr_s
add wave -noupdate /pcif_tb/next_write_s
add wave -noupdate /pcif_tb/pcif_i/mcif_1/valid_set_s
add wave -noupdate -radix unsigned /pcif_tb/rxm_read_data_s
add wave -noupdate /pcif_tb/rxm_read_data_vald_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55324 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 307
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
WaveRestoreZoom {54947 ns} {55571 ns}
