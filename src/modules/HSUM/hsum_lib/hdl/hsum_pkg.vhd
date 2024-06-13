----------------------------------------------------------------------------
-- Package Name:  hsum_pkg
--
-- Source Path:   hsum_lib/hdl/hsum_pkg.vhd
--
-- Functional Description:
--
-- This package provides definitions of types and constants to allow the
-- design to adjust to variations in the number of harmonics supported and
-- variations to the summing tree.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH  09/04/2019  Initial revision.
-- 0.2  RJH  19/05/2020  Updated to support the latest summing tree design
--                       containing max functions.
--
----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2020 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package hsum_pkg is

  -- Define a generic array of naturals.
  type natural_array_t is array(natural range <>) of natural;

  -- Define a generic array of 32-bit unsigned vectors.
  type unsigned32array_t is array(natural range <>) of unsigned(31 downto 0);

  -- Define a generic array of 32-bit std_logic vectors.
  type slv32array_t is array(natural range <>) of std_logic_vector(31 downto 0);

  -- Define a lookup table that maps column sequence number or DDRIN RAM number to harmonic.
  constant ram_harmonic_c : natural_array_t(1 to 144) := (
                            0,
                         1, 1, 1,
                         2, 2, 2,
                      3, 3, 3, 3, 3,
                      4, 4, 4, 4, 4,
                   5, 5, 5, 5, 5, 5, 5,
                   6, 6, 6, 6, 6, 6, 6,
                7, 7, 7, 7, 7, 7, 7, 7, 7,
                8, 8, 8, 8, 8, 8, 8, 8, 8,
             9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
            10,10,10,10,10,10,10,10,10,10,10,
         11,11,11,11,11,11,11,11,11,11,11,11,11,
         12,12,12,12,12,12,12,12,12,12,12,12,12,
      13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,
      14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,
   15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
  );

  -- Define a lookup table fot the end column number for a harmonic.
  -- This is also the number of RAMs required in DDRIN.
  constant last_column_c : natural_array_t(0 to 15) := (1, 4, 7, 12, 17, 24, 31, 40, 49, 60, 71, 84, 97, 112, 127, 144);

  -- Define a lookup table for the number of columns read for each harmonic.
  constant cols_per_harmonic_c : natural_array_t(0 to 15) :=
    (1, 3, 3, 5, 5, 7, 7, 9, 9, 11, 11, 13, 13, 15, 15, 17);

  -- Define a constant for the number of results per harmoninc.
  constant res_per_h_c : natural_array_t(0 to 15) := cols_per_harmonic_c;

  -- Define a constant for the first result number per harmonic.
  constant first_res_c : natural_array_t(0 to 15) :=
    (0, 1, 4, 7, 12, 17, 24, 31, 40, 49, 60, 71, 84, 97, 112, 127);

  -- Define a constant for the number of results to store per harmonic in hsumhres.
  -- Currently the bitmap allows for up to 32 results, however two words
  -- are reserved for the exceeded report and the DM number.
  constant max_results_c : natural range 1 to 30 := 25;

  -- The following constants must be set to reflect the latency of certain parts
  -- of the design. They are used to make the design self adjusting when
  -- timing changes are introduced.
  constant hpsel_latency_c      : natural := 1; -- HPSEL RAM circuit read latency.
  constant ddrin_latency_c      : natural := 2; -- DDRIN RAM read latency.
  constant tsel_latency_c       : natural := 2; -- TSEL RAM circuit read latency.
  constant comparator_latency_c : natural := 1; -- Comparator latency in the SUMMER tree.
  constant extra_delay_c        : natural_array_t(0 to 15) := (
    -- This constant defines the extra delay in generating the comparison result
    -- for each harmonic. The extra delay is that in addition to the adder and
    -- comparator delay, i.e. the delay through the max function, if present.
    0 to 1  => 0,  -- f0, 2*f0 : just the comparator delay.
    2       => 1,  -- 3*f0 : max function of 2.
    3       => 2,  -- 4*f0 : max function of 3.
    4       => 2,  -- 5*f0 : max function of 4.
    5       => 2,  -- 6*f0 : max function of 4.
    6       => 3,  -- 7*f0 : max function of 5.
    7       => 3,  -- 8*f0 : max function of 6.
    8       => 3,  -- 9*f0 : max function of 7.
    9       => 3,  --10*f0 : max function of 8.
    10      => 4,  --11*f0 : max function of 9.
    11      => 4,  --12*f0 : max function of 10.
    12      => 4,  --13*f0 : max function of 11.
    13 to 15=> 4   --14*f0 to 16*f0 : max function will add 4 cycles.
  );


end package hsum_pkg;
