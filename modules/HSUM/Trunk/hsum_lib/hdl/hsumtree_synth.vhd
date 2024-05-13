----------------------------------------------------------------------------
-- Module Name:  hsumtree
--
-- Source Path:  hsum_lib/hdl/hsumtree_synth.vhd
--
-- Requirements Covered:
--   FDAS.HARMONIC_SUM:060/A
--
-- Functional Description:
--
-- Performs the summation of the FOP power values and compares them
-- against a threshold.
--
-- In the diagram below, each '+' represents an adder.
-- Data flow is top to bottom.
-- The outputs from each adder in the same row are compared to the same
-- threshold.
-- Where adders are joined horizontally '+-+' they each receive the same
-- data_sum value and the maximum value from the group is passed on to
-- the comparator.
-- The data_sum and threshold data arrives pre-staggered (by HP_SEL and
-- T_SEL) to take into account the adder and max function latencies.
--
-- f0                                                                              data_sum(31:0)--|    >= t(31:0)
--                                                                                                 |
--                                                                       |-------------------------|-------------------------|
--                                                                       |                         |                         |
-- 2*f0                                                         (63:32)--+                (95:64)--+               (127:96)--+    >= t(63:32)
--                                                                       |                         |                         |
--                                                                       | |-----------------------|-----------------------| |
-- 3*f0                                                       (159:128)--+-+             (191:160)-+             (223:192)-+-+    >= t(95:64)
--                                                                       | |                       |                       | |
--                                                 |---------------------| | |---------------------|---------------------| | |---------------------|
-- 4*f0                                 (255:224)--+          (287:256)--+-+-+          (319:288)--+          (351:320)--+-+-+          (383:352)--+    >= t(127:96)
--                                                 |                     | | |                     |                     | | |                     |
--                                                 | |-------------------| | | |-------------------|-------------------| | | |-------------------| |
-- 5*f0                                 (415:384)--+-+        (447:416)--+-+-+-+        (479:448)--+        (511:480)--+-+-+-+        (543:512)--+-+    >= t(159:128)
--                                                 | | |-----------------| | | |                   |                   | | | |-----------------| | |
--                                                 | | |                   | | | |-----------------|-----------------| | | |                   | | |
--                               |-----------------| | | |-----------------| | | |                 |                 | | | |-----------------| | | |
-- 6*f0               (575:544)--+      (607:576)--+-+-+-+      (639:608)--+-+-+-+      (671:640)--+      (703:672)--+-+-+-+      (735:704)--+-+-+-+      (767:736)--+    >= t(191:160)
--                               | |---------------| | | |                 | | | |                 |                 | | | |                 | | | |---------------| |
--                               | |                 | | | |---------------| | | | |---------------|---------------| | | | |---------------| | | |                 | |
--                               | | |---------------| | | |               | | | | |               |               | | | | |               | | | |---------------| | |
-- 7*f0               (799:768)--+-+-+    (831:800)--+-+-+-+    (832:863)--+-+-+-+-+    (895:864)--+    (927:896)--+-+-+-+-+    (959:928)--+-+-+-+    (991:960)--+-+-+    >= t(223:192)
--                               | | |               | | | |               | | | | |               |               | | | | |               | | | |               | | |
--                 |-------------| | | |-------------| | | | |-------------| | | | | |-------------|-------------| | | | | |-------------| | | | |-------------| | | |-------------|
-- 8*f0 (1023:993)-+ (1055:1024)-+-+-+-+ (1087:1056)-+-+-+-+-+ (1119:1088)-+-+-+-+-+-+ (1151:1120)-+ (1183:1152)-+-+-+-+-+-+ (1215:1184)-+-+-+-+-+ (1247:1216)-+-+-+-+ (1279:1248)-+    >= t(255:224)
--                 |             | | | |             | | | | |             | | | | | |             |             | | | | | |             | | | | |             | | | |             |
--
-- values in data_sum and sum_s waveforms = <ambiguity#>,<seed#>
-- values in t waveforms = <seed#>
-- adder_latency = 2
--                           ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______
-- data_sum[127:0](SUM[0])  X__1,1_X__2,1_X__3,1_X__4,2_X__5,1_X__6,2_X__7,1_X__8,2_X__9,1_X_10,2_X_11,1_X__1,2_X
--                           ____________________________________________________________________________ ______
-- t[0]                     X______________________________________1_____________________________________X______
--                           ___________________________________________________________________________________
-- comp_en[0]               /
--                                  ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______
-- tc[0]                    _______X______X______X______X______X______X______X______X______X______X______X______X
--                                         ______ ______ ______ ______ ______ ______ ______ ______ ______ ______
-- sum_s[1],[2],[3]         ______________X__1,1_X__2,1_X__3,1_X__4,2_X__5,1_X__6,2_X__7,1_X__8,2_X__9,1_X_10,2_X
--                                         ______________________________________________________________________
-- t[1]                     ______________X______________________________________1_______________________________
--                                         ______________________________________________________________________
-- comp_en[1]               ______________/
--                                                ______ ______ ______ ______ ______ ______ ______ ______ ______
-- tc[1]                    _____________________X______X______X______X______X______X______X______X______X______X
--                                         ______ ______ ______ ______ ______ ______ ______ ______ ______ ______
-- data_sum[223:129]        ______________X__1,1_X__2,1_X__3,1_X__4,2_X__5,1_X__6,2_X__7,1_X__8,2_X__9,1_X_10,2_X
--                                                       ______ ______ ______ ______ ______ ______ ______ ______
-- sum_s[4],[5],[6]         ____________________________X__1,1_X__2,1_X__3,1_X__4,2_X__5,1_X__6,2_X__7,1_X__8,2_X
--                                                       ________________________________________________________
-- t[2]                     ____________________________X______________________________________1_________________
--                                                       ________________________________________________________
-- comp_en[2]               ____________________________/
--                                                              ______ ______ ______ ______ ______ ______ ______
-- tc[2]                    ___________________________________X______X______X______X______X______X______X______X
--
-- etc.
-- Note : Signals t[3], comp_en[3] and tc[3] and higher have additional delay to accommodate the delay through
-- the 'max' function that follows the summers.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     20/09/18 Initial revision.
-- 0.2  RJH     03/06/19 Updated to work with up to 16 harmonics.
-- 0.3  RJH     19/05/20 Summer tree modified. More than one adder now
--                       contributes to some compare points.
-- 0.4  RJH     04/06/20 Function added to generate some of the constants
--                       used to construct the tree, rather than entered
--                       by hand.
-- 0.5  RJH     07/07/20 Constant 'balance_delay_c' is now calculated by
--                       the function 'gen_constants'.
-- 0.6  RMD     29/08/23 Distributed the reset signal to eliminate 
--                       recovery timing warnings.
---------------------------------------------------------------------------
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hsum_lib;
use hsum_lib.hsum_pkg.all;

architecture synth of hsumtree is

-- Function to sum the values in an array.
function sum(vals : natural_array_t) return natural is
  variable sum_v : natural := 0;
begin
  for i in vals'range loop
    sum_v := sum_v + vals(i);
  end loop;
  return sum_v;
end function sum;

-- Define a constant array to describe the number of adders feeding each comparator.
-- The index is the comparator number.
-- ### NOTE: This constant needs extending up to 16 harmonics.
constant adders_per_comparator_c : natural_array_t(1 to last_column_c(12)) := (
                                  1,
                               1, 1, 1,
                               2, 1, 2,
                            1, 3, 1, 3, 1,
                            2, 4, 1, 4, 2,
                         1, 4, 4, 1, 4, 4, 1,
                         3, 4, 5, 1, 5, 4, 3,
                      1, 4, 5, 6, 1, 6, 5, 4, 1,
                      2, 5, 6, 7, 1, 7, 6, 5, 2,
                   1, 3, 6, 7, 8, 1, 8, 7, 6, 3, 1,
                   2, 4, 7, 8, 9, 1, 9, 8, 7, 4, 2,
                1, 3, 5, 8, 9,10, 1,10, 9, 8, 5, 3, 1,
                2, 4, 6, 9,10,11, 1,11,10, 9, 6, 4, 2
);

-- Determine the number of adders required for the number of harmonics implemented.
constant adders_c : natural := sum(adders_per_comparator_c(1 to last_column_c(harmonic_g-1)));

-- Determine the number of comparators required for the number of harmonics implemented.
constant comparators_c : natural := last_column_c(harmonic_g-1);

-- Lookup for number of retimes in max functions depending on its size.
-- A max function with 2 inputs adds 1 retime.
-- A max function with 3 or 4 inputs adds 2 retimes.
-- A max function with 5 to 8 inputs adds 3 retimes,
-- A max function with 9 to 16 inputs adds 4 retimes.
constant maxfunc_retimes_c : natural_array_t(0 to 16) :=
  (0 to 1 => 0, 2 => 1, 3 to 4 => 2, 5 to 8 => 3, 9 to 16 => 4);

-- From the above constants and last_column_c (from hsum_pkg) we can generate the
-- constants below using the following function.
function gen_constants(constant_sel : natural range 1 to 4) return natural_array_t is
  variable src_v       : natural := 0; -- Source adder.
  variable dest_v      : natural := 1; -- Destination adder.
  variable harmonic_v  : natural := 0; -- Harmonic count.
  variable size_v      : natural;      -- Size of max function.
  variable is_rowend_v : boolean;      -- Indicates last comparator for current harmonic.
  variable rowstart_v  : natural := 1; -- Pointer to first balance_delay_v element for current harmonic.
  variable max_del_v   : natural := 0; -- Stores maximum retimes in max function for current row.

  -- Arrays for return values.
  variable adder_source_v        : natural_array_t(1 to adders_c);
  variable adder_to_comparator_v : natural_array_t(1 to adders_c);
  variable first_adder_v         : natural_array_t(1 to comparators_c);
  variable balance_delay_v       : natural_array_t(1 to comparators_c);
begin
  -- Loop through each comparator.
  for comp in 1 to comparators_c loop
    size_v := adders_per_comparator_c(comp);
    is_rowend_v := (comp = last_column_c(harmonic_v));
    first_adder_v(comp) := dest_v;
    balance_delay_v(comp) := maxfunc_retimes_c(size_v); -- For now store actual number of retimes.
    if maxfunc_retimes_c(size_v) > max_del_v then
      max_del_v := maxfunc_retimes_c(size_v);  -- Determine max number of retimes for this row.
    end if;
    -- Loop through the number of adders for this comparator.
    for adder in 1 to size_v loop
      adder_source_v(dest_v) := src_v;
      adder_to_comparator_v(dest_v) := comp;
      dest_v := dest_v + 1;
      if adder /= size_v or is_rowend_v then
        src_v := src_v + 1;
      end if;
    end loop;
    if is_rowend_v then
      -- Calculate the balance delays.
      for i in rowstart_v to comp loop
        -- Set balance_delay_v to the difference between max retimes and actual retimes.
        balance_delay_v(i) := max_del_v - balance_delay_v(i);
      end loop;
      -- Check extra_delay_c defined in hsum package is correct.
      assert extra_delay_c(harmonic_v) = max_del_v
        report "Element " & natural'image(harmonic_v) & " of constant extra_delay_c is incorrect."
          severity error;
      -- Set vars for next row.
      max_del_v := 0;
      rowstart_v := comp + 1;
      harmonic_v := harmonic_v + 1;
    end if;
  end loop;

  -- Return results.
  case constant_sel is
    when 1 =>
      return adder_source_v;
    when 2 =>
      return adder_to_comparator_v;
    when 3 =>
      return first_adder_v;
    when 4 =>
      return balance_delay_v;
  end case;
end function gen_constants;

-- Define the connectivity between adders.
-- The index is an adder #, the value is the adder # driving the index.
constant adder_source_c : natural_array_t(1 to adders_c) := gen_constants(1);

-- Define a constant to map adder # to the comparator # (both are 1 based).
constant adder_to_comparator_c : natural_array_t(1 to adders_c) := gen_constants(2);

-- Define a constant to specify the lowest number adder feeding each comparator.
-- The index is the comparator number.
constant first_adder_c : natural_array_t(1 to comparators_c) := gen_constants(3);

-- Define a constant to define where additional retimes need to be added to
-- align the results of differing size max functions.
constant balance_delay_c : natural_array_t(1 to last_column_c(harmonic_g-1)) := gen_constants(4);

-- Define a signal for the outputs of the FP adders.
signal sum_s : unsigned32array_t(1 to adders_c);

-- Define an array signal for the thresholds.
signal thresholds_s : unsigned32array_t(0 to harmonic_g-1);

-- Define a signal for output of max functions.
signal max_s : unsigned32array_t(1 to comparators_c);

-- Define a signal to add delay between the max functions and comparators.
signal max_del_s : unsigned32array_t(1 to comparators_c);

component hsumadder is
  port (
    -- Data inputs.
    a         : in  std_logic_vector(31 downto 0);
    b         : in  std_logic_vector(31 downto 0);

    -- Sum output.
    sum       : out std_logic_vector(31 downto 0);

    -- Clock and reset.
    clk_sys   : in  std_logic;
    rst_sys_n : in std_logic
  );
end component hsumadder;

component hsummax is
  generic (
    size_g : natural range 2 to 32  -- Number of values to compare.
  );
  port (
    values    : in  unsigned32array_t(size_g-1 downto 0); -- Values to compare.
    maxval    : out unsigned(31 downto 0);                -- Maximum value.

    clk_sys   : in  std_logic;
    rst_sys_n : in  std_logic
  );
end component hsummax;

component hsumretime is
  generic (
    delay_g : natural; -- Number of retimes.
    width_g : natural  -- Width of data ports.
  );
  port (
    din       : in  unsigned(width_g-1 downto 0);
    dout      : out unsigned(width_g-1 downto 0);

    clk_sys   : in  std_logic;
    rst_sys_n : in  std_logic
  );
end component hsumretime;


begin

----------------------------------------------------------------------------
-- Function : Convert thresholds input into an array signal for convenience.
----------------------------------------------------------------------------
thresholds : for i in 0 to harmonic_g-1 generate
  cont : thresholds_s(i) <= unsigned(t(i*32+31 downto i*32));
end generate thresholds;

----------------------------------------------------------------------------
-- Function : Connect up the adders.
----------------------------------------------------------------------------
nullsum : sum_s(1) <= unsigned(data_sum(31 downto 0));

adders : for adder in 2 to sum_s'right generate

  fp_add : hsumadder
    port map (
      a             => std_logic_vector(sum_s(adder_source_c(adder))),
      b             => data_sum(adder_to_comparator_c(adder)*32-1 downto
                                adder_to_comparator_c(adder)*32-32),
      unsigned(sum) => sum_s(adder),

      clk_sys   => clk_sys,
      rst_sys_n => rst_sys_1_n
    );

end generate adders;

----------------------------------------------------------------------------
-- Function : Generate the max functions and any delay balancing retimes.
----------------------------------------------------------------------------
max_funcs : for i in max_s'range generate

  -- Generate max function if required.
  max_gen : if adders_per_comparator_c(i) > 1 generate
    max_i : hsummax
      generic map (
        size_g => adders_per_comparator_c(i)  -- Number of values to compare.
      )
      port map (
        values    => sum_s(first_adder_c(i) to first_adder_c(i) + adders_per_comparator_c(i) - 1), -- Values to compare.
        maxval    => max_s(i),   -- Maximum value.
        clk_sys   => clk_sys,
        rst_sys_n => rst_sys_2_n
      );
  end generate max_gen;
  nomax : if adders_per_comparator_c(i) = 1 generate
    -- Pass on sum directly.
    nomax : max_s(i) <= sum_s(first_adder_c(i));
  end generate nomax;

  -- Generate retimes if required for sums without a max function or to balance
  -- delays between differently sized max functions.
  noretime : if balance_delay_c(i) = 0 generate
    -- Pass on the signal directly.
    nodel : max_del_s(i) <= max_s(i);
  end generate noretime;
  retime_gen : if balance_delay_c(i) > 0 generate
    retime_i : hsumretime
      generic map (
        delay_g => balance_delay_c(i), -- Number of retimes.
        width_g => 32
      )
      port map (
        din       => max_s(i),
        dout      => max_del_s(i),
        clk_sys   => clk_sys,
        rst_sys_n => rst_sys_2_n
      );
  end generate retime_gen;

end generate max_funcs;

----------------------------------------------------------------------------
-- Function : Generate the comparators.
--            Note: Both sum and thresholds should be positive. If either is
--            negative, no comparison is performed.
----------------------------------------------------------------------------
comparators_p : process(clk_sys, rst_sys_1_n)
begin
  if rst_sys_1_n = '0' then
    -- Initialise.
    pwr <= (others => '0');
    tc  <= (others => '0');

  elsif rising_edge(clk_sys) then

    -- Defaults.
    tc <= (others => '0');

    for i in max_s'range loop
      if comp_en(ram_harmonic_c(i)) = '1' and
         max_del_s(i)(31) = '0' and thresholds_s(ram_harmonic_c(i))(31) = '0' then
        if max_del_s(i)(30 downto 0) >= thresholds_s(ram_harmonic_c(i))(30 downto 0) then
          tc(i-1) <= '1';
        end if;
      end if;
      pwr(i*32-1 downto i*32-32) <= std_logic_vector(max_del_s(i));
    end loop;

  end if;
end process comparators_p;

end architecture synth;

