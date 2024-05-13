% Generates a test FOP to be written into DDR SDRAM Memory
% Assumes a FOP COL OFFEST of 0 (instead of 210), just to make
% it easier to configure HSUM (since we are creating the FOP
% instead of using CONV)
% Programs a background of all 0's 
% With a simple Pulsar with tones in the following locations:
%              FOP_COL         FOP_ROW                     POWER (Decimal)
% Harmonic 1:    20            45 (Filter P[+2])                100.8
% Harmonic 2:    39            47 (Filter P[+4])                90.8
% Harmonic 3:    59            49 (Filter P[+6])                80.8
% Harmonic 4:    78            51 (Filter P[+8])                70.8
% Harmonic 5:    98            53 (Filter P[+10])               60.8
% Harmonic 6:   117            55 (Filter P[+12])               50.8
% Harmonic 7:   137            57 (Filter P[+14])               40.8
% Harmonic 8:   156            59 (Filter P[+16])               30.8
 
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
% FOP Col 39 occupies 32-bit locations 2497 to 2560
% FOP Col 59 occupies 32-bit locations 3777 to 3840
% FOP Col 78 occupies 32-bit locations 4993 to 5056
% FOP Col 98 occupies 32-bit locations 6273 to 6336
% FOP Col 117 occupies 32-bit locations 7489 to 7552
% FOP Col 137 occupies 32-bit locations 8769 to 8832
% FOP Col 156 occupies 32-bit locations 9985 to 10048


% The appropriate FOP Locations for the Pulsar harmonics
% can now be programmed with the appropriate power value


% DDR SDRAM#2
FOP_DDR_2(1285)  = 100.8 %Harmonic#1,P[+2] 
FOP_DDR_2(2505)  = 90.8 %Harmonic#2,P[+4]
FOP_DDR_2(3789)  = 80.8 %Harmonic#3,P[+6]  
FOP_DDR_2(10005) = 30.8 %Harmonic#8,P[+16] 

% DDR SDRAM#3
FOP_DDR_3(4995)  = 70.8 %Harmonic#4,P[+8]
FOP_DDR_3(6279)  = 60.8 %Harmonic#5,P[+10]
FOP_DDR_3(7499)  = 50.8 %Harmonic#6,P[+12]
FOP_DDR_3(8783)  = 40.8 %Harmonic#7,P[+14]



filename = 'FOP_DDR_SDRAM_2' 
fileID2 = fopen(filename, 'wb');
fwrite(fileID2,FOP_DDR_2,'float');
fclose(fileID2);

filename = 'FOP_DDR_SDRAM_3' 
fileID3 = fopen(filename, 'wb');
fwrite(fileID3,FOP_DDR_3,'float');
fclose(fileID3);
