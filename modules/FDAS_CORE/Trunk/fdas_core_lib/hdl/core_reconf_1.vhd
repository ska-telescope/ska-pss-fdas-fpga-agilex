----------------------------------------------------------------------------
-- Module Name:  core_reconf_1
--
-- Source Path:  fdas_core_lib/hdl/core_reconf_1.vhd
--
-- Description:  This is a copy of core_reconf renamed to core_reconf_1.
--               It is used for creating alternative design for the
--               reconfigurable partition.
--               The generics need to be defined here, since Quartus does
--               not pick them up from the normal settings.
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
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity core_reconf_1 is
   generic(
      ddr_g             : natural := 1;
      fft_abits_g       : natural := 10;
      fft_g             : natural := 1024;
      ifft_g            : natural := 7;
      ifft_loop_bits_g  : natural := 3;
      ifft_loop_g       : natural := 6;
      summer_g          : natural := 1;
      harmonic_g        : natural := 16;
      product_id_g      : natural := 16#FDA5#;
      version_number_g  : natural := 3;
      revision_number_g : natural := 1
   );
   port(
      CLK_SYS           : in     std_logic;
      CLK_MC            : in     std_logic;
      RST_MC_N          : in     std_logic;
      RST_GLOBAL_N      : in     std_logic;
      CLK_PCIE          : in     std_logic;
      RST_PCIE_N        : in     std_logic;
      mcaddr            : in     std_logic_vector (21 downto 0);
      mcdata            : in     std_logic_vector (31 downto 0);
      mcrwn             : in     std_logic;
      mccs              : in     std_logic;
      mcdataout         : out    std_logic_vector (31 downto 0);
      ddr0_rd_waitreq   : in     std_logic;
      ddr0_rd_data      : in     std_logic_vector (512*ddr_g -1  downto 0);
      ddr0_rd_valid     : in     std_logic;
      ddr0_rd_addr      : out    std_logic_vector (31 downto 0);
      ddr0_rd_en        : out    std_logic;
      ddr1_wr_waitreq   : in     std_logic;
      ddr1_wr_data      : out    std_logic_vector (ddr_g*512-1 downto 0);
      ddr1_wr_addr      : out    std_logic_vector (25 downto 0);
      ddr1_wr_en        : out    std_logic;
      ddr1_rd_waitreq   : in     std_logic;
      ddr1_rd_data      : in     std_logic_vector (512*ddr_g-1 downto 0);
      ddr1_rd_valid     : in     std_logic;
      ddr1_rd_addr      : out    std_logic_vector (31 downto 0);
      ddr1_rd_en        : out    std_logic;
      DDR_1_CAL_FAIL    : in     std_logic;
      DDR_0_CAL_SUCESS  : in     std_logic;
      DDR_1_CAL_SUCESS  : in     std_logic;
      DDR_0_CAL_FAIL    : in     std_logic;
      ddrif_0_resetn    : out    std_logic;
      ddrif_1_resetn    : out    std_logic;
      ddrif_pcie_resetn : out    std_logic;
      ddr_rst_n         : out    std_logic;
      txs_write         : out    std_logic;
      txs_address       : out    std_logic_vector (63 downto 0);
      txs_byte_enable   : out    std_logic_vector (3 downto 0);
      txs_write_data    : out    std_logic_vector (31 downto 0);
      txs_wait_request  : in     std_logic;
      msiintfc_o        : in     std_logic_vector (81 downto 0);
      msicontrol_o      : in     std_logic_vector (15 downto 0)
   );

end core_reconf_1 ;
