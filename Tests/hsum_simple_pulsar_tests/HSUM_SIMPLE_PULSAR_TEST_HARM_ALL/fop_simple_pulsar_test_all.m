% Generates a test FOP to be written into DDR SDRAM Memory
% Assumes a FOP COL OFFEST of 0 (instead of 210), just to make
% it easier to configure HSUM (since we are creating the FOP
% instead of using CONV)
% Programs a background of all 0's 
% With a simple Pulsar with tones in the following locations:
%                   FOP_COL         FOP_ROW                     POWER (Decimal)
% Harmonic 1 (0) :    20            45 (Filter P[+2])                100
% 
% Harmonic 2 (-1):    19            45 (Filter P[+4])                90.1
% Harmonic 2 (0) :    20            45 (Filter P[+4])                90
% Harmonic 2 (+1):    21            45 (Filter P[+4])                90.2
%
% Harmonic 3 (-1):    59            49 (Filter P[+6])                80.1
% Harmonic 3 (0):     60            49 (Filter P[+6])                80
% Harmonic 3 (+1):    61            49 (Filter P[+6])                80.2
%
% Harmonic 4 (-2):    78            51 (Filter P[+8])                70.1
% Harmonic 4 (-1):    79            51 (Filter P[+8])                70.2
% Harmonic 4 (0):     80            51 (Filter P[+8])                70
% Harmonic 4 (+1):    81            51 (Filter P[+8])                70.3
% Harmonic 4 (+2):    82            51 (Filter P[+8])                70.4
%
% Harmonic 5 (-2):    98             53 (Filter P[+10])              60.1
% Harmonic 5 (-1):    99             53 (Filter P[+10])              60.2
% Harmonic 5 (0):     100            53 (Filter P[+10])              60
% Harmonic 5 (+1):    101            53 (Filter P[+10])              60.3
% Harmonic 5 (+2):    102            53 (Filter P[+10])              60.4
%                                                                   
% Harmonic 6 (-3):    117            55 (Filter P[+12])              50.1
% Harmonic 6 (-2):    118            55 (Filter P[+12])              50.2
% Harmonic 6 (-1):    119            55 (Filter P[+12])              50.3
% Harmonic 6 (0):     120            55 (Filter P[+12])              50
% Harmonic 6 (+1):    121            55 (Filter P[+12])              50.4
% Harmonic 6 (+2):    122            55 (Filter P[+12])              50.5
% Harmonic 6 (+3):    123            55 (Filter P[+12])              50.6
%
% Harmonic 7 (-3):    137            57 (Filter P[+14])              40.1
% Harmonic 7 (-2):    138            57 (Filter P[+14])              40.2
% Harmonic 7 (-1):    139            57 (Filter P[+14])              40.3
% Harmonic 7 (0):     140            57 (Filter P[+14])              40
% Harmonic 7 (+1):    141            57 (Filter P[+14])              40.4
% Harmonic 7 (+2):    142            57 (Filter P[+14])              40.5
% Harmonic 7 (+3):    143            57 (Filter P[+14])              40.6
                                                                    
% Harmonic 8 (-4):    156            59 (Filter P[+16])              30.1
% Harmonic 8 (-3):    157            59 (Filter P[+16])              30.2
% Harmonic 8 (-2):    158            59 (Filter P[+16])              30.3
% Harmonic 8 (-1):    159            59 (Filter P[+16])              30.4
% Harmonic 8 (0):     160            59 (Filter P[+16])              30
% Harmonic 8 (+1):    161            59 (Filter P[+16])              30.5
% Harmonic 8 (+2):    162            59 (Filter P[+16])              30.6
% Harmonic 8 (+3):    163            59 (Filter P[+16])              30.7
% Harmonic 8 (+4):    164            59 (Filter P[+16])              30.8


 
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
% Each FOP Col after convoultion occupies 4-off 512-bit words (one not used but makes
% memory easy to assign). Hence each FOP Col occupies 512*4/32 = 64-off 32 bit locations.
% FOP Col 20 occupies 32-bit locations 1281 to 1344
%
% FOP Col 39 occupies 32-bit locations 2497 to 2560
% FOP Col 40 occupies 32-bit locations 2561 to 2624
% FOP Col 41 occupies 32-bit locations 2625 to 2688 
%
% FOP Col 59 occupies 32-bit locations 3777 to 3840
% FOP Col 60 occupies 32-bit locations 3841 to 3904
% FOP Col 61 occupies 32-bit locations 3905 to 3968
%
% FOP Col 78 occupies 32-bit locations 4993 to 5056
% FOP Col 79 occupies 32-bit locations 5057 to 5120
% FOP Col 80 occupies 32-bit locations 5121 to 5184
% FOP Col 81 occupies 32-bit locations 5185 to 5248
% FOP Col 82 occupies 32-bit locations 5249 to 5312
%
% FOP Col 98 occupies 32-bit locations 6273 to 6336
% FOP Col 99 occupies 32-bit locations 6337 to 6400
% FOP Col 100 occupies 32-bit locations 6401 to 6464
% FOP Col 101 occupies 32-bit locations 6465 to 6528
% FOP Col 102 occupies 32-bit locations 6529 to 6592
%
% FOP Col 117 occupies 32-bit locations 7489 to 7552
% FOP Col 118 occupies 32-bit locations 7553 to 7616
% FOP Col 119 occupies 32-bit locations 7617 to 7680
% FOP Col 120 occupies 32-bit locations 7681 to 7744
% FOP Col 121 occupies 32-bit locations 7745 to 7808
% FOP Col 122 occupies 32-bit locations 7809 to 7852
% FOP Col 123 occupies 32-bit locations 7873 to 7936
%
% FOP Col 137 occupies 32-bit locations 8769 to 8832
% FOP Col 138 occupies 32-bit locations 8833 to 8896
% FOP Col 139 occupies 32-bit locations 8897 to 8960
% FOP Col 140 occupies 32-bit locations 8961 to 9024
% FOP Col 141 occupies 32-bit locations 9025 to 9088
% FOP Col 142 occupies 32-bit locations 9089 to 9152
% FOP Col 143 occupies 32-bit locations 9153 to 9216
%
% FOP Col 156 occupies 32-bit locations 9985 to 10048
% FOP Col 157 occupies 32-bit locations 10049 to 10112
% FOP Col 158 occupies 32-bit locations 10133 to 10176
% FOP Col 159 occupies 32-bit locations 10177 to 10240
% FOP Col 160 occupies 32-bit locations 10241 to 10304
% FOP Col 161 occupies 32-bit locations 10305 to 10368
% FOP Col 162 occupies 32-bit locations 10369 to 10432
% FOP Col 163 occupies 32-bit locations 10433 to 10496
% FOP Col 164 occupies 32-bit locations 10497 to 10560

% The appropriate FOP Locations for the Pulsar harmonics
% can now be programmed with the appropriate power value


% DDR SDRAM#2
FOP_DDR_2(1285)  =  100    %Harmonic#1,P[+2] 
%                       
FOP_DDR_2(2505)  =   90.1  %Harmonic#2,P[+4]
FOP_DDR_2(2569)  =   90    %Harmonic#2,P[+4]
FOP_DDR_2(2633)  =   90.2  %Harmonic#2,P[+4]
%                       
FOP_DDR_2(3789)  =   80.1  %Harmonic#3,P[+6] 
FOP_DDR_2(3853)  =   80    %Harmonic#3,P[+6]  
FOP_DDR_2(3917)  =   80.2  %Harmonic#3,P[+6] 
%                       
FOP_DDR_2(10005) =   30.1  %Harmonic#8,P[+16]
FOP_DDR_2(10069) =   30.2  %Harmonic#8,P[+16] 
FOP_DDR_2(10133) =   30.3  %Harmonic#8,P[+16]
FOP_DDR_2(10197) =   30.4  %Harmonic#8,P[+16]
FOP_DDR_2(10261) =   30    %Harmonic#8,P[+16] 
FOP_DDR_2(10325) =   30.5  %Harmonic#8,P[+16] 
FOP_DDR_2(10389) =   30.6  %Harmonic#8,P[+16] 
FOP_DDR_2(10453) =   30.7  %Harmonic#8,P[+16] 
FOP_DDR_2(10517) =   30.8  %Harmonic#8,P[+16] 
                         
% DDR SDRAM#3            
FOP_DDR_3(4995)  =   70.1  %Harmonic#4,P[+8]
FOP_DDR_3(5059)  =   70.2  %Harmonic#4,P[+8]
FOP_DDR_3(5123)  =   70    %Harmonic#4,P[+8]
FOP_DDR_3(5187)  =   70.3  %Harmonic#4,P[+8]
FOP_DDR_3(5251)  =   70.4  %Harmonic#4,P[+8]
%                        
FOP_DDR_3(6279)  =   60.1  %Harmonic#5,P[+10]
FOP_DDR_3(6343)  =   60.2  %Harmonic#5,P[+10]
FOP_DDR_3(6407)  =   60    %Harmonic#5,P[+10]
FOP_DDR_3(6471)  =   60.3  %Harmonic#5,P[+10]
FOP_DDR_3(6535)  =   60.4  %Harmonic#5,P[+10]
%                        
FOP_DDR_3(7499)  =   50.1  %Harmonic#6,P[+12]
FOP_DDR_3(7563)  =   50.2  %Harmonic#6,P[+12]
FOP_DDR_3(7627)  =   50.3  %Harmonic#6,P[+12]
FOP_DDR_3(7691)  =   50    %Harmonic#6,P[+12]
FOP_DDR_3(7755)  =   50.4  %Harmonic#6,P[+12]
FOP_DDR_3(7819)  =   50.5  %Harmonic#6,P[+12]
FOP_DDR_3(7883)  =   50.6  %Harmonic#6,P[+12]
%                        
FOP_DDR_3(8783)  =   40.1  %Harmonic#7,P[+14]
FOP_DDR_3(8847)  =   40.2  %Harmonic#7,P[+14]
FOP_DDR_3(8911)  =   40.3  %Harmonic#7,P[+14]
FOP_DDR_3(8975)  =   40    %Harmonic#7,P[+14]
FOP_DDR_3(9039)  =   40.4  %Harmonic#7,P[+14]
FOP_DDR_3(9103)  =   40.5  %Harmonic#7,P[+14]
FOP_DDR_3(9167)  =   40.6  %Harmonic#7,P[+14]

filename = 'FOP_DDR_SDRAM_2' 
fileID2 = fopen(filename, 'wb');
fwrite(fileID2,FOP_DDR_2,'float');
fclose(fileID2);

filename = 'FOP_DDR_SDRAM_3' 
fileID3 = fopen(filename, 'wb');
fwrite(fileID3,FOP_DDR_3,'float');
fclose(fileID3);
