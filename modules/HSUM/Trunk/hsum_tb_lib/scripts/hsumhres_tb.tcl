# Script to run hsumhres testbench with all possible generic values.
# Source in Modelsim/Questasim after compiling the relevant design units.
#
# From within modelsim:
#   source <path>/hsumhres_tb.tcl
#
# From cygwin prompt:
#   <path>/vsim.exe -c -do "source <path>/hsumhres_tb.tcl; exit" -l hsumhres.log

for {set harmonic 0} {$harmonic < 16} {incr harmonic} {
  foreach summer {1 2 3} {
    vsim hsum_tb_lib.hsumhres_tb -gharmonic_num_g=$harmonic -gsummer_g=$summer
    run -all
    quit -sim
  }
}


