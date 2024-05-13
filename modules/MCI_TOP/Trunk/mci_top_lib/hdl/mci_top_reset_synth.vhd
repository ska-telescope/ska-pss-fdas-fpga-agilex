----------------------------------------------------------------------------
-- Module Name:  mci_top_reset
--
-- Source Path:  mci_top_lib/hdl/mci_top_reset_synth.vhd
--
-- Functional Description:
--
-- Logically ANDs the MC configurable resets with the main system reset.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  15/09/2017  Initial revision.
-- 0.2  RJH  26/11/2018  DDR_2_RESETN changed to DDRIF_PCIE_RESETN.
-- 0.3  RJH  24/03/2020  Removed signals and process.
-- 0.4  RMD  25/03/2022  Added DDR_2_RESETN and MSIX_RESETN
-- 0.5  RMD  09/04/2023  Separate Resets for four DDR Controllers and DDRIF2 modules
-- 0.6  RMD  12/04/2023  Inverted the sense of the Resets from the MCI so that
--                       at power up Resets are not asserted.
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of mci_top_reset is

begin

-- Concurrent assignments.
-- Gate each MC generated reset with the system reset.
assign_ctrl_resetn    : CTRL_RESETN       <= not(ctrl_reset_in) and resetn;
assign_cld_resetn     : CLD_RESETN        <= not(cld_reset_in) and resetn;
assign_conv_resetn    : CONV_RESETN       <= not(conv_reset_in) and resetn;
assign_hsum_resetn    : HSUM_RESETN       <= not(hsum_reset_in) and resetn;
assign_msix_resetn    : MSIX_RESETN       <= not(msix_reset_in) and resetn;
assign_ddrif_0_resetn : DDRIF_0_RESETN    <= not(ddrif_0_reset_in) and resetn;
assign_ddrif_1_resetn : DDRIF_1_RESETN    <= not(ddrif_1_reset_in) and resetn;
assign_ddrif_2_resetn : DDRIF_2_RESETN    <= not(ddrif_2_reset_in) and resetn;
assign_ddrif_3_resetn : DDRIF_3_RESETN    <= not(ddrif_3_reset_in) and resetn;
assign_ddr_0_resetn   : DDR_0_RESETN      <= not(ddr_0_reset_in) and resetn;
assign_ddr_1_resetn   : DDR_1_RESETN      <= not(ddr_1_reset_in) and resetn;
assign_ddr_2_resetn   : DDR_2_RESETN      <= not(ddr_2_reset_in) and resetn;
assign_ddr_3_resetn   : DDR_3_RESETN      <= not(ddr_3_reset_in) and resetn;
assign_ddrif_p_resetn : DDRIF_PCIE_RESETN <= not(ddrif_pcie_reset_in) and resetn;


end architecture synth;
