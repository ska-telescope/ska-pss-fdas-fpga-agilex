--------------------------------------------------------------------------------
-- Entity: mci_top_decodemci
--------------------------------------------------------------------------------
-- Module: MCI_TOP_DECODE
-- Date:   12/04/2023 12:52:10
-- File:   mci_top_decodemci.vhd
-- CRC-16: 0x2337
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mci_top_decodemci is
    port (
        MCADDR        : in  std_logic_vector(21 downto 0);
        MCCS          : in  std_logic;
        MCMS_TOPMCI_1 : out std_logic;
        MCMS_CTRL_1   : out std_logic;
        MCMS_MSIX_1   : out std_logic;
        MCMS_CONV_1   : out std_logic;
        MCMS_HSUM_1   : out std_logic
    );
end mci_top_decodemci;
