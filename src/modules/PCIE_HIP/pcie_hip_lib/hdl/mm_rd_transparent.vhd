----------------------------------------------------------------------------
-- Module Name:  MM_RD_TRANSPARENT
--
-- Source Path:  mm_rd_transparent.vhd
--
-- Description:  Memory Mapped Transparent Bridge
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/09/2017  Initial revision.
-- 0.1  RMD   14/03/2022  Added response[1:0] (required by Agilex PCIe Hard IP Macro)
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

entity mm_rd_transparent is
  generic (
    DATA_WIDTH       : integer := 256;
    BYTE_SIZE        : integer := 8;
    ADDRESS_WIDTH    : integer := 32;
    BURSTCOUNT_WIDTH : integer := 4
  );
  port ( 
    clk              : in  std_logic                      := 'X';                      -- clk          
    m0_waitrequest   : in  std_logic                      := 'X';                      -- waitrequest  
    m0_readdata      : in  std_logic_vector(DATA_WIDTH-1 downto 0) := (others => 'X'); -- readdata     
    m0_readdatavalid : in  std_logic                      := 'X';                      -- readdatavalid
    m0_response      : in  std_logic_vector(1 downto 0) := (others => 'X');            -- response
    m0_burstcount    : out std_logic_vector(BURSTCOUNT_WIDTH-1 downto 0);              -- burstcount   
    m0_address       : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);                 -- address      
    m0_read          : out std_logic;                                                  -- read
    reset            : in  std_logic                      := 'X';                      -- reset        
    s0_waitrequest   : out std_logic;                                                  -- waitrequest  
    s0_readdata      : out std_logic_vector(DATA_WIDTH-1 downto 0);                    -- readdata     
    s0_readdatavalid : out std_logic;                                                  -- readdatavalid
    s0_response      : out  std_logic_vector(1 downto 0);                              -- response
    s0_burstcount    : in  std_logic_vector(BURSTCOUNT_WIDTH-1 downto 0)   := (others => 'X'); -- burstcount
    s0_address       : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0)  := (others => 'X'); -- address
    s0_read          : in  std_logic                      := 'X'                      -- read
  );

-- Declarations

end entity mm_rd_transparent;

