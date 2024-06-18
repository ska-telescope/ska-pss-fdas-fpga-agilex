# Script to run hsumddrin testbench with different generic values.
# Source in Modelsim/Questasim after compiling the relevant design units.
#
# From within modelsim:
#   source <path>/hsumddrin_tb.tcl
#
# From cygwin prompt:
#   <path>/vsim.exe -c -do "source <path>/hsumddrin_tb.tcl; exit" -l hsumddrin.log

foreach ddr {1 2 3} {
  foreach summer {1 2 3} {
    foreach harmonic {8 16} {
      vsim hsum_tb_lib.hsumddrin_tb -gddr_g=$ddr -gsummer_g=$summer -gharmonic_g=$harmonic
      run -all
      quit -sim
    }
  }
}


