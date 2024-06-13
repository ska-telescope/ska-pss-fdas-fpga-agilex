----------------------------------------------------------------------------
-- Module Name:  core_reconf
--
-- Source Path:  fdas_core_lib/hdl/core_reconf_1_scm.vhd
--
-- Description:  This is a copy of core_reconf renamed to core_reconf_1.
--               It is used for creating alternative design for the
--               reconfigurable partition.
---------------------------------------------------------------------------
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library cld_lib;
library conv_lib;
library ctrl_lib;
library fdas_core_lib;
library hsum_lib;
library mci_top_lib;
library msi_lib;

architecture scm of core_reconf_1 is

   -- Architecture declarations

   -- Internal signal declarations
   signal cld_done_s        : std_logic;
   signal cld_enable_s      : std_logic;
   signal cld_page_s        : std_logic_vector(31 downto 0);
   signal cld_trigger_s     : std_logic;
   signal conv_data_s       : std_logic_vector(63 downto 0);
   signal conv_done_s       : std_logic;
   signal conv_enable_s     : std_logic;
   signal conv_eof_s        : std_logic;
   signal conv_fft_ready_s  : std_logic;
   signal conv_page_s       : std_logic_vector(31 downto 0);
   signal conv_ready_s      : std_logic;
   signal conv_req_s        : std_logic;
   signal conv_sof_s        : std_logic;
   signal conv_trigger_s    : std_logic;
   signal conv_valid_s      : std_logic;
   signal fft_sample_s      : std_logic_vector(9  downto 0);
   signal fop_sample_num_s  : std_logic_vector(22 downto 0);
   signal hsum_done_s       : std_logic;
   signal hsum_enable_s     : std_logic;
   signal hsum_page_s       : std_logic_vector(31 downto 0);
   signal hsum_trigger_s    : std_logic;
   signal ifft_loop_num_s   : std_logic_vector(5 downto 0);
   signal mcdataout_conv_s  : std_logic_vector(31 downto 0);
   signal mcdataout_ctrl_s  : std_logic_vector(31 downto 0);
   signal mcdataout_hsum_s  : std_logic_vector(31 downto 0);
   signal mcms_conv_s       : std_logic;
   signal mcms_ctrl_s       : std_logic;
   signal mcms_hsum_s       : std_logic;
   signal overlap_size_s    : std_logic_vector(fft_abits_g-1 downto 0);
   signal product_id_s      : std_logic_vector(15 downto 0);
   signal revision_number_s : std_logic_vector(15 downto 0);
   signal rst_cld_n_s       : std_logic;
   signal rst_cld_sys_n_s   : std_logic;
   signal rst_conv_n_s      : std_logic;
   signal rst_conv_sys_n_s  : std_logic;
   signal rst_ctrl_n_s      : std_logic;
   signal rst_ctrl_sys_n_s  : std_logic;
   signal rst_hsum_n_s      : std_logic;
   signal rst_hsum_sys_n_s  : std_logic;
   signal version_number_s  : std_logic_vector(15 downto 0);


   -- Component Declarations
   component cld
   generic (
      ddr_g                    : integer;      --number of DDR Interfaces
      fft_ddr_addr_num_g       : integer;      --Number of DDR locations to read for an FFT
      fop_ddr_addr_max_width_g : integer;      --Number of counter bits to support the address for reading of the FOP from DDR memory
      fft_ddr_addr_num_width_g : integer;      --Number of counter bits to support ddr_addr_num_g
      fft_g                    : integer;      --Number of samples in an FFT
      fft_count_width_g        : integer;      --Number of counter bits  to support fft_g
      sample_count_width_g     : integer;      --Number of counter bits to support fop_g
      fifo_waddr_width_g       : integer;      --Number of counter bits to support write locations
      fifo_raddr_width_g       : integer       --Number of counter bits to support read locations
   );
   port (
      cld_enable     : in     std_logic ;
      cld_page       : in     std_logic_vector (31 downto 0);
      cld_trigger    : in     std_logic ;
      clk_sys        : in     std_logic ;
      data_valid     : in     std_logic ;
      ddr_data       : in     std_logic_vector (512*ddr_g -1  downto 0);
      fop_sample_num : in     std_logic_vector (22 downto 0);
      overlap_int    : in     std_logic_vector (4 downto 0);
      overlap_rem    : in     std_logic_vector (4 downto 0);
      overlap_size   : in     std_logic_vector (9  downto 0);
      ready          : in     std_logic ;
      rst_sys_n      : in     std_logic ;
      wait_request   : in     std_logic ;
      cld_done       : out    std_logic ;
      conv_data      : out    std_logic_vector (63  downto 0);
      conv_req       : out    std_logic ;
      ddr_addr       : out    std_logic_vector (31 downto 0);
      ddr_read       : out    std_logic ;
      eof            : out    std_logic ;
      fft_sample     : out    std_logic_vector (9  downto 0);
      sof            : out    std_logic ;
      valid          : out    std_logic 
   );
   end component;
   component conv
   generic (
      ddr_g            : natural;      --number of external DDR interfaces
      ifft_g           : natural;      --number of ifft filter pairs
      ifft_loop_g      : natural;      --number of filter repeats
      ifft_loop_bits_g : natural;      --filter repeat count bits
      fft_g            : natural;      --FFT/IFFT points
      abits_g          : natural;      --points count bits
      fop_num_bits_g   : natural       --bits for freq bins processed
   );
   port (
      CLK_MC        : in     std_logic ;
      CLK_SYS       : in     std_logic ;
      CONV_ENABLE   : in     std_logic ;
      CONV_TRIGGER  : in     std_logic ;
      EOF           : in     std_logic ;
      IDATA         : in     std_logic_vector (31 downto 0);
      MCADDR        : in     std_logic_vector (19 downto 0);
      MCDATA        : in     std_logic_vector (31 downto 0);
      MCMS          : in     std_logic ;
      MCRWN         : in     std_logic ;
      FOP_NUM       : in     std_logic_vector (fop_num_bits_g-1 downto 0);
      OVERLAP_SIZE  : in     std_logic_vector (abits_g-1 downto 0);
      RDATA         : in     std_logic_vector (31 downto 0);
      DDR_WAITREQ   : in     std_logic ;
      RST_MC_N      : in     std_logic ;
      RST_SYS_N     : in     std_logic ;
      SOF           : in     std_logic ;
      VALID         : in     std_logic ;
      DDR_ADDROUT   : out    std_logic_vector (25 downto 0);
      DDR_DATAOUT   : out    std_logic_vector (ddr_g*512-1 downto 0);
      DDR_VALIDOUT  : out    std_logic ;
      MCDATAOUT     : out    std_logic_vector (31 downto 0);
      READYOUT      : out    std_logic ;
      IFFT_LOOP_NUM : in     std_logic_vector (ifft_loop_bits_g-1 downto 0);
      SEGDONEOUT    : out    std_logic ;
      MCREADYOUT    : out    std_logic ;
      CONV_DONEOUT  : out    std_logic ;
      PAGE_START    : in     std_logic_vector (25 downto 0)
   );
   end component;
   component ctrl
   port (
      cld_done       : in     std_logic;
      clk_mc         : in     std_logic;
      clk_sys        : in     std_logic;
      conv_done      : in     std_logic;
      conv_fft_ready : in     std_logic;
      hsum_done      : in     std_logic;
      mcaddr         : in     std_logic_vector (19 downto 0);
      mcdatain       : in     std_logic_vector (31 downto 0);
      mcms           : in     std_logic;
      mcrwn          : in     std_logic;
      rst_mc_n       : in     std_logic;
      rst_sys_n      : in     std_logic;
      cld_enable     : out    std_logic;
      cld_page       : out    std_logic_vector (31 downto 0);
      cld_trigger    : out    std_logic;
      conv_enable    : out    std_logic;
      conv_page      : out    std_logic_vector (31 downto 0);
      conv_trigger   : out    std_logic;
      fop_sample_num : out    std_logic_vector (22 downto 0);
      hsum_enable    : out    std_logic;
      hsum_page      : out    std_logic_vector (31 downto 0);
      hsum_trigger   : out    std_logic;
      ifft_loop_num  : out    std_logic_vector (5 downto 0);
      mcdataout      : out    std_logic_vector (31 downto 0);
      overlap_size   : out    std_logic_vector (9 downto 0)
   );
   end component;
   component reset_sync
   port (
      RST_N     : in     std_logic ;
      CLK       : in     std_logic ;
      RST_OUT_N : out    std_logic 
   );
   end component;
   component hsum
   generic (
      ddr_g           : natural range 1 to 3;      -- Number of DDR interfaces.
      summer_g        : natural range 1 to 3;      -- Number of SUMMER sub-blocks to instantiate.
      adder_latency_g : natural range 1 to 7;      -- Latency of IEEE-754 adder function.
      harmonic_g      : natural range 8 to 16      -- Max number of harmonics that may be processed (including fundamental).
   );
   port (
      -- Control inputs.
      hsum_page            : in     std_logic_vector (31 downto 0);        -- Offset for DDR address.
      hsum_trigger         : in     std_logic ;                            -- Triggers analysis run(s).
      hsum_enable          : in     std_logic ;                            -- Qualifies hsum_trigger and can also pause analysis run.
      -- Control outputs.
      hsum_done            : out    std_logic ;
      -- DDR Interface.
      wait_request         : in     std_logic ;
      data_valid           : in     std_logic ;
      ddr_data             : in     std_logic_vector (512*ddr_g-1 downto 0);
      ddr_addr             : out    std_logic_vector (31 downto 0);
      ddr_read             : out    std_logic ;
      -- Micro interface (Covnetics standard interface).
      mcaddr               : in     std_logic_vector (17 downto 0);
      mcdatain             : in     std_logic_vector (31 downto 0);
      mcrwn                : in     std_logic ;
      mcms                 : in     std_logic ;
      mcdataout            : out    std_logic_vector (31 downto 0);
      -- Clock and reset.
      clk_sys              : in     std_logic ;
      rst_sys_n            : in     std_logic ;
      clk_mc               : in     std_logic ;
      rst_mc_n             : in     std_logic
   );
   end component;
   component mci_top
   port (
      clk_mc            : in     std_logic ;
      ddr_1_cal_fail    : in     std_logic ;
      ddr_1_cal_pass    : in     std_logic ;
      ddr_2_cal_fail    : in     std_logic ;
      ddr_2_cal_pass    : in     std_logic ;
      mcaddr_pcif       : in     std_logic_vector (21 downto 0);
      mccs_pcif         : in     std_logic ;
      mcdatain_pcif     : in     std_logic_vector (31 downto 0);
      mcdataout_conv    : in     std_logic_vector (31 downto 0);
      mcdataout_ctrl    : in     std_logic_vector (31 downto 0);
      mcdataout_hsum    : in     std_logic_vector (31 downto 0);
      mcrwn_pcif        : in     std_logic ;
      product_id        : in     std_logic_vector (15 downto 0);
      resetn            : in     std_logic ;
      revision_number   : in     std_logic_vector (15 downto 0);
      rst_mc_n          : in     std_logic ;
      version_number    : in     std_logic_vector (15 downto 0);
      cld_resetn        : out    std_logic ;
      conv_resetn       : out    std_logic ;
      ctrl_resetn       : out    std_logic ;
      ddr_1_resetn      : out    std_logic ;
      ddrif_1_resetn    : out    std_logic ;
      ddrif_2_resetn    : out    std_logic ;
      ddrif_pcie_resetn : out    std_logic ;
      hsum_resetn       : out    std_logic ;
      mcdataout_pcif    : out    std_logic_vector (31 downto 0);
      mcms_conv         : out    std_logic ;
      mcms_ctrl         : out    std_logic ;
      mcms_hsum         : out    std_logic 
   );
   end component;
   component msi
   port (
      clk_pcie         : in     std_logic ;
      clk_sys          : in     std_logic ;
      rst_pcie_n       : in     std_logic ;
      rst_sys_n        : in     std_logic ;
      cld_done         : in     std_logic ;
      conv_done        : in     std_logic ;
      hsum_done        : in     std_logic ;
      msiintfc_o       : in     std_logic_vector (81 downto 0);
      txs_wait_request : in     std_logic ;
      txs_address      : out    std_logic_vector (63 downto 0);
      txs_write_data   : out    std_logic_vector (31 downto 0);
      txs_byte_enable  : out    std_logic_vector (3 downto 0);
      txs_write        : out    std_logic ;
      msicontrol_o     : in     std_logic_vector (15 downto 0)
   );
   end component;

   -- Optional embedded configurations
   -- pragma synthesis_off
   for all : cld use entity cld_lib.cld;
   for all : conv use entity conv_lib.conv;
   for all : ctrl use entity ctrl_lib.ctrl;
   for all : hsum use entity hsum_lib.hsum;
   for all : mci_top use entity mci_top_lib.mci_top;
   for all : msi use entity msi_lib.msi;
   for all : reset_sync use entity fdas_core_lib.reset_sync;
   -- pragma synthesis_on


begin
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 2 eb2
   -- eb2
   product_id_s <= std_logic_vector(to_unsigned(product_id_g,16));
   version_number_s <= std_logic_vector(to_unsigned(version_number_g,16));
   revision_number_s <= std_logic_vector(to_unsigned(revision_number_g,16));                                        


   -- Instance port mappings.
   cld_i : cld
      generic map (
         ddr_g                    => ddr_g,               --number of DDR Interfaces
         fft_ddr_addr_num_g       => 128,                 --Number of DDR locations to read for an FFT
         fop_ddr_addr_max_width_g => 18,                  --Number of counter bits to support the address for reading of the FOP from DDR memory
         fft_ddr_addr_num_width_g => 7,                   --Number of counter bits to support ddr_addr_num_g
         fft_g                    => fft_g,               --Number of samples in an FFT
         fft_count_width_g        => fft_abits_g,         --Number of counter bits  to support fft_g
         sample_count_width_g     => 22,                  --Number of counter bits to support fop_g
         fifo_waddr_width_g       => 9,                   --Number of counter bits to support write locations
         fifo_raddr_width_g       => 12                   --Number of counter bits to support read locations
      )
      port map (
         cld_enable => cld_enable_s,
         cld_page => cld_page_s,
         cld_trigger => cld_trigger_s,
         clk_sys => CLK_SYS,
         data_valid => ddr0_rd_valid,
         ddr_data => ddr0_rd_data,
         fop_sample_num => fop_sample_num_s,
         overlap_size => overlap_size_s,
         ready => conv_ready_s,
         rst_sys_n => rst_cld_sys_n_s,
         wait_request => ddr0_rd_waitreq,
         cld_done => cld_done_s,
         conv_data => conv_data_s,
         conv_req => conv_req_s,
         ddr_addr => ddr0_rd_addr,
         ddr_read => ddr0_rd_en,
         eof => conv_eof_s,
         fft_sample => fft_sample_s,
         sof => conv_sof_s,
         valid => conv_valid_s,
         overlap_int => (others => '0'),
         overlap_rem => (others => '0')
      );
   conv_i : conv
      generic map (
         ddr_g            => ddr_g,                    --number of external DDR interfaces
         ifft_g           => ifft_g,                   --number of ifft filter pairs
         ifft_loop_g      => ifft_loop_g,              --number of filter repeats
         ifft_loop_bits_g => ifft_loop_bits_g,         --filter repeat count bits
         fft_g            => fft_g,                    --FFT/IFFT points
         abits_g          => fft_abits_g,              --points count bits
         fop_num_bits_g   => 23                        --bits for freq bins processed
      )
      port map (
         CLK_MC        => CLK_MC,
         CLK_SYS       => CLK_SYS,
         CONV_ENABLE   => conv_enable_s,
         CONV_TRIGGER  => conv_trigger_s,
         EOF           => conv_eof_s,
         IDATA         => conv_data_s(63 downto 32),
         MCADDR        => mcaddr(19 downto 0),
         MCDATA        => mcdata,
         MCMS          => mcms_conv_s,
         MCRWN         => mcrwn,
         FOP_NUM       => fop_sample_num_s,
         OVERLAP_SIZE  => overlap_size_s,
         RDATA         => conv_data_s(31 downto 0),
         DDR_WAITREQ   => ddr1_wr_waitreq,
         RST_MC_N      => RST_MC_N,
         RST_SYS_N     => rst_conv_sys_n_s,
         SOF           => conv_sof_s,
         VALID         => conv_valid_s,
         DDR_ADDROUT   => ddr1_wr_addr,
         DDR_DATAOUT   => ddr1_wr_data,
         DDR_VALIDOUT  => ddr1_wr_en,
         MCDATAOUT     => mcdataout_conv_s,
         READYOUT      => conv_ready_s,
         IFFT_LOOP_NUM => ifft_loop_num_s(2 downto 0),
         SEGDONEOUT    => open,
         MCREADYOUT    => conv_fft_ready_s,
         CONV_DONEOUT  => conv_done_s,
         PAGE_START    => conv_page_s(31 downto 6)
      );
   ctrl_i : ctrl
      port map (
         cld_done       => cld_done_s,
         clk_mc         => CLK_MC,
         clk_sys        => CLK_SYS,
         conv_done      => conv_done_s,
         conv_fft_ready => conv_fft_ready_s,
         hsum_done      => hsum_done_s,
         mcaddr         => mcaddr(19 downto 0),
         mcdatain       => mcdata,
         mcms           => mcms_ctrl_s,
         mcrwn          => mcrwn,
         rst_mc_n       => RST_MC_N,
         rst_sys_n      => rst_ctrl_sys_n_s,
         cld_enable     => cld_enable_s,
         cld_page       => cld_page_s,
         cld_trigger    => cld_trigger_s,
         conv_enable    => conv_enable_s,
         conv_page      => conv_page_s,
         conv_trigger   => conv_trigger_s,
         fop_sample_num => fop_sample_num_s,
         hsum_enable    => hsum_enable_s,
         hsum_page      => hsum_page_s,
         hsum_trigger   => hsum_trigger_s,
         ifft_loop_num  => ifft_loop_num_s,
         mcdataout      => mcdataout_ctrl_s,
         overlap_size   => overlap_size_s
      );
   rst_cld_i : reset_sync
      port map (
         RST_N     => rst_cld_n_s,
         CLK       => CLK_SYS,
         RST_OUT_N => rst_cld_sys_n_s
      );
   rst_conv_i : reset_sync
      port map (
         RST_N     => rst_conv_n_s,
         CLK       => CLK_SYS,
         RST_OUT_N => rst_conv_sys_n_s
      );
   rst_ctrl_i : reset_sync
      port map (
         RST_N     => rst_ctrl_n_s,
         CLK       => CLK_SYS,
         RST_OUT_N => rst_ctrl_sys_n_s
      );
   rst_hsum_i : reset_sync
      port map (
         RST_N     => rst_hsum_n_s,
         CLK       => CLK_SYS,
         RST_OUT_N => rst_hsum_sys_n_s
      );
   hsum_i : hsum
      generic map (
         ddr_g           => ddr_g,             -- Number of DDR interfaces.
         summer_g        => summer_g,          -- Number of SUMMER sub-blocks to instantiate.
         adder_latency_g => 2,                 -- Latency of IEEE-754 adder function.
         harmonic_g      => harmonic_g         -- Max number of harmonics that may be processed (including fundamental).
      )
      port map (
         hsum_page => hsum_page_s,
         hsum_trigger => hsum_trigger_s,
         hsum_enable => hsum_enable_s,
         hsum_done => hsum_done_s,
         wait_request => ddr1_rd_waitreq,
         data_valid => ddr1_rd_valid,
         ddr_data => ddr1_rd_data,
         ddr_addr => ddr1_rd_addr,
         ddr_read => ddr1_rd_en,
         mcaddr => mcaddr(17 downto 0),
         mcdatain => mcdata,
         mcrwn => mcrwn,
         mcms => mcms_hsum_s,
         mcdataout => mcdataout_hsum_s,
         clk_sys => CLK_SYS,
         rst_sys_n => rst_hsum_sys_n_s,
         clk_mc => CLK_MC,
         rst_mc_n => RST_MC_N
      );
   mci_top_i : mci_top
      port map (
         clk_mc            => CLK_MC,
         ddr_1_cal_fail    => DDR_0_CAL_FAIL,
         ddr_1_cal_pass    => DDR_0_CAL_SUCESS,
         ddr_2_cal_fail    => DDR_1_CAL_FAIL,
         ddr_2_cal_pass    => DDR_1_CAL_SUCESS,
         mcaddr_pcif       => mcaddr,
         mccs_pcif         => mccs,
         mcdatain_pcif     => mcdata,
         mcdataout_conv    => mcdataout_conv_s,
         mcdataout_ctrl    => mcdataout_ctrl_s,
         mcdataout_hsum    => mcdataout_hsum_s,
         mcrwn_pcif        => mcrwn,
         product_id        => product_id_s,
         resetn            => RST_GLOBAL_N,
         revision_number   => revision_number_s,
         rst_mc_n          => RST_MC_N,
         version_number    => version_number_s,
         cld_resetn        => rst_cld_n_s,
         conv_resetn       => rst_conv_n_s,
         ctrl_resetn       => rst_ctrl_n_s,
         ddr_1_resetn      => ddr_rst_n,
         ddrif_1_resetn    => ddrif_0_resetn,
         ddrif_2_resetn    => ddrif_1_resetn,
         ddrif_pcie_resetn => ddrif_pcie_resetn,
         hsum_resetn       => rst_hsum_n_s,
         mcdataout_pcif    => mcdataout,
         mcms_conv         => mcms_conv_s,
         mcms_ctrl         => mcms_ctrl_s,
         mcms_hsum         => mcms_hsum_s
      );
   msi_i : msi
      port map (
         clk_pcie         => CLK_PCIE,
         clk_sys          => CLK_SYS,
         rst_pcie_n       => RST_PCIE_N,
         rst_sys_n        => rst_ctrl_sys_n_s,
         cld_done         => cld_done_s,
         conv_done        => conv_done_s,
         hsum_done        => hsum_done_s,
         msiintfc_o       => msiintfc_o,
         txs_wait_request => txs_wait_request,
         txs_address      => txs_address,
         txs_write_data   => txs_write_data,
         txs_byte_enable  => txs_byte_enable,
         txs_write        => txs_write,
         msicontrol_o     => msicontrol_o
      );

end scm;
