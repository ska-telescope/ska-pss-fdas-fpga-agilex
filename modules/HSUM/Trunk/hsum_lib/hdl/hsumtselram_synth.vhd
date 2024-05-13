----------------------------------------------------------------------------
-- Module Name:  hsumtselram
--
-- Source Path:  hsum_lib/hdl/hsumtselram_synth.vhd
--
-- Functional Description:
--   Altera RAM model.
--   Read latency for port A is 2.
--   Read latency for port B is 2.
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RJH     24/05/18 Initial revision.
-- 0.2  RJH     10/06/19 Added retime to A read port.
-- 0.3  RMD     10/01/22 Agilex does not seem to support True Dual Port altsyncram with
--                       different clocks on the A and B port. The options are to either use the 
--                       Quartus 21.3 IP catalog to create the RAM or to infer the RAM with appropriately
--                       constructed VHDL code. Since infering RAMs is done in CLD, CONV and DDRIF2 the 
--                       inferring of RAMs in HSUM will be attempted to create a common theme.
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2022 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------

library ieee;
library altera_mf;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--architecture synth of hsumtselram is
--
---- Define constants for the dimensions of the RAMs.
--constant ram_depth_c      : natural := 2*32;
--constant ram_width_c      : natural := 32;
--constant ram_addr_width_c : natural := 6;
--
--component altsyncram IS
--generic (
--  address_aclr_b : string;
--  address_reg_b : string;
--  clock_enable_input_b : string;
--  clock_enable_output_b : string;
--  clock_enable_output_a  : string;
--  clock_enable_input_a : string;
--  intended_device_family: string;
--  lpm_type : string;
--  numwords_a : natural;
--  numwords_b : natural;
--  operation_mode : string;
--  power_up_uninitialized : string;
--  outdata_aclr_a : string;
--  outdata_reg_a : string;
--  read_during_write_mode_port_a : string;
--  rdcontrol_reg_b : string;
--  outdata_aclr_b : string;
--  outdata_reg_b : string;
--  widthad_a : natural;
--  width_a : natural;
--  widthad_b : natural;
--  width_b : natural
--);
--port (
--  wren_a   : in std_logic;
--  clock0   : in std_logic;
--  address_a: in std_logic_vector (widthad_a-1 downto 0);
--  rden_a   : in std_logic;
--  data_a   : in std_logic_vector (width_a-1 downto 0);
--  clock1   : in std_logic;
--  address_b: in std_logic_vector (widthad_b-1 downto 0);
--  rden_b   : in std_logic;
--  q_a      : out std_logic_vector (width_a-1 downto 0);
--  q_b      : out std_logic_vector (width_b-1 downto 0)  );
--end component;
--
--begin
--
--altsyncram_component : altsyncram
--generic map (
--  address_aclr_b => "NONE",
--  address_reg_b => "CLOCK1",
--  clock_enable_input_b => "BYPASS",
--  clock_enable_output_b => "BYPASS",
--  clock_enable_input_a  => "BYPASS",
--  clock_enable_output_a => "BYPASS",
--  intended_device_family => "Arria 10",
--  lpm_type => "altsyncram",
--  numwords_a => ram_depth_c,
--  numwords_b => ram_depth_c,
--  operation_mode => "BIDIR_DUAL_PORT",
--  power_up_uninitialized => "FALSE",
--  outdata_aclr_a => "NONE",
--  outdata_reg_a => "CLOCK0",
--  outdata_aclr_b => "NONE",
--  outdata_reg_b => "CLOCK1",
--  read_during_write_mode_port_a => "DONT_CARE",
--  rdcontrol_reg_b => "CLOCK1",
--  widthad_a => ram_addr_width_c,
--  width_a => ram_width_c,
--  widthad_b => ram_addr_width_c,
--  width_b => ram_width_c
--)
--port map (
--  wren_a => a_write_en,
--  clock0 => a_clk,
--  address_a => a_addr,
--  rden_a => a_read_en,
--  data_a => a_write_data,
--  clock1 => b_clk,
--  address_b => b_addr,
--  rden_b => b_read_en,
--  q_a => a_read_data,
--  q_b => b_read_data
--);
--
--end architecture synth;


architecture synth of hsumtselram is
  ---- Define constants for the dimensions of the RAM.
  constant ram_depth_c      : natural := 2*32;
  constant ram_width_c      : natural := 32;

  type ram_t is array (0 to ram_depth_c-1) of std_logic_vector(ram_width_c-1 downto 0);
  signal rdatastore_s      : ram_t;
  signal a_read_data_unregistered_s : std_logic_vector(ram_width_c-1 downto 0); 
  signal b_read_data_unregistered_s : std_logic_vector(ram_width_c-1 downto 0); 

begin
 
  -- READ CIRCUIT SIDE
  --------------------------------------------------------------------------
  -- RAM read circuit side (infer ram with unregistered output)
  --------------------------------------------------------------------------
  rdstore  : process 
  begin
    wait until rising_edge(b_clk); 

      if b_read_en ='1' then -- If circuit Read is enabled obtain the data for the requested address
        b_read_data_unregistered_s <= rdatastore_s(to_integer(unsigned(b_addr)));
      end if;
      
      b_read_data <= b_read_data_unregistered_s; -- retime the data delivered to the Circuit side
            
  end process rdstore;

  -- READ/WRITE MCI SIDE
  --------------------------------------------------------------------------
  -- MCI write store
  --------------------------------------------------------------------------
  mcwrstore : process 
  begin
    wait until rising_edge(a_clk); 
 
      if a_write_en='1' then -- If an MCI Write is enabled store the data at the requested address         
        rdatastore_s(to_integer(unsigned(a_addr))) <= a_write_data;
      end if;
  
  end process mcwrstore;
 
   --------------------------------------------------------------------------
   -- MCI read store
   --------------------------------------------------------------------------
   mcrdstore : process 
   begin
     wait until rising_edge(a_clk); 
 
       if a_read_en ='1' then -- If an MCI  Read is enabled obtain the data for the requested address
         a_read_data_unregistered_s <= rdatastore_s(to_integer(unsigned(a_addr)));          
       end if;
       
       a_read_data <= a_read_data_unregistered_s; -- retime the data delivered to the MCI side
   end process mcrdstore;

end architecture synth;



