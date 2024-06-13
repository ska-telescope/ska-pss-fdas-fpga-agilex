----------------------------------------------------------------------------
-- Module Name:  MSIX Test Bench
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the MSIX Module
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  25/04/2022   Initial revision.
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
use ieee.math_real.all;
use ieee.std_logic_textio.all;
use std.textio.all;
library msix_lib;
use msix_lib.msix;


architecture stim of msix_tb is
  -- Define clock period.
  constant ck_per_sys_c   		: time := 2.857 ns; -- 350MHz clock
  constant ck_per_mc_c   		: time := 2.8 ns;   -- 350MHz clock, but slighlty off frequency to create phase shifts
  constant ck_per_pcie_c   		: time := 2.85 ns;  -- 350MHz clock, but slighlty off frequency to create phase shifts 

  -- Signal declarations.
  -- MSIX Module Interfaces
  signal cld_done_s               : std_logic;
  signal clk_mc_s                 : std_logic;
  signal clk_pcie_s               : std_logic;
  signal clk_sys_s                : std_logic;
  signal conv_done_s              : std_logic;
  signal hsum_done_s              : std_logic;
  signal mcaddr_s                 : std_logic_vector(3 downto 0);
  signal mcdatain_s               : std_logic_vector(31 downto 0);
  signal mcms_s                   : std_logic;
  signal mcrwn_s                  : std_logic;
  signal rst_mc_n_s               : std_logic;
  signal rst_pcie_n_s             : std_logic;
  signal rst_sys_n_s              : std_logic;
  signal usr_event_msix_ready_s   : std_logic;
  signal mcdataout_s              : std_logic_vector(31 downto 0);
  signal usr_event_msix_data_s    : std_logic_vector(15 downto 0);
  signal usr_event_msix_valid_s   : std_logic;  
  
  -- Test Bench
  signal usr_event_msix_data_expected_s      : std_logic_vector(15 downto 0);
  signal enable_msix_check_single_s          : std_logic; 
  signal usr_event_msix_ready_cnt_s          : unsigned(15 downto 0);
  signal usr_ready_delay_s                   : unsigned(15 downto 0);
  signal usr_event_msix_valid_latch_s        : std_logic;  
  signal enable_msix_check_single_ret_s      : std_logic; 
  signal usr_event_msix_data_expected_1_s    : std_logic_vector(15 downto 0);
  signal usr_event_msix_data_expected_2_s    : std_logic_vector(15 downto 0);
  signal usr_event_msix_data_expected_3_s    : std_logic_vector(15 downto 0);
  signal enable_msix_check_multiple_s        : std_logic;    
  signal enable_msix_check_multiple_ret_s    : std_logic;         
  signal int_cnt_s                           : unsigned(1 downto 0);
  
  -- general
  signal test_finished                   : boolean := false; 
  signal error_s                         : unsigned(3 downto 0); 
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  -- Component Declarations
  component msix
  port (
      CLD_DONE             : IN     std_logic;
      CLK_MC               : IN     std_logic;
      CLK_PCIE             : IN     std_logic;
      CLK_SYS              : IN     std_logic;
      CONV_DONE            : IN     std_logic;
      HSUM_DONE            : IN     std_logic;
      MCADDR               : IN     std_logic_vector (3 DOWNTO 0);
      MCDATAIN             : IN     std_logic_vector (31 DOWNTO 0);
      MCMS                 : IN     std_logic;
      MCRWN                : IN     std_logic;
      RST_MC_N             : IN     std_logic;
      RST_PCIE_N           : IN     std_logic;
      RST_SYS_N            : IN     std_logic;
      USR_EVENT_MSIX_READY : IN     std_logic;
      MCDATAOUT            : OUT    std_logic_vector (31 DOWNTO 0);
      USR_EVENT_MSIX_DATA  : OUT    std_logic_vector (15 DOWNTO 0);
      USR_EVENT_MSIX_VALID : OUT    std_logic
  );
  end component;

  begin
    -- Instance port mappings.
    msix_i : msix
      port map (
      CLD_DONE             => cld_done_s,
      CLK_MC               => clk_mc_s,
      CLK_PCIE             => clk_pcie_s,
      CLK_SYS              => clk_sys_s,
      CONV_DONE            => conv_done_s,
      HSUM_DONE            => hsum_done_s,
      MCADDR               => mcaddr_s,
      MCDATAIN             => mcdatain_s,
      MCMS                 => mcms_s,
      MCRWN                => mcrwn_s,
      RST_MC_N             => rst_mc_n_s,
      RST_PCIE_N           => rst_pcie_n_s,
      RST_SYS_N            => rst_sys_n_s,
      USR_EVENT_MSIX_READY => usr_event_msix_ready_s,
      MCDATAOUT            => mcdataout_s,
      USR_EVENT_MSIX_DATA  => usr_event_msix_data_s,
      USR_EVENT_MSIX_VALID => usr_event_msix_valid_s      
     );

------------------------------------------------------------------------------
-- PROCESS : clkgen1
-- FUNCTION: Generates clk_sys. Main system clock
------------------------------------------------------------------------------
clkgen1 : process
begin
  while not test_finished loop
    clk_sys_s <= '0', '1' after ck_per_sys_c/2;
    wait for ck_per_sys_c;
  end loop;
  wait;
end process clkgen1;

------------------------------------------------------------------------------
-- PROCESS : clkgen2
-- FUNCTION: Generates clk_mc. Micro Configuration Clock
------------------------------------------------------------------------------
clkgen2 : process
begin
  while not test_finished loop
    clk_mc_s <= '0', '1' after ck_per_mc_c/2;
    wait for ck_per_mc_c;
  end loop;
  wait;
end process clkgen2;

------------------------------------------------------------------------------
-- PROCESS : clkgen3
-- FUNCTION: Generates clk_pcie. Micro Configuration Clock
------------------------------------------------------------------------------
clkgen3 : process
begin
  while not test_finished loop
    clk_pcie_s <= '0', '1' after ck_per_pcie_c/2;
    wait for ck_per_pcie_c;
  end loop;
  wait;
end process clkgen3;


------------------------------------------------------------------------------
-- PROCESS : Check_MSIX_Data
-- FUNCTION: Generates clk_pcie. Micro Configuration Clock
------------------------------------------------------------------------------
Check_MSIX_Data : process (rst_pcie_n_s, clk_pcie_s)

begin
  if rst_pcie_n_s = '0' then
    usr_event_msix_ready_s <= '0';    
    usr_event_msix_ready_cnt_s <= (others => '0');
    usr_event_msix_valid_latch_s <= '0';
    enable_msix_check_single_ret_s <= '0';
    enable_msix_check_multiple_ret_s <= '0';
    int_cnt_s <= (others => '0');
  elsif (rising_edge(clk_pcie_s)) then
    usr_event_msix_ready_s <= '0';  -- default
  
    
    -- CHECKING SINGLE INTERRUPTS
    enable_msix_check_single_ret_s <= enable_msix_check_single_s;
    
    -- Clear any latching of the usr_event_msix_valid_s signal when the check starts
    -- and clear the counter that determines when the usr_event_msix_ready_s signal
    -- is asserted
    if enable_msix_check_single_s = '1' and enable_msix_check_single_ret_s = '0' then
      usr_event_msix_valid_latch_s <= '0';
      usr_event_msix_ready_cnt_s <= (others => '0');
    end if;
    
    -- Also clear the ounter that determines when the usr_event_msix_ready_s signal
    -- at the end of a test (needed due to pipelining in test bench)
    if enable_msix_check_single_s = '0' and enable_msix_check_single_ret_s = '1' then
      usr_event_msix_ready_cnt_s <= (others => '0');
    end if;    
    
    -- Check when a single interrupt is expected
    if enable_msix_check_single_s = '1' then
      -- assert the usr_event_msix_ready_s after a configured period of time
      if usr_ready_delay_s = usr_event_msix_ready_cnt_s then
        -- assert the ready signal
        usr_event_msix_ready_s <= '1';
      else 
        usr_event_msix_ready_cnt_s <= usr_event_msix_ready_cnt_s + 1;
      end if;
    
      -- when usr_event_msix_ready_s and usr_event_msix_valid_s are both asserted
      -- that the usr_event_msix_data_s is correct.
      if usr_event_msix_ready_s = '1' and usr_event_msix_valid_s = '1' then
        if usr_event_msix_data_s /= usr_event_msix_data_expected_s then
          testbench_passed_v := false;
        end if;
      end if;
      
      -- latch any assertion of the usr_event_msix_valid_s signal
      if usr_event_msix_valid_s = '1' then
        usr_event_msix_valid_latch_s <= '1';
      end if;     
    end if;
    

    
    
    -- CHECKING MULTIPLE INTERRUPTS    
    enable_msix_check_multiple_ret_s <= enable_msix_check_multiple_s;

    -- Clear the count of interrupts 
    if enable_msix_check_multiple_s = '1' and enable_msix_check_multiple_ret_s = '0' then
      int_cnt_s <= (others => '0');
    end if;    
    
    -- Check when all three interrupts are expected
    if enable_msix_check_multiple_s = '1' then
      -- assert the usr_event_msix_ready_s after a configured period of time
      if usr_ready_delay_s = usr_event_msix_ready_cnt_s then
        -- assert the ready signal
        usr_event_msix_ready_s <= '1';
      else 
        usr_event_msix_ready_cnt_s <= usr_event_msix_ready_cnt_s + 1;
      end if;
    
      -- when usr_event_msix_ready_s and usr_event_msix_valid_s are both asserted
      -- that the usr_event_msix_data_s is correct.
      if int_cnt_s = "00" then 
        if usr_event_msix_ready_s = '1' and usr_event_msix_valid_s = '1' then
          int_cnt_s <= int_cnt_s + 1;
          if usr_event_msix_data_s /= usr_event_msix_data_expected_1_s then
            testbench_passed_v := false;
          end if;
        end if;
      end if;
      
      if int_cnt_s = "01" then 
        if usr_event_msix_ready_s = '1' and usr_event_msix_valid_s = '1' then
          int_cnt_s <= int_cnt_s + 1;
          if usr_event_msix_data_s /= usr_event_msix_data_expected_2_s then
            testbench_passed_v := false;
          end if;
        end if;
      end if;      
      
      if int_cnt_s = "10" then 
        if usr_event_msix_ready_s = '1' and usr_event_msix_valid_s = '1' then
          int_cnt_s <= int_cnt_s + 1;
          if usr_event_msix_data_s /= usr_event_msix_data_expected_3_s then
            testbench_passed_v := false;
          end if;
        end if;
      end if;         
      
    end if;    
      
  end if;
      
end process Check_MSIX_Data;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- PROCESS : stimgen
-- FUNCTION: Main test process.
------------------------------------------------------------------------------
stimgen : process


  -- Testbench variables.
    variable  test_1_v      : std_logic;
    variable  test_2_v      : std_logic;
    variable  test_3_v      : std_logic;
    variable  test_4_v      : std_logic;
    variable  test_5_v      : std_logic;    
    variable  test_6_v      : std_logic;        
    variable  outline_v 	      : line;
    
--------------------------------------------------------------------------------
-------------------------- PROCEDURES ------------------------------------------
--------------------------------------------------------------------------------
  -- 1) Procedure to perform micro write.
  procedure mcwrite(address : natural;
                    data    : std_logic_vector(31 downto 0) ) is
  begin
    mcaddr_s <= std_logic_vector(to_unsigned(address, mcaddr_s'left + 1));
    mcdatain_s <= data;
    mcrwn_s <= '0';
    mcms_s  <= '1';
    wait for ck_per_mc_c*4;
    mcms_s <= '0';
    wait for ck_per_mc_c;
  end procedure mcwrite;

  
  -- 2) Procedure to perform micro write.
  procedure mcwrite(address : natural;
                    data    : natural) is
  begin
    mcwrite(address, std_logic_vector(to_unsigned(data, 32)));
  end procedure mcwrite;

  
  -- 3) Procedure to perform micro read, and optionally check read data.
  procedure mcread(address : natural;
                   readdata_v: out std_logic_vector(31 downto 0);
                   exp_data: std_logic_vector(31 downto 0) := (others => '-')
                  ) is
  begin
    mcaddr_s <= std_logic_vector(to_unsigned(address, mcaddr_s'left + 1));
    mcrwn_s <= '1';
    mcms_s  <= '1';
    wait for ck_per_mc_c*4;
    mcms_s  <= '0';
    wait for ck_per_mc_c;
    readdata_v := mcdataout_s;
    for i in mcdataout_s'range loop
      if exp_data(i) = '-' then
        next;
      end if;
      if exp_data(i) /= mcdataout_s(i) then
        testbench_passed_v := false;
        write(outline_v, string'("Micro read incorrect:"));
        write(outline_v, string'("expected "));
        hwrite(outline_v, exp_data);
        write(outline_v, string'(", got "));
        hwrite(outline_v, mcdataout_s);
        writeline(OUTPUT,outline_v);
        assert false
          severity error;
        exit;
      end if;
    end loop;
  end procedure mcread;

  
  -- 4) Procedure to perform micro read and check read data (integer argument).
  procedure mcread(address : natural;
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
    wait for ck_per_sys_c * clocks;
  end procedure run;

      

begin

  -- CLD/CONV/HSUM Interface
  cld_done_s         <= '0';
  conv_done_s        <= '0';
  hsum_done_s        <= '0';
   
  -- Test bench
  usr_event_msix_data_expected_s               <= (others => '0');
  enable_msix_check_single_s                   <= '0';
  usr_ready_delay_s                            <= (others => '0');
  usr_event_msix_data_expected_1_s             <= (others => '0');
  usr_event_msix_data_expected_2_s             <= (others => '0');  
  usr_event_msix_data_expected_3_s             <= (others => '0');  
  enable_msix_check_multiple_s                 <= '0';  
  
  -- Apply Resets
  rst_sys_n_s 	                <= '0'; 
  rst_pcie_n_s 	                <= '0';
  rst_mc_n_s 	                <= '0';
  run(2);
  rst_sys_n_s 	                <= '1'; 
  rst_pcie_n_s 	                <= '1';
  rst_mc_n_s 	                <= '1';  
  
  -- Ensure bitmap is initialised
  mcwrite(16#00#, 0);   -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0]
  mcwrite(16#04#, 0);	-- CONV_MSIX_EN & CONV_MSIX_DATA[15:0]
  mcwrite(16#08#, 0);	-- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0]

	
  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
  test_6_v := '1';  
----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.MSIX.DM.01: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT ENABLED                                                        ---
---                                                                                                                                              ---                                                                                                                                                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.MSIX.DM.01: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT ENABLED");
 
  -- CLD MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"AAAA";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CLD MSIX Data to 0xAAAA and enable CLD MSI-X Interrupts
  mcwrite(16#00#, x"0001AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  
  -- pulse the CLD_DONE
  cld_done_s         <= '1';
  run(1);
  cld_done_s         <= '0';
  
  run(100);
  
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;
  enable_msix_check_single_s <= '0';
  
  run(2);
  
  -- CONV MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"BBBB";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CONV MSIX Data to 0xBBBB and enable CONV MSI-X Interrupts
  mcwrite(16#04#, x"0001BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  
  -- pulse the CONV_DONE
  conv_done_s         <= '1';
  run(1);
  conv_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';  
  
  run(2);
   
  -- HSUM MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"CCCC";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the HSUM MSIX Data to 0xCCCC and enable HSUM MSI-X Interrupts
  mcwrite(16#08#, x"0001CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the HSUM_DONE
  hsum_done_s         <= '1';
  run(1);
  hsum_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0'; 
  
  run(2);
  

end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.MSIX.DM.02: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT DISABLED                                                       ---
---                                                                                                                                              ---                                                                                                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 1: TC.MSIX.DM.02: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT DISABLED ");
 
  -- CLD MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"AAAA";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CLD MSIX Data to 0xAAAA and disable CLD MSI-X Interrupts
  mcwrite(16#00#, x"0000AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  
  -- pulse the CLD_DONE
  cld_done_s         <= '1';
  run(1);
  cld_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';

  run(2);  
  
  -- CONV MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"BBBB";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CONV MSIX Data to 0xBBBB and disable CONV MSI-X Interrupts
  mcwrite(16#04#, x"0000BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  
  -- pulse the CONV_DONE
  conv_done_s         <= '1';
  run(1);
  conv_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';  
  
  run(2);
  
  -- HSUM MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"CCCC";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the HSUM MSIX Data to 0xCCCC and disable HSUM MSI-X Interrupts
  mcwrite(16#08#, x"0000CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the HSUM_DONE
  hsum_done_s         <= '1';
  run(1);
  hsum_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';  
  
  run(2);  
  

end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.MSIX.DM.01: CHECK ALL MSI-X INTERRUPTS OCCURING SIMULTANEOUSLY AND ENABLED                                                        ---
---                                                                                                                                              ---                                                                                                                                                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_3_v = '1' then  
  puts("Test 3: TC.MSIX.DM.03: CHECK ALL MSI-X INTERRUPTS OCCURING SIMULTANEOUSLY AND ENABLED ");
 
  -- set the expected USR_EVENT_MSIX_DATA[15:0] values
  usr_event_msix_data_expected_1_s <= x"AAAA";  
  usr_event_msix_data_expected_2_s <= x"BBBB";  
  usr_event_msix_data_expected_3_s <= x"CCCC"; 
  
  -- Set the MSIX Data to Values
  mcwrite(16#00#, x"0001AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  mcwrite(16#04#, x"0001BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  mcwrite(16#08#, x"0001CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  
  enable_msix_check_multiple_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  

  -- pulse all the _DONE signals simultaneously
  cld_done_s          <= '1';
  conv_done_s         <= '1';
  hsum_done_s         <= '1';
  run(1);
  cld_done_s          <= '0';
  conv_done_s         <= '0';
  hsum_done_s         <= '0';
  
  run(100);
  enable_msix_check_multiple_s <= '0';
  run(2);

end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.MSIX.DM.04: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT ENABLED AND DELAYED READY SIGNAL                                                       ---
---                                                                                                                                              ---                                                                                                                                                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.MSIX.DM.04: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT ENABLED AND DELAYED READY SIGNAL");
 
  -- CLD MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"AAAA";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(30, 16)); 
  
  -- Set the CLD MSIX Data to 0xAAAA and enable CLD MSI-X Interrupts
  mcwrite(16#00#, x"0001AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  
  -- pulse the CLD_DONE
  cld_done_s         <= '1';
  run(1);
  cld_done_s         <= '0';
  
  run(100);
  
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;
  enable_msix_check_single_s <= '0';
  
  run(2);
  
  -- CONV MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"BBBB";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(40, 16)); 
  
  -- Set the CONV MSIX Data to 0xBBBB and enable CONV MSI-X Interrupts
  mcwrite(16#04#, x"0001BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  
  -- pulse the CONV_DONE
  conv_done_s         <= '1';
  run(1);
  conv_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';  
  
  run(2);
   
  -- HSUM MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"CCCC";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(50, 16)); 
  
  -- Set the HSUM MSIX Data to 0xCCCC and enable HSUM MSI-X Interrupts
  mcwrite(16#08#, x"0001CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the HSUM_DONE
  hsum_done_s         <= '1';
  run(1);
  hsum_done_s         <= '0';
  
  run(100);
  if usr_event_msix_valid_latch_s = '0' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0'; 
  
  run(2);
  

end if;


---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 5: TC.MSIX.DM.05: CHECK EACH MSI-X INTERRUPT WITH A WALKING 1's TEST                                                                    ---
---                                                                                                                                              ---                                                                                                                                                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_5_v = '1' then  
  puts("Test 5: TC.MSIX.DM.05: CHECK EACH MSI-X INTERRUPT WITH A WALKING 1's TEST ");
 
  -- CLD MSI-X INTERRUPT  
  for i in 0 to 15 loop
    -- set the expected USR_EVENT_MSIX_DATA[15:0]
    usr_event_msix_data_expected_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i, 16));  
        
    enable_msix_check_single_s <= '1';
    usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
    
    -- Set the CLD MSIX Data to 0xAAAA and enable CLD MSI-X Interrupts
    mcwrite(16#00#, STD_LOGIC_VECTOR(TO_UNSIGNED((2**i) + 65536, 32)));  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
    
    -- pulse the CLD_DONE
    cld_done_s         <= '1';
    run(1);
    cld_done_s         <= '0';
    
    run(100);
    
    if usr_event_msix_valid_latch_s = '0' then
      testbench_passed_v := false;
    end if;
    enable_msix_check_single_s <= '0';
   
    run(2);   
    
  end loop;
  

  
  -- CONV MSI-X INTERRUPT 
  for i in 0 to 15 loop 
    -- set the expected USR_EVENT_MSIX_DATA[15:0]
    usr_event_msix_data_expected_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i, 16));  
        
    enable_msix_check_single_s <= '1';
    usr_ready_delay_s <= (TO_UNSIGNED(0, 16));     
    
    -- Set the CONV MSIX Data to 0xBBBB and enable CONV MSI-X Interrupts
    mcwrite(16#04#, STD_LOGIC_VECTOR(TO_UNSIGNED((2**i) + 65536, 32)));  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
    
    -- pulse the CONV_DONE
    conv_done_s         <= '1';
    run(1);
    conv_done_s         <= '0';
    
    run(100);
    if usr_event_msix_valid_latch_s = '0' then
      testbench_passed_v := false;
    end if;  
    enable_msix_check_single_s <= '0';  
  
    run(2);
  end loop;
   
  -- HSUM MSI-X INTERRUPT
  for i in 0 to 15 loop   
    -- set the expected USR_EVENT_MSIX_DATA[15:0]
    usr_event_msix_data_expected_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(2**i, 16));  
    
    enable_msix_check_single_s <= '1';
    usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
    
    -- Set the HSUM MSIX Data to 0xCCCC and enable HSUM MSI-X Interrupts
    mcwrite(16#08#, STD_LOGIC_VECTOR(TO_UNSIGNED((2**i) + 65536, 32)));  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
    
    -- pulse the HSUM_DONE
    hsum_done_s         <= '1';
    run(1);
    hsum_done_s         <= '0';
    
    run(100);
    if usr_event_msix_valid_latch_s = '0' then
      testbench_passed_v := false;
    end if;  
    enable_msix_check_single_s <= '0'; 
  
    run(2);
  end loop;
  

end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 6: TC.MSIX.DM.06: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT DISABLED                                                        ---
---                                                                                                                                              ---                                                                                                                                                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_6_v = '1' then  
  puts("Test 6: TC.MSIX.DM.06: CHECK EACH MSI-X INTERRUPT IN ISOLATION WITH INTERRUPT DISABLED");
 
  -- CLD MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"AAAA";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CLD MSIX Data to 0xAAAA and disable CLD MSI-X Interrupts, but keep the CONV and HSUM interrupts enabled
  mcwrite(16#00#, x"0000AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  mcwrite(16#04#, x"0001BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  mcwrite(16#08#, x"0001CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the CLD_DONE
  cld_done_s         <= '1';
  run(1);
  cld_done_s         <= '0';
  
  run(100);
  
  -- In this case there is no MSI-X interrupt expected
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;
  enable_msix_check_single_s <= '0';
  
  run(2);
  
  -- CONV MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"BBBB";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the CONV MSIX Data to 0xBBBB and disable CONV MSI-X Interrupts, but keep the CLD and HSUM interrupts enabled
  mcwrite(16#00#, x"0001AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  mcwrite(16#04#, x"0000BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  mcwrite(16#08#, x"0001CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the CONV_DONE
  conv_done_s         <= '1';
  run(1);
  conv_done_s         <= '0';
  
  run(100);
  
  -- In this case there is no MSI-X interrupt expected
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0';  
  
  run(2);
   
  -- HSUM MSI-X INTERRUPT
  -- set the expected USR_EVENT_MSIX_DATA[15:0]
  usr_event_msix_data_expected_s <= x"CCCC";  
  
  enable_msix_check_single_s <= '1';
  usr_ready_delay_s <= (TO_UNSIGNED(0, 16)); 
  
  -- Set the HSUM MSIX Data to 0xCCCC and disable HSUM MSI-X Interrupts, but keep the CLD and CONV interrupts enabled
  mcwrite(16#00#, x"0001AAAA");  -- CLD_MSIX_EN & CLD_MSIX_DATA[15:0] 
  mcwrite(16#04#, x"0001BBBB");  -- CONV_MSIX_EN & CONV_MSIX_DATA[15:0] 
  mcwrite(16#08#, x"0000CCCC");  -- HSUM_MSIX_EN & HSUM_MSIX_DATA[15:0] 
  
  -- pulse the HSUM_DONE
  hsum_done_s         <= '1';
  run(1);
  hsum_done_s         <= '0';
  
  run(100);

  -- In this case there is no MSI-X interrupt expected  
  if usr_event_msix_valid_latch_s = '1' then
    testbench_passed_v := false;
  end if;  
  enable_msix_check_single_s <= '0'; 
  
  run(2);
  

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









