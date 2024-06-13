--------------------------------------------------------------------------------
-- Architecture: synth
--------------------------------------------------------------------------------
-- Module: MSIX
-- Date:   21/04/2022 13:01:35
-- File:   msixmci_synth.vhd
-- CRC-16: 0x2701
--------------------------------------------------------------------------------

architecture synth of msixmci is

    -- Internal Interface Signals
    signal mcaddr_rt_s : std_logic_vector(3 downto 0);
    signal mcdatain_rt_s : std_logic_vector(31 downto 0);
    signal mcdataout_rd_s : std_logic_vector(31 downto 0);
    signal mcrwn_rt_s : std_logic;
    signal mcms_rt_s : std_logic;

    -- Storage Registers
    signal cld_msix_data_reg_s : std_logic_vector(15 downto 0);
    signal cld_msix_en_reg_s : std_logic;
    signal conv_msix_data_reg_s : std_logic_vector(15 downto 0);
    signal conv_msix_en_reg_s : std_logic;
    signal hsum_msix_data_reg_s : std_logic_vector(15 downto 0);
    signal hsum_msix_en_reg_s : std_logic;

    -- Decoded Write Enables
    signal wren0_s : std_logic;
    signal wren4_s : std_logic;
    signal wren8_s : std_logic;

begin

    -- Storage Output Assignments
    assign_cld_msix_data : CLD_MSIX_DATA <= cld_msix_data_reg_s;
    assign_cld_msix_en : CLD_MSIX_EN <= cld_msix_en_reg_s;
    assign_conv_msix_data : CONV_MSIX_DATA <= conv_msix_data_reg_s;
    assign_conv_msix_en : CONV_MSIX_EN <= conv_msix_en_reg_s;
    assign_hsum_msix_data : HSUM_MSIX_DATA <= hsum_msix_data_reg_s;
    assign_hsum_msix_en : HSUM_MSIX_EN <= hsum_msix_en_reg_s;

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
    decode : process (cld_msix_data_reg_s, cld_msix_en_reg_s, conv_msix_data_reg_s, 
            conv_msix_en_reg_s, hsum_msix_data_reg_s, hsum_msix_en_reg_s, 
            mcaddr_rt_s, mcdatain_rt_s, mcrwn_rt_s, mcms_rt_s)

        variable addr_v, offset_v : integer range 0 to 15;

    begin

        wren0_s <= '0';
        wren4_s <= '0';
        wren8_s <= '0';

        mcdataout_rd_s <= (others => '0');

        if mcms_rt_s = '1' then
            addr_v := to_integer(unsigned(mcaddr_rt_s));

            case addr_v is
                when 16#0# =>
                    wren0_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(15 downto 0) <= cld_msix_data_reg_s;
                    mcdataout_rd_s(16) <= cld_msix_en_reg_s;
                when 16#4# =>
                    wren4_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(15 downto 0) <= conv_msix_data_reg_s;
                    mcdataout_rd_s(16) <= conv_msix_en_reg_s;
                when 16#8# =>
                    wren8_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(15 downto 0) <= hsum_msix_data_reg_s;
                    mcdataout_rd_s(16) <= hsum_msix_en_reg_s;
                when others =>
                    null;
            end case;
        end if;

    end process decode;

    -- Micro Store
    store : process (CLK_MC, RST_MC_N)
    begin

        if RST_MC_N = '0' then

            cld_msix_data_reg_s <= (others => '0');
            cld_msix_en_reg_s <= '0';
            conv_msix_data_reg_s <= (others => '0');
            conv_msix_en_reg_s <= '0';
            hsum_msix_data_reg_s <= (others => '0');
            hsum_msix_en_reg_s <= '0';

        elsif rising_edge(CLK_MC) then

            if mcms_rt_s = '1' then
                -- 16#0#:
                if wren0_s = '1' then
                    cld_msix_data_reg_s <= mcdatain_rt_s(15 downto 0);
                    cld_msix_en_reg_s <= mcdatain_rt_s(16);
                end if;
                -- 16#4#:
                if wren4_s = '1' then
                    conv_msix_data_reg_s <= mcdatain_rt_s(15 downto 0);
                    conv_msix_en_reg_s <= mcdatain_rt_s(16);
                end if;
                -- 16#8#:
                if wren8_s = '1' then
                    hsum_msix_data_reg_s <= mcdatain_rt_s(15 downto 0);
                    hsum_msix_en_reg_s <= mcdatain_rt_s(16);
                end if;
            end if;

        end if;
    end process store;

end synth;
