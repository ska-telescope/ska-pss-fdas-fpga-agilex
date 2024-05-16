----------------------------------------------------------------------------
-- Module Name:  hsumddrinram
--
-- Source Path:  hsum_lib/hdl/hsumddrinram_synth.vhd
--
-- Functional Description:
--   Instantiates an Altera MLAB RAM.
--   Write width is wide and varies (512*ddr_g).
--   Read width is narrow and fixed (32 bits).
--
--   Overall read latency is effectively 2 cycles, but the final retime is
--   in hsummins.
--
--   The diagrams below show how the RAM is used. A quarter of the RAM is shown (one page).
--   There are 4 pages.
--
--   ddr_g = 1:
--
--          +----------------+
--   Addr 0 | DDR #1 Word #0 |
--          +----------------+
--          | DDR #1 Word #1 |
--          +----------------+
--          | DDR #1 Word #2 |
--          +----------------+
--          | DDR #1 Word #3 |
--          +----------------+
--          | DDR #1 Word #4 |
--          +----------------+
--          | DDR #1 Word #5 |
--          +----------------+
--          |                |
--          +----------------+
--   Addr 7 |                |
--          +----------------+
--
--   ddr_g = 2:
--
--          +----------------+----------------+
--   Addr 0 | DDR #2 Word #0 | DDR #1 Word #0 |
--          +----------------+----------------+
--          | DDR #2 Word #1 | DDR #1 Word #1 |
--          +----------------+----------------+
--          | DDR #2 Word #2 | DDR #1 Word #2 |
--          +----------------+----------------+
--   Addr 3 |                |                |
--          +----------------+----------------+
--
--   ddr_g = 3:
--
--          +----------------+----------------+----------------+----------------+
--   Addr 0 |                | DDR #3 Word #0 | DDR #2 Word #0 | DDR #1 Word #0 |
--          +----------------+----------------+----------------+----------------+
--   Addr 1 |                | DDR #3 Word #1 | DDR #2 Word #1 | DDR #1 Word #1 |
--          +----------------+----------------+----------------+----------------+
--
--   For readback, however, for the case of ddr_g = 3 we want the RAM to appear
--   as follows so that HPSEL values are consistent in all cases, thus some
--   manipulation of the address bits is required:
--
--          +----------------+----------------+----------------+----------------+
--   Addr 0 | DDR #1 Word #1 | DDR #3 Word #0 | DDR #2 Word #0 | DDR #1 Word #0 |
--          +----------------+----------------+----------------+----------------+
--   Addr 1 |                |                | DDR #3 Word #1 | DDR #2 Word #1 |
--          +----------------+----------------+----------------+----------------+

----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     23/10/18 Initial revision.
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

architecture synth of hsumddrinram is

-- Define constants for the dimensions of the RAMs.
constant ram_addr_width_c : natural := 6-ddr_g;
constant ram_depth_c      : natural := 2**ram_addr_width_c;
constant ram_width_c      : natural := 512*ddr_g;

signal read_addr_s : std_logic_vector(read_addr'range); -- After manipulation, if required.
signal read_data_s : std_logic_vector(ram_width_c-1 downto 0); -- RAM read output.
signal ext_data_s  : std_logic_vector(512*(2**(ddr_g-1))-1 downto 0); -- Extended/modified read data.
signal ram_addr_s  : std_logic_vector(ram_addr_width_c-1 downto 0);  -- Part of read_addr_s which addresses the RAM.
signal word_sel_s  : natural range 0 to ram_width_c/32-1; -- Part of read_addr_s which slices the RAM output.
signal word_sel_d1 : natural range 0 to ram_width_c/32-1; -- word_sel_s delayed by 1 cycle.
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

----------------------------------------------------------------------------
-- Function: Manipulate read address.
----------------------------------------------------------------------------
alter_rd_addr_p : process(read_addr)
begin
  -- No change to address in most cases.
  read_addr_s <= read_addr;

  if ddr_g = 3 then
    case read_addr(6 downto 4) is
      when "011" =>
        read_addr_s(6 downto 4) <= "100";
      when "100" =>
        read_addr_s(6 downto 4) <= "101";
      when "101" =>
        read_addr_s(6 downto 4) <= "110";
      when "110" =>
        read_addr_s(6 downto 4) <= "011";
      when others =>
        null;
    end case;
  end if;
end process alter_rd_addr_p;

----------------------------------------------------------------------------
-- Function: Divide the read address into two parts: one for addressing the
--           RAM, and one for slicing the output.
----------------------------------------------------------------------------
split_rd_addr_p : process(read_addr_s)
begin
  case ddr_g is
    when 1 =>
      ram_addr_s <= read_addr_s(8 downto 4);
      word_sel_s <= to_integer(unsigned(read_addr_s(3 downto 0)));
    when 2 =>
      ram_addr_s <= read_addr_s(8 downto 5);
      word_sel_s <= to_integer(unsigned(read_addr_s(4 downto 0)));
    when 3 =>
      ram_addr_s <= read_addr_s(8 downto 6);
      word_sel_s <= to_integer(unsigned(read_addr_s(5 downto 0)));
  end case;
end process split_rd_addr_p;

----------------------------------------------------------------------------
-- Function: Delay word_sel_s to align with RAM output.
----------------------------------------------------------------------------
del_word_sel_p : process(clk_sys, rst_sys_n)
begin
  if rst_sys_n = '0' then
    -- Initialise.
    word_sel_d1 <= 0;
  elsif rising_edge(clk_sys) then
    word_sel_d1 <= word_sel_s;
  end if;
end process del_word_sel_p;

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
    numwords_a  => ram_depth_c,
    numwords_b  => ram_depth_c,
    operation_mode  => "DUAL_PORT",
    outdata_aclr_b  => "NONE",
    outdata_reg_b  => "UNREGISTERED",
    power_up_uninitialized  => "FALSE",
    ram_block_type  => "MLAB",
    read_during_write_mode_mixed_ports  => "DONT_CARE",
    widthad_a  => ram_addr_width_c,
    widthad_b  => ram_addr_width_c,
    width_a  => ram_width_c,
    width_b  => ram_width_c,
    width_byteena_a  => 1
  )
  port map (
    address_a => write_addr,
    address_b => ram_addr_s,
    addressstall_b => readstall_s,
    clock0 => clk_sys,
    data_a => write_data,
    wren_a => write_en,
    q_b => read_data_s
);


----------------------------------------------------------------------------
-- Function: Extend ram output bus so we don't get any out of range errors
--           whilst muxing. Replace unused parts of the RAM output with zeros
--           so that the unused RAM resource can be optimised away.
----------------------------------------------------------------------------
ext1: if ddr_g = 1 generate
  ext_data_s <= read_data_s;
end generate ext1;
ext2: if ddr_g = 2 generate
  ext_data_s(1023 downto 512) <= read_data_s(1023 downto 576) & X"0000000000000000";
  ext_data_s(511 downto 0)    <= read_data_s(511 downto 0);
end generate ext2;
ext3: if ddr_g = 3 generate
  ext_data_s(2047 downto 1536) <= (others => '0');
  ext_data_s(1535 downto 1024) <= read_data_s(1535 downto 1088) & X"0000000000000000";
  ext_data_s(1023 downto 512)  <= read_data_s(1023 downto 576) & X"0000000000000000";
  ext_data_s(511 downto 0)     <= read_data_s(511 downto 0);
end generate ext3;

----------------------------------------------------------------------------
-- Function: Final word selection.
----------------------------------------------------------------------------
word_sel : read_data <= ext_data_s(word_sel_d1*32+31 downto word_sel_d1*32);

end architecture synth;

