--------------------------------------------------------------------------------
-- Architecture: synth
--------------------------------------------------------------------------------
-- Module: CTRL
-- Date:   12/06/2023 13:26:34
-- File:   ctrlmci_synth.vhd
-- CRC-16: 0x157F
--------------------------------------------------------------------------------

architecture synth of ctrlmci is

    -- Internal Interface Signals
    signal mcaddr_rt_s : std_logic_vector(18 downto 0);
    signal mcdatain_rt_s : std_logic_vector(31 downto 0);
    signal mcdataout_rd_s : std_logic_vector(31 downto 0);
    signal mcrwn_rt_s : std_logic;
    signal mcms_rt_s : std_logic;

    -- Storage Registers
    signal dm_trig_reg_s : std_logic;
    signal page_reg_s : std_logic;
    signal overlap_size_reg_s : std_logic_vector(9 downto 0);
    signal fop_sample_num_reg_s : std_logic_vector(22 downto 0);
    signal ifft_loop_num_reg_s : std_logic_vector(5 downto 0);
    signal man_override_reg_s : std_logic;
    signal man_cld_trig_reg_s : std_logic;
    signal man_conv_trig_reg_s : std_logic;
    signal man_hsum_trig_reg_s : std_logic;
    signal man_cld_en_reg_s : std_logic;
    signal man_conv_en_reg_s : std_logic;
    signal man_hsum_en_reg_s : std_logic;
    signal man_cld_pause_en_reg_s : std_logic;
    signal man_conv_pause_en_reg_s : std_logic;
    signal man_hsum_pause_en_reg_s : std_logic;
    signal man_cld_pause_rst_reg_s : std_logic;
    signal man_conv_pause_rst_reg_s : std_logic;
    signal man_hsum_pause_rst_reg_s : std_logic;
    signal man_cld_pause_cnt_reg_s : std_logic_vector(31 downto 0);
    signal man_conv_pause_cnt_reg_s : std_logic_vector(31 downto 0);
    signal man_hsum_pause_cnt_reg_s : std_logic_vector(31 downto 0);

    -- Decoded Write Enables
    signal wren00000_s : std_logic;
    signal wren00008_s : std_logic;
    signal wren00010_s : std_logic;
    signal wren00018_s : std_logic;
    signal wren0001a_s : std_logic;
    signal wren00020_s : std_logic;
    signal wren00028_s : std_logic;
    signal wren00030_s : std_logic;
    signal wren00038_s : std_logic;
    signal wren00040_s : std_logic;
    signal wren00048_s : std_logic;
    signal wren00049_s : std_logic;
    signal wren0004a_s : std_logic;

begin

    -- Storage Output Assignments
    assign_dm_trig : DM_TRIG <= dm_trig_reg_s;
    assign_page : PAGE <= page_reg_s;
    assign_overlap_size : OVERLAP_SIZE <= overlap_size_reg_s;
    assign_fop_sample_num : FOP_SAMPLE_NUM <= fop_sample_num_reg_s;
    assign_ifft_loop_num : IFFT_LOOP_NUM <= ifft_loop_num_reg_s;
    assign_man_override : MAN_OVERRIDE <= man_override_reg_s;
    assign_man_cld_trig : MAN_CLD_TRIG <= man_cld_trig_reg_s;
    assign_man_conv_trig : MAN_CONV_TRIG <= man_conv_trig_reg_s;
    assign_man_hsum_trig : MAN_HSUM_TRIG <= man_hsum_trig_reg_s;
    assign_man_cld_en : MAN_CLD_EN <= man_cld_en_reg_s;
    assign_man_conv_en : MAN_CONV_EN <= man_conv_en_reg_s;
    assign_man_hsum_en : MAN_HSUM_EN <= man_hsum_en_reg_s;
    assign_man_cld_pause_en : MAN_CLD_PAUSE_EN <= man_cld_pause_en_reg_s;
    assign_man_conv_pause_en : MAN_CONV_PAUSE_EN <= man_conv_pause_en_reg_s;
    assign_man_hsum_pause_en : MAN_HSUM_PAUSE_EN <= man_hsum_pause_en_reg_s;
    assign_man_cld_pause_rst : MAN_CLD_PAUSE_RST <= man_cld_pause_rst_reg_s;
    assign_man_conv_pause_rst : MAN_CONV_PAUSE_RST <= man_conv_pause_rst_reg_s;
    assign_man_hsum_pause_rst : MAN_HSUM_PAUSE_RST <= man_hsum_pause_rst_reg_s;
    assign_man_cld_pause_cnt : MAN_CLD_PAUSE_CNT <= man_cld_pause_cnt_reg_s;
    assign_man_conv_pause_cnt : MAN_CONV_PAUSE_CNT <= man_conv_pause_cnt_reg_s;
    assign_man_hsum_pause_cnt : MAN_HSUM_PAUSE_CNT <= man_hsum_pause_cnt_reg_s;

    -- Micro Interface Retimes
    retime : process (CLK_MC, RST_MC_N)
    begin

        if RST_MC_N = '0' then

            mcaddr_rt_s <= (others => '0');
            mcdatain_rt_s <= (others => '0');
            mcrwn_rt_s <= '0';
            mcms_rt_s <= '0';
            MCDATAOUT <= (others => '0');

        elsif rising_edge(CLK_MC) then

            mcaddr_rt_s <= MCADDR;
            mcdatain_rt_s <= MCDATAIN;
            mcrwn_rt_s <= MCRWN;
            mcms_rt_s <= MCMS;

            MCDATAOUT <= mcdataout_rd_s;

        end if;
    end process retime;

    -- Micro Read and Address Decode
    decode : process (dm_trig_reg_s, page_reg_s, overlap_size_reg_s, 
            fop_sample_num_reg_s, ifft_loop_num_reg_s, man_override_reg_s, 
            man_cld_trig_reg_s, man_conv_trig_reg_s, man_hsum_trig_reg_s, 
            man_cld_en_reg_s, man_conv_en_reg_s, man_hsum_en_reg_s, 
            man_cld_pause_en_reg_s, man_conv_pause_en_reg_s, 
            man_hsum_pause_en_reg_s, man_cld_pause_rst_reg_s, 
            man_conv_pause_rst_reg_s, man_hsum_pause_rst_reg_s, 
            man_cld_pause_cnt_reg_s, man_conv_pause_cnt_reg_s, 
            man_hsum_pause_cnt_reg_s, LATCHED_CLD_DONE, LATCHED_CONV_DONE, 
            LATCHED_HSUM_DONE, CLD_PAUSED, CONV_PAUSED, HSUM_PAUSED, 
            CONV_FFT_READY, CLD_PROC_TIME, CONV_PROC_TIME, HSUM_PROC_TIME, 
            CONV_REQ_CNT, HSUM_REQ_CNT, HSUM_REC_CNT, mcaddr_rt_s, mcdatain_rt_s, 
            mcrwn_rt_s, mcms_rt_s)

        variable addr_v, offset_v : integer range 0 to 524287;

    begin

        wren00000_s <= '0';
        wren00008_s <= '0';
        wren00010_s <= '0';
        wren00018_s <= '0';
        wren0001a_s <= '0';
        wren00020_s <= '0';
        wren00028_s <= '0';
        wren00030_s <= '0';
        wren00038_s <= '0';
        wren00040_s <= '0';
        wren00048_s <= '0';
        wren00049_s <= '0';
        wren0004a_s <= '0';

        mcdataout_rd_s <= (others => '0');

        if mcms_rt_s = '1' then
            addr_v := to_integer(unsigned(mcaddr_rt_s));

            case addr_v is
                when 16#00000# =>
                    wren00000_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= dm_trig_reg_s;
                when 16#00008# =>
                    wren00008_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= page_reg_s;
                when 16#00010# =>
                    wren00010_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(9 downto 0) <= overlap_size_reg_s;
                when 16#00018# =>
                    wren00018_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(22 downto 0) <= fop_sample_num_reg_s;
                when 16#0001A# =>
                    wren0001a_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(5 downto 0) <= ifft_loop_num_reg_s;
                when 16#00020# =>
                    wren00020_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= man_override_reg_s;
                when 16#00028# =>
                    wren00028_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= man_cld_trig_reg_s;
                    mcdataout_rd_s(1) <= man_conv_trig_reg_s;
                    mcdataout_rd_s(2) <= man_hsum_trig_reg_s;
                when 16#00030# =>
                    wren00030_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= man_cld_en_reg_s;
                    mcdataout_rd_s(1) <= man_conv_en_reg_s;
                    mcdataout_rd_s(2) <= man_hsum_en_reg_s;
                when 16#00038# =>
                    wren00038_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= man_cld_pause_en_reg_s;
                    mcdataout_rd_s(1) <= man_conv_pause_en_reg_s;
                    mcdataout_rd_s(2) <= man_hsum_pause_en_reg_s;
                when 16#00040# =>
                    wren00040_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= man_cld_pause_rst_reg_s;
                    mcdataout_rd_s(1) <= man_conv_pause_rst_reg_s;
                    mcdataout_rd_s(2) <= man_hsum_pause_rst_reg_s;
                when 16#00048# =>
                    wren00048_s <= not mcrwn_rt_s;
                    mcdataout_rd_s <= man_cld_pause_cnt_reg_s;
                when 16#00049# =>
                    wren00049_s <= not mcrwn_rt_s;
                    mcdataout_rd_s <= man_conv_pause_cnt_reg_s;
                when 16#0004A# =>
                    wren0004a_s <= not mcrwn_rt_s;
                    mcdataout_rd_s <= man_hsum_pause_cnt_reg_s;
                when 16#00050# =>
                    mcdataout_rd_s(0) <= LATCHED_CLD_DONE;
                    mcdataout_rd_s(1) <= LATCHED_CONV_DONE;
                    mcdataout_rd_s(2) <= LATCHED_HSUM_DONE;
                when 16#00058# =>
                    mcdataout_rd_s(0) <= CLD_PAUSED;
                    mcdataout_rd_s(1) <= CONV_PAUSED;
                    mcdataout_rd_s(2) <= HSUM_PAUSED;
                when 16#00060# =>
                    mcdataout_rd_s(0) <= CONV_FFT_READY;
                when 16#00062# =>
                    mcdataout_rd_s <= CLD_PROC_TIME;
                when 16#00063# =>
                    mcdataout_rd_s <= CONV_PROC_TIME;
                when 16#00064# =>
                    mcdataout_rd_s <= HSUM_PROC_TIME;
                when 16#00068# =>
                    mcdataout_rd_s <= CONV_REQ_CNT;
                when 16#00069# =>
                    mcdataout_rd_s <= HSUM_REQ_CNT;
                when 16#0006A# =>
                    mcdataout_rd_s <= HSUM_REC_CNT;
                when others =>
                    null;
            end case;
        end if;

    end process decode;

    -- Micro Store
    store : process (CLK_MC, RST_MC_N)
    begin

        if RST_MC_N = '0' then

            dm_trig_reg_s <= '0';
            page_reg_s <= '0';
            overlap_size_reg_s <= (others => '0');
            fop_sample_num_reg_s <= (others => '0');
            ifft_loop_num_reg_s <= (others => '0');
            man_override_reg_s <= '0';
            man_cld_trig_reg_s <= '0';
            man_conv_trig_reg_s <= '0';
            man_hsum_trig_reg_s <= '0';
            man_cld_en_reg_s <= '0';
            man_conv_en_reg_s <= '0';
            man_hsum_en_reg_s <= '0';
            man_cld_pause_en_reg_s <= '0';
            man_conv_pause_en_reg_s <= '0';
            man_hsum_pause_en_reg_s <= '0';
            man_cld_pause_rst_reg_s <= '0';
            man_conv_pause_rst_reg_s <= '0';
            man_hsum_pause_rst_reg_s <= '0';
            man_cld_pause_cnt_reg_s <= (others => '0');
            man_conv_pause_cnt_reg_s <= (others => '0');
            man_hsum_pause_cnt_reg_s <= (others => '0');

        elsif rising_edge(CLK_MC) then

            if mcms_rt_s = '1' then
                -- 16#00000#:
                if wren00000_s = '1' then
                    dm_trig_reg_s <= mcdatain_rt_s(0);
                end if;
                -- 16#00008#:
                if wren00008_s = '1' then
                    page_reg_s <= mcdatain_rt_s(0);
                end if;
                -- 16#00010#:
                if wren00010_s = '1' then
                    overlap_size_reg_s <= mcdatain_rt_s(9 downto 0);
                end if;
                -- 16#00018#:
                if wren00018_s = '1' then
                    fop_sample_num_reg_s <= mcdatain_rt_s(22 downto 0);
                end if;
                -- 16#0001A#:
                if wren0001a_s = '1' then
                    ifft_loop_num_reg_s <= mcdatain_rt_s(5 downto 0);
                end if;
                -- 16#00020#:
                if wren00020_s = '1' then
                    man_override_reg_s <= mcdatain_rt_s(0);
                end if;
                -- 16#00028#:
                if wren00028_s = '1' then
                    man_cld_trig_reg_s <= mcdatain_rt_s(0);
                    man_conv_trig_reg_s <= mcdatain_rt_s(1);
                    man_hsum_trig_reg_s <= mcdatain_rt_s(2);
                end if;
                -- 16#00030#:
                if wren00030_s = '1' then
                    man_cld_en_reg_s <= mcdatain_rt_s(0);
                    man_conv_en_reg_s <= mcdatain_rt_s(1);
                    man_hsum_en_reg_s <= mcdatain_rt_s(2);
                end if;
                -- 16#00038#:
                if wren00038_s = '1' then
                    man_cld_pause_en_reg_s <= mcdatain_rt_s(0);
                    man_conv_pause_en_reg_s <= mcdatain_rt_s(1);
                    man_hsum_pause_en_reg_s <= mcdatain_rt_s(2);
                end if;
                -- 16#00040#:
                if wren00040_s = '1' then
                    man_cld_pause_rst_reg_s <= mcdatain_rt_s(0);
                    man_conv_pause_rst_reg_s <= mcdatain_rt_s(1);
                    man_hsum_pause_rst_reg_s <= mcdatain_rt_s(2);
                end if;
                -- 16#00048#:
                if wren00048_s = '1' then
                    man_cld_pause_cnt_reg_s <= mcdatain_rt_s;
                end if;
                -- 16#00049#:
                if wren00049_s = '1' then
                    man_conv_pause_cnt_reg_s <= mcdatain_rt_s;
                end if;
                -- 16#0004A#:
                if wren0004a_s = '1' then
                    man_hsum_pause_cnt_reg_s <= mcdatain_rt_s;
                end if;
            end if;

        end if;
    end process store;

end synth;
