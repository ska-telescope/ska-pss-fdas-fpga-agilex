----------------------------------------------------------------------------
-- Module Name:  ddrif2_if_sel
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- Interface Selector 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  1/6/2017   Initial revision.
-- 0.2  RMD  3/7/2017   Corrected the priority selection for the interfaces
-- 0.3  RMD  5/9/2017   Renamed resetn to rst_ddr_n
-- 0.4  RMD  26/11/2018 Retimed the PCIE RD_DMA_WRITE and WR_DMA_READ on the 
--                      PCIe CLK and stretch to make safe transfer to DDR CLK
--                      since the PCIE Hard Macro outputs these signals from
--                      combo logic.
-- 0.5  RMD  08/06/2023 Stretch the System Read/Write commands on the system 
--                      so that they will be seen on the slower DDR clock
--                      even for a single access.
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

architecture synth of ddrif2_if_sel is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------

-- stretch_pcie process
signal rd_dma_write_rt_pcie_1_s      :       std_logic;
signal wr_dma_read_rt_pcie_1_s       :       std_logic;
signal rd_dma_write_stretch_s        :       std_logic;
signal wr_dma_read_stretch_s         :       std_logic;

-- stretch_sys process
signal ddr_wr_en_ret_s               :       std_logic; 
signal ddr_rd_en_ret_s               :       std_logic;
signal ddr_wr_en_stretch_s           :       std_logic;
signal ddr_rd_en_stretch_s           :       std_logic;

-- retime_enable process
signal rd_dma_write_rt_1_s           :       std_logic;
signal rd_dma_write_rt_2_s           :       std_logic;
signal wr_dma_read_rt_1_s            :       std_logic;
signal wr_dma_read_rt_2_s            :       std_logic;
signal ddr_wr_en_rt_1_s              :       std_logic;
signal ddr_wr_en_rt_2_s              :       std_logic;
signal ddr_rd_en_rt_1_s              :       std_logic;
signal ddr_rd_en_rt_2_s              :       std_logic;

-- select_enable process
signal pcie_proc_sel_s               :       std_logic;
signal read_write_sel_s              :       std_logic;


begin


------------------------------------------------------------------------------
-- Process: stretch_pcie
-- Sample the PCIe Read and Write signals on the PCIe clock and stretch
-- 
-----------------------------------------------------------------------------
stretch_pcie: process(clk_pcie, rst_pcie_n)
begin

  if rst_pcie_n  = '0' then
    rd_dma_write_rt_pcie_1_s <= '0';  
    wr_dma_read_rt_pcie_1_s <= '0'; 
    rd_dma_write_stretch_s <= '0';
    wr_dma_read_stretch_s <= '0';
  elsif rising_edge(clk_pcie) then
    
    -- retime  
    -- PCIe Write to DDR Interface 
    rd_dma_write_rt_pcie_1_s <= RD_DMA_WRITE;  
  
    -- PCIe Read from DDR Interface 
    wr_dma_read_rt_pcie_1_s <= WR_DMA_READ;  
   
    
  
    rd_dma_write_stretch_s <= RD_DMA_WRITE or rd_dma_write_rt_pcie_1_s;
    wr_dma_read_stretch_s <= WR_DMA_READ or wr_dma_read_rt_pcie_1_s; 
      
  end if;
end process stretch_pcie;    


------------------------------------------------------------------------------
-- Process: stretch_sys
-- Sample the System Read and Write signals on the system clock and stretch
-- 
-----------------------------------------------------------------------------
stretch_sys: process(clk_sys, rst_sys_n)
begin

  if rst_sys_n  = '0' then
    ddr_wr_en_ret_s <= '0';  
    ddr_rd_en_ret_s <= '0'; 
    ddr_wr_en_stretch_s <= '0';
    ddr_rd_en_stretch_s <= '0';
  elsif rising_edge(clk_sys) then
    
    -- retime  
    -- System Write to DDR Interface 
    ddr_wr_en_ret_s <= DDR_WR_EN;  
    
    -- System Read to DDR Interface
    ddr_rd_en_ret_s <= DDR_RD_EN;  
    
  
    ddr_wr_en_stretch_s <= DDR_WR_EN or ddr_wr_en_ret_s;
    ddr_rd_en_stretch_s <= DDR_RD_EN or ddr_rd_en_ret_s; 
      
  end if;
end process stretch_sys;    

------------------------------------------------------------------------------
-- Process: retime_enable
-- Retime the read or write enables onto the DDR clock
-- Ensure meta-stability protection due to clock domain crossing is performed
-----------------------------------------------------------------------------
retime_enable: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    rd_dma_write_rt_1_s <= '0';
    rd_dma_write_rt_2_s <= '0';  
    wr_dma_read_rt_1_s <= '0';
    wr_dma_read_rt_2_s <= '0';
    ddr_wr_en_rt_1_s <= '0';
    ddr_wr_en_rt_2_s <= '0';
    ddr_rd_en_rt_1_s <= '0';
    ddr_rd_en_rt_2_s <= '0';
   
    
  elsif rising_edge(clk_ddr) then
    
    -- retime  
    -- PCIe Write to DDR Interface 
    rd_dma_write_rt_1_s <= rd_dma_write_stretch_s;  
    rd_dma_write_rt_2_s <= rd_dma_write_rt_1_s; 
    
    
    -- PCIe Read from DDR Interface 
    wr_dma_read_rt_1_s <= wr_dma_read_stretch_s;  
    wr_dma_read_rt_2_s <= wr_dma_read_rt_1_s; 
     
 
    -- FDAS Core Write to DDR Interface 
    ddr_wr_en_rt_1_s <= ddr_wr_en_stretch_s;  
    ddr_wr_en_rt_2_s <= ddr_wr_en_rt_1_s; 
       
    
    -- FDAS Core Read from DDR Interface 
    ddr_rd_en_rt_1_s <= ddr_rd_en_stretch_s;  
    ddr_rd_en_rt_2_s <= ddr_rd_en_rt_1_s; 
    
      
  end if;
end process retime_enable;    
 

------------------------------------------------------------------------------
-- Process: select_enable
-- Select the active enable on a fixed priority
-- 
-----------------------------------------------------------------------------
select_enable: process(clk_ddr, rst_ddr_n)

begin

  if rst_ddr_n  = '0' then
    pcie_proc_sel_s <= '0';
    read_write_sel_s <= '0';
  elsif rising_edge(clk_ddr) then
  
    if ddr_wr_en_rt_2_s = '1'then -- Write by FDAS Processing Module (Lowest Priority)
      pcie_proc_sel_s <= '0';
      read_write_sel_s <= '1';
    end if;

    if ddr_rd_en_rt_2_s = '1' then -- Read by FDAS Processing Module
      pcie_proc_sel_s <= '0';
      read_write_sel_s <= '0';
    end if;

    if rd_dma_write_rt_2_s = '1' then -- Write by PCIe 
      pcie_proc_sel_s <= '1';
      read_write_sel_s <= '1';
    end if;

   if wr_dma_read_rt_2_s = '1' then  -- Read by PCIe (Highest Priority)
     pcie_proc_sel_s <= '1';
     read_write_sel_s <= '0';
   end if; 
  
   
  end if;
end process select_enable;    



-- Concurrent assignments
assign_pcie_proc_sel : PCIE_PROC_SEL <= pcie_proc_sel_s;
assign_read_write_sel : READ_WRITE_SEL <= read_write_sel_s;


end architecture synth;





