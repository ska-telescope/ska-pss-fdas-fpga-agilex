----------------------------------------------------------------------------
-- Module Name:  hsumhpsel
--
-- Source Path:  hsum_lib/hdl/hsumhpsel_synth.vhd
--
-- Requirements Covered:
--   FDAS.HARMONIC_SUM:035/A
--   FDAS.HARMONIC_SUM:040/A
--   FDAS.HARMONIC_SUM:050/A
--   FDAS.HARMONIC_SUM:055/A
--   FDAS.HARMONIC_SUM:070/A
--
-- Functional Description:
--
-- Controls fetching of the FOP data to feed into the summer tree.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     16/08/18 Initial revision.
-- 0.2  RJH     20/05/19 Added generic harmonic_g and support for upto 16 harmonics.
--
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2018 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of hsumhpsel is

-- Number of cycles to wait for summation results to be passed to TREP.
constant wait_count_start_c : unsigned(3 downto 0) :=
  to_unsigned(adder_latency_g+2+extra_delay_c(harmonic_g-1), 4);

-- Pipeline delay required to convert hpsel into row_info output, i.e. align hpsel with the summer comparator output.
-- The basic delay is DDRIN RAM read latency + comparator latency.
-- After f0 the adder latency needs to be added.
-- An extra delay is added to take into account any max function between the
-- adder and the comparator.
-- The constants are defined in the hsum package.
constant hpsel_delay_c : natural_array_t(0 to 15) := (
  ddrin_latency_c + comparator_latency_c + extra_delay_c(0),                                                      -- f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(1)  + adder_latency_g,  -- 2*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(2)  + adder_latency_g,  -- 3*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(3)  + adder_latency_g,  -- 4*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(4)  + adder_latency_g,  -- 5*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(5)  + adder_latency_g,  -- 6*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(6)  + adder_latency_g,  -- 7*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(7)  + adder_latency_g,  -- 8*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(8)  + adder_latency_g,  -- 9*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(9)  + adder_latency_g,  -- 10*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(10) + adder_latency_g,  -- 11*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(11) + adder_latency_g,  -- 12*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(12) + adder_latency_g,  -- 13*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(13) + adder_latency_g,  -- 14*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(14) + adder_latency_g,  -- 15*f0
  ddrin_latency_c + comparator_latency_c + extra_delay_c(15) + adder_latency_g   -- 16*f0
);

-- Delay required to convert the RAM read enables into enables comp_en.
-- The basic delay is HPSEL RAM read latency + DDRIN RAM read latency.
-- After f0 the adder latency needs to be added.
-- An extra delay is added to take into account any max function between the adder and the
-- comparator. This is defined in the hsum package.
constant enable_delay_c : natural_array_t(0 to 15) := (
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(0),                     -- f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(1)  + adder_latency_g,  -- 2*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(2)  + adder_latency_g,  -- 3*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(3)  + adder_latency_g,  -- 4*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(4)  + adder_latency_g,  -- 5*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(5)  + adder_latency_g,  -- 6*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(6)  + adder_latency_g,  -- 7*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(7)  + adder_latency_g,  -- 8*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(8)  + adder_latency_g,  -- 9*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(9)  + adder_latency_g,  -- 10*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(10) + adder_latency_g,  -- 11*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(11) + adder_latency_g,  -- 12*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(12) + adder_latency_g,  -- 13*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(13) + adder_latency_g,  -- 14*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(14) + adder_latency_g,  -- 15*f0
  hpsel_latency_c + ddrin_latency_c + extra_delay_c(15) + adder_latency_g   -- 16*f0
);

-- Delay required to make last_result_s align with the results in SUMMER.
--constant last_result_delay_0_c : natural := enable_delay_0_c - 1;
--constant last_result_delay_c   : natural := enable_delay_c - 1;

-- RAM component.
component hsumhpselram is
  port (
    -- Port A: write/read.
    a_addr       : in  std_logic_vector(9 downto 0);
    a_write_data : in  std_logic_vector(6 downto 0);
    a_write_en   : in  std_logic;
    a_read_en    : in  std_logic;
    a_read_data  : out std_logic_vector(6 downto 0);
    a_clk        : in  std_logic;

    -- Port B: read.
    b_addr       : in  std_logic_vector(9 downto 0);
    b_read_en    : in  std_logic;
    b_read_data  : out std_logic_vector(6 downto 0);
    b_clk        : in  std_logic
  );
end component hsumhpselram;

type ram_read_data_t    is array(0 to harmonic_g-1) of std_logic_vector(6 downto 0);
type ram_hpsel_addr_t   is array(0 to harmonic_g-1) of std_logic_vector(9 downto 0);
type hpsel_t            is array(0 to harmonic_g-1) of std_logic_vector(6 downto 0);
type seed_count_t       is array(0 to harmonic_g-1) of unsigned(4 downto 0);
type slope_count_t      is array(0 to harmonic_g-1) of unsigned(3 downto 0);
type hpsel_delay_t      is array(0 to hpsel_delay_c(harmonic_g-1) - 1) of hpsel_t;
type en_delay_t         is array(0 to enable_delay_c(harmonic_g-1) - 1) of std_logic_vector(harmonic_g-1 downto 0);

signal ram_write_enable_s : std_logic_vector(harmonic_g-1 downto 0); -- Micro write enables.
signal ram_read_enable_s  : std_logic_vector(harmonic_g-1 downto 0); -- Micro read enables.
signal ram_read_data_s    : ram_read_data_t;                         -- Micro read data.
signal hpsel_s            : hpsel_t;                                 -- RAM output to DDRIN module.
signal ram_hpsel_rden_s   : std_logic_vector(harmonic_g-1 downto 0); -- Function read enables.
signal num_seeds_s        : unsigned(4 downto 0);                    -- Number of seed f0s to process.
signal num_slopes_s       : unsigned(3 downto 0);                    -- Number of ambiguity slopes to process.
signal num_harmonics_s    : unsigned(3 downto 0);                    -- Number of harmonics to process.
signal seed_count_s       : seed_count_t;                            -- Current seed number being processed (per harmonic).
signal slope_count_s      : slope_count_t;                           -- Current slope number being processed (per harmonic).
signal harmonic_count_s   : unsigned(3 downto 0);                    -- Current harmonic being processed.
signal latency_count_s    : unsigned(2 downto 0);                    -- Counts delay between harmonics.
signal trigger_reading_s  : std_logic;                               -- Indicates reading of data for next harmonic may be triggered.
signal wait_count_s       : unsigned(3 downto 0);                    -- Counts delay whilst TREP is updated.
signal hpsel_delay_s      : hpsel_delay_t;                           -- Pipeline delay signals for row_info.
signal en_delay_s         : en_delay_t;                              -- Pipeline delay signals for enables.
signal last_result_s      : std_logic;                               -- Indicates the last ambiguity value being read.
signal last_result_delay_s: std_logic_vector(enable_delay_c(harmonic_g-1) - 2 downto 0); -- last_result_s delay line.

begin

----------------------------------------------------------------------------
-- Function: Generate the RAM enables for micro write and mux the read back data.
----------------------------------------------------------------------------
gen_enables_p : process(hpsel_mci, ram_read_data_s)
begin
  -- Defaults.
  ram_write_enable_s <= (others => '0');
  ram_read_enable_s  <= (others => '0');
  hpsel_rd           <= (others => '0');

  if unsigned(hpsel_mci.addr(15 downto 14)) = summer_inst_g then
    for i in 0 to harmonic_g-1 loop
      if unsigned(hpsel_mci.addr(3 downto 0)) = i then
        ram_write_enable_s(i) <= hpsel_mci.wren;
        ram_read_enable_s(i)  <= hpsel_mci.rden;
        hpsel_rd              <= ram_read_data_s(i);
      end if;
    end loop;
  end if;
end process gen_enables_p;


-- Generate the RAMs, one per harmonic.
gen_ram : for i in 0 to harmonic_g-1 generate

  hpselram : hsumhpselram
    port map (
      -- Port A: write/read.
      a_addr       => hpsel_mci.addr(13 downto 4),
      a_write_data => hpsel_mci.wr,
      a_write_en   => ram_write_enable_s(i),
      a_read_en    => ram_read_enable_s(i),
      a_read_data  => ram_read_data_s(i),
      a_clk        => clk_mc,

      -- Port B: read.
      b_addr(9)          => analysis_run,
      b_addr(8 downto 4) => std_logic_vector(seed_count_s(i)),
      b_addr(3 downto 0) => std_logic_vector(slope_count_s(i)),
      b_read_en          => ram_hpsel_rden_s(i),
      b_read_data        => hpsel_s(i),
      b_clk              => clk_sys
    );

end generate gen_ram;


----------------------------------------------------------------------------
-- Function: Convert configuration to unsigned.
----------------------------------------------------------------------------
conv_seed: num_seeds_s     <= unsigned(p_en);
conv_slop: num_slopes_s    <= unsigned(a);
conv_harm: num_harmonics_s <= unsigned(h);


----------------------------------------------------------------------------
-- Function: Loop through the seed, slopes and harmonics generating the
--           addresses for the RAMs.
--           The address for each RAM is made up as follows:
--           (9)          = analysis run,
--           (8 downto 4) = seed number,
--           (3 downto 0) = slope number.
--
--           The same addresses are applied to each RAM, but they need to be
--           offset in time by the latency of the summation function, thus
--           each RAM has its own address counter.
--           Note: Fundamental and first harmonic are addressed together since
--           no summation is required to process fundamental.
----------------------------------------------------------------------------
addr_gen_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    ram_hpsel_rden_s  <= (others => '0');
    t_en              <= (others => '0');
    latency_count_s   <= (others => '0');
    seed_count_s      <= (others => (others => '0'));
    slope_count_s     <= (others => (others => '0'));
    harmonic_count_s  <= (others => '0');
    wait_count_s      <= (others => '0');
    trigger_reading_s <= '0';
    done_sum          <= '0';
    last_result_s     <= '0';

  elsif rising_edge(clk_sys) then

    -- Defaults.
    done_sum    <= '0';
    t_en        <= (others => '0');
    last_result_s <= '0';

    -- Start new analysis run.
    if new_sum = '1' then
      ram_hpsel_rden_s  <= (others => '0');
      latency_count_s   <= (others => '0');
      seed_count_s      <= (others => (others => '0'));
      slope_count_s     <= (others => (others => '0'));
      harmonic_count_s  <= (0 => '1', others => '0');
      trigger_reading_s <= '1';
    end if;

    if trigger_reading_s = '1' then
      -- Latency counter counts down.
      latency_count_s <= latency_count_s - 1;

      if latency_count_s = 0 then
        -- Restart latency counter.
        latency_count_s  <= to_unsigned(adder_latency_g-1,3);

        -- Increment harmony counter.
        harmonic_count_s <= harmonic_count_s + 1;
        if harmonic_count_s = num_harmonics_s or num_harmonics_s = 0 then
          trigger_reading_s <= '0';
        end if;

        -- Trigger reading the next harmonic.
        if harmonic_count_s = 1 then
          ram_hpsel_rden_s(0) <= '1';
          t_en(0)             <= '1';
        end if;
        for harmonic in 1 to harmonic_g-1 loop
          if harmonic_count_s = harmonic and harmonic_count_s <= num_harmonics_s then
            ram_hpsel_rden_s(harmonic) <= '1';
            t_en(harmonic)             <= '1';
          end if;
        end loop;
      end if; -- latency_count_s = 0
    end if; -- running_s = '1'

    -- Increment slope and seed counters.
    for harmonic in 0 to harmonic_g-1 loop
      if ram_hpsel_rden_s(harmonic) = '1' then
        slope_count_s(harmonic) <= slope_count_s(harmonic) + 1;
        if slope_count_s(harmonic) = num_slopes_s then
          slope_count_s(harmonic) <= (others => '0');
          if harmonic = num_harmonics_s then
            last_result_s <= '1';
          end if;
          seed_count_s(harmonic)  <= seed_count_s(harmonic) + 1;
          if seed_count_s(harmonic) = num_seeds_s then
            -- Last seed completed.
            ram_hpsel_rden_s(harmonic) <= '0';
            if harmonic = num_harmonics_s then
              -- Indicate last harmonic has finished reading.
              wait_count_s <= wait_count_start_c;
            end if;
          else
            -- Read threshold for next seed.
            t_en(harmonic) <= '1';
          end if;
        end if;
      end if;
    end loop;

    -- Wait for processing to finish.
    if wait_count_s > 0 then
      wait_count_s <= wait_count_s - 1;
      if wait_count_s = 1 then
        done_sum <= '1';
      end if;
    end if;

  end if; -- rst_sys_n = '0'

end process addr_gen_p;


----------------------------------------------------------------------------
-- Function: Generate the delay lines for hpsel.
--           These will be used to generate row_info, below.
----------------------------------------------------------------------------
pipeline_delay_1_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    hpsel_delay_s <= (others => (others => (others => '0')));

  elsif rising_edge(clk_sys) then

    hpsel_delay_s(0) <= hpsel_s;
    for i in 1 to hpsel_delay_c(harmonic_g-1) - 1 loop
      hpsel_delay_s(i) <= hpsel_delay_s(i-1);
    end loop;

  end if;
end process pipeline_delay_1_p;

----------------------------------------------------------------------------
-- Function: Delay the RAM read enables so that they can be used to enable
--           the comparators in SUMMER_TREE.
----------------------------------------------------------------------------
enable_delay_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    en_delay_s <= (others => (others => '0'));

  elsif rising_edge(clk_sys) then

    en_delay_s(0) <= ram_hpsel_rden_s;
    for i in 1 to enable_delay_c(harmonic_g-1) - 1 loop
      en_delay_s(i) <= en_delay_s(i-1);
    end loop;

  end if;
end process enable_delay_p;

----------------------------------------------------------------------------
-- Function: Delay last_result_s to align with the results in SUMMER.
--           The delay required is the same as for RAM read enables, but
--           reduced by one cycle.
----------------------------------------------------------------------------
last_result_delay_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    last_result_delay_s  <= (others => '0');
    last_result          <= '0';

  elsif rising_edge(clk_sys) then

    -- Create delay line.
    last_result_delay_s <= last_result_delay_s(enable_delay_c(harmonic_g-1) - 3 downto 0) & last_result_s;

    -- Select required tap according to the number of harmonics covered by the analysis run.
    last_result <= last_result_delay_s(enable_delay_c(to_integer(num_harmonics_s))-2);
  end if;
end process last_result_delay_p;

----------------------------------------------------------------------------
-- Function: Connect up outputs.
----------------------------------------------------------------------------
outgen : for i in 0 to harmonic_g-1 generate
  -- Connect seed_num output.
  conseed : seed_num(i*5+4 downto i*5) <= std_logic_vector(seed_count_s(i));

  -- Connect hpsel output.
  conhpsel : hpsel(i*7+6 downto i*7) <= hpsel_s(i);

  -- Generate msel output.
  genmsel : msel(i) <= '1' when hpsel_delay_s(0)(i) = "1100000" else '0';

  -- Connect row_info and comparator enables.
  rowinfo : row_info(i*7+6 downto i*7) <= hpsel_delay_s(hpsel_delay_c(i)-1)(i);
  compen  : comp_en(i)                 <= en_delay_s(enable_delay_c(i)-1)(i);

end generate outgen;

conhpen : hpsel_en <= en_delay_s(0);

end architecture synth;

