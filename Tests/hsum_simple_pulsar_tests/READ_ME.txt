Each folder of 10 folders "HSUM_SIMPLE_PULSAR_TEST_HARM_0_0_0_0_0_0_0_0" contains the complete set of informaton to perform a test
of HSUM.

In each folder there is a MATLAB script (eg fop_simple_pulsar_test.m) that describes which frequency bins in the FOP will 
contain non-zero power values, and when run this script creates the FOP_BACKGROUND, FOP_DDR_SDRAM_2 and FOP_DDR_SDRAM_3 values 
that can be written via the PCIe into the DDR SDRAMs containing the FOP, assuming a two DDR FOP Implementation. 
(The FOP_BACKGROUND is just an all zeros file that can be
written to each DDR SDRAM before overwriting with the FOP_DDR_SDRAM_*).

There is also config for the HSUM module (eg simple_pulsar_config.txt) that can be written to HSUM and then HSUM can be 
manually triggered to perform the summing.

The results file is "hsum_results1.txt" which covers all the tests in the folders. The results have been manually checked
with the word "correct" added if it is correct.

In the HSUM_SIMPLE_PULSAR_TEST_HARM_ALL folder there is an Excel spreadsheet "SUM_ALL_EXPECTED.xlsx" which shows the expected 
results of the summing, since this is a more complex test.

There are also the spreadsheets "32_BIT_LOCATION_CALC.xlsx" and "FOP_SAMPLE_NUMBERING.xlsx" which help to determine where in the 
FOP_DDR_SDRAM_2 locations the non-zero power values should be placed (note the for the MATLAB scripts the address location
of the first 32-bit word is 1).