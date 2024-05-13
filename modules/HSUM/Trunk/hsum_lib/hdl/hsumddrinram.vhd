----------------------------------------------------------------------------
-- Module Name:  hsumddrinram
--
-- Source Path:  hsum_lib/hdl/hsumddrinram.vhd
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     03/04/18 Initial revision.
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

entity hsumddrinram is
  generic (
    ddr_g  : natural range 1 to 3
  );
  port (
    -- Write port.
    write_data : in  std_logic_vector(512*ddr_g - 1 downto 0);
    write_addr : in  std_logic_vector(5-ddr_g downto 0);
    write_en   : in  std_logic;

    -- Read port.
    read_addr  : in  std_logic_vector(8 downto 0);
    read_en    : in  std_logic;
    read_data  : out std_logic_vector(31 downto 0);

    -- Clock and reset.
    clk_sys    : in  std_logic;
    rst_sys_n  : in  std_logic
  );
end entity hsumddrinram;


