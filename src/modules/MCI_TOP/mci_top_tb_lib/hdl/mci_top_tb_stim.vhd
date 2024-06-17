----------------------------------------------------------------------------
-- Module Name:  MCI_TOP Test Bench
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the MCI_TOP Module
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  11/09/2017   Initial revision.
-- 0.2  RMD  15/09/2017   Added  ANDing of individual MC configurable resets
--                        with the main system reset
-- 0.3  RMD  03/11/2017   Address width reduced to 22 bits
-- 0.4  RMD  06/05/2022   Added MSIX Module MCI Support and DDR Controller Reset Done
-- 0.5  RMD  06/06/2023   Updated for extra reset signals and inverting the reset sense
--                        This was done in PI18, but was accidentally overwritten in
--                        SVN. Hence it is now being re-released to SVN
---------------------------------------------------------------------------
--       __
--    ,/'__`\                             _     _
--   ,/ /  )_)   _   _   _   ___     __  | |__ (_)   __    ___
--   ( (    _  /' `\\ \ / //' _ `\ /'__`\|  __)| | /'__`)/',__)
--   '\ \__) )( (_) )\ ' / | ( ) |(  ___/| |_, | |( (___ \__, \
--    '\___,/  \___/  \_/  (_) (_)`\____)(___,)(_)`\___,)(____/
--
-- Copyright (c) Covnetics Limited 2024 All Rights Reserved. The information
-- contained herein remains the property of Covnetics Limited and may not be
-- copied or reproduced in any format or medium without the written consent
-- of Covnetics Limited.
--
----------------------------------------------------------------------------






library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;
use std.textio.all;
library mci_top_lib;
use mci_top_lib.mci_top;


architecture stim of mci_top_tb is
  -- Define clock period.
  constant ck_mc_per_c    : time := 5 ns; -- 200MHz clock

  -- Signal declarations.
  
  -- MCI_TOP Module PCIF Interface
  signal mcaddr_pcif_s                   : std_logic_vector(21 downto 0);
  signal mcdatain_pcif_s 		             : std_logic_vector(31 downto 0);
  signal mcrwn_pcif_s    		             : std_logic;
  signal mccs_pcif_s 		                 : std_logic; 
  signal mcdataout_pcif_s 		           : std_logic_vector(31 downto 0);
  
  
  -- MCI_TOP Module CTRL/CONV/HSUM Select
  signal mcms_ctrl_s                     : std_logic;
  signal mcms_conv_s                     : std_logic;
  signal mcms_hsum_s                     : std_logic;
  signal mcms_msix_s                    : std_logic;
  
  -- MCI_TOP Module Resets
  signal resetn_s                        : std_logic;
  signal ctrl_resetn_s                   : std_logic;
  signal cld_resetn_s                    : std_logic;
  signal conv_resetn_s                   : std_logic;
  signal hsum_resetn_s                   : std_logic;
  signal msix_resetn_s                   : std_logic;
  signal ddrif_0_resetn_s                : std_logic; 
  signal ddrif_1_resetn_s                : std_logic; 
  signal ddrif_2_resetn_s                : std_logic; 
  signal ddrif_3_resetn_s                : std_logic;   
  signal ddr_0_resetn_s                  : std_logic; 
  signal ddr_1_resetn_s                  : std_logic;   
  signal ddr_2_resetn_s                  : std_logic; 
  signal ddr_3_resetn_s                  : std_logic; 
  signal ddr_0_reset_done_s              : std_logic; 
  signal ddr_1_reset_done_s              : std_logic;   
  signal ddr_2_reset_done_s              : std_logic; 
  signal ddr_3_reset_done_s              : std_logic;       
  signal ddrif_pcie_resetn_s             : std_logic;   
  
  -- MCI_TOP Module Inventory
  signal product_id_s                    : std_logic_vector(15 downto 0);
  signal core_version_s                  : std_logic_vector(15 downto 0);
  signal core_revision_s                 : std_logic_vector(15 downto 0); 
  signal top_version_s                   : std_logic_vector(15 downto 0);
  signal top_revision_s                  : std_logic_vector(15 downto 0);   
  
  -- MCI_TOP DDR Pass/Fail
  signal ddr_0_cal_fail_s                : std_logic; 
  signal ddr_0_cal_pass_s                : std_logic;   
  signal ddr_1_cal_fail_s                : std_logic; 
  signal ddr_1_cal_pass_s                : std_logic; 
  signal ddr_2_cal_fail_s                : std_logic;   
  signal ddr_2_cal_pass_s                : std_logic; 
  signal ddr_3_cal_fail_s                : std_logic;   
  signal ddr_3_cal_pass_s                : std_logic;     
  
  -- MCI_TOP Data from CTRL, CONV, HSUM
  signal mcdataout_ctrl_s                : std_logic_vector(31 downto 0);
  signal mcdataout_conv_s                : std_logic_vector(31 downto 0);
  signal mcdataout_hsum_s                : std_logic_vector(31 downto 0);
  signal mcdataout_msix_s                : std_logic_vector(31 downto 0);
  
  -- Process : mcms_det
  signal mcms_ctrl_ret_1_s               : std_logic; 
  signal mcms_conv_ret_1_s               : std_logic; 
  signal mcms_hsum_ret_1_s               : std_logic; 
  signal mcms_msix_ret_1_s                : std_logic; 
  signal mcms_chk_ret_1_s                : std_logic; 
  signal mcms_ctrl_det_s                 : std_logic; 
  signal mcms_conv_det_s                 : std_logic; 
  signal mcms_hsum_det_s                 : std_logic; 
  signal mcms_msix_det_s                 : std_logic; 
 
  -- Test bench 
  signal mcms_chk_s                      : std_logic;
  
  --process: clk_gen
  signal clk_mc_s 		                   : std_logic;
  signal rst_mc_n_s                      : std_logic;
 
  
  
  
  -- general
  signal test_finished                   : boolean := false;
  
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  -- Component Declarations
  component mci_top
  PORT( 
      clk_mc            : in     std_logic;
      ddr_1_cal_fail    : in     std_logic;
      ddr_1_cal_pass    : in     std_logic;
      ddr_2_cal_fail    : in     std_logic;
      ddr_2_cal_pass    : in     std_logic;
      mcaddr_pcif       : in     std_logic_vector (21 downto 0);
      mccs_pcif         : in     std_logic;
      mcdatain_pcif     : in     std_logic_vector (31 downto 0);
      mcdataout_conv    : in     std_logic_vector (31 downto 0);
      mcdataout_ctrl    : in     std_logic_vector (31 downto 0);
      mcdataout_hsum    : in     std_logic_vector (31 downto 0);
      mcrwn_pcif        : in     std_logic;
      product_id        : in     std_logic_vector (15 downto 0);
      resetn            : in     std_logic;
      rst_mc_n          : in     std_logic;
      core_revision     : in     std_logic_vector (15 downto 0);
      core_version      : in     std_logic_vector (15 downto 0);
      top_revision      : in     std_logic_vector (15 downto 0);
      top_version       : in     std_logic_vector (15 downto 0);
      cld_resetn        : out    std_logic;
      conv_resetn       : out    std_logic;
      ctrl_resetn       : out    std_logic;
      ddr_1_resetn      : out    std_logic;
      ddrif_1_resetn    : out    std_logic;
      ddrif_2_resetn    : out    std_logic;
      ddrif_pcie_resetn : out    std_logic;
      hsum_resetn       : out    std_logic;
      mcdataout_pcif    : out    std_logic_vector (31 downto 0);
      mcms_conv         : out    std_logic;
      mcms_ctrl         : out    std_logic;
      mcms_hsum         : out    std_logic;
      mcms_msix         : out    std_logic;
      ddr_1_reset_done  : in     std_logic;
      ddr_2_reset_done  : in     std_logic;
      mcdataout_msix    : in     std_logic_vector (31 downto 0);
      ddr_2_resetn      : out    std_logic;
      msix_resetn       : out    std_logic;
      
      ddr_0_cal_fail    : in     std_logic;
      ddr_0_cal_pass    : in     std_logic;
      ddr_3_cal_fail    : in     std_logic;
      ddr_3_cal_pass    : in     std_logic;
      ddr_0_reset_done  : in     std_logic;
      ddr_3_reset_done  : in     std_logic;
      ddr_3_resetn      : out    std_logic;
      ddr_0_resetn      : out    std_logic;
      ddrif_3_resetn    : out    std_logic;
      ddrif_0_resetn    : out    std_logic  
      
  ); 
  end component;

  begin
    -- Instance port mappings.
    mci_top_i : mci_top
      port map (
        clk_mc             =>     clk_mc_s,
        ddr_1_cal_fail     =>     ddr_1_cal_fail_s,
        ddr_1_cal_pass     =>     ddr_1_cal_pass_s,
        ddr_2_cal_fail     =>     ddr_2_cal_fail_s,
        ddr_2_cal_pass     =>     ddr_2_cal_pass_s,
        mcaddr_pcif        =>     mcaddr_pcif_s,
        mccs_pcif          =>     mccs_pcif_s,
        mcdatain_pcif      =>     mcdatain_pcif_s,
        mcdataout_conv     =>     mcdataout_conv_s,
        mcdataout_ctrl     =>     mcdataout_ctrl_s,
        mcdataout_hsum     =>     mcdataout_hsum_s,
        mcrwn_pcif         =>     mcrwn_pcif_s,
        product_id         =>     product_id_s,
        resetn             =>     resetn_s,
        rst_mc_n           =>     rst_mc_n_s,
        core_revision      =>     core_revision_s,
        core_version       =>     core_version_s,
        top_revision       =>     top_revision_s,
        top_version        =>     top_version_s,
        cld_resetn         =>     cld_resetn_s,
        conv_resetn        =>     conv_resetn_s,
        ctrl_resetn        =>     ctrl_resetn_s,
        ddr_1_resetn       =>     ddr_1_resetn_s,
        ddrif_1_resetn     =>     ddrif_1_resetn_s,
        ddrif_2_resetn     =>     ddrif_2_resetn_s,
        ddrif_pcie_resetn  =>     ddrif_pcie_resetn_s,
        hsum_resetn        =>     hsum_resetn_s,
        mcdataout_pcif     =>     mcdataout_pcif_s,
        mcms_conv          =>     mcms_conv_s,
        mcms_ctrl          =>     mcms_ctrl_s,
        mcms_hsum          =>     mcms_hsum_s, 
        mcms_msix          =>     mcms_msix_s,
        ddr_1_reset_done   =>     ddr_1_reset_done_s,
        ddr_2_reset_done   =>     ddr_2_reset_done_s,
        mcdataout_msix     =>     mcdataout_msix_s,
        ddr_2_resetn       =>     ddr_2_resetn_s,
        msix_resetn        =>     msix_resetn_s,     
        ddr_0_cal_fail     =>     ddr_0_cal_fail_s,  
        ddr_0_cal_pass     =>     ddr_0_cal_pass_s,  
        ddr_3_cal_fail     =>     ddr_3_cal_fail_s,  
        ddr_3_cal_pass     =>     ddr_3_cal_pass_s,  
        ddr_0_reset_done   =>     ddr_0_reset_done_s,
        ddr_3_reset_done   =>     ddr_3_reset_done_s,
        ddr_3_resetn       =>     ddr_3_resetn_s,    
        ddr_0_resetn       =>     ddr_0_resetn_s,    
        ddrif_3_resetn     =>     ddrif_3_resetn_s,  
        ddrif_0_resetn     =>     ddrif_0_resetn_s           
        
        
        
     );

 
------------------------------------------------------------------------------
-- PROCESS : clkgen1
-- FUNCTION: Generates clk_sys. Main system clock
------------------------------------------------------------------------------
clkgen1 : process
begin
  while not test_finished loop
    clk_mc_s <= '0', '1' after ck_mc_per_c/2;
    wait for ck_mc_per_c;
  end loop;
  wait;
end process clkgen1;


------------------------------------------------------------------------------
-- Process: mcms_det
-- Detect MCMS
--
-----------------------------------------------------------------------------
mcms_det: process(clk_mc_s, rst_mc_n_s)
begin

  if rst_mc_n_s  = '0' then
    mcms_ctrl_ret_1_s <= '0';
    mcms_conv_ret_1_s <= '0';
    mcms_hsum_ret_1_s <= '0';
    mcms_msix_ret_1_s <= '0';
    mcms_chk_ret_1_s <= '0';
    mcms_ctrl_det_s <= '0';
    mcms_conv_det_s <= '0';
    mcms_hsum_det_s <= '0';  
    mcms_msix_det_s <= '0';
    mcdataout_ctrl_s     <= (others => '0');           
    mcdataout_conv_s     <= (others => '0');
    mcdataout_hsum_s     <= (others => '0');  
    mcdataout_msix_s     <= (others => '0');  
  elsif rising_edge(clk_mc_s) then
  
    -- default
    mcdataout_ctrl_s     <= (others => '0');           
    mcdataout_conv_s     <= (others => '0');
    mcdataout_hsum_s     <= (others => '0'); 
    mcdataout_msix_s     <= (others => '0'); 
  
    mcms_chk_ret_1_s <= mcms_chk_s;
    
    if mcms_chk_s = '1' and  mcms_chk_ret_1_s = '0' then
      mcms_ctrl_det_s <= '0';
      mcms_conv_det_s <= '0';
      mcms_hsum_det_s <= '0'; 
      mcms_msix_det_s <= '0'; 
    end if;
     
    mcms_ctrl_ret_1_s <= mcms_ctrl_s;
    mcms_conv_ret_1_s <= mcms_conv_s;
    mcms_hsum_ret_1_s <= mcms_hsum_s;
    mcms_msix_ret_1_s <= mcms_msix_s;
     
    if mcms_ctrl_s = '1' and mcms_ctrl_ret_1_s = '0' then
      mcms_ctrl_det_s <= '1';
    end if;
    
    if mcms_conv_s = '1' and mcms_conv_ret_1_s = '0' then
      mcms_conv_det_s <= '1';
    end if;   
    
    if mcms_hsum_s = '1' and mcms_hsum_ret_1_s = '0' then
      mcms_hsum_det_s <= '1';
    end if;     

    if mcms_msix_s = '1' and mcms_msix_ret_1_s = '0' then
      mcms_msix_det_s <= '1';
    end if;      
    
    if mcms_ctrl_s = '1' then 
      mcdataout_ctrl_s     <= "11110001111000101101001111000100";  -- 0xF1E2D3C4  
    end if;

    if mcms_conv_s = '1' then 
      mcdataout_conv_s     <= "10110101101001101001011110001000"; -- 0xB5A69788
    end if;

    if mcms_hsum_s = '1' then 
      mcdataout_hsum_s     <= "01111001011010100101101101001100"; -- 0x796A5B4C
    end if;
    
    if mcms_msix_s = '1' then 
      mcdataout_msix_s     <= "00111101001011100001111100000000"; -- 0x3D2E1F00
    end if;    
    
    
    if mcms_ctrl_ret_1_s = '1' then
      if mcdataout_pcif_s /= "11110001111000101101001111000100" then
        testbench_passed_v := false;
	   end if;	
	end if;
	  
    if mcms_conv_ret_1_s = '1' then
      if mcdataout_pcif_s /= "10110101101001101001011110001000" then
        testbench_passed_v := false;
	  end if;	
	end if;	  

    if mcms_hsum_ret_1_s = '1' then
      if mcdataout_pcif_s /= "01111001011010100101101101001100" then
        testbench_passed_v := false;
	  end if;	
	end if;	  
	  
    if mcms_msix_ret_1_s = '1' then
      if mcdataout_pcif_s /= "00111101001011100001111100000000" then
        testbench_passed_v := false;
	  end if;	
	end if;	  	  
    
  end if;
end process mcms_det;





------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- PROCESS : stimgen
-- FUNCTION: Main test process.
------------------------------------------------------------------------------
stimgen : process


  -- stimgen variables.
    variable  test_1_v      : std_logic;
    variable  test_2_v      : std_logic;
    variable  test_3_v      : std_logic;
    variable  test_4_v      : std_logic;
    variable  test_5_v      : std_logic;    
    variable  outline_v 	  : line;
    variable  readdata_v 	: std_logic_vector(31 downto 0);
    
  
--------------------------------------------------------------------------------
-------------------------- PROCEDURES ------------------------------------------
--------------------------------------------------------------------------------
  -- 1) Procedure to perform micro write.
  procedure mcwrite(address : std_logic_vector(21 downto 0);
                    data    : std_logic_vector(31 downto 0) ) is
  begin
    mcaddr_pcif_s <=  address;
    mcdatain_pcif_s <= data;
    mcrwn_pcif_s <= '0';
    mccs_pcif_s  <= '1';
    wait for ck_mc_per_c*4;
    mccs_pcif_s <= '0';
    wait for ck_mc_per_c;
  end procedure mcwrite;

  
  -- 2) Procedure to perform micro write.
  procedure mcwrite(address : std_logic_vector(21 downto 0);
                    data    : natural) is
  begin
    mcwrite(address, std_logic_vector(to_unsigned(data, 32)));
  end procedure mcwrite;

  
  -- 3) Procedure to perform micro read, and optionally check read data.
  procedure mcread(address : std_logic_vector(21 downto 0);
                   readdata_v: out std_logic_vector(31 downto 0);
                   exp_data: std_logic_vector(31 downto 0) := (others => '-')
                  ) is
  begin
    mcaddr_pcif_s <=  address;
    mcrwn_pcif_s <= '1';
    mccs_pcif_s  <= '1';
    wait for ck_mc_per_c*4;
    mccs_pcif_s  <= '0';
    wait for ck_mc_per_c;
    readdata_v := mcdataout_pcif_s;
    for i in mcdataout_pcif_s'range loop
      if exp_data(i) = '-' then
        next;
      end if;
      if exp_data(i) /= mcdataout_pcif_s(i) then
        testbench_passed_v := false;
        write(outline_v, string'("Micro read incorrect:"));
        write(outline_v, string'("expected "));
        hwrite(outline_v, exp_data);
        write(outline_v, string'(", got "));
        hwrite(outline_v, mcdataout_pcif_s);
        writeline(OUTPUT,outline_v);
        assert false
          severity error;
        exit;
      end if;
    end loop;
  end procedure mcread;

  
  -- 4) Procedure to perform micro read and check read data (integer argument).
  procedure mcread(address : std_logic_vector(21 downto 0);
                   exp_data: natural
                  ) is
    variable readdata_v : std_logic_vector(31 downto 0);
  begin
    mcread(address, readdata_v, std_logic_vector(to_unsigned(exp_data, 32)));
  end procedure mcread;


  -- 5) Procedure to output a string.
  procedure puts(msg : string) is
  begin
    write(outline_v, msg);
    writeline(output,outline_v);
  end procedure puts;

  
  -- 6) Procedure to generate a heading.
  procedure heading (title : string) is
  begin
    writeline(output,outline_v);
    puts("-------------------------------------------------");
    puts("-- " & title);
    puts("-------------------------------------------------");
  end procedure heading;

  
  -- 3)Procedure to run for a period of time.
  procedure run (clocks : natural) is
  begin
    wait for ck_mc_per_c * clocks;
  end procedure run;

  
 

begin

  heading("Initialisation.");
  -- Initialise signals.
  
  -- Signal declarations.
 
  
  -- FDAS interface
  product_id_s         <= "1111111011011100";  -- 0xFEDC
  core_version_s       <= "1011101010011000"; -- 0xBA98
  core_revision_s      <= "0111011001010100"; -- 0x7654
  top_version_s        <= "0011001000010000"; -- 0x3210
  top_revision_s       <= "1010101111001101"; -- 0xABCB 
  ddr_0_cal_fail_s     <= '0';
  ddr_0_cal_pass_s     <= '0';
  ddr_1_cal_fail_s     <= '0';
  ddr_1_cal_pass_s     <= '0';
  ddr_2_cal_fail_s     <= '0';
  ddr_2_cal_pass_s     <= '0';
  ddr_3_cal_fail_s     <= '0';
  ddr_3_cal_pass_s     <= '0';  
  ddr_0_reset_done_s   <= '0';
  ddr_1_reset_done_s   <= '0';
  ddr_2_reset_done_s   <= '0';   
  ddr_3_reset_done_s   <= '0';   
  resetn_s             <= '1';

  
  -- Test bench
  rst_mc_n_s 	                  <= '0';  
  run(2); 
  rst_mc_n_s 	                  <= '1'; 

  mcms_chk_s                    <= '0';
  
  
  
  -- Ensure bitmap is initialised
	mcwrite("0000000000000000010000", 0);  -- Module Resets
	
  mcread("0000000000000000000000", readdata_v); -- Product ID
  if readdata_v(15 downto 0) /= "1111111011011100" then
    testbench_passed_v := false;
	  puts("Product ID is not correct");
	end if;		
	
  mcread("0000000000000000000001", readdata_v); -- Core Version Number
  if readdata_v(15 downto 0) /= "1011101010011000" then
    testbench_passed_v := false;
	  puts("Core Version Number is not correct");
	end if;		
	
  mcread("0000000000000000000010", readdata_v); -- Core Revision Number
  if readdata_v(15 downto 0) /= "0111011001010100" then
    testbench_passed_v := false;
	  puts("Core Revision Number is not correct");
	end if;			
	
  mcread("0000000000000000000011", readdata_v); -- Top Version Number
  if readdata_v(15 downto 0) /= "0011001000010000" then
    testbench_passed_v := false;
	  puts("Top Version Number is not correct");
	end if;		
	
  mcread("0000000000000000000100", readdata_v); -- Top Revision Number
  if readdata_v(15 downto 0) /= "1010101111001101" then
    testbench_passed_v := false;
	  puts("Top Revision Number is not correct");
	end if;				
	
	
	
  mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail and Reset Done
  if readdata_v(3 downto 0) /= "0000" then
    testbench_passed_v := false;
	  puts("DDR Controller Pass/Fail is not correct");
	end if;			
	

  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
----------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.MCI_TOP.DM.01: Check MCI Access to the MCI Configured Resets and DDR Pass/Fail Readback                                           ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.MCI_TOP.DM.01: Check MCI Access to the MCI Configured Resets and DDR Pass/Fail Readabck");
  
  mcwrite("0000000000000000010000", 1); -- CTRL Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32)) then
    testbench_passed_v := false;
	  puts("CTRL_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '1' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("CTRL_RESET is 0");	
	end if;
	
  mcwrite("0000000000000000010000", 2); -- CLD Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2,32)) then
    testbench_passed_v := false;
	  puts("CLD_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '1' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("CLD_RESET is 0");	
	end if;	
	

  mcwrite("0000000000000000010000", 4); -- CONV Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(4,32)) then
    testbench_passed_v := false;
	  puts("CONV_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '1' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("CONV_RESET is 0");	
	end if;	


  mcwrite("0000000000000000010000", 8); -- HSUM Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(8,32)) then
    testbench_passed_v := false;
	  puts("HSUM_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '1' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("HSUM_RESET is 0");	
	end if;	

	
  mcwrite("0000000000000000010000", 16); -- DDRIF_0 Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(16,32)) then
    testbench_passed_v := false;
	  puts("DDRIF_0_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '1' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("DDRIF_1_RESET is 0");	
	end if;	

	
 mcwrite("0000000000000000010000", 32); -- DDRIF_1 Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(32,32)) then
    testbench_passed_v := false;
	  puts("DDRIF_1_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '1' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("DDRIF_2_RESET is 0");	
	end if;	


  mcwrite("0000000000000000010000", 64); -- DDRIF_2 Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(64,32)) then
    testbench_passed_v := false;
	  puts("DDRIF_2_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '1' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("DDRIF_PCIE_RESETN is 0");	
	end if;	


  mcwrite("0000000000000000010000", 128); -- DDRIF_3 Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(128,32)) then
    testbench_passed_v := false;
	  puts("DDRIF_3_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '1' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
    testbench_passed_v := false;
	  puts("DDR_1_RESET is 0");	
	end if;
	
	
  mcwrite("0000000000000000010000", 256); -- DDRIF_PCIE Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(256,32)) then
    testbench_passed_v := false;
	  puts("DDRIF_PCIE_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '1' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("DDR_2_RESET is 0");	
	end if;	
	

  mcwrite("0000000000000000010000", 512); -- DDR_0_RESET Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(512,32)) then
    testbench_passed_v := false;
	  puts("DDR_0_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '1' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("DDR_2_RESET is 0");	
	end if;		
	

  mcwrite("0000000000000000010000", 1024); -- DDR_1_RESET Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(1024,32)) then
    testbench_passed_v := false;
	  puts("DDR_1_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '1' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("DDR_2_RESET is 0");	
	end if;			
	
	
  mcwrite("0000000000000000010000", 2048); -- DDR_2_RESET Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(2048,32)) then
    testbench_passed_v := false;
	  puts("DDR_2_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '1' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("DDR_2_RESET is 0");	
	end if;				
	
	
  mcwrite("0000000000000000010000", 4096); -- DDR_3_RESET Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(4096,32)) then
    testbench_passed_v := false;
	  puts("DDR_3_RESET readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '1' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("DDR_2_RESET is 0");	
	end if;				
	
		
  mcwrite("0000000000000000010000", 8192); --MSIX Reset
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(8192,32)) then
    testbench_passed_v := false;
	  puts("MSIX readback is 0");
	end if;	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0'or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '1' then
      testbench_passed_v := false;
	  puts("MSIX is 0");	
	end if;		
	
	
	
	mcwrite("0000000000000000010000", 0); -- Return resets to 0

	ddr_0_cal_fail_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000000001" then
      testbench_passed_v := false;
	  puts("DDR Controller 0 Fail is not correct");
	end if;		

	ddr_0_cal_fail_s <= '0';
	ddr_0_cal_pass_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000000010" then
      testbench_passed_v := false;
	  puts("DDR Controller 0 Pass is not correct");
	end if;		
	
	ddr_0_cal_pass_s <= '0';		
	ddr_1_cal_fail_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000000100" then
      testbench_passed_v := false;
	  puts("DDR Controller 1 Fail is not correct");
	end if;	

	ddr_1_cal_fail_s <= '0';
	ddr_1_cal_pass_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000001000" then
      testbench_passed_v := false;
	  puts("DDR Controller 1 Pass is not correct");
	end if;	

	ddr_1_cal_pass_s <= '0';
	ddr_2_cal_fail_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000010000" then
      testbench_passed_v := false;
	  puts("DDR Controller 2 Fail is not correct");
	end if;	

	ddr_2_cal_fail_s <= '0';
	ddr_2_cal_pass_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000000100000" then
      testbench_passed_v := false;
	  puts("DDR Controller 2 Pass is not correct");
	end if;	
	
	ddr_2_cal_pass_s <= '0';
	ddr_3_cal_fail_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000001000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 3 Fail is not correct");
	end if;	

	ddr_3_cal_fail_s <= '0';
	ddr_3_cal_pass_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Pass/Fail
    if readdata_v(11 downto 0) /= "000010000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 3 Pass is not correct");
	end if;	
	
	ddr_3_cal_pass_s <= '0';
	ddr_0_reset_done_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Reset Done
    if readdata_v(11 downto 0) /= "000100000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 0 Reset Done is not correct");
	end if;		

	ddr_0_reset_done_s <= '0';
	ddr_1_reset_done_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Reset Done
    if readdata_v(11 downto 0) /= "001000000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 1 Reset Done is not correct");
	end if;			
	
	ddr_1_reset_done_s <= '0';
	ddr_2_reset_done_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Reset Done
    if readdata_v(11 downto 0) /= "010000000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 2 Reset Done is not correct");
	end if;		

	ddr_2_reset_done_s <= '0';
	ddr_3_reset_done_s <= '1';
	mcread("0000000000000000010001", readdata_v); -- DDR Controller Reset Done
    if readdata_v(11 downto 0) /= "100000000000" then
      testbench_passed_v := false;
	  puts("DDR Controller 3 Reset Done is not correct");
	end if;			
	
	ddr_3_reset_done_s <= '0';
  
  run(100);
 
end if;

 
---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.MCI_TOP.DM.02: Check MCMS enables to CTRL, CONV, HSUM and MSIX                                                                         ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 2: TC.MCI_TOP.DM.02: Check MCMS enables to CTRL, CONV, HSUM and MSIX");
  
  
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';
  
	
  mcwrite("0100000000000000000000", 0);	-- CTRL Lower Memory space
  if  mcms_ctrl_det_s = '0' or mcms_msix_det_s = '1' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("CTRL Module not selected");
  end if;
	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';	
	
  mcwrite("0101111111111111111111", 0);	-- CTRL Upper Memory space
  if  mcms_ctrl_det_s = '0' or mcms_msix_det_s = '1' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("CTRL Module not selected");
  end if;	

  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';	

  mcwrite("0110000000000000000000", 0);	-- MSIX Lower Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '0' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("MSIX Module not selected");
  end if;
	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';	
	
  mcwrite("0110000000000000001111", 0);	-- MSIX Upper Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '0' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("MSIX Module not selected");
  end if;	  
  	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';
  
	
  mcwrite("1000000000000000000000", 0);	-- CONV Lower Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '1' or mcms_conv_det_s = '0' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("CONV Module not selected");
  end if;
	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';	
	
  mcwrite("1011111111111111111111", 0);	-- CONV Upper Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '1' or mcms_conv_det_s = '0' or mcms_hsum_det_s = '1' then
    testbench_passed_v := false;
	puts("CONV Module not selected");
  end if;		
	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';
  
	
  mcwrite("1100000000000000000000", 0);	-- HSUM Lower Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '1' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '0' then
    testbench_passed_v := false;
	puts("HSUM Module not selected");
  end if;
	
  mcms_chk_s <= '1';
  run(2);
  mcms_chk_s <= '0';	
	
  mcwrite("1100111111111111111111", 0);	-- HSUM Upper Memory space
  if  mcms_ctrl_det_s = '1' or mcms_msix_det_s = '1' or mcms_conv_det_s = '1' or mcms_hsum_det_s = '0' then
    testbench_passed_v := false;
	puts("HSUM Module not selected");
 end if;		


  run(100);  
  
  
  
end if;  



---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.MCI_TOP.DM.03: Check Main System Reset                                                                                            ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.MCI_TOP.DM.03: Check Main System Reset");
  
  mcwrite("0000000000000000010000", 0); -- Disable all MC Configured resets
  mcread("0000000000000000010000", readdata_v);
  if readdata_v(31 downto 0) /= STD_LOGIC_VECTOR(TO_UNSIGNED(0,32)) then
    testbench_passed_v := false;
	  puts("Module RESET readback is not all 0's");
	end if;	
	
	if ctrl_resetn_s = '0' or cld_resetn_s = '0' or conv_resetn_s = '0' or hsum_resetn_s = '0' or 
	   ddrif_0_resetn_s = '0' or ddrif_1_resetn_s = '0' or ddrif_2_resetn_s = '0' or ddrif_3_resetn_s = '0' or
	   ddrif_pcie_resetn_s = '0' or ddr_0_resetn_s = '0' or ddr_1_resetn_s = '0' or ddr_2_resetn_s = '0' or
	   ddr_3_resetn_s = '0' or msix_resetn_s = '0' then
      testbench_passed_v := false;
	  puts("Module resets are not logic '1'");	
	end if;
	
	run(10);
	
	resetn_s <= '0';
	
	run(1);
	
	if ctrl_resetn_s = '1' or cld_resetn_s = '1' or conv_resetn_s = '1' or hsum_resetn_s = '1' or 
	   ddrif_0_resetn_s = '1' or ddrif_1_resetn_s = '1' or ddrif_2_resetn_s = '1' or ddrif_3_resetn_s = '1' or
	   ddrif_pcie_resetn_s = '1' or ddr_0_resetn_s = '1' or ddr_1_resetn_s = '1' or ddr_2_resetn_s = '1' or
	   ddr_3_resetn_s = '1' or msix_resetn_s = '1' then
      testbench_passed_v := false;
	  puts("Module resets are not logic '0'");	
	end if;	
	
end if;

 ---------------------------------------------------------------------------------------------------        
  -- Display pass/fail message.
  if testbench_passed_v then
    heading("Testbench PASSED");
  else
    heading("Testbench FAILED");
  end if;
  -- Stop simulation.
  test_finished <= true;
  wait;

end process stimgen;

end stim;




