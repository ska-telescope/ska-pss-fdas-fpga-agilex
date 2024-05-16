# (C) 2001-2022 Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License Subscription 
# Agreement, Intel FPGA IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Intel and sold by 
# Intel or its authorized distributors.  Please refer to the applicable 
# agreement for further details.



# Ref. https://www.intel.com/content/www/us/en/docs/programmable/683068/18-1/clock-divider-example-divide-by.html

if [info exists inst] {
  unset inst
  }
# Get the current Native PCIe IP instance
set inst [get_current_instance]

      set mcdma_slow_clk_src ${inst}|gen_agilex.pcie_clk_divider_inst|inclk
      set mcdma_slow_clk_div4 ${inst}|gen_agilex.pcie_clk_divider_inst|clock_div4
      create_generated_clock -name slow_clk -divide_by 4 -source [get_pins $mcdma_slow_clk_src] [get_pins $mcdma_slow_clk_div4]
   set_false_path -to [get_registers -nowarn ${inst}|*p0_slow_reset_status_n_sync_inst|din_s1]
   set_false_path -to [get_registers -nowarn ${inst}|*mcdma|gen_enable_cpl_timeout.cpl_timeout_sync_inst|din_s1]

# Recovery and Removal Timing Violation Warnings when Compiling a DCFIFO
set_false_path -to [get_registers -nowarn ${inst}|*dcfifo_cpl_to|auto_generated|wraclr|dffe*a[0]]
set_false_path -to [get_registers -nowarn ${inst}|*dcfifo_cpl_to|auto_generated|rdaclr|dffe*a[0]]


