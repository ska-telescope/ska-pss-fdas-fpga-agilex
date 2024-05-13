----------------------------------------------------------------------------
-- Module Name: hsummci
--
-- Source Path: hsum_lib/hdl/hsummci_synth.vhd 
--
-- Functional Description:
--
-- CMG generated Microcontroller Interface sub-module.
--
-- CRC-16: 0x42F9
--
----------------------------------------------------------------------------
-- Date: 23/05/2019 10:40:59
----------------------------------------------------------------------------  
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2019 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

architecture synth of hsummci is

    -- Constant Declarations
    constant hsel_addr_space_c : integer := summer_g*16384;
    constant tsel_addr_space_c : integer := summer_g*1024;

    -- Internal Interface Signals
    signal mcaddr_rt_s : std_logic_vector(17 downto 0);
    signal mcdatain_rt_s : std_logic_vector(31 downto 0);
    signal mcdataout_rd_s : std_logic_vector(31 downto 0);
    signal mcrwn_rt_s : std_logic;
    signal mcms_rt_s : std_logic;

    -- Storage Registers
    signal b_start_1_reg_s : std_logic_vector(21 downto 0);
    signal b_stop_1_reg_s : std_logic_vector(21 downto 0);
    signal b_start_2_reg_s : std_logic_vector(21 downto 0);
    signal b_stop_2_reg_s : std_logic_vector(21 downto 0);
    signal h_1_reg_s : std_logic_vector(3 downto 0);
    signal h_2_reg_s : std_logic_vector(3 downto 0);
    signal fop_row_1_reg_s : std_logic_vector(6 downto 0);
    signal fop_row_2_reg_s : std_logic_vector(6 downto 0);
    signal fop_col_offset_reg_s : std_logic_vector(8 downto 0);
    signal a_set_reg_s : std_logic;
    signal thresh_set_reg_s : std_logic_vector(21 downto 0);
    signal m_reg_s : std_logic_vector(31 downto 0);
    signal t_filter_en_reg_s : std_logic;
    signal p_en_1_reg_s : vector_5_array_t(0 to summer_g-1);
    signal p_en_2_reg_s : vector_5_array_t(0 to summer_g-1);
    signal a_1_reg_s : vector_4_array_t(0 to summer_g-1);
    signal a_2_reg_s : vector_4_array_t(0 to summer_g-1);
    signal dm_cnt_reset_reg_s : std_logic;

    -- Decoded Write Enables
    signal wren0d000_s : std_logic;
    signal wren0d001_s : std_logic;
    signal wren0d002_s : std_logic;
    signal wren0d003_s : std_logic;
    signal wren0d004_s : std_logic;
    signal wren0d005_s : std_logic;
    signal wren0d006_s : std_logic;
    signal wren0d008_s : std_logic;
    signal wren0d009_s : std_logic;
    signal wren0d00a_s : std_logic;
    signal wren0d00c_s : std_logic;
    signal wren0d010_s : std_logic_vector(summer_g*2-1 downto 0);
    signal wren0d021_s : std_logic;

begin

    -- Ram Output Assignments
    assign_hsel_addr : hsel.ADDR <= mcaddr_rt_s(15 downto 0);
    assign_hsel_data : hsel.WR <= mcdatain_rt_s(6 downto 0);
    assign_tsel_addr : tsel.ADDR <= mcaddr_rt_s(11 downto 0);
    assign_tsel_data : tsel.WR <= mcdatain_rt_s(31 downto 0);
    assign_results_addr : results.ADDR <= mcaddr_rt_s(15 downto 0);
    assign_exc_addr : exc.ADDR <= mcaddr_rt_s(10 downto 0);

    -- Storage Output Assignments
    assign_b_start_1 : b_start_1 <= b_start_1_reg_s;
    assign_b_stop_1 : b_stop_1 <= b_stop_1_reg_s;
    assign_b_start_2 : b_start_2 <= b_start_2_reg_s;
    assign_b_stop_2 : b_stop_2 <= b_stop_2_reg_s;
    assign_h_1 : h_1 <= h_1_reg_s;
    assign_h_2 : h_2 <= h_2_reg_s;
    assign_fop_row_1 : fop_row_1 <= fop_row_1_reg_s;
    assign_fop_row_2 : fop_row_2 <= fop_row_2_reg_s;
    assign_fop_col_offset : fop_col_offset <= fop_col_offset_reg_s;
    assign_a_set : a_set <= a_set_reg_s;
    assign_thresh_set : thresh_set <= thresh_set_reg_s;
    assign_m : m <= m_reg_s;
    assign_t_filter_en : t_filter_en <= t_filter_en_reg_s;
    assign_p_en_1 : p_en_1 <= p_en_1_reg_s;
    assign_p_en_2 : p_en_2 <= p_en_2_reg_s;
    assign_a_1 : a_1 <= a_1_reg_s;
    assign_a_2 : a_2 <= a_2_reg_s;
    assign_dm_cnt_reset : dm_cnt_reset <= dm_cnt_reset_reg_s;

    -- Micro Interface Retimes
    retime : process (clk, rst_n)
    begin

        if rst_n = '0' then

            mcaddr_rt_s <= (others => '0');
            mcdatain_rt_s <= (others => '0');
            mcrwn_rt_s <= '0';
            mcms_rt_s <= '0';
            mcdataout <= (others => '0');

        elsif rising_edge(clk) then

            mcaddr_rt_s <= mcaddr;
            mcdatain_rt_s <= mcdatain;
            mcrwn_rt_s <= mcrwn;
            mcms_rt_s <= mcms;

            mcdataout <= mcdataout_rd_s;

        end if;
    end process retime;

    -- Micro Read and Address Decode
    decode : process (hsel_rd, tsel_rd, b_start_1_reg_s, b_stop_1_reg_s, 
            b_start_2_reg_s, b_stop_2_reg_s, h_1_reg_s, h_2_reg_s, fop_row_1_reg_s, 
            fop_row_2_reg_s, fop_col_offset_reg_s, a_set_reg_s, thresh_set_reg_s, 
            m_reg_s, t_filter_en_reg_s, p_en_1_reg_s, p_en_2_reg_s, a_1_reg_s, 
            a_2_reg_s, dm_cnt, dm_cnt_reset_reg_s, results_rd, exc_rd, mcaddr_rt_s, 
            mcdatain_rt_s, mcrwn_rt_s, mcms_rt_s)

        variable addr_v, offset_v : integer range 0 to 262143;

    begin

        wren0d000_s <= '0';
        wren0d001_s <= '0';
        wren0d002_s <= '0';
        wren0d003_s <= '0';
        wren0d004_s <= '0';
        wren0d005_s <= '0';
        wren0d006_s <= '0';
        wren0d008_s <= '0';
        wren0d009_s <= '0';
        wren0d00a_s <= '0';
        wren0d00c_s <= '0';
        wren0d010_s <= (others => '0');
        wren0d021_s <= '0';

        hsel.RDEN <= '0';
        hsel.WREN <= '0';
        tsel.RDEN <= '0';
        tsel.WREN <= '0';
        results.RDEN <= '0';
        exc.RDEN <= '0';
        mcdataout_rd_s <= (others => '0');

        if mcms_rt_s = '1' then
            addr_v := to_integer(unsigned(mcaddr_rt_s));

            case addr_v is
                when 16#00000# to 16#00000#+hsel_addr_space_c-1 =>
                    offset_v := addr_v - 16#00000#;
                    hsel.RDEN <= mcrwn_rt_s;
                    hsel.WREN <= not mcrwn_rt_s;
                    mcdataout_rd_s(6 downto 0) <= hsel_rd;
                when 16#0C000# to 16#0C000#+tsel_addr_space_c-1 =>
                    offset_v := addr_v - 16#0C000#;
                    tsel.RDEN <= mcrwn_rt_s;
                    tsel.WREN <= not mcrwn_rt_s;
                    mcdataout_rd_s(31 downto 0) <= tsel_rd;
                when 16#0D000# =>
                    wren0d000_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(21 downto 0) <= b_start_1_reg_s;
                when 16#0D001# =>
                    wren0d001_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(21 downto 0) <= b_stop_1_reg_s;
                when 16#0D002# =>
                    wren0d002_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(21 downto 0) <= b_start_2_reg_s;
                when 16#0D003# =>
                    wren0d003_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(21 downto 0) <= b_stop_2_reg_s;
                when 16#0D004# =>
                    wren0d004_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(3 downto 0) <= h_1_reg_s;
                    mcdataout_rd_s(11 downto 8) <= h_2_reg_s;
                when 16#0D005# =>
                    wren0d005_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(6 downto 0) <= fop_row_1_reg_s;
                    mcdataout_rd_s(14 downto 8) <= fop_row_2_reg_s;
                when 16#0D006# =>
                    wren0d006_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(8 downto 0) <= fop_col_offset_reg_s;
                when 16#0D008# =>
                    wren0d008_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= a_set_reg_s;
                when 16#0D009# =>
                    wren0d009_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(21 downto 0) <= thresh_set_reg_s;
                when 16#0D00A# =>
                    wren0d00a_s <= not mcrwn_rt_s;
                    mcdataout_rd_s <= m_reg_s;
                when 16#0D00C# =>
                    wren0d00c_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= t_filter_en_reg_s;
                when 16#0D010# to 16#0D010#+summer_g*2-1 =>
                    offset_v := addr_v - 16#0D010#;
                    wren0d010_s(offset_v) <= not mcrwn_rt_s;
                    for a in 0 to summer_g-1 loop
                        if offset_v = a*2 then
                            mcdataout_rd_s(4 downto 0) <= p_en_1_reg_s(a);
                            mcdataout_rd_s(12 downto 8) <= p_en_2_reg_s(a);
                        end if;
                        if offset_v = a*2+1 then
                            mcdataout_rd_s(3 downto 0) <= a_1_reg_s(a);
                            mcdataout_rd_s(11 downto 8) <= a_2_reg_s(a);
                        end if;
                    end loop;
                when 16#0D020# =>
                    mcdataout_rd_s <= dm_cnt;
                when 16#0D021# =>
                    wren0d021_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= dm_cnt_reset_reg_s;
                when 16#10000# to 16#1FFFF# =>
                    offset_v := addr_v - 16#10000#;
                    results.RDEN <= mcrwn_rt_s;
                    mcdataout_rd_s(31 downto 0) <= results_rd;
                when 16#20000# to 16#207FF# =>
                    offset_v := addr_v - 16#20000#;
                    exc.RDEN <= mcrwn_rt_s;
                    mcdataout_rd_s(31 downto 0) <= exc_rd;
                when others =>
                    null;
            end case;
        end if;

    end process decode;

    -- Micro Store
    store : process (clk, rst_n)
    begin

        if rst_n = '0' then

            b_start_1_reg_s <= (others => '0');
            b_stop_1_reg_s <= (others => '0');
            b_start_2_reg_s <= (others => '0');
            b_stop_2_reg_s <= (others => '0');
            h_1_reg_s <= (others => '0');
            h_2_reg_s <= (others => '0');
            fop_row_1_reg_s <= (others => '0');
            fop_row_2_reg_s <= (others => '0');
            fop_col_offset_reg_s <= (others => '0');
            a_set_reg_s <= '0';
            thresh_set_reg_s <= (others => '0');
            m_reg_s <= (others => '0');
            t_filter_en_reg_s <= '0';
            p_en_1_reg_s <= (others => (others => '0'));
            p_en_2_reg_s <= (others => (others => '0'));
            a_1_reg_s <= (others => (others => '0'));
            a_2_reg_s <= (others => (others => '0'));
            dm_cnt_reset_reg_s <= '0';

        elsif rising_edge(clk) then

            if mcms_rt_s = '1' then
                -- 16#0D000#:
                if wren0d000_s = '1' then
                    b_start_1_reg_s <= mcdatain_rt_s(21 downto 0);
                end if;
                -- 16#0D001#:
                if wren0d001_s = '1' then
                    b_stop_1_reg_s <= mcdatain_rt_s(21 downto 0);
                end if;
                -- 16#0D002#:
                if wren0d002_s = '1' then
                    b_start_2_reg_s <= mcdatain_rt_s(21 downto 0);
                end if;
                -- 16#0D003#:
                if wren0d003_s = '1' then
                    b_stop_2_reg_s <= mcdatain_rt_s(21 downto 0);
                end if;
                -- 16#0D004#:
                if wren0d004_s = '1' then
                    h_1_reg_s <= mcdatain_rt_s(3 downto 0);
                    h_2_reg_s <= mcdatain_rt_s(11 downto 8);
                end if;
                -- 16#0D005#:
                if wren0d005_s = '1' then
                    fop_row_1_reg_s <= mcdatain_rt_s(6 downto 0);
                    fop_row_2_reg_s <= mcdatain_rt_s(14 downto 8);
                end if;
                -- 16#0D006#:
                if wren0d006_s = '1' then
                    fop_col_offset_reg_s <= mcdatain_rt_s(8 downto 0);
                end if;
                -- 16#0D008#:
                if wren0d008_s = '1' then
                    a_set_reg_s <= mcdatain_rt_s(0);
                end if;
                -- 16#0D009#:
                if wren0d009_s = '1' then
                    thresh_set_reg_s <= mcdatain_rt_s(21 downto 0);
                end if;
                -- 16#0D00A#:
                if wren0d00a_s = '1' then
                    m_reg_s <= mcdatain_rt_s;
                end if;
                -- 16#0D00C#:
                if wren0d00c_s = '1' then
                    t_filter_en_reg_s <= mcdatain_rt_s(0);
                end if;
                -- 16#0D010# to 16#0D010#+summer_g*2-1:
                for a in 0 to summer_g-1 loop
                    if wren0d010_s(a*2) = '1' then
                        p_en_1_reg_s(a) <= mcdatain_rt_s(4 downto 0);
                        p_en_2_reg_s(a) <= mcdatain_rt_s(12 downto 8);
                    end if;
                    if wren0d010_s(a*2+1) = '1' then
                        a_1_reg_s(a) <= mcdatain_rt_s(3 downto 0);
                        a_2_reg_s(a) <= mcdatain_rt_s(11 downto 8);
                    end if;
                end loop;
                -- 16#0D021#:
                if wren0d021_s = '1' then
                    dm_cnt_reset_reg_s <= mcdatain_rt_s(0);
                end if;
            end if;

        end if;
    end process store;

end synth;
