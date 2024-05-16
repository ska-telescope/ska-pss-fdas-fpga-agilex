set_global_assignment -entity "multadd_fp_ci" -library "lib_multadd_fp_ci" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "multadd_fp_ci" -library "lib_multadd_fp_ci" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "multadd_fp_ci" -library "lib_multadd_fp_ci" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_multadd_fp_ci" -name SPD_FILE [file join $::quartus(sip_path) "multadd_fp_ci.spd"]
set_global_assignment -library "lib_multadd_fp_ci" -name MISC_FILE [file join $::quartus(sip_path) "../multadd_fp_ci.qsys"]

set_global_assignment -library "lib_multadd_fp_ci" -name MISC_FILE [file join $::quartus(sip_path) "sim/multadd_fp_ci.vhd"]
set_global_assignment -library "lib_multadd_fp_ci" -name MISC_FILE [file join $::quartus(sip_path) "altera_fpdsp_block_151/sim/multadd_fp_ci_altera_fpdsp_block_151_tfmq2sa.vhd"]
