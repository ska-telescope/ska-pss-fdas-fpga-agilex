% Generates a test FOP to be written into DDR SDRAM Memory
% Assumes a FOP COL OFFEST of 0 (instead of 210), just to make
% it easier to configure HSUM (since we are creating the FOP
% instead of using CONV)
% Programs a background of all 0's 
% With a simple Pulsar with tones in the following locations:
%              FOP_COL         FOP_ROW                     POWER (Decimal)
% Harmonic 1:    20            45 (Filter P[+2])                100.4
% Harmonic 2:    41            47 (Filter P[+4])                 90.3
% Harmonic 3:    61            49 (Filter P[+6])                 80.3
% Harmonic 4:    82            51 (Filter P[+8])                 70.3
% Harmonic 5:   102            53 (Filter P[+10])                60.3
% Harmonic 6:   123            55 (Filter P[+12])                50.3
% Harmonic 7:   143            57 (Filter P[+14])                40.3
% Harmonic 8:   164            59 (Filter P[+16])                30.4
 
% Martin Droog Covnetics 19 June 2023

  clear; clf;
  
 %%%%%%%%%%%%%%%%% INPUT SELECTION %%%%%%%%%%%%%%%%

%% Create an All 0s FOP File
% FOP_DDR_2 is for DDR SDRAM#2 of the Agilex Card
% FOP_DDR_3 is for DDR SDRAM#3 of the Agilex Card


% Create a an all zeros background file to load first
FOP_ALL_0 = zeros(1, 268435456, 'float');
filename = 'FOP_BACKGROUND' 
fileID1 = fopen(filename, 'wb');
fwrite(fileID1,FOP_ALL_0,'float');
fclose(fileID1);

% Create a shorter backbround file that contains the Pulsar 
FOP_DDR_2 = zeros(1, 20000, 'float');
FOP_DDR_3 = zeros(1, 20000, 'float');

% Now create a set of values at FOP for the Pulsar
% Each FOP Col after convolution occupies 4-off 512-bit words (one not used but makes
% memory easy to assign). Hence each FOP Col occupies 512*4/32 = 64-off 32 bit locations.
% FOP Col 20 occupies 32-bit locations 1281 to 1344
% FOP Col 43 occupies 32-bit locations 2753 to 2816 
% FOP Col 63 occupies 32-bit locations 4033 to 4096
% FOP Col 82 occupies 32-bit locations 5249 to 5312
% FOP Col 102 occupies 32-bit locations 6529 to 6592
% FOP Col 123 occupies 32-bit locations 7873 to 7936
% FOP Col 143 occupies 32-bit locations 9153 to 9216
% FOP Col 164 occupies 32-bit locations 10497 to 10560


% The appropriate FOP Locations for the Pulsar harmonics
% can now be programmed with the appropriate power value


% DDR SDRAM#2
FOP_DDR_2(1285)  = 100.4 %Harmonic#1,P[+2] 
FOP_DDR_2(2633)  =  90.4 %Harmonic#2,P[+4]
FOP_DDR_2(3917)  =  80.4 %Harmonic#3,P[+6]  
FOP_DDR_2(10517) =  30.4 %Harmonic#8,P[+16] 

% DDR SDRAM#3
FOP_DDR_3(5251)  =  70.4 %Harmonic#4,P[+8]
FOP_DDR_3(6535)  =  60.4 %Harmonic#5,P[+10]
FOP_DDR_3(7883)  =  50.4 %Harmonic#6,P[+12]
FOP_DDR_3(9167)  =  40.4 %Harmonic#7,P[+14]



filename = 'FOP_DDR_SDRAM_2' 
fileID2 = fopen(filename, 'wb');
fwrite(fileID2,FOP_DDR_2,'float');
fclose(fileID2);

filename = 'FOP_DDR_SDRAM_3' 
fileID3 = fopen(filename, 'wb');
fwrite(fileID3,FOP_DDR_3,'float');
fclose(fileID3);
