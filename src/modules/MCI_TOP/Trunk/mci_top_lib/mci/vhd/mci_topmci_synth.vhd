--------------------------------------------------------------------------------
-- Architecture: synth
--------------------------------------------------------------------------------
-- Module: MCI_TOP
-- Date:   12/04/2023 12:52:10
-- File:   mci_topmci_synth.vhd
-- CRC-16: 0x5161
--------------------------------------------------------------------------------

architecture synth of mci_topmci is

    -- Internal Interface Signals
    signal mcaddr_rt_s : std_logic_vector(19 downto 0);
    signal mcdatain_rt_s : std_logic_vector(31 downto 0);
    signal mcdataout_rd_s : std_logic_vector(31 downto 0);
    signal mcrwn_rt_s : std_logic;
    signal mcms_rt_s : std_logic;

    -- Storage Registers
    signal ctrl_reset_reg_s : std_logic;
    signal cld_reset_reg_s : std_logic;
    signal conv_reset_reg_s : std_logic;
    signal hsum_reset_reg_s : std_logic;
    signal ddrif_0_reset_reg_s : std_logic;
    signal ddrif_1_reset_reg_s : std_logic;
    signal ddrif_2_reset_reg_s : std_logic;
    signal ddrif_3_reset_reg_s : std_logic;
    signal ddrif_pcie_reset_reg_s : std_logic;
    signal ddr_0_reset_reg_s : std_logic;
    signal ddr_1_reset_reg_s : std_logic;
    signal ddr_2_reset_reg_s : std_logic;
    signal ddr_3_reset_reg_s : std_logic;
    signal msix_reset_reg_s : std_logic;

    -- Decoded Write Enables
    signal wren00010_s : std_logic;

begin

    -- Storage Output Assignments
    assign_ctrl_reset : CTRL_RESET <= ctrl_reset_reg_s;
    assign_cld_reset : CLD_RESET <= cld_reset_reg_s;
    assign_conv_reset : CONV_RESET <= conv_reset_reg_s;
    assign_hsum_reset : HSUM_RESET <= hsum_reset_reg_s;
    assign_ddrif_0_reset : DDRIF_0_RESET <= ddrif_0_reset_reg_s;
    assign_ddrif_1_reset : DDRIF_1_RESET <= ddrif_1_reset_reg_s;
    assign_ddrif_2_reset : DDRIF_2_RESET <= ddrif_2_reset_reg_s;
    assign_ddrif_3_reset : DDRIF_3_RESET <= ddrif_3_reset_reg_s;
    assign_ddrif_pcie_reset : DDRIF_PCIE_RESET <= ddrif_pcie_reset_reg_s;
    assign_ddr_0_reset : DDR_0_RESET <= ddr_0_reset_reg_s;
    assign_ddr_1_reset : DDR_1_RESET <= ddr_1_reset_reg_s;
    assign_ddr_2_reset : DDR_2_RESET <= ddr_2_reset_reg_s;
    assign_ddr_3_reset : DDR_3_RESET <= ddr_3_reset_reg_s;
    assign_msix_reset : MSIX_RESET <= msix_reset_reg_s;

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
    decode : process (PRODUCT_ID, CORE_VERSION, CORE_REVISION, TOP_VERSION, 
            TOP_REVISION, ctrl_reset_reg_s, cld_reset_reg_s, conv_reset_reg_s, 
            hsum_reset_reg_s, ddrif_0_reset_reg_s, ddrif_1_reset_reg_s, 
            ddrif_2_reset_reg_s, ddrif_3_reset_reg_s, ddrif_pcie_reset_reg_s, 
            ddr_0_reset_reg_s, ddr_1_reset_reg_s, ddr_2_reset_reg_s, 
            ddr_3_reset_reg_s, msix_reset_reg_s, DDR_0_CAL_FAIL, DDR_0_CAL_PASS, 
            DDR_1_CAL_FAIL, DDR_1_CAL_PASS, DDR_2_CAL_FAIL, DDR_2_CAL_PASS, 
            DDR_3_CAL_FAIL, DDR_3_CAL_PASS, DDR_0_RESET_DONE, DDR_1_RESET_DONE, 
            DDR_2_RESET_DONE, DDR_3_RESET_DONE, mcaddr_rt_s, mcdatain_rt_s, 
            mcrwn_rt_s, mcms_rt_s)

        variable addr_v, offset_v : integer range 0 to 1048575;

    begin

        wren00010_s <= '0';

        mcdataout_rd_s <= (others => '0');

        if mcms_rt_s = '1' then
            addr_v := to_integer(unsigned(mcaddr_rt_s));

            case addr_v is
                when 16#00000# =>
                    mcdataout_rd_s(15 downto 0) <= PRODUCT_ID;
                when 16#00001# =>
                    mcdataout_rd_s(15 downto 0) <= CORE_VERSION;
                when 16#00002# =>
                    mcdataout_rd_s(15 downto 0) <= CORE_REVISION;
                when 16#00003# =>
                    mcdataout_rd_s(15 downto 0) <= TOP_VERSION;
                when 16#00004# =>
                    mcdataout_rd_s(15 downto 0) <= TOP_REVISION;
                when 16#00010# =>
                    wren00010_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(0) <= ctrl_reset_reg_s;
                    mcdataout_rd_s(1) <= cld_reset_reg_s;
                    mcdataout_rd_s(2) <= conv_reset_reg_s;
                    mcdataout_rd_s(3) <= hsum_reset_reg_s;
                    mcdataout_rd_s(4) <= ddrif_0_reset_reg_s;
                    mcdataout_rd_s(5) <= ddrif_1_reset_reg_s;
                    mcdataout_rd_s(6) <= ddrif_2_reset_reg_s;
                    mcdataout_rd_s(7) <= ddrif_3_reset_reg_s;
                    mcdataout_rd_s(8) <= ddrif_pcie_reset_reg_s;
                    mcdataout_rd_s(9) <= ddr_0_reset_reg_s;
                    mcdataout_rd_s(10) <= ddr_1_reset_reg_s;
                    mcdataout_rd_s(11) <= ddr_2_reset_reg_s;
                    mcdataout_rd_s(12) <= ddr_3_reset_reg_s;
                    mcdataout_rd_s(13) <= msix_reset_reg_s;
                when 16#00011# =>
                    mcdataout_rd_s(0) <= DDR_0_CAL_FAIL;
                    mcdataout_rd_s(1) <= DDR_0_CAL_PASS;
                    mcdataout_rd_s(2) <= DDR_1_CAL_FAIL;
                    mcdataout_rd_s(3) <= DDR_1_CAL_PASS;
                    mcdataout_rd_s(4) <= DDR_2_CAL_FAIL;
                    mcdataout_rd_s(5) <= DDR_2_CAL_PASS;
                    mcdataout_rd_s(6) <= DDR_3_CAL_FAIL;
                    mcdataout_rd_s(7) <= DDR_3_CAL_PASS;
                    mcdataout_rd_s(8) <= DDR_0_RESET_DONE;
                    mcdataout_rd_s(9) <= DDR_1_RESET_DONE;
                    mcdataout_rd_s(10) <= DDR_2_RESET_DONE;
                    mcdataout_rd_s(11) <= DDR_3_RESET_DONE;
                when others =>
                    null;
            end case;
        end if;

    end process decode;

    -- Micro Store
    store : process (CLK_MC, RST_MC_N)
    begin

        if RST_MC_N = '0' then

            ctrl_reset_reg_s <= '0';
            cld_reset_reg_s <= '0';
            conv_reset_reg_s <= '0';
            hsum_reset_reg_s <= '0';
            ddrif_0_reset_reg_s <= '0';
            ddrif_1_reset_reg_s <= '0';
            ddrif_2_reset_reg_s <= '0';
            ddrif_3_reset_reg_s <= '0';
            ddrif_pcie_reset_reg_s <= '0';
            ddr_0_reset_reg_s <= '0';
            ddr_1_reset_reg_s <= '0';
            ddr_2_reset_reg_s <= '0';
            ddr_3_reset_reg_s <= '0';
            msix_reset_reg_s <= '0';

        elsif rising_edge(CLK_MC) then

            if mcms_rt_s = '1' then
                -- 16#00010#:
                if wren00010_s = '1' then
                    ctrl_reset_reg_s <= mcdatain_rt_s(0);
                    cld_reset_reg_s <= mcdatain_rt_s(1);
                    conv_reset_reg_s <= mcdatain_rt_s(2);
                    hsum_reset_reg_s <= mcdatain_rt_s(3);
                    ddrif_0_reset_reg_s <= mcdatain_rt_s(4);
                    ddrif_1_reset_reg_s <= mcdatain_rt_s(5);
                    ddrif_2_reset_reg_s <= mcdatain_rt_s(6);
                    ddrif_3_reset_reg_s <= mcdatain_rt_s(7);
                    ddrif_pcie_reset_reg_s <= mcdatain_rt_s(8);
                    ddr_0_reset_reg_s <= mcdatain_rt_s(9);
                    ddr_1_reset_reg_s <= mcdatain_rt_s(10);
                    ddr_2_reset_reg_s <= mcdatain_rt_s(11);
                    ddr_3_reset_reg_s <= mcdatain_rt_s(12);
                    msix_reset_reg_s <= mcdatain_rt_s(13);
                end if;
            end if;

        end if;
    end process store;

end synth;
