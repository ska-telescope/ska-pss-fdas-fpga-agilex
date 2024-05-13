onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ddrif2_tb/test_finished
add wave -noupdate /ddrif2_tb/testbench_passed_v
add wave -noupdate /ddrif2_tb/clk_sys_s
add wave -noupdate /ddrif2_tb/clk_pcie_s
add wave -noupdate /ddrif2_tb/clk_ddr_s
add wave -noupdate /ddrif2_tb/ddr_wr_wait_request_s
add wave -noupdate /ddrif2_tb/ddr_wr_en_s
add wave -noupdate /ddrif2_tb/ddr_wr_addr_s
add wave -noupdate /ddrif2_tb/ddr_wr_data_s
add wave -noupdate /ddrif2_tb/rd_dma_wait_request_s
add wave -noupdate /ddrif2_tb/rd_dma_write_s
add wave -noupdate /ddrif2_tb/rd_dma_address_s
add wave -noupdate /ddrif2_tb/rd_dma_write_data_s
add wave -noupdate /ddrif2_tb/rd_dma_byte_en_s
add wave -noupdate /ddrif2_tb/rd_dma_burst_count_s
add wave -noupdate /ddrif2_tb/ddr_rd_wait_request_s
add wave -noupdate /ddrif2_tb/ddr_rd_en_s
add wave -noupdate /ddrif2_tb/ddr_rd_data_s
add wave -noupdate /ddrif2_tb/wr_dma_wait_request_s
add wave -noupdate /ddrif2_tb/wr_dma_read_s
add wave -noupdate /ddrif2_tb/wr_dma_address_s
add wave -noupdate /ddrif2_tb/wr_dma_burst_count_s
add wave -noupdate /ddrif2_tb/amm_wait_request_s
add wave -noupdate /ddrif2_tb/amm_write_s
add wave -noupdate /ddrif2_tb/amm_read_s
add wave -noupdate -radix unsigned /ddrif2_tb/amm_address_s
add wave -noupdate /ddrif2_tb/amm_write_data_s
add wave -noupdate /ddrif2_tb/amm_read_data_valid_s
add wave -noupdate /ddrif2_tb/amm_read_data_s
add wave -noupdate /ddrif2_tb/ddr_rd_data_valid_s
add wave -noupdate /ddrif2_tb/ddr_rd_data_s
add wave -noupdate /ddrif2_tb/wr_dma_read_data_valid_s
add wave -noupdate /ddrif2_tb/wr_dma_read_data_s
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
