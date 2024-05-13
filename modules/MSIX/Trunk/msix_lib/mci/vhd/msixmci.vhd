--------------------------------------------------------------------------------
-- Entity: msixmci
--------------------------------------------------------------------------------
-- Module: MSIX
-- Date:   21/03/2022 13:41:57
-- File:   msixmci.vhd
-- CRC-16: 0x4E8B
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity msixmci is
    port (
        MCADDR         : in  std_logic_vector(3 downto 0);
        MCDATAIN       : in  std_logic_vector(31 downto 0);
        MCDATAOUT      : out std_logic_vector(31 downto 0);
        MCRWN          : in  std_logic;
        MCMS           : in  std_logic;
        CLK_MC         : in  std_logic;
        RST_MC_N       : in  std_logic;
        CLD_MSIX_DATA  : out std_logic_vector(15 downto 0);
        CLD_MSIX_EN    : out std_logic;
        CONV_MSIX_DATA : out std_logic_vector(15 downto 0);
        CONV_MSIX_EN   : out std_logic;
        HSUM_MSIX_DATA : out std_logic_vector(15 downto 0);
        HSUM_MSIX_EN   : out std_logic
    );
end msixmci;
