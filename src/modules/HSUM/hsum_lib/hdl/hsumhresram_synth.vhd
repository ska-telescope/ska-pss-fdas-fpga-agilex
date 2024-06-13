----------------------------------------------------------------------------
-- Module Name:  hsumhresram
--
-- Source Path:  hsum_lib/hdl/hsumhresram_synth.vhd
--
-- Functional Description:
--   Altera RAM model.
--   Read latency is 2.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     11/06/18 Initial revision.
-- 0.2  RJH     23/05/19 RAM size changed to support DMA access.
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

architecture synth of hsumhresram is

-- Define constants for the dimensions of the RAMs.
constant ram_depth_c      : natural := 2*2*16;
constant ram_width_c      : natural := 128;
constant ram_addr_width_c : natural := 6;

component altsyncram IS
generic (
  address_aclr_b : string;
  address_reg_b : string;
  clock_enable_input_b : string;
  clock_enable_output_b : string;
  clock_enable_output_a  : string;
  clock_enable_input_a : string;
  intended_device_family: string;
  lpm_type : string;
  numwords_a : natural;
  numwords_b : natural;
  operation_mode : string;
  power_up_uninitialized : string;
  rdcontrol_reg_b : string;
  read_during_write_mode_mixed_ports : string;
  outdata_aclr_b : string;
  outdata_reg_b : string;
  widthad_a : natural;
  width_a : natural;
  widthad_b : natural;
  width_b : natural
);
port (
  wren_a   : in std_logic;
  clock0   : in std_logic;
  address_a: in std_logic_vector (widthad_a-1 downto 0);
  data_a   : in std_logic_vector (width_a-1 downto 0);
  clock1   : in std_logic;
  address_b: in std_logic_vector (widthad_b-1 downto 0);
  rden_b   : in std_logic;  q_a      : out std_logic_vector (width_a-1 downto 0);
  q_b      : out std_logic_vector (width_b-1 downto 0)  );
end component;

begin

altsyncram_component : altsyncram
generic map (
  address_aclr_b => "NONE",
  address_reg_b => "CLOCK1",
  clock_enable_input_b => "BYPASS",
  clock_enable_output_b => "BYPASS",
  clock_enable_input_a  => "BYPASS",
  clock_enable_output_a => "BYPASS",
  intended_device_family => "Arria 10",
  lpm_type => "altsyncram",
  numwords_a => ram_depth_c,
  numwords_b => ram_depth_c,
  operation_mode => "DUAL_PORT",
  power_up_uninitialized => "FALSE",
  outdata_reg_b => "UNREGISTERED",
  outdata_aclr_b => "NONE",
  read_during_write_mode_mixed_ports => "DONT_CARE",
  rdcontrol_reg_b => "CLOCK1",
  widthad_a => ram_addr_width_c,
  width_a => ram_width_c,
  widthad_b => ram_addr_width_c,
  width_b => ram_width_c
)
port map (
  wren_a => a_write_en,
  clock0 => a_clk,
  address_a => a_addr,
  data_a => a_write_data,
  clock1 => b_clk,
  address_b => b_addr,
  rden_b => b_read_en,
  q_b => b_read_data
);

end architecture synth;

