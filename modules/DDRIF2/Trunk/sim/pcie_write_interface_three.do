onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ddrif2_tb/test_finished
add wave -noupdate /ddrif2_tb/testbench_passed_v
add wave -noupdate /ddrif2_tb/clk_pcie_s
add wave -noupdate /ddrif2_tb/rst_pcie_n_s
add wave -noupdate /ddrif2_tb/rd_dma_address_1_s
add wave -noupdate /ddrif2_tb/rd_dma_address_2_s
add wave -noupdate /ddrif2_tb/rd_dma_address_3_s
add wave -noupdate /ddrif2_tb/rd_dma_write_1_s
add wave -noupdate /ddrif2_tb/rd_dma_write_2_s
add wave -noupdate /ddrif2_tb/rd_dma_write_3_s
add wave -noupdate /ddrif2_tb/rd_dma_write_data_1_s
add wave -noupdate /ddrif2_tb/rd_dma_write_data_2_s
add wave -noupdate /ddrif2_tb/rd_dma_write_data_3_s
add wave -noupdate /ddrif2_tb/rd_dma_burst_count_1_s
add wave -noupdate /ddrif2_tb/rd_dma_burst_count_2_s
add wave -noupdate /ddrif2_tb/rd_dma_burst_count_3_s
add wave -noupdate /ddrif2_tb/rd_dma_byte_en_1_s
add wave -noupdate /ddrif2_tb/rd_dma_byte_en_2_s
add wave -noupdate /ddrif2_tb/rd_dma_byte_en_3_s
add wave -noupdate /ddrif2_tb/rd_dma_wait_request_1_s
add wave -noupdate /ddrif2_tb/rd_dma_wait_request_2_s
add wave -noupdate /ddrif2_tb/rd_dma_wait_request_3_s
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
