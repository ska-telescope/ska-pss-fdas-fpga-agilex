----------------------------------------------------------------------------
-- Module Name:  msixtxint
--
-- Source Path:  msix_lib/hdl/msixtxint_synth.vhd
--
-- Requirements Covered:
--
-- Functional Description: Module receives three asynchronous toggle signals from
-- msixpulsedet and pipelines each through its own metastability circuit to safely
-- transfer data between the clk_sys domain and clk_pcie domain. Each toggle is
-- then edge detected to determine when a new interrupt has occured.
--
-- When an interrupt is to be sent to the PCIe Hard IP Macro the usr_event_msix_valid
-- signal shall be asserted with the appropriate configured usr_event_msix_data[15:0] 
-- value for the interrupt source (i.e. CLD_DONE, CONV_DONE or HSUM_DONE). on the 
-- CLK_PCIE rising edge that both the usr_event_msix_valid and usr_event_msix_ready 
-- signals are asserted the usr_event_msix_data[15:0] shall be deemed to have been  
-- passed to the PCIe Hard Macro and the usr_event_msix_valid shall de-assert. 
-- If there is another interrupt to send (i.e. back-to-back interrupt) then
-- a cycle later the usr_event_msix_valid shall be re-asserted with new
--  usr_event_msix_data[15:0]
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD   21/04/2022  Initial revision.
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture synth of msixtxint is

  signal cld_toggle_meta_d          : std_logic_vector(2 downto 0);
  signal cld_edge_det_s             : std_logic;

  signal conv_toggle_meta_d         : std_logic_vector(2 downto 0);
  signal conv_edge_det_s            : std_logic;

  signal hsum_toggle_meta_d         : std_logic_vector(2 downto 0);
  signal hsum_edge_det_s            : std_logic;

  signal cld_output_s               : std_logic;
  signal conv_output_s              : std_logic;
  signal hsum_output_s              : std_logic;

  signal cld_ready_for_output_s     : std_logic;
  signal conv_ready_for_output_s    : std_logic; 
  signal hsum_ready_for_output_s    : std_logic;   
  
  signal usr_event_msix_valid_s     : std_logic; 
 
begin


  -- Meta-harden interrupt cld_toggle signal and also detect rising/falling edge of toggle.
  -- Only recognise the change of state of the cld_toggle signal if the CLD interrupt is 
  -- enabled by configuration. 
  -- Only clear down the detection of a cld_toggle state change if the usr_event_msix_data[15:0]
  -- for a CLD interrupt has been passed to the PCIe Hard IP Macro.
  cld_meta_harden_detect: process(clk_pcie, rst_pcie_n) is
  begin
    if rst_pcie_n = '0' then
      cld_toggle_meta_d <= (others => '0');
      cld_edge_det_s    <= '0';
    elsif rising_edge(clk_pcie) then
      cld_toggle_meta_d(0) <= cld_toggle;
      cld_toggle_meta_d(1) <= cld_toggle_meta_d(0);
      cld_toggle_meta_d(2) <= cld_toggle_meta_d(1);

      -- Detect rising/falling edge of cld_toggle if the CLD MSI-X Interrupt is enabled
      -- by configuration.  
      -- keep value of edge detect registered until the configured usr_event_msix_data[15:0]
      -- value for the CLD interrupt has been passed to the PCIe Hard IP Macro.
      if cld_toggle_meta_d(2) /= cld_toggle_meta_d(1) and cld_msix_en = '1' then
        cld_edge_det_s <= '1';
      elsif cld_edge_det_s = '1' and cld_output_s = '1' then
        cld_edge_det_s <= '0';
      end if;
    end if;
  end process cld_meta_harden_detect;

  -- Meta-harden interrupt conv_toggle signal and also detect rising/falling edge of toggle.
  -- Only recognise the change of state of the conv_toggle signal if the CONV interrupt is 
  -- enabled by configuration. 
  -- Only clear down the detection of a conv_toggle state change if the usr_event_msix_data[15:0]
  -- for a CONV interrupt has been passed to the PCIe Hard IP Macro.
  conv_meta_harden_detect: process(clk_pcie, rst_pcie_n) is
  begin
    if rst_pcie_n = '0' then
      conv_toggle_meta_d <= (others => '0');
      conv_edge_det_s    <= '0';
    elsif rising_edge(clk_pcie) then
      conv_toggle_meta_d(0) <= conv_toggle;
      conv_toggle_meta_d(1) <= conv_toggle_meta_d(0);
      conv_toggle_meta_d(2) <= conv_toggle_meta_d(1);

      -- Detect rising/falling edge of conv_toggle if the CONV MSI-X Interrupt is enabled
      -- by configuration.  
      -- keep value of edge detect registered until the configured usr_event_msix_data[15:0]
      -- value for the CONV interrupt has been passed to the PCIe Hard IP Macro.
      if conv_toggle_meta_d(2) /= conv_toggle_meta_d(1) and conv_msix_en = '1' then
        conv_edge_det_s <= '1';
      elsif conv_edge_det_s = '1' and conv_output_s = '1' then
        conv_edge_det_s <= '0';
      end if;
    end if;
  end process conv_meta_harden_detect;

  -- Meta-harden interrupt hsum_toggle signal and also detect rising/falling edge of toggle.
  -- Only recognise the change of state of the hsum_toggle signal if the HSUM interrupt is 
  -- enabled by configuration. 
  -- Only clear down the detection of a hsum_toggle state change if the usr_event_msix_data[15:0]
  -- for an HSUM interrupt has been passed to the PCIe Hard IP Macro.
  hsum_meta_harden_detect: process(clk_pcie, rst_pcie_n) is
  begin
    if rst_pcie_n = '0' then
      hsum_toggle_meta_d <= (others => '0');
      hsum_edge_det_s    <= '0';
    elsif rising_edge(clk_pcie) then
      hsum_toggle_meta_d(0) <= hsum_toggle;
      hsum_toggle_meta_d(1) <= hsum_toggle_meta_d(0);
      hsum_toggle_meta_d(2) <= hsum_toggle_meta_d(1);

      -- Detect rising/falling edge of conv_toggle if the HSUM MSI-X Interrupt is enabled
      -- by configuration.  
      -- keep value of edge detect registered until the configured usr_event_msix_data[15:0]
      -- value for the HSUM interrupt has been passed to the PCIe Hard IP Macro.
      if hsum_toggle_meta_d(2) /= hsum_toggle_meta_d(1) and hsum_msix_en = '1' then
        hsum_edge_det_s <= '1';
      elsif hsum_edge_det_s = '1' and hsum_output_s = '1' then
        hsum_edge_det_s <= '0';
      end if;
    end if;
  end process hsum_meta_harden_detect;

  -- select the usr_event_msix_data[15:0] to send to the PCIe Hard IP Macro
  -- and perform the transfer
  msix_data_gen: process(clk_pcie, rst_pcie_n) is
  begin
    if rst_pcie_n = '0' then
      cld_output_s  <= '0';
      conv_output_s <= '0';
      hsum_output_s <= '0';
      cld_ready_for_output_s <= '0';
      conv_ready_for_output_s <= '0';
      hsum_ready_for_output_s <= '0';
      usr_event_msix_valid_s <= '0';
    elsif rising_edge(clk_pcie) then
      cld_output_s  <= '0';
      conv_output_s <= '0';
      hsum_output_s <= '0';
    

      -- Assign appropriate usr_event_msix_data[15:0] value for the interrupt detected.
      -- and assert the usr_event_msix_valid signal
      -- If more than one MSI interrupt is present, interrupts will be output one
      -- after another
      if cld_edge_det_s = '1' and cld_output_s = '0' then
        usr_event_msix_data <= cld_msix_data;
        usr_event_msix_valid_s <= '1'; 
        cld_ready_for_output_s <= '1';
      elsif conv_edge_det_s = '1' and conv_output_s = '0' then
        usr_event_msix_data <= conv_msix_data;
        usr_event_msix_valid_s <= '1'; 
        conv_ready_for_output_s <= '1';
      elsif hsum_edge_det_s = '1' and hsum_output_s = '0' then
        usr_event_msix_data <= hsum_msix_data;
        usr_event_msix_valid_s <= '1'; 
        hsum_ready_for_output_s <= '1';
      end if;
      

      -- if the usr_event_msix_valid_s is asserted indicating that new
      -- usr_event_msix_data is available for the PCIe Hard Macro and 
      -- the PCIe Hard IP Macro has asserted the usr_event_msix_ready
      -- then the usr_event_msix_data can be assumed to have been passed to
      -- the PCIe Hard IP Macro
      if usr_event_msix_valid_s = '1' and usr_event_msix_ready = '1' then
        usr_event_msix_valid_s <= '0';  -- clear the valid signal as the transfer has occured
        if cld_ready_for_output_s = '1' then
          cld_ready_for_output_s <= '0';          
          cld_output_s  <= '1';  -- pulses for one cycle         
        end if;        
        if conv_ready_for_output_s = '1' then
          conv_ready_for_output_s <= '0';
          conv_output_s  <= '1';  -- pulses for one cycle          
        end if;   
        if hsum_ready_for_output_s = '1' then
          hsum_ready_for_output_s <= '0';
          hsum_output_s  <= '1';  -- pulses for one cycle
        end if;         
      end if;
    end if;     
  end process msix_data_gen;

 

  -- concurrent assignments.
  valid_out: usr_event_msix_valid <= usr_event_msix_valid_s;

end architecture synth;

