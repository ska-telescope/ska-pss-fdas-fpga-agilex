----------------------------------------------------------------------------
-- Package Name: hsummci_pkg
--
-- Source Path: hsum_lib/hdl/hsummci_pkg.vhd 
--
-- Functional Description:
--
-- CMG generated types and records.
--
----------------------------------------------------------------------------
-- Date:   23/05/2019 10:40:59
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

package hsummci_pkg is

    -- Output record for ram 'HSEL'
    type hsel_out_t is record
        addr : std_logic_vector(15 downto 0);
        rden : std_logic;
        wren : std_logic;
        wr : std_logic_vector(6 downto 0);
    end record;

    constant hsel_out_init_c : hsel_out_t := (
        (others => '0'),
        '0',
        '0',
        (others => '0')
    );

    -- Output record for ram 'TSEL'
    type tsel_out_t is record
        addr : std_logic_vector(11 downto 0);
        rden : std_logic;
        wren : std_logic;
        wr : std_logic_vector(31 downto 0);
    end record;

    constant tsel_out_init_c : tsel_out_t := (
        (others => '0'),
        '0',
        '0',
        (others => '0')
    );

    type vector_5_array_t is array (natural range <>) of std_logic_vector(4 downto 0);

    type vector_4_array_t is array (natural range <>) of std_logic_vector(3 downto 0);

    -- Output record for ram 'RESULTS'
    type results_out_t is record
        addr : std_logic_vector(15 downto 0);
        rden : std_logic;
    end record;

    constant results_out_init_c : results_out_t := (
        (others => '0'),
        '0'
    );

    -- Output record for ram 'EXC'
    type exc_out_t is record
        addr : std_logic_vector(10 downto 0);
        rden : std_logic;
    end record;

    constant exc_out_init_c : exc_out_t := (
        (others => '0'),
        '0'
    );

end hsummci_pkg;
