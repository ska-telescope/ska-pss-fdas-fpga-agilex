----------------------------------------------------------------------------
-- Package Name: cmplx_pkg
--
-- Source Path: CON/hdl/cmplx_pkg.vhd 
--
-- Functional Description:
--
----------------------------------------------------------------------------
-- Date:   07/06/2017
----------------------------------------------------------------------------  
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2017 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package cmplx_pkg is

  --------------------------------------------------------------------------
  -- SYSTEM PARAMETERS
  --------------------------------------------------------------------------
  constant DBITS_C        : natural := 32;
  
  
  --------------------------------------------------------------------------
  -- RECORD DEFINITIONS
  --------------------------------------------------------------------------
  -- complex number record
  type cmplx_t is record
      RE               : std_logic_vector(DBITS_C-1 downto 0);
      IM               : std_logic_vector(DBITS_C-1 downto 0);
  end record;
  constant rst_cmplx_c : cmplx_t := (
      (others => '0'),
      (others => '0')
  );
    
  type cmplx_array_t is array (natural range <>) of cmplx_t;
    
  
end cmplx_pkg;