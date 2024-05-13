----------------------------------------------------------------------------
-- Package Name: convmci_pkg
--
-- Source Path: CONV_LIB/hdl/convmci_pkg.vhd 
--
-- Functional Description:
--
-- CMG generated types and records.
--
----------------------------------------------------------------------------
-- Date:   21/02/2019 07:28:50
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

package convmci_pkg is

    -- Output record for ram 'FILTER_COEFFICIENTS'
    type filter_coefficients_out_t is record
        addr : std_logic_vector(16 downto 0);
        rden : std_logic;
        wren : std_logic;
        wr : std_logic_vector(31 downto 0);
    end record;

    constant filter_coefficients_out_init_c : filter_coefficients_out_t := (
        (others => '0'),
        '0',
        '0',
        (others => '0')
    );

    -- Output record for ram 'FFT_RESULTS'
    type fft_results_out_t is record
        addr : std_logic_vector(10 downto 0);
        rden : std_logic;
    end record;

    constant fft_results_out_init_c : fft_results_out_t := (
        (others => '0'),
        '0'
    );

end convmci_pkg;
