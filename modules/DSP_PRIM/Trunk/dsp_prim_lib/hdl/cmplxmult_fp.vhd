----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
-- VHDL Entity dsp_prim_lib.cmplxmult_fp.symbol
--
-- Created:
--          by - taylorj.UNKNOWN (COVNETICSDT11)
--          at - 17:36:20 26/04/2022
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
library ieee;
use ieee.std_logic_1164.all;

--  Module Name:  CMPLXMULT
--
--  Source Path:  cmplxmult.vhd
--
--  Description:
--
--  Author:       jon.taylor@covnetics.com
--
-- --------------------------------------------------------------------------
--  Rev  Auth     Date      Revision History
--
--  0.1  JT     26/11/2015  Initial revision.
-- --------------------------------------------------------------------------
--        __
--     ,/'__`\                             _     _
--    ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--    ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--    '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--     '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
--  Copyright (c) Covnetics Limited 2015 All Rights Reserved. The information
--  contained herein remains the property of Covnetics Limited and may not be
--  copied or reproduced in any format or medium without the written consent
--  of Covnetics Limited.
--
-- --------------------------------------------------------------------------
--  VHDL Version: VHDL '93
-- --------------------------------------------------------------------------
--
entity cmplxmult_fp is
  port( 
    ACLR        : in     std_logic;                       -- aclr
    AY_IM       : in     std_logic_vector (31 downto 0);  -- ax
    AY_RE       : in     std_logic_vector (31 downto 0);  -- ax
    AZ_IM       : in     std_logic_vector (31 downto 0);  -- az
    AZ_RE       : in     std_logic_vector (31 downto 0);  -- az
    CLK         : in     std_logic;                       -- clk
    ENA         : in     std_logic;                       -- ena
    CHAINOUT_IM : out    std_logic_vector (31 downto 0);  -- result
    CHAINOUT_RE : out    std_logic_vector (31 downto 0);  -- result
    RESULT_IM   : out    std_logic_vector (31 downto 0);  -- result
    RESULT_RE   : out    std_logic_vector (31 downto 0)   -- result
  );

-- Declarations

end entity cmplxmult_fp ;

