#!/cygdrive/C/ActiveTcl/bin/tclsh

# Tcl script to compile module and testbenches in Modelsim or Questasim.
#
# Run this script in the directory where the simulation is to be run (but do not move this script).
#   e.g. : ../hsum_tb_lib/scripts/compile.tcl
#
# If a command line argument is supplied, then compiling the Intel IP libraries will be skipped
# and just the design libraries will be compiled.

# Follow these steps:
# Step 1:
# If not using the Intel free version of Modelsim, then the Intel libraries must be compiled first
# using the Quartus Library Compiler (Tools menu -> Launch Simulation Library Compiler) and set the
# paths 'alt_lib_vhdl' & 'alt_lib_ver', below, to the correct path that you have chosen.
# In the Quartus Library Compiler Launch Simulation Library Compiler screen ensure that the 
# Questa version you want to use is stated.
# For Quartus Prime 21.3 it has been found that Questa 2021.4 works OK.

# Step 2:
# Also on your PC right click on the Windows Start and select "system". On the right side of the system screen
# select "Advanced System Settings" and click the "Environment Variables" button on the screen that appears.
# In the screen that appears in the user variables select "PATH" in the table and then click the edit button.
# Move the Questa version you want to use to be above any other Questa version. This will ensure the PC will look
# in that Questa version to find the VCOM, VLIB commands etc.

# Step 3:
# On your PC create a directory where you will do the simulation work (i.e. where the libraries will be compiled into), this
# will also be where you will need to "cd" to in the Questa command line.

#Step 4:
# Bring up a windows command window and CD to the directory you created where the libraries will be complied and use a tcl 
# shell to run this compile script.
# e.g. tclsh C:/AGILEX_BUILD_AREA/HSUM/hsum_tb_lib/scripts/compile.tcl
# You can check that the tclsh is using the correct Questa version by typing "vcom -version" in the windows command window
# and check it is one you desired via the "Environment Variables"

#Step 5:
# If Questa is launched the individual test benches can be run using the comments at the end of this script.
# Make sure on tne Questa command line you "cd" to the directory where your compiled files are.
# It should also be possible to run the test benches in the tclsh in the windows command line, which will launch questa
# The easiest way to run any tcl scripts that check operation with different generic settings is to copy the scripts from 
# hsum_tb_lib/scripts directory to where your compiled files are and then in the Questa command line window just source the
# script, e.g source hsumddrin_tb.tcl.


if {![info exists env(SETUP)] || $env(SETUP) ne "FREE_MENTOR"} {
  # Define path to Altera compiled VHDL libraries.
  set alt_lib_vhdl "E:/INTEL_QUARTUS_AGILEX_COMPILE_OUTPUT/vhdl_libs"
  set alt_lib_ver "E:/INTEL_QUARTUS_AGILEX_COMPILE_OUTPUT/verilog_libs"
  exec vmap altera_mf [file join $alt_lib_vhdl altera_mf]
  exec vmap tennm [file join $alt_lib_vhdl tennm]
}

# Set paths to source files.
set hsum_lib_src [file normalize [file join [file dirname [info script]] .. .. hsum_lib hdl]]
if {![file exists $hsum_lib_src]} {
  set hsum_lib_src [file normalize [file join [file dirname [info script]] .. .. HSUM hdl]]
  if {![file exists $hsum_lib_src]} {
    puts "ERROR: Cannot find hsum_lib source files!"
    exit 1
  }
}
set hsum_tb_lib_src [file normalize [file join [file dirname [info script]] .. hdl]]

# Create questa library directories.
foreach lib {hsum_lib hsum_tb_lib s20_native_floating_point_dsp_1910} {
  if {![file exist $lib]} {
    puts "Creating library $lib ..."
    exec vlib $lib
  }
  exec vmap $lib $lib
}

# Compile.
foreach lib {hsum_lib hsum_tb_lib} src [list $hsum_lib_src $hsum_tb_lib_src] {

  # Sort list of source files into packages, architectures and entities.
  set packages {}
  set architectures {}
  set entities {}
  set globs [glob -dir $src *.vhd]
  foreach file $globs {
    switch -glob $file {
      *_synth.vhd -
      *_struc.vhd -
      *_scm.vhd -
      *_stim.vhd  {lappend architectures $file}
      *_pkg.vhd   {lappend packages $file}
      default     {lappend entities $file}
    }
  }

  # Compile files.
  puts "\nCompiling library $lib ..."
  set errors 0
  set files [concat $packages $entities $architectures]
  foreach file $files {
    puts -nonewline "  [file tail $file] : "
    if {[catch {exec vcom -2008 -work $lib $file} err]} {
      puts "FAILED\n    $err"
      incr errors
    } else {
      puts "OK"
    }
  }
  puts "[llength $files] compiled, $errors errors."
}


puts "\nExecute the following commands either in tclsh or on the questa command line to compile the altera IP:\n"
puts "  vcom -2008 -work s20_native_floating_point_dsp_1910 <path>/fp_add/s20_native_floating_point_dsp_1910/sim/fp_add_s20_native_floating_point_dsp_1910_646nw2y.vhd"
puts "  vcom -2008 -work hsum_lib <path>/fp_add/sim/fp_add.vhd"
puts "\nRun top level sim with command:"
puts "  vsim -t 10ps -work hsum_tb_lib -L tennm hsum_tb -do \"run -all; quit -f\""
puts ""

# To run hsum_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsum_tb -do
# then type
# run -all

# To run hsumddrin_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumddrin_tb -do
# then type
# run -all

# To run hsumfilt_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumfilt_tb -do
# then type
# run -all

# To run hsumhpsel_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumhpsel_tb -do
# then type
# run -all

# To run hsumhres_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumhres_tb  -gharmonic_num_g=8 -gsummer_g=1 -do
# then type
# run -all

# To run hsumtgen_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumtgen_tb -do
# then type
# run -all

# To run hsumsummer_tb type in the modelsim command window
# vsim -t 10ps -work hsum_tb_lib -L tennm hsumsummer_tb -do
# then type
# run -all
