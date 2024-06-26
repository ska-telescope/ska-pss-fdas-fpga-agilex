----------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2017 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------
--
-- VHDL Architecture cld_lib.cld_fifo.scm
--
-- Created:
--          by - droogm.UNKNOWN (COVNETICSDT7)
--          at - 13:26:51 13/11/2017
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.2a (Build 3)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library cld_lib;
use cld_lib.all;


ARCHITECTURE scm OF cld_fifo IS

  -- Architecture declarations

  -- Internal signal declarations
  SIGNAL bo : std_logic_vector(512*ddr_g-1 DOWNTO 0);


  -- Component Declarations
  COMPONENT dual_port_ram
  GENERIC (
    abits_g : integer;
    dbits_g : integer
  );
  PORT (
    aa    : IN     std_logic_vector (abits_g-1 DOWNTO 0);
    ai    : IN     std_logic_vector (dbits_g-1 DOWNTO 0);
    awren : IN     std_logic ;
    ba    : IN     std_logic_vector (abits_g-1 DOWNTO 0);
    clk   : IN     std_logic ;
    bo    : OUT    std_logic_vector (dbits_g-1 DOWNTO 0)
  );
  END COMPONENT dual_port_ram;
  COMPONENT ram_mux
  GENERIC (
    ddr_g : integer
  );
  PORT (
    clk_sys   : IN     std_logic ;
    fft_zeros : IN     std_logic ;
    ram_data  : IN     std_logic_vector (512*ddr_g-1 DOWNTO 0);
    read_addr : IN     std_logic_vector (ddr_g +1 DOWNTO 0);
    rst_sys_n : IN     std_logic ;
    wait_req  : IN     std_logic ;
    conv_data : OUT    std_logic_vector (63  DOWNTO 0)
  );
  END COMPONENT ram_mux;

  -- Optional embedded configurations
  -- pragma synthesis_off
  FOR ALL : dual_port_ram USE ENTITY cld_lib.dual_port_ram;
  FOR ALL : ram_mux USE ENTITY cld_lib.ram_mux;
  -- pragma synthesis_on


BEGIN

  -- Instance port mappings.
  dual_port_ram_1 : dual_port_ram
    GENERIC MAP (
      abits_g => fifo_waddr_width_g,
      dbits_g => 512*ddr_g
    )
    PORT MAP (
      aa    => fifo_waddr_s,
      ai    => ddr_data,
      awren => data_valid,
      ba    => fifo_raddr_s(fifo_raddr_width_g -1 DOWNTO fifo_raddr_width_g - fifo_waddr_width_g),
      clk   => clk_sys,
      bo    => bo
    );
  ram_mux_1 : ram_mux
    GENERIC MAP (
      ddr_g => ddr_g
    )
    PORT MAP (
      clk_sys   => clk_sys,
      fft_zeros => fft_zeros,
      ram_data  => bo,
      read_addr => fifo_raddr_s(fifo_raddr_width_g -fifo_waddr_width_g -1 DOWNTO 0),
      rst_sys_n => rst_sys_n,
      wait_req  => wait_req,
      conv_data => conv_data
    );

END ARCHITECTURE scm;
