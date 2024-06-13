----------------------------------------------------------------------------
-- Module Name:  hsumtsel
--
-- Source Path:  hsum_lib/hdl/hsumtsel_synth.vhd
--
-- Requirements Covered:
--   FDAS.THRESHOLD:010/A
--
-- Functional Description:
--
-- Performs threshold selection to feed into SUMMER_TREE.
-- The RAM outputs are delayed to align with the summations in SUMMER_TREE.
-- The delay is applied to the RAM address and read enables since this
-- requires fewer d-types.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     16/08/18 Initial revision.
-- 0.2  RJH     20/05/19 Added generic harmonic_g and support for upto 16 harmonics.
-- 0.3  RJH     12/05/20 Updated to take into account extra delay in the
--                       summing tree due to the addition of the max functions.
---------------------------------------------------------------------------
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

library hsum_lib;
use hsum_lib.hsum_pkg.all;

architecture synth of hsumtsel is

-- Pipeline delay for the threshold data to arrive at the comparator in
-- hsumtree at the correct time.
-- Tbe basic delay is HPSEL read latency + DDRIN read latency - TSEL read latency
-- After f0 the adder latency needs to be added.
-- An extra delay is added to take into account any max function between the
-- adder and the comparator.
-- The constants are defined in the hsum package.
constant base_delay_c : natural := hpsel_latency_c + ddrin_latency_c - tsel_latency_c;
constant tsel_delay_c : natural_array_t(0 to 15) := (
  base_delay_c + extra_delay_c(0),                    -- f0
  base_delay_c + extra_delay_c(1)  + adder_latency_g, -- 2*f0
  base_delay_c + extra_delay_c(2)  + adder_latency_g, -- 3*f0
  base_delay_c + extra_delay_c(3)  + adder_latency_g, -- 4*f0
  base_delay_c + extra_delay_c(4)  + adder_latency_g, -- 5*f0
  base_delay_c + extra_delay_c(5)  + adder_latency_g, -- 6*f0
  base_delay_c + extra_delay_c(6)  + adder_latency_g, -- 7*f0
  base_delay_c + extra_delay_c(7)  + adder_latency_g, -- 8*f0
  base_delay_c + extra_delay_c(8)  + adder_latency_g, -- 9*f0
  base_delay_c + extra_delay_c(9)  + adder_latency_g, -- 10*f0
  base_delay_c + extra_delay_c(10) + adder_latency_g, -- 11*f0
  base_delay_c + extra_delay_c(11) + adder_latency_g, -- 12*f0
  base_delay_c + extra_delay_c(12) + adder_latency_g, -- 13*f0
  base_delay_c + extra_delay_c(13) + adder_latency_g, -- 14*f0
  base_delay_c + extra_delay_c(14) + adder_latency_g, -- 15*f0
  base_delay_c + extra_delay_c(15) + adder_latency_g  -- 16*f0
);

-- RAM component.
component hsumtselram is
  port (
    -- Port A: write/read.
    a_addr       : in  std_logic_vector(5 downto 0);
    a_write_data : in  std_logic_vector(31 downto 0);
    a_write_en   : in  std_logic;
    a_read_en    : in  std_logic;
    a_read_data  : out std_logic_vector(31 downto 0);
    a_clk        : in  std_logic;

    -- Port B: read.
    b_addr       : in  std_logic_vector(5 downto 0);
    b_read_en    : in  std_logic;
    b_read_data  : out std_logic_vector(31 downto 0);
    b_clk        : in  std_logic
  );
end component hsumtselram;

type ram_read_data_t is array(0 to harmonic_g-1) of std_logic_vector(31 downto 0);
type ram_tsel_addr_t is array(0 to harmonic_g-1) of std_logic_vector(5 downto 0);
type addr_delay_t    is array(0 to tsel_delay_c(harmonic_g-1) - 1) of std_logic_vector(seed_num'range);
type enable_delay_t  is array(0 to tsel_delay_c(harmonic_g-1) - 1) of std_logic_vector(t_en'range);

signal ram_write_enable_s : std_logic_vector(harmonic_g-1 downto 0); -- Micro write enables.
signal ram_read_enable_s  : std_logic_vector(harmonic_g-1 downto 0); -- Micro read enables.
signal ram_read_data_s    : ram_read_data_t;                         -- Micro read data.
signal addr_delay_s       : addr_delay_t;                            -- Pipeline delay signals for read address.
signal enable_delay_s     : enable_delay_t;                          -- Pipeline delay signals for read enables.
signal ram_tsel_rden_s    : std_logic_vector(harmonic_g-1 downto 0); -- Function read enables.
signal ram_tsel_addr_s    : ram_tsel_addr_t;                         -- Function read address.

begin

----------------------------------------------------------------------------
-- Function: Generate the micro RAM write enables and mux the read back data.
----------------------------------------------------------------------------
gen_enables_p : process(tsel_mci, ram_read_data_s)
begin
  -- Defaults.
  ram_write_enable_s <= (others => '0');
  ram_read_enable_s  <= (others => '0');
  tsel_rd            <= (others => '0');

  if unsigned(tsel_mci.addr(11 downto 10)) = summer_inst_g then
    for i in 0 to harmonic_g-1 loop
      if unsigned(tsel_mci.addr(3 downto 0)) = i then
        ram_write_enable_s(i) <= tsel_mci.wren;
        ram_read_enable_s(i)  <= tsel_mci.rden;
        tsel_rd               <= ram_read_data_s(i);
      end if;
    end loop;
  end if;
end process gen_enables_p;


-- Generate the RAMs, one per harmonic.
-- Note: B port read latency is 2.
gen_ram : for i in 0 to harmonic_g-1 generate

  tselram : hsumtselram
    port map (
      -- Port A: write/read.
      a_addr       => tsel_mci.addr(9 downto 4),
      a_write_data => tsel_mci.wr,
      a_write_en   => ram_write_enable_s(i),
      a_read_en    => ram_read_enable_s(i),
      a_read_data  => ram_read_data_s(i),
      a_clk        => clk_mc,

      -- Port B: read.
      b_addr       => ram_tsel_addr_s(i),
      b_read_en    => ram_tsel_rden_s(i),
      b_read_data  => t(i*32+31 downto i*32),
      b_clk        => clk_sys
    );

end generate gen_ram;


----------------------------------------------------------------------------
-- Function: Generates a delay line for the seed numbers and enables from
--           HP_SEL which will be subsequently used to address the threshold
--           RAMs. The required delay for each harmonic is tapped off in
--           the generate statement below.
----------------------------------------------------------------------------
pipeline_delay_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    addr_delay_s   <= (others => (others => '0'));
    enable_delay_s <= (others => (others => '0'));

  elsif rising_edge(clk_sys) then

    addr_delay_s(0)   <= seed_num;
    enable_delay_s(0) <= t_en;
    for i in 1 to tsel_delay_c(harmonic_g-1) - 1 loop
      addr_delay_s(i)   <= addr_delay_s(i-1);
      enable_delay_s(i) <= enable_delay_s(i-1);
    end loop;

  end if;
end process pipeline_delay_p;

----------------------------------------------------------------------------
-- Function: Selects the appropriately delayed address and enables so that
--           the thresholds read from the RAMs arrive at the comparators in
--           hsumtree at the correct time.
----------------------------------------------------------------------------
connect : for i in 0 to harmonic_g-1 generate
  addr : ram_tsel_addr_s(i) <= t_set & addr_delay_s(tsel_delay_c(i)-1)(5*i+4 downto 5*i);
  en   : ram_tsel_rden_s(i) <= enable_delay_s(tsel_delay_c(i)-1)(i);
end generate connect;

end architecture synth;

