----------------------------------------------------------------------------
-- Module Name:  MM_WR_TRANSPARENT
--
-- Source Path:  mm_wr_transparent.vhd
--
-- Description:  Memory Mapped Transparent Bridge
--
-- Author:       jon.taylor@covnetics.com
--
----------------------------------------------------------------------------
-- Rev  Auth     Date     Revision History
--
-- 0.1  JT    04/09/2017  Initial revision.
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2017 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Version: VHDL '93
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mm_wr_transparent is
  generic (
    DATA_WIDTH       : integer := 256;
    BYTE_SIZE        : integer := 8;
    ADDRESS_WIDTH    : integer := 32;
    BURSTCOUNT_WIDTH : integer := 4
  );
  port ( 
    clk              : in  std_logic                      := 'X';                      -- clk          
    m0_waitrequest   : in  std_logic                      := 'X';                      -- waitrequest  
    m0_burstcount    : out std_logic_vector(BURSTCOUNT_WIDTH-1 downto 0);              -- burstcount   
    m0_writedata     : out std_logic_vector(DATA_WIDTH-1 downto 0);                    -- writedata    
    m0_address       : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);                 -- address      
    m0_write         : out std_logic;                                                  -- write        
    m0_byteenable    : out std_logic_vector(DATA_WIDTH/BYTE_SIZE-1 downto 0);          -- byteenable   
    reset            : in  std_logic                      := 'X';                      -- reset        
    s0_waitrequest   : out std_logic;                                                  -- waitrequest  
    s0_burstcount    : in  std_logic_vector(BURSTCOUNT_WIDTH-1 downto 0)   := (others => 'X'); -- burstcount
    s0_writedata     : in  std_logic_vector(DATA_WIDTH-1 downto 0) := (others => 'X'); -- writedata
    s0_address       : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0)  := (others => 'X'); -- address
    s0_write         : in  std_logic                      := 'X';                      -- write
    s0_byteenable    : in  std_logic_vector(DATA_WIDTH/BYTE_SIZE-1 downto 0)  := (others => 'X') -- byteenable 
  );

-- Declarations

end entity mm_wr_transparent;

