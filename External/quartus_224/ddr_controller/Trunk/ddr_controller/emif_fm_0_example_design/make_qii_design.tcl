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



proc error_and_exit {msg} {
   post_message -type error "SCRIPT_ABORTED!!!"
   foreach line [split $msg "\n"] {
      post_message -type error $line
   }
   qexit -error
}

proc ls_recursive {base glob} {
    set files [list]

    foreach f [glob -nocomplain -types f -directory $base $glob] {
        set file_path [file join $base $f]
        lappend files $file_path
    }

    foreach d [glob -nocomplain -types d -directory $base *] {
        set files_recursive [ls_recursive [file join $base $d] $glob]
        lappend files {*}$files_recursive
    }

    return $files
}

proc get_relative_path {base path} {
    return [string trimleft [ string range $path [string length $base] [string length $path] ] "/"]
}

proc deep_copy {ifn ofn} {
   set ifh       [open $ifn r]
   set ofh       [open $ofn w]
   
   fconfigure $ifh -translation binary
   fconfigure $ofh -translation binary
   
   set blob [read $ifh]
   puts -nonewline $ofh $blob

   close $ofh
   close $ifh
}

if {[string compare -nocase $quartus(nameofexecutable) "quartus"] == 0} {
   set gui_mode 1
} else {
   set gui_mode 0
}

set script_path [file dirname [file normalize [info script]]]

source "$script_path/params.tcl"

if {[is_project_open]} {
   post_message "Closing currently opened project..."
   project_close
}

set ex_design_path         "$script_path/qii"
set system_name            $ed_params(SYNTH_QSYS_NAME)
set qsys_file              "${system_name}.qsys"
set family                 $ip_params(SYS_INFO_DEVICE_FAMILY)
set issp_en                $ip_params(DIAG_EX_DESIGN_ISSP_EN)

set arg [lindex $argv 0]
if {$argc > 1} {
   error_and_exit "make_qii_design.tcl can only take one argument.\nThe argument must be a valid device OPN,"
} elseif {$argc == 1} {
   set device $arg 
} else {
   set device $ed_params(DEFAULT_DEVICE)
}

post_message " "
post_message "*************************************************************************"
post_message "Intel External Memory Interface IP Example Design Builder"
post_message " "
post_message "Type  : Quartus Prime Project"
post_message "Family: $family"
post_message "Device: $device"
post_message " "
post_message "This script takes ~1 minute to execute..."
post_message "*************************************************************************"
post_message " "

if {[file isdirectory $ex_design_path]} {
   error_and_exit "Directory $ex_design_path has already been generated.\nThis script cannot overwrite generated example designs.\nIf you would like to regenerate the design by re-running the script, please remove the directory."
}

file mkdir $ex_design_path
file copy -force "${script_path}/$qsys_file" "${ex_design_path}/$qsys_file"

file mkdir "${ex_design_path}/ip"
file copy -force "${script_path}/ip/${system_name}" "${ex_design_path}/ip/."

deep_copy "$::env(QUARTUS_ROOTDIR)/../ip/altera/emif/ip_top/ex_design/jtag_example.sdc" "${ex_design_path}/jtag_example.sdc"

if {[file exists "${script_path}/quartus.ini"]} {
   file copy -force "${script_path}/quartus.ini" "${ex_design_path}/quartus.ini"
}

post_message "Generating example design files..."

set qsys_generate_exe_path "$::env(QUARTUS_ROOTDIR)/sopc_builder/bin/qsys-generate"

cd $ex_design_path
exec -ignorestderr $qsys_generate_exe_path $qsys_file --pro --quartus-project=none --synthesis --family=$family --part=$device >>& ip_generate.out

post_message "Creating Quartus Prime project..."
project_new -family $family -part $device $system_name
set_global_assignment -name QSYS_FILE ${system_name}.qsys

if {$issp_en} {
   set_global_assignment -name VERILOG_MACRO "\"ALTERA_EMIF_ENABLE_ISSP=1\""
}
foreach ip_file [lsort [ls_recursive "${ex_design_path}/ip" "*.ip"]] {
   set ip_file [get_relative_path $ex_design_path $ip_file]
   set_global_assignment -name IP_FILE $ip_file
}

set_global_assignment -name SDC_FILE jtag_example.sdc

if ([string match "1SG10MHN3F74C2LGS1*"  $device]) {
    set_global_assignment -name ASIC_PROTOTYPING on 
}

project_close

if {$gui_mode} {
   project_open $system_name
}

post_message " "
post_message "*************************************************************************"
post_message "Successfully generated example design at the following location:"
post_message " "
post_message "   $ex_design_path"
post_message " "
post_message "*************************************************************************"
post_message " "
