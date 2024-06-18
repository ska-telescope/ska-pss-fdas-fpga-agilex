The two scripts in this folder are used to compile the HSUM design in Questa to allow HSUM test benches to be run.

These two scripts essentially do the same task as the compile.tcl script that is in the hsum_tb_lib/scripts folder 
except that these two scripts can be sourced directly in the Questa command window instead of having to launch a 
windows command DOS window and using tclsh.

The hsum_local_msim_compiled_intel_libraries.tcl script is self contained and will compile HSUM libraries and all the necessary Intel
libraries via calling the msim_setup.tcl script from the fp_add folder for the Intel floating poin adder. This script
does take some time to run but it easy to use as it is self contained. It can be run by sourcing it in the Questa
command window after changing directory in Questa to where this scripy is located i.e:
source hsum_local_msim_compiled_intel_libraries.tcl

The hsum_quartus_compiled_intel_libraries.tcl script complies all HSUM libraries but relies on the Intel libraries being first
compiled in the Quartus Prime tool. 
This script is faster than hsum_local_msim_compiled_intel_libraries.tcl . It can be run by sourcing it in the Questa
command window after changing directory in Questa to where this scripy is located i.e:
source hsum_quartus_compiled_intel_libraries.tcl

Once the hsum_local_msim_compiled_intel_libraries.tcl or hsum_quartus_compiled_intel_libraries.tcl scripts have been run
the desired HSUM test benches can be run by following the comments in the scripts.