To prepare and run simulation:

1. copy common, mentor and modelsim.ini to sim directory
2. run up QuestaSim in sim directory
3. check compile options that:
       VHDL, "Language Syntax" is set to "Use 1076-2008"
       SystemC, "Custom g++ compiler path" is ticked and "Compiler path" is set to point to g++ executable (should be in Quartus installation directory)        e.g. E:/questasim64_2022.2/questa_sim-win64-gcc-7.4.0-mingw64vc15/gcc-7.4.0-mingw64vc15/bin/g++.exe
4. source fdas_core_run_msim_rtl_vhdl.do
