set_global_assignment -entity "mult_fp_co" -library "lib_mult_fp_co" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "mult_fp_co" -library "lib_mult_fp_co" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "mult_fp_co" -library "lib_mult_fp_co" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_mult_fp_co" -name SPD_FILE [file join $::quartus(sip_path) "mult_fp_co.spd"]
set_global_assignment -library "lib_mult_fp_co" -name MISC_FILE [file join $::quartus(sip_path) "../mult_fp_co.qsys"]

set_global_assignment -library "lib_mult_fp_co" -name MISC_FILE [file join $::quartus(sip_path) "sim/mult_fp_co.vhd"]
set_global_assignment -library "lib_mult_fp_co" -name MISC_FILE [file join $::quartus(sip_path) "altera_fpdsp_block_151/sim/mult_fp_co_altera_fpdsp_block_151_vv4hvni.vhd"]
