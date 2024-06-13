----------------------------------------------------------------------------
-- Module Name:  hsumhpselram
--
-- Source Path:  hsum_lib/hdl/hsumhpselram.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     24/04/18 Initial revision.
--
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2018 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;

entity hsumhpselram is
  port (
    -- Port A: write/read.
    a_addr       : in  std_logic_vector(9 downto 0);
    a_write_data : in  std_logic_vector(6 downto 0);
    a_write_en   : in  std_logic;
    a_read_en    : in  std_logic;
    a_read_data  : out std_logic_vector(6 downto 0);
    a_clk        : in  std_logic;

    -- Port B: read.
    b_addr       : in  std_logic_vector(9 downto 0);
    b_read_en    : in  std_logic;
    b_read_data  : out std_logic_vector(6 downto 0);
    b_clk        : in  std_logic
  );
end entity hsumhpselram;


