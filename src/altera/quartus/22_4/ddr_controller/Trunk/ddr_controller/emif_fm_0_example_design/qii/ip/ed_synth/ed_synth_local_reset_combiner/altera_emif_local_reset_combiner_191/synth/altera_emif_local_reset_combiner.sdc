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


#####################################################################
#
# THIS IS AN AUTO-GENERATED FILE!
# -------------------------------
# If you modify this files, all your changes will be lost if you
# regenerate the core!
#
# FILE DESCRIPTION
# ----------------
# This file specifies the timing constraints for the EMIF local_reset_combiner
# component, which is instantiated as part of the EMIF example design.

# Relax timing for the async reset signal going into the reset synchronizer
# See RTL for the justification of setup=4 and hold=3
set tmp "reset_n_sync_inst|*"
set tmp_pin [get_pins -nowarn [list "${tmp}|clrn"]]
set tmp_reg [get_registers -nowarn $tmp]
set_multicycle_path -through $tmp_pin -to $tmp_reg -setup 4 -end
set_multicycle_path -through $tmp_pin -to $tmp_reg -hold  3 -end

# Relax timing for signal going into the local_reset_req_issp_n synchronizer
# setup=7 and hold=6 are somewhat arbitrary choices
set tmp "local_reset_req_issp_n_sync_inst|din_s1"
set tmp_pin [get_pins -nowarn [list "${tmp}|d" "${tmp}|*data"]]
set tmp_reg [get_registers -nowarn $tmp]
set_multicycle_path -through $tmp_pin -to $tmp_reg -setup 7 -end
set_multicycle_path -through $tmp_pin -to $tmp_reg -hold  6 -end

# Relax timing for signal going into the local_reset_req synchronizer
# setup=7 and hold=6 are somewhat arbitrary choices
set tmp "local_reset_req_sync_inst|din_s1"
set tmp_pin [get_pins -nowarn [list "${tmp}|d" "${tmp}|*data"]]
set tmp_reg [get_registers -nowarn $tmp]
set_multicycle_path -through $tmp_pin -to $tmp_reg -setup 7 -end
set_multicycle_path -through $tmp_pin -to $tmp_reg -hold  6 -end

# Relax timing for signal going into the local_reset_done synchronizer
# setup=7 and hold=6 are somewhat arbitrary choices
set tmp "status[*].local_reset_done_in_sync_inst|din_s1"
set tmp_pin [get_pins -nowarn [list "${tmp}|d" "${tmp}|*data"]]
set tmp_reg [get_registers -nowarn $tmp]
set_multicycle_path -through $tmp_pin -to $tmp_reg -setup 7 -end
set_multicycle_path -through $tmp_pin -to $tmp_reg -hold  6 -end
