----------------------------------------------------------------------------
-- Module Name: convmci
--
-- Source Path: CONV_LIB/hdl/convmci.vhd 
--
----------------------------------------------------------------------------
-- Date: 21/02/2019 07:28:50
----------------------------------------------------------------------------  
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2019 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library CONV_LIB;
use CONV_LIB.convmci_pkg.all;

entity convmci is
  port( 
    MCADDR                 : in     std_logic_vector (19 downto 0);
    MCDATAIN               : in     std_logic_vector (31 downto 0);
    MCDATAOUT              : out    std_logic_vector (31 downto 0);
    MCRWN                  : in     std_logic;
    MCMS                   : in     std_logic;
    CLK_MC                 : in     std_logic;
    RST_MC_N               : in     std_logic;
    FILTER_COEFFICIENTS    : out    filter_coefficients_out_t;
    FILTER_COEFFICIENTS_RD : in     std_logic_vector (31 downto 0);
    FFT_RESULTS            : out    fft_results_out_t;
    FFT_RESULTS_RD         : in     std_logic_vector (31 downto 0);
    ROW0_DELAY             : out    std_logic_vector (9 downto 0);
    OVERFLOW               : in     std_logic_vector (84 downto 0)
  );

-- Declarations

end entity convmci ;
