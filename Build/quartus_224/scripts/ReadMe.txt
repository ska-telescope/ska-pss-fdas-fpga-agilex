fdas4_co.tcl
===========
Script to check out the Quartus project directory 'fdas_top' (for Quartus 22.4)
and all source files.

Put this file in run directory and double click on file in Windows file browser
or
Open Command Prompt or Powershell in run directory
run command tclsh
source fdas4_co.tcl

It will create the following directory structure in the directory from which it
is run.

         .
         |
    +----+----+
    |         |
fdas_top   Projects
              |
             SKA
              |
    +------+--+-+----+-----+------+---------+--------+-------+-----+-----+------+-----+
    |      |    |    |     |      |         |        |       |     |     |      |     |
  altera  CLD CONV CTRL DDRIF2 DSP_PRIM FDAS_CORE FDAS_TOP HSUM MCI_TOP MSI PCIE_HIP PCIF
    |
  quartus
    |
   22.4
    |
    +---------------+----------------------+------------+--------+------+--------+--------+
    |               |                      |            |        |      |        |        |
   clkgen ddr_controller_master ddr_controller_slave dsp_prim fft1024 fp_add ifft1024 pcie_hip


Before opening the project in Quartus, modifiy the source paths in 'fdas_top.qsf'.
