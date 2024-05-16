#!/bin/sh
# restart with tclsh \
exec tclsh "$0" "$@"

# Script to checkout everything to build FDAS (with Quartus 22.2).

# It will create the following directory structure in the directory from which it
# is run.

#          .
#          |
#     +----+----+
#     |         |
# fdas_top   Projects
#               |
#              SKA
#               |
#     +------+--+-+----+-----+------+---------+--------+-------+-----+-----+-------+-----+
#     |      |    |    |     |      |         |        |       |     |     |       |     |
#   altera  CLD CONV CTRL DDRIF2 DSP_PRIM FDAS_CORE FDAS_TOP HSUM MCI_TOP MSIX PCIE_HIP PCIF
#     |
#   quartus
#     |
#     21.3
#     |
#     +-----------+--------------+-----------+-----------+-------------+-----------+-------+-------+--------+---------+
#     |           |              |           |           |             |           |       |       |        |         |
#   clkgen ddr_controller ddr_controller mult_fp_co multadd_fp_ci multsub_fp_ci fft1024 fp_add ifft1024 pcie_hip reset_release
#
#
# Before opening the project in Quartus, modifiy the source paths in 'fdas_top.qsf'.

set repo https://covneticssrv2.covnetics.local:8443/svn/UoM/projects/FDAS4_AGILEX_2_DDR_FOP
set target "Projects/SKA"

# Get Quartus project.
puts "Getting Quartus project ..."
#exec svn co $repo/Build/quartus_222/fdas_top/Trunk/fdas_top

# Sources will be stored under './Projects/SKA'.
file mkdir $target/altera/quartus/22.2

# Get Quartus IP designs.
set iplist {clkgen ddr_controller mult_fp_co multadd_fp_ci multsub_fp_ci \
            fp_add fft1024 ifft1024 pcie_hip reset_release}
foreach ip $iplist {
  puts "Getting IP $ip ..."
  exec svn co $repo/External/quartus_222/$ip/Trunk/$ip $target/altera/quartus/22.2/$ip
}

# Get modules.
set rev 2286 ;# Default revision.
set modulelist     {CLD  CONV CTRL DDRIF2 DSP_PRIM FDAS_CORE FDAS_TOP HSUM MCI_TOP MSIX PCIE_HIP PCIF}
set revisions [list 2237 2242 2247 2252   2255     2260      2263     2268 2273    2278 2334     2286]
foreach module $modulelist rev $revisions {
  puts "Getting module $module revision $rev ..."
  exec svn co -r $rev $repo/modules/$module/Trunk/[string tolower $module]_lib $target/$module
}

# Copy memory initialization files from fft1024 to project dir.
# (Don't know why this is necessary, but compilation fails without them there.)
#file copy {*}[glob $target/altera/quartus/22.2/fft1024/fft1024/intel_FPGA_unified_fft_101/synth/*.hex] fdas_top

