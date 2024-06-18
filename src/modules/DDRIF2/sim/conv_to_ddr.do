onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ddrif2_tb/test_finished
add wave -noupdate /ddrif2_tb/testbench_passed_v
add wave -noupdate /ddrif2_tb/clk_sys_s
add wave -noupdate /ddrif2_tb/clk_pcie_s
add wave -noupdate /ddrif2_tb/clk_ddr_s
add wave -noupdate /ddrif2_tb/ddr_wr_en_s
add wave -noupdate -radix unsigned /ddrif2_tb/ddr_wr_addr_s
add wave -noupdate /ddrif2_tb/ddr_wr_data_s
add wave -noupdate /ddrif2_tb/ddr_wr_wait_request_s
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_proc_if_1/valid
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_proc_if_1/rx_data_proc
add wave -noupdate -radix unsigned /ddrif2_tb/ddrif2_i/rx_proc_if_1/rx_addr_proc
add wave -noupdate -radix unsigned /ddrif2_tb/ddrif2_i/muxin_2/ddr_addr
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_2/ddr_data
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_2/ddr_write
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_2/ddr_read
add wave -noupdate /ddrif2_tb/ddrif2_i/muxin_2/valid
add wave -noupdate /ddrif2_tb/ddrif2_i/wag_in_2/fifo_ready
add wave -noupdate /ddrif2_tb/ddrif2_i/wag_in_2/waddr
add wave -noupdate /ddrif2_tb/ddrif2_i/rag_in_2/wait_req
add wave -noupdate /ddrif2_tb/ddrif2_i/rag_in_2/raddr
add wave -noupdate /ddrif2_tb/ddrif2_i/rag_in_2/req
add wave -noupdate -radix unsigned /ddrif2_tb/ddrif2_i/rx_fifo_2/ddr_addr_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_2/ddr_data_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_2/ddr_read_out
add wave -noupdate /ddrif2_tb/ddrif2_i/rx_fifo_2/ddr_write_out
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 258
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
WaveRestoreZoom {0 ns} {6474 ns}
