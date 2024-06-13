--------------------------------------------------------------------------------
-- Architecture: synth
--------------------------------------------------------------------------------
-- Module: MCI_TOP_DECODE
-- Date:   12/04/2023 12:52:10
-- File:   mci_top_decodemci_synth.vhd
-- CRC-16: 0x192B
--------------------------------------------------------------------------------

architecture synth of mci_top_decodemci is

begin

    -- Process: decode
    decode : process (MCADDR, MCCS)

        variable addr_v : integer range 0 to 4194303;

    begin

        MCMS_TOPMCI_1 <= '0';
        MCMS_CTRL_1 <= '0';
        MCMS_MSIX_1 <= '0';
        MCMS_CONV_1 <= '0';
        MCMS_HSUM_1 <= '0';

        if MCCS = '1' then
            addr_v := to_integer(unsigned(MCADDR));
            case addr_v is
                when 16#000000# to 16#0FFFFF# =>
                    -- Instance TOPMCI_1 of module MCI_TOP:
                    MCMS_TOPMCI_1 <= '1';
                when 16#100000# to 16#17FFFF# =>
                    -- Instance CTRL_1 of module CTRL:
                    MCMS_CTRL_1 <= '1';
                when 16#180000# to 16#18000F# =>
                    -- Instance MSIX_1 of module MSIX:
                    MCMS_MSIX_1 <= '1';
                when 16#200000# to 16#2FFFFF# =>
                    -- Instance CONV_1 of module CONV:
                    MCMS_CONV_1 <= '1';
                when 16#300000# to 16#33FFFF# =>
                    -- Instance HSUM_1 of module HSUM:
                    MCMS_HSUM_1 <= '1';
                when others =>
                    null;
            end case;
        end if;

    end process decode;

end synth;
