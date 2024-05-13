----------------------------------------------------------------------------
-- Module Name:  FDAS_PCIE
--
-- Source Path:  fdas_pcie.vhd
--
-- Description:  Instantiates PCIE IP block.
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD   30/03/2022  Initial revision.
-- 0.2  RMD   26/09/2022  Update to support four DMA ports
-- 0.3  RMD   09/01/2023  Burstcount removed from the RXM PIO Interface
-- 0.4  RMD   28/02/2023  PCIe Macro updated for Intel Quartus Prime 22.4
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity fdas_pcie is
   port( 
      CLK_PCIE_O                  : out    std_logic;
      RD_DMA_0_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      RD_DMA_0_WRITE_O            : out    std_logic;
      RD_DMA_0_WRITEDATA_O        : out    std_logic_vector (511 downto 0);
      RD_DMA_0_WAITREQUEST_I      : in     std_logic;
      RD_DMA_0_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      RD_DMA_0_BYTEENABLE_O       : out    std_logic_vector (63 downto 0);
      RD_DMA_1_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      RD_DMA_1_WRITE_O            : out    std_logic;
      RD_DMA_1_WRITEDATA_O        : out    std_logic_vector (511 downto 0);
      RD_DMA_1_WAITREQUEST_I      : in     std_logic;
      RD_DMA_1_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      RD_DMA_1_BYTEENABLE_O       : out    std_logic_vector (63 downto 0);      
      RD_DMA_2_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      RD_DMA_2_WRITE_O            : out    std_logic;
      RD_DMA_2_WRITEDATA_O        : out    std_logic_vector (511 downto 0);
      RD_DMA_2_WAITREQUEST_I      : in     std_logic;
      RD_DMA_2_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      RD_DMA_2_BYTEENABLE_O       : out    std_logic_vector (63 downto 0);
      RD_DMA_3_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      RD_DMA_3_WRITE_O            : out    std_logic;
      RD_DMA_3_WRITEDATA_O        : out    std_logic_vector (511 downto 0);
      RD_DMA_3_WAITREQUEST_I      : in     std_logic;
      RD_DMA_3_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      RD_DMA_3_BYTEENABLE_O       : out    std_logic_vector (63 downto 0);            
      WR_DMA_0_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      WR_DMA_0_READ_O             : out    std_logic;
      WR_DMA_0_RESPONSE_I         : in     std_logic_vector (1 downto 0);
      WR_DMA_0_READDATA_I         : in     std_logic_vector (511 downto 0);
      WR_DMA_0_WAITREQUEST_I      : in     std_logic;
      WR_DMA_0_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      WR_DMA_0_READDATAVALID_I    : in     std_logic;
      WR_DMA_1_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      WR_DMA_1_READ_O             : out    std_logic;
      WR_DMA_1_RESPONSE_I         : in     std_logic_vector (1 downto 0);
      WR_DMA_1_READDATA_I         : in     std_logic_vector (511 downto 0);
      WR_DMA_1_WAITREQUEST_I      : in     std_logic;
      WR_DMA_1_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      WR_DMA_1_READDATAVALID_I    : in     std_logic;           
      WR_DMA_2_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      WR_DMA_2_READ_O             : out    std_logic;
      WR_DMA_2_RESPONSE_I         : in     std_logic_vector (1 downto 0);
      WR_DMA_2_READDATA_I         : in     std_logic_vector (511 downto 0);
      WR_DMA_2_WAITREQUEST_I      : in     std_logic;
      WR_DMA_2_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      WR_DMA_2_READDATAVALID_I    : in     std_logic;
      WR_DMA_3_ADDRESS_O          : out    std_logic_vector (25 downto 0);
      WR_DMA_3_READ_O             : out    std_logic;
      WR_DMA_3_RESPONSE_I         : in     std_logic_vector (1 downto 0);
      WR_DMA_3_READDATA_I         : in     std_logic_vector (511 downto 0);
      WR_DMA_3_WAITREQUEST_I      : in     std_logic;
      WR_DMA_3_BURSTCOUNT_O       : out    std_logic_vector (3 downto 0);
      WR_DMA_3_READDATAVALID_I    : in     std_logic;                 
      RXM_WAITREQUEST_I           : in     std_logic;   
      RXM_ADDRESS_O               : out    std_logic_vector(21 downto 0);        
      RXM_BYTEENABLE_O            : out    std_logic_vector(3 downto 0);
      RXM_READ_O                  : out    std_logic;  
      RXM_WRITE_RESPONSE_VALID_I  : in     std_logic;
      RXM_RESPONSE_I              : in     std_logic_vector (1 downto 0);          
      RXM_READDATA_I              : in     std_logic_vector (31 downto 0);
      RXM_READDATAVALID_I         : in     std_logic;        
      RXM_WRITE_O                 : out    std_logic;    
      RXM_WRITEDATA_O             : out    std_logic_vector (31 downto 0);     
      RX_IN0                      : in     std_logic;
      RX_IN1                      : in     std_logic;
      RX_IN2                      : in     std_logic;
      RX_IN3                      : in     std_logic;
      RX_IN4                      : in     std_logic;
      RX_IN5                      : in     std_logic;
      RX_IN6                      : in     std_logic;
      RX_IN7                      : in     std_logic;
      RX_IN8                      : in     std_logic;
      RX_IN9                      : in     std_logic;
      RX_IN10                     : in     std_logic;
      RX_IN11                     : in     std_logic;
      RX_IN12                     : in     std_logic;
      RX_IN13                     : in     std_logic;
      RX_IN14                     : in     std_logic;
      RX_IN15                     : in     std_logic;      
      RX_IN0_N                    : in     std_logic;
      RX_IN1_N                    : in     std_logic;
      RX_IN2_N                    : in     std_logic;
      RX_IN3_N                    : in     std_logic;
      RX_IN4_N                    : in     std_logic;
      RX_IN5_N                    : in     std_logic;
      RX_IN6_N                    : in     std_logic;
      RX_IN7_N                    : in     std_logic;
      RX_IN8_N                    : in     std_logic;
      RX_IN9_N                    : in     std_logic;
      RX_IN10_N                   : in     std_logic;
      RX_IN11_N                   : in     std_logic;
      RX_IN12_N                   : in     std_logic;
      RX_IN13_N                   : in     std_logic;
      RX_IN14_N                   : in     std_logic;
      RX_IN15_N                   : in     std_logic;                 
      TX_OUT0                     : out    std_logic;
      TX_OUT1                     : out    std_logic;
      TX_OUT2                     : out    std_logic;
      TX_OUT3                     : out    std_logic;
      TX_OUT4                     : out    std_logic;
      TX_OUT5                     : out    std_logic;
      TX_OUT6                     : out    std_logic;
      TX_OUT7                     : out    std_logic;
      TX_OUT8                     : out    std_logic;
      TX_OUT9                     : out    std_logic;
      TX_OUT10                    : out    std_logic;
      TX_OUT11                    : out    std_logic;
      TX_OUT12                    : out    std_logic;
      TX_OUT13                    : out    std_logic;
      TX_OUT14                    : out    std_logic;
      TX_OUT15                    : out    std_logic;      
      TX_OUT0_N                   : out    std_logic;
      TX_OUT1_N                   : out    std_logic;
      TX_OUT2_N                   : out    std_logic;
      TX_OUT3_N                   : out    std_logic;
      TX_OUT4_N                   : out    std_logic;
      TX_OUT5_N                   : out    std_logic;
      TX_OUT6_N                   : out    std_logic;
      TX_OUT7_N                   : out    std_logic;
      TX_OUT8_N                   : out    std_logic;
      TX_OUT9_N                   : out    std_logic;
      TX_OUT10_N                  : out    std_logic;
      TX_OUT11_N                  : out    std_logic;
      TX_OUT12_N                  : out    std_logic;
      TX_OUT13_N                  : out    std_logic;
      TX_OUT14_N                  : out    std_logic;
      TX_OUT15_N                  : out    std_logic;           
      USER_MSIX_VALID_I           : in     std_logic;
      USER_MSIX_READY_O           : out    std_logic;
      USER_MSIX_DATA_I            : in     std_logic_vector (15 downto 0);         
      PIN_PERST_I                 : in     std_logic;
      CLK_REF_I_0                 : in     std_logic;
      CLK_REF_I_1                 : in     std_logic;
      RST_PCIE_N_O                : out    std_logic;
      NINIT_DONE_I                : in     std_logic

   );

-- Declarations

end fdas_pcie ;
