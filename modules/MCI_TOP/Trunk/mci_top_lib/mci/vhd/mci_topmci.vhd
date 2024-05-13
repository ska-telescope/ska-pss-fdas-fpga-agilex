--------------------------------------------------------------------------------
-- Entity: mci_topmci
--------------------------------------------------------------------------------
-- Module: MCI_TOP
-- Date:   12/04/2023 12:52:10
-- File:   mci_topmci.vhd
-- CRC-16: 0x6F88
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mci_topmci is
    port (
        MCADDR           : in  std_logic_vector(19 downto 0);
        MCDATAIN         : in  std_logic_vector(31 downto 0);
        MCDATAOUT        : out std_logic_vector(31 downto 0);
        MCRWN            : in  std_logic;
        MCMS             : in  std_logic;
        CLK_MC           : in  std_logic;
        RST_MC_N         : in  std_logic;
        PRODUCT_ID       : in  std_logic_vector(15 downto 0);
        CORE_VERSION     : in  std_logic_vector(15 downto 0);
        CORE_REVISION    : in  std_logic_vector(15 downto 0);
        TOP_VERSION      : in  std_logic_vector(15 downto 0);
        TOP_REVISION     : in  std_logic_vector(15 downto 0);
        CTRL_RESET       : out std_logic;
        CLD_RESET        : out std_logic;
        CONV_RESET       : out std_logic;
        HSUM_RESET       : out std_logic;
        DDRIF_0_RESET    : out std_logic;
        DDRIF_1_RESET    : out std_logic;
        DDRIF_2_RESET    : out std_logic;
        DDRIF_3_RESET    : out std_logic;
        DDRIF_PCIE_RESET : out std_logic;
        DDR_0_RESET      : out std_logic;
        DDR_1_RESET      : out std_logic;
        DDR_2_RESET      : out std_logic;
        DDR_3_RESET      : out std_logic;
        MSIX_RESET       : out std_logic;
        DDR_0_CAL_FAIL   : in  std_logic;
        DDR_0_CAL_PASS   : in  std_logic;
        DDR_1_CAL_FAIL   : in  std_logic;
        DDR_1_CAL_PASS   : in  std_logic;
        DDR_2_CAL_FAIL   : in  std_logic;
        DDR_2_CAL_PASS   : in  std_logic;
        DDR_3_CAL_FAIL   : in  std_logic;
        DDR_3_CAL_PASS   : in  std_logic;
        DDR_0_RESET_DONE : in  std_logic;
        DDR_1_RESET_DONE : in  std_logic;
        DDR_2_RESET_DONE : in  std_logic;
        DDR_3_RESET_DONE : in  std_logic
    );
end mci_topmci;
