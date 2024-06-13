----------------------------------------------------------------------------
-- Module Name:  hsumhpselram
--
-- Source Path:  hsum_lib/hdl/hsumhpselram_synth.vhd
--
-- Functional Description:
--   RAM model.
--   Read latency is 2 for A port.
--   Read latency is 1 for B port.
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


architecture synth of hsumhpselram is
  ---- Define constants for the dimensions of the RAM.
  constant ram_depth_c      : natural := 2*32*16;
  constant ram_width_c      : natural := 7;

  type ram_t is array (0 to ram_depth_c-1) of std_logic_vector(ram_width_c-1 downto 0);
  signal rdatastore_s      : ram_t;
  signal a_read_data_unregistered_s : std_logic_vector(ram_width_c-1 downto 0); 

begin
 
  -- READ CIRCUIT SIDE
  --------------------------------------------------------------------------
  -- RAM read circuit side (infer ram with unregistered output)
  --------------------------------------------------------------------------
  rdstore  : process 
  begin
    wait until rising_edge(b_clk); 

      if b_read_en ='1' then -- If circuit Read is enabled obtain the data for the requested address
        b_read_data <= rdatastore_s(to_integer(unsigned(b_addr)));
      end if;
            
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
 
