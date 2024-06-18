----------------------------------------------------------------------------
-- Module Name:  FDAS_DDR_CONTROLLER
--
-- Source Path:  fdas_ddr_controller_calibration.vhd
--
-- Description:  
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD    25/02/2022  Initial revision.
-- 0.2  RMD    22/09/2022  Updated to support two DDR Interfaces
-- 0.3  RMD    24/01/2022  DDR Controllers now support ECC
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

entity fdas_ddr_controller_calibration is
  port( 
    LOCAL_RESET_REQ_2_I         : in    std_logic                        := '0';
    LOCAL_RESET_DONE_2_O        : out   std_logic;
    PLL_REF_CLK_2_I             : in     std_logic                       := '0';
    OCT_RZQIN2_I                : in     std_logic                       := '0'; 
    MEM2_CK_O                   : out    std_logic_vector (0 downto 0);
    MEM2_CK_N_O                 : out    std_logic_vector (0 downto 0);
    MEM2_A_O                    : out    std_logic_vector (16 downto 0);
    MEM2_ACT_N_O                : out    std_logic_vector (0 downto 0);
    MEM2_BA_O                   : out    std_logic_vector (1 downto 0); 
    MEM2_BG_O                   : out    std_logic_vector (1 downto 0); 
    MEM2_CKE_O                  : out    std_logic_vector (0 downto 0);
    MEM2_CS_N_O                 : out    std_logic_vector (0 downto 0);
    MEM2_ODT_O                  : out    std_logic_vector (0 downto 0);
    MEM2_RESET_N_O              : out    std_logic_vector (0 downto 0);
    MEM2_PAR_O                  : out    std_logic_vector (0 downto 0); 
    MEM2_ALERT_N_I              : in     std_logic_vector (0 downto 0)   := (others => '0');
    MEM2_DQS_IO                 : inout  std_logic_vector (8 downto 0)   := (others => '0');
    MEM2_DQS_N_IO               : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    MEM2_DQ_IO                  : inout  std_logic_vector (71 downto 0)  := (others => '0'); 
    MEM2_DBI_N_IO               : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    LOCAL_CAL_SUCCESS_2_O       : out    std_logic; 
    LOCAL_CAL_FAIL_2_O          : out    std_logic;
    EMIF_USER_RESET_N_2_O       : out    std_logic;
    EMIF_USR_CLK_2_O            : out    std_logic; 
    AMM_READY_2_O               : out    std_logic;       
    AMM_READ_2_I                : in     std_logic                       := '0'; 
    AMM_WRITE_2_I               : in     std_logic                       := '0';  
    AMM_ADDRESS_2_I             : in     std_logic_vector (25 downto 0)  := (others => '0');     
    AMM_READDATA_2_O            : out    std_logic_vector (511 downto 0);
    AMM_WRITEDATA_2_I           : in     std_logic_vector (511 downto 0) := (others => '0');
    AMM_BURSTCOUNT_2_I          : in     std_logic_vector (6 downto 0)   := (others => '0');
    AMM_BYTEENABLE_2_I          : in     std_logic_vector (63 downto 0)  := (others => '0');
    AMM_READDATAVALID_2_O       : out    std_logic;  
    
    LOCAL_RESET_REQ_3_I         : in    std_logic                        := '0';
    LOCAL_RESET_DONE_3_O        : out   std_logic;
    PLL_REF_CLK_3_I             : in     std_logic                       := '0';
    OCT_RZQIN3_I                : in     std_logic                       := '0'; 
    MEM3_CK_O                   : out    std_logic_vector (0 downto 0);
    MEM3_CK_N_O                 : out    std_logic_vector (0 downto 0);
    MEM3_A_O                    : out    std_logic_vector (16 downto 0);
    MEM3_ACT_N_O                : out    std_logic_vector (0 downto 0);
    MEM3_BA_O                   : out    std_logic_vector (1 downto 0); 
    MEM3_BG_O                   : out    std_logic_vector (1 downto 0); 
    MEM3_CKE_O                  : out    std_logic_vector (0 downto 0);
    MEM3_CS_N_O                 : out    std_logic_vector (0 downto 0);
    MEM3_ODT_O                  : out    std_logic_vector (0 downto 0);
    MEM3_RESET_N_O              : out    std_logic_vector (0 downto 0);
    MEM3_PAR_O                  : out    std_logic_vector (0 downto 0); 
    MEM3_ALERT_N_I              : in     std_logic_vector (0 downto 0)   := (others => '0');
    MEM3_DQS_IO                 : inout  std_logic_vector (8 downto 0)   := (others => '0');
    MEM3_DQS_N_IO               : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    MEM3_DQ_IO                  : inout  std_logic_vector (71 downto 0)  := (others => '0'); 
    MEM3_DBI_N_IO               : inout  std_logic_vector (8 downto 0)   := (others => '0'); 
    LOCAL_CAL_SUCCESS_3_O       : out    std_logic; 
    LOCAL_CAL_FAIL_3_O          : out    std_logic;
    EMIF_USER_RESET_N_3_O       : out    std_logic;
    EMIF_USR_CLK_3_O            : out    std_logic; 
    AMM_READY_3_O               : out    std_logic;       
    AMM_READ_3_I                : in     std_logic                       := '0'; 
    AMM_WRITE_3_I               : in     std_logic                       := '0';  
    AMM_ADDRESS_3_I             : in     std_logic_vector (25 downto 0)  := (others => '0');     
    AMM_READDATA_3_O            : out    std_logic_vector (511 downto 0);
    AMM_WRITEDATA_3_I           : in     std_logic_vector (511 downto 0) := (others => '0');
    AMM_BURSTCOUNT_3_I          : in     std_logic_vector (6 downto 0)   := (others => '0');
    AMM_BYTEENABLE_3_I          : in     std_logic_vector (63 downto 0)  := (others => '0');
    AMM_READDATAVALID_3_O       : out    std_logic      
  );

-- Declarations

end entity fdas_ddr_controller_calibration;
