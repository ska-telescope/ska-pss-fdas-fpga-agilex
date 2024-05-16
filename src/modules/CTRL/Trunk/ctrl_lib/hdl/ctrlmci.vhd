--------------------------------------------------------------------------------
-- Entity: ctrlmci
--------------------------------------------------------------------------------
-- Module: CTRL
-- Date:   06/05/2022 14:39:51
-- File:   ctrlmci.vhd
-- CRC-16: 0x0F73
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlmci is
  port( 
    MCADDR             : in     std_logic_vector (18 downto 0);
    MCDATAIN           : in     std_logic_vector (31 downto 0);
    MCDATAOUT          : out    std_logic_vector (31 downto 0);
    MCRWN              : in     std_logic;
    MCMS               : in     std_logic;
    CLK_MC             : in     std_logic;
    RST_MC_N           : in     std_logic;
    DM_TRIG            : out    std_logic;
    PAGE               : out    std_logic;
    OVERLAP_SIZE       : out    std_logic_vector (9 downto 0);
    FOP_SAMPLE_NUM     : out    std_logic_vector (22 downto 0);
    IFFT_LOOP_NUM      : out    std_logic_vector (5 downto 0);
    MAN_OVERRIDE       : out    std_logic;
    MAN_CLD_TRIG       : out    std_logic;
    MAN_CONV_TRIG      : out    std_logic;
    MAN_HSUM_TRIG      : out    std_logic;
    MAN_CLD_EN         : out    std_logic;
    MAN_CONV_EN        : out    std_logic;
    MAN_HSUM_EN        : out    std_logic;
    MAN_CLD_PAUSE_EN   : out    std_logic;
    MAN_CONV_PAUSE_EN  : out    std_logic;
    MAN_HSUM_PAUSE_EN  : out    std_logic;
    MAN_CLD_PAUSE_RST  : out    std_logic;
    MAN_CONV_PAUSE_RST : out    std_logic;
    MAN_HSUM_PAUSE_RST : out    std_logic;
    MAN_CLD_PAUSE_CNT  : out    std_logic_vector (31 downto 0);
    MAN_CONV_PAUSE_CNT : out    std_logic_vector (31 downto 0);
    MAN_HSUM_PAUSE_CNT : out    std_logic_vector (31 downto 0);
    LATCHED_CLD_DONE   : in     std_logic;
    LATCHED_CONV_DONE  : in     std_logic;
    LATCHED_HSUM_DONE  : in     std_logic;
    CLD_PAUSED         : in     std_logic;
    CONV_PAUSED        : in     std_logic;
    HSUM_PAUSED        : in     std_logic;
    CONV_FFT_READY     : in     std_logic;
    CLD_PROC_TIME      : in     std_logic_vector (31 downto 0);
    CONV_PROC_TIME     : in     std_logic_vector (31 downto 0);
    HSUM_PROC_TIME     : in     std_logic_vector (31 downto 0);
    CONV_REQ_CNT       : in     std_logic_vector (31 downto 0);
    HSUM_REQ_CNT       : in     std_logic_vector (31 downto 0);
    HSUM_REC_CNT       : in     std_logic_vector (31 downto 0)
  );

-- Declarations

end entity ctrlmci ;
