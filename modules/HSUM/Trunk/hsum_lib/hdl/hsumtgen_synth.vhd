----------------------------------------------------------------------------
-- Module Name:  hsumtgen
--
-- Source Path:  hsum_lib/hdl/hsumtgen_synth.vhd
--
-- Requirements Covered:
--   FDAS.HARMONIC_SUM:035/A
--   FDAS.HARMONIC_SUM:040/A
--   FDAS.HARMONIC_SUM:080/A
--
-- Functional Description:
--
-- Generates the control signals for DDRIN and SUMMER sub-blocks.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     13/11/18 Initial revision.
-- 0.2  RJH     15/04/19 Modified to work with up to 16 harmonics.
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

architecture synth of hsumtgen is

-- Constants for the delay from done_sum being raised and the SUMMER results
-- being stored in the first stage store (d-types) of TREP (hsumhres).
-- When the filter is off, the delay is 4 cycles (1 in hsumfilt, 3 in hsumhres).
constant filter_off_delay_c : natural := 4;
-- When filter is on, the delay 17 cycles (3 + 11 in hsumfilt, 3 in hsumhres)
constant filter_on_delay_c : natural := 17;
-- Therefore, a 5-bit counter is required for the hold-off counter.

type control_state_t is (idle, init, wait_for_data, wait_sum_done,
                         save_data, paused, run_complete, begin_run2);

signal done_sum_latch_s     : std_logic_vector(summer_g-1 downto 0);
signal done_sum_holdoff_s   : unsigned(4 downto 0); -- done_sum hold-off counter.
signal all_sum_done_s       : std_logic;      -- Indicates all SUMMERs have finished.
signal run_num_s            : std_logic;      -- Analysis run number.
signal state_s              : control_state_t;-- FSM state variable.
signal hsum_trigger_d1      : std_logic;      -- Retimed trigger input.
signal triggered_s          : std_logic;      -- Indicates rising edge detected on trigger input.
signal triggered_d1         : std_logic;      -- Delayed triggered_s.
signal running_s            : std_logic;      -- Control for DDRIN and SUMMER trigger processes.
signal last_col_requested_s : std_logic;      -- Indicates data for last column of run is being requested by DDRIN.
signal last_col_processed_s : std_logic;      -- Indicates last column of run is being processed by SUMMER.
signal seed_col_read_s      : unsigned(21 downto 0); -- Seed column counter for DDRIN.
signal new_col_s            : std_logic;      -- Trigger to DDRIN to fetch next column(s) of data.
signal new_sum_s            : std_logic;      -- Trigger to SUMMERs to process column(s) of data.
signal request_count_s      : unsigned(2 downto 0); -- Counts number of pages of FOP data requested from DDR.
signal req_in_progress_s    : std_logic;      -- Indicates DDRIN is requesting data.
signal full_page_count_s    : unsigned(2 downto 0); -- Count of filled pages in DDRIN.
signal ddrin_rd_page_s      : unsigned(1 downto 0); -- RAM page to use when SUMMER is reading FOP data.
signal seed_col_sum_s       : unsigned(21 downto 0); -- Seed column counter for SUMMER.

-- Configuration latched when triggered.
signal b_start_1_s          : std_logic_vector(21 downto 0);
signal b_stop_1_s           : std_logic_vector(21 downto 0);
signal b_start_2_s          : std_logic_vector(21 downto 0);
signal b_stop_2_s           : std_logic_vector(21 downto 0);
signal h_1_s                : std_logic_vector(3 downto 0);
signal h_2_s                : std_logic_vector(3 downto 0);
signal a_1_s                : vector_4_array_t(0 to summer_g-1);
signal a_2_s                : vector_4_array_t(0 to summer_g-1);
signal p_en_1_s             : vector_5_array_t(0 to summer_g-1);
signal p_en_2_s             : vector_5_array_t(0 to summer_g-1);
signal fop_row_1_s          : std_logic_vector(6 downto 0);
signal fop_row_2_s          : std_logic_vector(6 downto 0);
-- Configuration for current run.
signal b_stop_s             : unsigned(21 downto 0); -- End column.
signal h_s                  : std_logic_vector(3 downto 0); -- Number of harmonics.
signal a_s                  : vector_4_array_t(0 to summer_g-1);  -- Number of orbital acceleration ambiguity slopes.
signal p_en_s               : vector_5_array_t(0 to summer_g-1);  -- Number of orbital acceleration values.
signal fop_row_s            : std_logic_vector(6 downto 0); -- Number of FOP rows to fetch from DDR.

begin

----------------------------------------------------------------------------
-- Function:  Retime trigger signal and edge detect.
----------------------------------------------------------------------------
det_trig_p : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    hsum_trigger_d1 <= '0';
    triggered_s     <= '0';
    triggered_d1    <= '0';

  elsif rising_edge(clk_sys) then
    -- Retime trigger input.
    hsum_trigger_d1 <= hsum_trigger;

    -- Detect rising edge on trigger input.
    if hsum_trigger = '1' and hsum_trigger_d1 = '0' and hsum_enable = '1' then
      triggered_s <= '1';
    else
      triggered_s <= '0';
    end if;

    -- Retime trigger signal.
    triggered_d1 <= triggered_s;

  end if;
end process det_trig_p;

----------------------------------------------------------------------------
-- Function:  Latch the configuration when triggered and select for each run.
----------------------------------------------------------------------------
selectcfg_p : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    b_start_1_s <= (others => '0');
    b_start_2_s <= (others => '0');
    b_stop_1_s  <= (others => '0');
    b_stop_2_s  <= (others => '0');
    h_1_s       <= (others => '0');
    h_2_s       <= (others => '0');
    a_1_s       <= (others => (others => '0'));
    a_2_s       <= (others => (others => '0'));
    p_en_1_s    <= (others => (others => '0'));
    p_en_2_s    <= (others => (others => '0'));
    b_stop_s    <= (others => '0');
    h_s         <= (others => '0');
    a_s         <= (others => (others => '0'));
    p_en_s      <= (others => (others => '0'));
    fop_row_1_s <= (others => '0');
    fop_row_2_s <= (others => '0');
    fop_row_s   <= (others => '0');

  elsif rising_edge(clk_sys) then

    if triggered_s = '1' then
      b_start_1_s <= b_start_1;
      b_start_2_s <= b_start_2;
      b_stop_1_s  <= b_stop_1;
      b_stop_2_s  <= b_stop_2;
      h_1_s       <= h_1;
      h_2_s       <= h_2;
      a_1_s       <= a_1;
      a_2_s       <= a_2;
      p_en_1_s    <= p_en_1;
      p_en_2_s    <= p_en_2;
      fop_row_1_s <= fop_row_1;
      fop_row_2_s <= fop_row_2;
    end if;

    if run_num_s = '0' then
      b_stop_s  <= unsigned(b_stop_1_s);
      h_s       <= h_1_s;
      a_s       <= a_1_s;
      p_en_s    <= p_en_1_s;
      fop_row_s <= fop_row_1_s;
    else
      b_stop_s  <= unsigned(b_stop_2_s);
      h_s       <= h_2_s;
      a_s       <= a_2_s;
      p_en_s    <= p_en_2_s;
      fop_row_s <= fop_row_2_s;
    end if;
  end if;
end process selectcfg_p;

----------------------------------------------------------------------------
-- Function:  Latch the done signals from SUMMER sub-blocks.
--            There is a delay between SUMMER done and when the results are
--            finally stored safely in TREP. A hold-off timer is started
--            when done_sum is raised that counts down to zero.
----------------------------------------------------------------------------
latch_p : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    done_sum_latch_s   <= (others => '0');
    done_sum_holdoff_s <= (others => '0');
    all_sum_done_s     <= '0';

  elsif rising_edge(clk_sys) then

    -- Defaults for single cycle active signals.
    all_sum_done_s <= '0';

    -- Latch done signals.
    for i in done_sum'range loop
      if done_sum(i) = '1' then
        done_sum_latch_s(i) <= '1';
      end if;
    end loop;

    -- Hold off SUMMER done due to delay in processing results.
    if done_sum /= (done_sum'range => '0') then
      -- Start count.
      if t_filter_en = '0' then
        done_sum_holdoff_s <= to_unsigned(filter_off_delay_c, 5);
      else
        done_sum_holdoff_s <= to_unsigned(filter_on_delay_c, 5);
      end if;
    elsif done_sum_holdoff_s /= 0 then
      -- Decrement count.
      done_sum_holdoff_s <= done_sum_holdoff_s - 1;
    end if;

    -- Determine when all SUMMERs are done.
    if done_sum_latch_s = (done_sum'range => '1') then
      -- Add additional delay if this is the last column to allow for results
      -- to propagate through TREP.
      if last_col_processed_s = '0' or done_sum_holdoff_s = 0 then
        all_sum_done_s <= '1';
        done_sum_latch_s  <= (others => '0');
      end if;
    end if;

    -- Clear on trigger just to be sure we start cleanly.
    if triggered_d1 = '1' then
      done_sum_latch_s  <= (others => '0');
    end if;
  end if;
end process latch_p;

----------------------------------------------------------------------------
-- Function:  Update the seed column numbers.
----------------------------------------------------------------------------
update_seed_p : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    seed_col_read_s      <= (others => '0');
    seed_col_sum_s       <= (others => '0');
    last_col_requested_s <= '0';
    last_col_processed_s <= '0';
    t_set                <= '0';

  elsif rising_edge(clk_sys) then
    if running_s = '0' then
      -- Load start value.
      if run_num_s = '0' then
        seed_col_read_s <= unsigned(b_start_1_s);
        seed_col_sum_s  <= unsigned(b_start_1_s);
      else
        seed_col_read_s <= unsigned(b_start_2_s);
        seed_col_sum_s  <= unsigned(b_start_2_s);
      end if;
      -- Clear flags.
      last_col_requested_s <= '0';
      last_col_processed_s <= '0';
    end if;

    -- Increment DDRIN seed column when DDR requests are complete.
    if done_req = '1' then
      seed_col_read_s <= seed_col_read_s + 1;
    end if;

    -- Increment SUMMER seed column when summations are complete.
    if all_sum_done_s = '1' then
      seed_col_sum_s <= seed_col_sum_s + 1;
    end if;

    -- Set a flag when last column data is being fetched by DDRIN.
    if new_col_s = '1' and seed_col_read_s >= b_stop_s then
      last_col_requested_s <= '1';
    end if;

    -- Set a flag when last column data is being processed by SUMMER.
    if new_sum_s = '1' and seed_col_sum_s >= b_stop_s then
      last_col_processed_s <= '1';
    end if;

    -- Set the threshold set to use.
    if seed_col_sum_s >= unsigned(thresh_set) then
      t_set <= '1';
    else
      t_set <= '0';
    end if;
  end if;
end process update_seed_p;

----------------------------------------------------------------------------
-- Function:  Control requesting of new data by DDRIN.
--            A count of pages requested is maintained, incremented when a
--            DDRIN is triggered and decremented when SUMMER completes.
--            There are 4 pages of RAM for the data in DDRIN, so upto 4
--            requests can be made before we need to wait for the SUMMER to
--            have freed up a page.
----------------------------------------------------------------------------
ddrin_trigger : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    new_col_s         <= '0';
    request_count_s   <= (others => '0');
    req_in_progress_s <= '0';

  elsif rising_edge(clk_sys) then

    -- Defaults for single cycle active signals.
    new_col_s <= '0';

    if running_s = '0' then
      -- Only make requests when control FSM is active.
      req_in_progress_s <= '0';
    else
      -- Check whether a new request can be made.
      if req_in_progress_s = '0' and request_count_s < 4 and last_col_requested_s = '0' then
        new_col_s         <= '1';
        req_in_progress_s <= '1';
      end if;
    end if;

    -- Update request counter.
    if running_s = '0' then
      request_count_s <= (others => '0');
    elsif new_col_s = '1' and all_sum_done_s = '0' then
      request_count_s <= request_count_s + 1;
    elsif new_col_s = '0' and all_sum_done_s = '1' then
      request_count_s <= request_count_s - 1;
    end if;

    -- Clear in progress flag, when requests have completed.
    if done_req = '1' then
      req_in_progress_s <= '0';
    end if;

  end if; -- rst_sys_n = '0'
end process ddrin_trigger;

----------------------------------------------------------------------------
-- Function:  A count of filled pages of data is maintained that is incremented
--            when DDRIN completes reading and decremented when SUMMER completes.
--            If the number of full pages is greater than one, then a new
--            summation can begin.
--            The RAM page to read from in DDRIN is incremented here.
----------------------------------------------------------------------------
page_count : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    full_page_count_s <= (others => '0');
    ddrin_rd_page_s   <= "00";

  elsif rising_edge(clk_sys) then

    -- Update count of full pages.
    if running_s = '0' then
      full_page_count_s <= (others => '0');
    elsif done_read = '1' and all_sum_done_s = '0' then
      full_page_count_s <= full_page_count_s + 1;
    elsif done_read = '0' and all_sum_done_s = '1' then
      full_page_count_s <= full_page_count_s - 1;
    end if;

    -- Update read page.
    if triggered_s = '1' then
      ddrin_rd_page_s <= "00";
    elsif all_sum_done_s = '1' then
      ddrin_rd_page_s <= ddrin_rd_page_s + 1;
    end if;
  end if;
end process page_count;

----------------------------------------------------------------------------
-- Function:  Timing generator controller FSM.
----------------------------------------------------------------------------
control_fsm_p : process(rst_sys_n, clk_sys)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    state_s       <= idle;
    run_num_s     <= '0';
    new_sum_s     <= '0';
    hsum_done     <= '0';
    save_results  <= '0';
    clear_results <= '0';
    running_s     <= '0';

  elsif rising_edge(clk_sys) then

    -- Defaults for single cycle outputs/signals.
    new_sum_s     <= '0';
    hsum_done     <= '0';
    save_results  <= '0';
    clear_results <= '0';

    case state_s is
      when idle =>
        -- Set starting conditions.
        run_num_s <= '0';
        running_s <= '0';
        -- Wait for trigger.
        if triggered_d1 = '1' then
          state_s       <= init;
        end if;

      when init =>
        -- Allow seed column counters to load before proceeding.
        running_s     <= '1';
        clear_results <= '1';        -- Clear results in TREP.
        state_s       <= wait_for_data;

      when wait_for_data =>
        -- Wait for at least one page of FOP data to be read in.
        if full_page_count_s > 0 then
          new_sum_s <= '1';
          state_s   <= wait_sum_done;
        end if;

      when wait_sum_done =>
        -- Wait for SUMMER to finish.
        if all_sum_done_s = '1' then
          if last_col_processed_s = '1' then
            state_s      <= run_complete;
            save_results <= '1';
          elsif hsum_enable = '0' then
            save_results <= '1';
            state_s      <= save_data;
          else
            state_s <= wait_for_data;
          end if;
        end if;

      when save_data =>
        -- Wait for the transfer of results to RAM to complete.
        if save_done = '1' then
          state_s <= paused;
        end if;

      when paused =>
        -- Wait for enable to go high.
        if hsum_enable = '1' then
          state_s <= wait_for_data;
        end if;

      when run_complete =>
        running_s <= '0';
        -- Wait for results to be saved.
        if save_done = '1' then
          if a_set = '0' or run_num_s = '1' then
            -- All runs complete.
            hsum_done <= '1';
            state_s   <= idle;
          else
            -- Start second analysis run.
            run_num_s <= '1';
            state_s   <= begin_run2;
          end if;
        end if;

      when begin_run2 =>
        -- Wait for b_start/stop selection to update before starting again.
        state_s <= init;

    end case;

  end if;
end process control_fsm_p;

-- Connect outputs.
con1 : seed_col_read <= std_logic_vector(seed_col_read_s);
con2 : analysis_run  <= run_num_s;
con3 : h             <= h_s;
con4 : a             <= a_s;
con5 : p_en          <= p_en_s;
con6 : fop_row       <= fop_row_s;
con7 : triggered     <= triggered_s;
con8 : new_col       <= new_col_s;
con9 : new_sum       <= new_sum_s;
con10: ddrin_rd_page <= std_logic_vector(ddrin_rd_page_s);
con11: seed_col_sum  <= std_logic_vector(seed_col_sum_s);

end architecture synth;

