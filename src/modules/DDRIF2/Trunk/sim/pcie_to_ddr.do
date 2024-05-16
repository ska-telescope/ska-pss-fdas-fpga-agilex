onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ddrif2_tb/test_finished
add wave -noupdate /ddrif2_tb/testbench_passed_v
add wave -noupdate /ddrif2_tb/clk_sys_s
add wave -noupdate /ddrif2_tb/clk_pcie_s
add wave -noupdate /ddrif2_tb/clk_ddr_s
add wave -noupdate /ddrif2_tb/rd_dma_wait_request_s
add wave -noupdate /ddrif2_tb/rd_dma_address_s
add wave -noupdate /ddrif2_tb/rd_dma_burst_count_s
add wave -noupdate /ddrif2_tb/rd_dma_byte_en_s
add wave -noupdate /ddrif2_tb/rd_dma_write_s
add wave -noupdate /ddrif2_tb/rd_dma_write_data_s
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_pcie_if_1/valid
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_pcie_if_1/rx_addr_pcie
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_pcie_if_1/rx_data_pcie
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_1/valid
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_1/ddr_addr
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_1/ddr_data
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_1/ddr_read
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_1/ddr_write
add wave -noupdate /ddrif2_tb/ddrif2_i/wag_in_1/fifo_ready
add wave -noupdate /ddrif2_tb/ddrif2_i/wag_in_1/waddr
add wave -noupdate /ddrif2_tb/ddrif2_i/rag_in_1/raddr
add wave -noupdate /ddrif2_tb/ddrif2_i/rag_in_1/req
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_1/ddr_addr_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_1/ddr_data_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_1/ddr_read_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_1/ddr_write_out
add wave -noupdate -radix unsigned /ddrif2_tb/ddrif2_i/rx_mux_1/ddr_addr_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_mux_1/ddr_data_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_mux_1/read_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_mux_1/write_out
add wave -noupdate /ddrif2_tb/amm_wait_request_s
add wave -noupdate -radix unsigned /ddrif2_tb/amm_address_s
add wave -noupdate /ddrif2_tb/amm_write_data_s
add wave -noupdate /ddrif2_tb/amm_write_s
add wave -noupdate /ddrif2_tb/amm_read_s
add wave -noupdate /ddrif2_tb/amm_read_data_valid_s
add wave -noupdate /ddrif2_tb/amm_read_data_s
add wave -noupdate /ddrif2_tb/ddrif2_i/ddr_mux_1/pcie_amm_read_data_valid
add wave -noupdate /ddrif2_tb/ddrif2_i/ddr_mux_1/proc_amm_read_data_valid
add wave -noupdate /ddrif2_tb/ddrif2_i/ddr_mux_1/amm_read_data_out
add wave -noupdate /ddrif2_tb/ddr_rd_data_valid_s
add wave -noupdate /ddrif2_tb/ddr_rd_data_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65589 ns} 0}
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
WaveRestoreZoom {65447 ns} {65643 ns}
