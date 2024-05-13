----------------------------------------------------------------------------
-- Module Name:  FDAS_DDR_CONTROLLER_HPS
--
-- Source Path:  fdas_ddr_controller_calibration_hps.vhd
--
-- Description:  
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD    21/07/2022  Initial revision.
-- 0.2  RMD    22/09/2022  Updated to support two DDR Interfaces
-- 0.3  RMD    24/01/2023  DDR Controllers now support ECC
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
library fdas_top_lib;
use IEEE.std_logic_1164.all;

entity fdas_ddr_controller_calibration_hps is
  port( 
    LOCAL_RESET_REQ_0_I         : in    std_logic                        := '0';
    LOCAL_RESET_DONE_0_O        : out   std_logic;
    PLL_REF_CLK_0_I             : in     std_logic                       := '0';
    OCT_RZQIN0_I               : in     std_logic                       := '0'; 
    MEM0_CK_O                  : out    std_logic_vector (0 downto 0);
    MEM0_CK_N_O                : out    std_logic_vector (0 downto 0);
    MEM0_A_O                   : out    std_logic_vector (16 downto 0);
    MEM0_ACT_N_O               : out    std_logic_vector (0 downto 0);
    MEM0_BA_O                  : out    std_logic_vector (1 downto 0); 
    MEM0_BG_O                  : out    std_logic_vector (1 downto 0); 
    MEM0_CKE_O                 : out    std_logic_vector (0 downto 0);
    MEM0_CS_N_O                : out    std_logic_vector (0 downto 0);
    MEM0_ODT_O                 : out    std_logic_vector (0 downto 0);
    MEM0_RESET_N_O             : out    std_logic_vector (0 downto 0);
    MEM0_PAR_O                 : out    std_logic_vector (0 downto 0); 
    MEM0_ALERT_N_I             : in     std_logic_vector (0 downto 0)   := (others => '0');
    MEM0_DQS_IO                : inout  std_logic_vector (8 downto 0)   := (others => '0');
    MEM0_DQS_N_IO              : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    MEM0_DQ_IO                 : inout  std_logic_vector (71 downto 0)  := (others => '0'); 
    MEM0_DBI_N_IO              : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    LOCAL_CAL_SUCCESS_0_O       : out    std_logic; 
    LOCAL_CAL_FAIL_0_O          : out    std_logic;
    EMIF_USER_RESET_N_0_O       : out    std_logic;
    EMIF_USR_CLK_0_O            : out    std_logic; 
    AMM_READY_0_O               : out    std_logic;       
    AMM_READ_0_I                : in     std_logic                       := '0'; 
    AMM_WRITE_0_I               : in     std_logic                       := '0';  
    AMM_ADDRESS_0_I             : in     std_logic_vector (25 downto 0)  := (others => '0');     
    AMM_READDATA_0_O            : out    std_logic_vector (511 downto 0);
    AMM_WRITEDATA_0_I           : in     std_logic_vector (511 downto 0) := (others => '0');
    AMM_BURSTCOUNT_0_I          : in     std_logic_vector (6 downto 0)   := (others => '0');
    AMM_BYTEENABLE_0_I          : in     std_logic_vector (63 downto 0)  := (others => '0');
    AMM_READDATAVALID_0_O       : out    std_logic;  
    
    LOCAL_RESET_REQ_1_I         : in    std_logic                        := '0';
    LOCAL_RESET_DONE_1_O        : out   std_logic;
    PLL_REF_CLK_1_I             : in     std_logic                       := '0';
    OCT_RZQIN1_I               : in     std_logic                       := '0'; 
    MEM1_CK_O                  : out    std_logic_vector (0 downto 0);
    MEM1_CK_N_O                : out    std_logic_vector (0 downto 0);
    MEM1_A_O                   : out    std_logic_vector (16 downto 0);
    MEM1_ACT_N_O               : out    std_logic_vector (0 downto 0);
    MEM1_BA_O                  : out    std_logic_vector (1 downto 0); 
    MEM1_BG_O                  : out    std_logic_vector (1 downto 0); 
    MEM1_CKE_O                 : out    std_logic_vector (0 downto 0);
    MEM1_CS_N_O                : out    std_logic_vector (0 downto 0);
    MEM1_ODT_O                 : out    std_logic_vector (0 downto 0);
    MEM1_RESET_N_O             : out    std_logic_vector (0 downto 0);
    MEM1_PAR_O                 : out    std_logic_vector (0 downto 0); 
    MEM1_ALERT_N_I             : in     std_logic_vector (0 downto 0)   := (others => '0');
    MEM1_DQS_IO                : inout  std_logic_vector (8 downto 0)   := (others => '0');
    MEM1_DQS_N_IO              : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    MEM1_DQ_IO                 : inout  std_logic_vector (71 downto 0)  := (others => '0'); 
    MEM1_DBI_N_IO              : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    LOCAL_CAL_SUCCESS_1_O       : out    std_logic; 
    LOCAL_CAL_FAIL_1_O          : out    std_logic;
    EMIF_USER_RESET_N_1_O       : out    std_logic;
    EMIF_USR_CLK_1_O            : out    std_logic; 
    AMM_READY_1_O               : out    std_logic;       
    AMM_READ_1_I                : in     std_logic                       := '0'; 
    AMM_WRITE_1_I               : in     std_logic                       := '0';  
    AMM_ADDRESS_1_I             : in     std_logic_vector (25 downto 0)  := (others => '0');     
    AMM_READDATA_1_O            : out    std_logic_vector (511 downto 0);
    AMM_WRITEDATA_1_I           : in     std_logic_vector (511 downto 0) := (others => '0');
    AMM_BURSTCOUNT_1_I          : in     std_logic_vector (6 downto 0)   := (others => '0');
    AMM_BYTEENABLE_1_I          : in     std_logic_vector (63 downto 0)  := (others => '0');
    AMM_READDATAVALID_1_O       : out    std_logic      
    
  );

-- Declarations

end entity fdas_ddr_controller_calibration_hps;
