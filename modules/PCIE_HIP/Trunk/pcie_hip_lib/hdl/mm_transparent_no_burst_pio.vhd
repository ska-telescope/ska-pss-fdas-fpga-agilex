----------------------------------------------------------------------------
-- Module Name:  MM_TRANSPARENT_NO_BURST_PIO
--
-- Source Path:  mm_transparent_no_burst_pio.vhd
--
-- Description:  Memory Mapped Transparent Bridge for the PCIe Macro PIO interface
--               With no Burstcoint signal
--
-- Author:       martin.droog@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  RMD    18/11/2022  Initial revision.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mm_transparent_no_burst_pio is
  generic (
    DATA_WIDTH       : integer := 32;
    BYTE_SIZE        : integer := 8;
    ADDRESS_WIDTH    : integer := 20;
    RESPONSE_WIDTH   : integer := 2
  );
  port ( 
    clk                   : in  std_logic                      := 'X';                                 -- clk          
    m0_waitrequest        : in  std_logic                      := 'X';                                 -- waitrequest  
    m0_readdata           : in  std_logic_vector(DATA_WIDTH-1 downto 0) := (others => 'X');            -- readdata     
    m0_readdatavalid      : in  std_logic                      := 'X';                                 -- readdatavalid
    m0_writeresponsevalid : in  std_logic                      := 'X';                                 -- write response valid
    m0_response           : in  std_logic_vector(RESPONSE_WIDTH -1 downto 0)   := (others => 'X');     -- response
    m0_writedata          : out std_logic_vector(DATA_WIDTH-1 downto 0);                               -- writedata    
    m0_address            : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);                            -- address      
    m0_write              : out std_logic;                                                             -- write        
    m0_read               : out std_logic;                                                             -- read
    m0_byteenable         : out std_logic_vector(DATA_WIDTH/BYTE_SIZE-1 downto 0);                     -- byteenable   
    reset                 : in  std_logic                      := 'X';                                 -- reset        
    s0_waitrequest        : out std_logic;                                                             -- waitrequest  
    s0_readdata           : out std_logic_vector(DATA_WIDTH-1 downto 0);                               -- readdata     
    s0_readdatavalid      : out std_logic;                                                             -- readdatavalid
    s0_writeresponsevalid : out  std_logic;                                                            -- write response valid
    s0_response           : out  std_logic_vector(RESPONSE_WIDTH -1 downto 0);                         -- response    
    s0_writedata          : in  std_logic_vector(DATA_WIDTH-1 downto 0) := (others => 'X');            -- writedata
    s0_address            : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0)  := (others => 'X');        -- address
    s0_write              : in  std_logic                      := 'X';                                 -- write
    s0_read               : in  std_logic                      := 'X';                                 -- read
    s0_byteenable         : in  std_logic_vector(DATA_WIDTH/BYTE_SIZE-1 downto 0)  := (others => 'X')  -- byteenable 
  );                      

-- Declarations

end entity mm_transparent_no_burst_pio;

