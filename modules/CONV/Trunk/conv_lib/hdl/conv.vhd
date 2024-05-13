----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2023 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Entity conv_lib1.conv.symbol
--
-- Created:
--          by - taylorj.UNKNOWN (COVNETICSDT11)
--          at - 13:04:22 29/03/2023
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
library conv_lib;
use conv_lib.cmplx_pkg.all;
use conv_lib.convmci_pkg.all;

entity conv is
  generic( 
    ddr_g            : natural;    --number of external DDR interfaces
    ifft_g           : natural;    --number of ifft filter pairs
    ifft_loop_g      : natural;    --number of filter repeats
    ifft_loop_bits_g : natural;    --filter repeat count bits
    fft_g            : natural;    --FFT/IFFT points
    abits_g          : natural;    --points count bits
    fop_num_bits_g   : natural;    --bits for freq bins processed
    res_pages_g      : natural     --Address bits for result store
  );
  port( 
    CLK_MC        : in     std_logic;
    CLK_SYS       : in     std_logic;
    CONV_ENABLE   : in     std_logic;
    CONV_TRIGGER  : in     std_logic;
    EOF           : in     std_logic;
    IDATA         : in     std_logic_vector (31 downto 0);
    MCADDR        : in     std_logic_vector (19 downto 0);
    MCDATA        : in     std_logic_vector (31 downto 0);
    MCMS          : in     std_logic;
    MCRWN         : in     std_logic;
    FOP_NUM       : in     std_logic_vector (fop_num_bits_g-1 downto 0);
    OVERLAP_SIZE  : in     std_logic_vector (abits_g-1 downto 0);
    RDATA         : in     std_logic_vector (31 downto 0);
    DDR_WAITREQ   : in     std_logic;
    RST_MC_N      : in     std_logic;
    RST_SYS_N     : in     std_logic;
    SOF           : in     std_logic;
    VALID         : in     std_logic;
    DDR_ADDROUT   : out    std_logic_vector (25 downto 0);
    DDR_DATAOUT   : out    std_logic_vector (ddr_g*512-1 downto 0);
    DDR_VALIDOUT  : out    std_logic;
    MCDATAOUT     : out    std_logic_vector (31 downto 0);
    READYOUT      : out    std_logic;
    IFFT_LOOP_NUM : in     std_logic_vector (ifft_loop_bits_g downto 0);
    SEGDONEOUT    : out    std_logic;
    MCREADYOUT    : out    std_logic;
    CONV_DONEOUT  : out    std_logic;
    PAGE_START    : in     std_logic_vector (25 downto 0)
  );

-- Declarations

end entity conv ;

