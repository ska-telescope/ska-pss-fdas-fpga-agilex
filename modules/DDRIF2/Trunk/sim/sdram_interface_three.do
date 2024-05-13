onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ddrif2_tb/test_finished
add wave -noupdate /ddrif2_tb/testbench_passed_v
add wave -noupdate /ddrif2_tb/clk_ddr_1_s
add wave -noupdate /ddrif2_tb/clk_ddr_2_s
add wave -noupdate /ddrif2_tb/clk_ddr_3_s
add wave -noupdate /ddrif2_tb/rst_ddr_n_1_s
add wave -noupdate /ddrif2_tb/rst_ddr_n_2_s
add wave -noupdate /ddrif2_tb/rst_ddr_n_3_s
add wave -noupdate /ddrif2_tb/amm_address_1_s
add wave -noupdate /ddrif2_tb/amm_address_2_s
add wave -noupdate /ddrif2_tb/amm_address_3_s
add wave -noupdate /ddrif2_tb/amm_write_1_s
add wave -noupdate /ddrif2_tb/amm_write_2_s
add wave -noupdate /ddrif2_tb/amm_write_3_s
add wave -noupdate /ddrif2_tb/amm_write_data_1_s
add wave -noupdate /ddrif2_tb/amm_write_data_2_s
add wave -noupdate /ddrif2_tb/amm_write_data_3_s
add wave -noupdate /ddrif2_tb/amm_read_1_s
add wave -noupdate /ddrif2_tb/amm_read_2_s
add wave -noupdate /ddrif2_tb/amm_read_3_s
add wave -noupdate /ddrif2_tb/amm_wait_request_1_s
add wave -noupdate /ddrif2_tb/amm_wait_request_2_s
add wave -noupdate /ddrif2_tb/amm_wait_request_3_s
add wave -noupdate /ddrif2_tb/amm_read_data_1_s
add wave -noupdate /ddrif2_tb/amm_read_data_2_s
add wave -noupdate /ddrif2_tb/amm_read_data_3_s
add wave -noupdate /ddrif2_tb/amm_read_data_valid_1_s
add wave -noupdate /ddrif2_tb/amm_read_data_valid_2_s
add wave -noupdate /ddrif2_tb/amm_read_data_valid_3_s
add wave -noupdate /ddrif2_tb/amm_burstcount_1_s
add wave -noupdate /ddrif2_tb/amm_burstcount_2_s
add wave -noupdate /ddrif2_tb/amm_burstcount_3_s
add wave -noupdate /ddrif2_tb/amm_byte_en_1_s
add wave -noupdate /ddrif2_tb/amm_byte_en_2_s
add wave -noupdate /ddrif2_tb/amm_byte_en_3_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82602 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 341
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
WaveRestoreZoom {0 ns} {100286 ns}
