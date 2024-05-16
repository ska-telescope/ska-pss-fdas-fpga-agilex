----------------------------------------------------------------------------
-- Module Name: convmci
--
-- Source Path: CONV_LIB/hdl/convmci_synth.vhd 
--
-- Functional Description:
--
-- CMG generated Microcontroller Interface sub-module.
--
-- CRC-16: 0x90A7
--
----------------------------------------------------------------------------
-- Date: 21/02/2019 07:28:50
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

architecture synth of convmci is

    -- Internal Interface Signals
    signal mcaddr_rt_s : std_logic_vector(19 downto 0);
    signal mcdatain_rt_s : std_logic_vector(31 downto 0);
    signal mcdataout_rd_s : std_logic_vector(31 downto 0);
    signal mcrwn_rt_s : std_logic;
    signal mcms_rt_s : std_logic;

    -- Storage Registers
    signal row0_delay_reg_s : std_logic_vector(9 downto 0);

    -- Decoded Write Enables
    signal wren28000_s : std_logic;

begin

    -- Ram Output Assignments
    assign_filter_coefficients_addr : FILTER_COEFFICIENTS.ADDR <= mcaddr_rt_s(16 downto 0);
    assign_filter_coefficients_data : FILTER_COEFFICIENTS.WR <= mcdatain_rt_s(31 downto 0);
    assign_fft_results_addr : FFT_RESULTS.ADDR <= mcaddr_rt_s(10 downto 0);

    -- Storage Output Assignments
    assign_row0_delay : ROW0_DELAY <= row0_delay_reg_s;

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
    decode : process (FILTER_COEFFICIENTS_RD, FFT_RESULTS_RD, row0_delay_reg_s, 
            OVERFLOW, mcaddr_rt_s, mcdatain_rt_s, mcrwn_rt_s, mcms_rt_s)

        variable addr_v, offset_v : integer range 0 to 1048575;

    begin

        wren28000_s <= '0';

        FILTER_COEFFICIENTS.RDEN <= '0';
        FILTER_COEFFICIENTS.WREN <= '0';
        FFT_RESULTS.RDEN <= '0';
        mcdataout_rd_s <= (others => '0');

        if mcms_rt_s = '1' then
            addr_v := to_integer(unsigned(mcaddr_rt_s));

            case addr_v is
                when 16#00000# to 16#14FFF# =>
                    offset_v := addr_v - 16#00000#;
                    FILTER_COEFFICIENTS.RDEN <= mcrwn_rt_s;
                    FILTER_COEFFICIENTS.WREN <= not mcrwn_rt_s;
                    mcdataout_rd_s(31 downto 0) <= FILTER_COEFFICIENTS_RD;
                when 16#20000# to 16#207FF# =>
                    offset_v := addr_v - 16#20000#;
                    FFT_RESULTS.RDEN <= mcrwn_rt_s;
                    mcdataout_rd_s(31 downto 0) <= FFT_RESULTS_RD;
                when 16#28000# =>
                    wren28000_s <= not mcrwn_rt_s;
                    mcdataout_rd_s(9 downto 0) <= row0_delay_reg_s;
                when 16#30000# =>
                    mcdataout_rd_s <= OVERFLOW(31 downto 0);
                when 16#30001# =>
                    mcdataout_rd_s <= OVERFLOW(63 downto 32);
                when 16#30002# =>
                    mcdataout_rd_s(20 downto 0) <= OVERFLOW(84 downto 64);
                when others =>
                    null;
            end case;
        end if;

    end process decode;

    -- Micro Store
    store : process (CLK_MC, RST_MC_N)
    begin

        if RST_MC_N = '0' then

            row0_delay_reg_s <= (others => '0');

        elsif rising_edge(CLK_MC) then

            if mcms_rt_s = '1' then
                -- 16#28000#:
                if wren28000_s = '1' then
                    row0_delay_reg_s <= mcdatain_rt_s(9 downto 0);
                end if;
            end if;

        end if;
    end process store;

end synth;
