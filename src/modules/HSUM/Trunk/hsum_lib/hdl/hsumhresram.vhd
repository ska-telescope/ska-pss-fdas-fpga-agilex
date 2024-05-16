----------------------------------------------------------------------------
-- Module Name:  hsumhresram
--
-- Source Path:  hsum_lib/hdl/hsumhresram.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     11/06/18 Initial revision.
-- 0.2  RJH     23/05/19 RAM size changed to support DMA access.
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

entity hsumhresram is
  port (
    -- Port A: write.
    a_addr       : in  std_logic_vector(5 downto 0);
    a_write_data : in  std_logic_vector(127 downto 0);
    a_write_en   : in  std_logic;
    a_clk        : in  std_logic;

    -- Port B: read.
    b_addr       : in  std_logic_vector(5 downto 0);
    b_read_en    : in  std_logic;
    b_read_data  : out std_logic_vector(127 downto 0);
    b_clk        : in  std_logic
  );
end entity hsumhresram;


