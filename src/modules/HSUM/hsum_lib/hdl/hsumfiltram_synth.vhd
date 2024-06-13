----------------------------------------------------------------------------
-- Module Name:  hsumfiltram
--
-- Source Path:  hsum_lib/hdl/hsumfiltram_synth.vhd
--
-- Functional Description:
--   Instantiates an Altera MLAB RAM.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     04/06/18 Initial revision.
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
library altera_mf;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of hsumfiltram is

signal readstall_s : std_logic;

component altsyncram IS
  generic (
    address_aclr_b : string;
    address_reg_b : string;
    clock_enable_input_b : string;
    clock_enable_output_b : string;
    clock_enable_input_a : string;
    intended_device_family: string;
    lpm_type : string;
    numwords_a : natural;
    numwords_b : natural;
    operation_mode : string;
    power_up_uninitialized : string;
    read_during_write_mode_mixed_ports : string;
    ram_block_type : string;
    outdata_aclr_b : string;
    outdata_reg_b : string;
    widthad_a : natural;
    widthad_b : natural;
    width_a : natural;
    width_b : natural;
    width_byteena_a : natural
  );
  port (
    wren_a   : in std_logic;
    clock0   : in std_logic;
    address_a: in std_logic_vector (widthad_a-1 downto 0);
    data_a   : in std_logic_vector (width_a-1 downto 0);
    address_b: in std_logic_vector (widthad_b-1 downto 0);
    addressstall_b : in std_logic;
    q_b      : out std_logic_vector (width_b-1 downto 0)
  );
end component;

begin

-- Invert read enable.
invrden : readstall_s <= not read_en;

----------------------------------------------------------------------------
-- Function: Instantiate Altera MLAB RAM.
----------------------------------------------------------------------------
ram : altsyncram
  generic map (
    address_aclr_b  => "NONE",
    address_reg_b  => "CLOCK0",
    clock_enable_input_a  => "BYPASS",
    clock_enable_input_b  => "BYPASS",
    clock_enable_output_b  => "BYPASS",
    intended_device_family  => "Arria 10",
    lpm_type  => "altera_syncram",
    numwords_a  => 2**write_addr'length,
    numwords_b  => 2**read_addr'length,
    operation_mode  => "DUAL_PORT",
    outdata_aclr_b  => "NONE",
    outdata_reg_b  => "UNREGISTERED",
    power_up_uninitialized  => "FALSE",
    ram_block_type  => "MLAB",
    read_during_write_mode_mixed_ports  => "DONT_CARE",
    widthad_a  => write_addr'length,
    widthad_b  => read_addr'length,
    width_a  => data_width_g,
    width_b  => data_width_g,
    width_byteena_a  => 1
  )
  port map (
    address_a => write_addr,
    address_b => read_addr,
    addressstall_b => readstall_s,
    clock0 => clk_sys,
    data_a => write_data,
    wren_a => write_en,
    q_b => read_data
);

end architecture synth;

