----------------------------------------------------------------------------
-- Module Name:  PCIF Test Bench
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Test bench for the PCIF Module
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  03/07/2017   Initial revision.
-- 0.2  RMD  07/09/2017   Changed to clk_mc clock domain to allow a lower
--                        micro configuration clock (future prooofing.
--                        Added rst_pcie_n.
-- 0.3  RMD  03/11/2017   Address now only 22 bits
-- 0.4  RMD  06/11/2017   Added test to check when the RXM_WRITE or RXM_READ
--                        are not de-asserted between accesses.
-- 0.5  RMD  14/03/2022   Added tests for new signals rxm_write_response_valid 
--                        and rxm_response[1:0]
-- 0.6 RMD  02/12/2022    Jon Taylor noted from the Intel Avalon spec
--                        mnl_avalon_spec-683091-667068.pdf with regard to the
--                        writeresponsevalid signal:-
--                          "An optional signal. If present, the interface issues write
--                           responses for write commands.
--                           When asserted, the value on the response signal is a valid write
--                           response.
--                           Writeresponsevalid is only asserted one clock cycle or more
--                           after the write command is accepted. There is at least a one
--                           clock cycle latency from command acceptance to assertion of
--                           writeresponsevalid.
--                           A write command is considered accepted when the last beat of
--                           the burst is issued to the agent and waitrequest is low.
--                           writeresponsevalid can be asserted one or more clock
--                           cycles after the last beat of the burst has been issued".
--                        From this statement it seems that the writeresponsevalid signal
--                        should pulse high one cycle after the waitrequest signal has pulsed low.
--                        Hence the correction is to delay the writeresponsevalid signal by
--                        one clock cycle in this design (currently the writeresponsevalid
--                        signal pulses high on the same clock cycle that the waitrequest
--                        signal pules low).
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
library pcif_lib;
use pcif_lib.pcif;


architecture stim of pcif_tb is
  -- Define clock period.
  constant ck_mc_per_c   		  : time := 2.80 ns; -- ~350MHz clock, slightly below CLK_PCIE to cause asynchronisity
  constant ck_pcie_per_c   		: time := 2.85 ns; -- 350MHz clock 

  -- Signal declarations.
  -- PCIF Module PCIe Hard IP Macro Interface
  signal rxm_wait_request_s          : std_logic;
  signal rxm_address_s               : std_logic_vector(21 downto 0);
  signal rxm_write_data_s            : std_logic_vector(31 downto 0);
  signal rxm_byte_enable_s           : std_logic_vector(3 downto 0);
  signal rxm_read_s                  : std_logic;
  signal rxm_write_s                 : std_logic;
  signal rxm_read_data_s             : std_logic_vector(31 downto 0);
  signal rxm_read_data_vald_s        : std_logic;
  signal clk_pcie_s                  : std_logic;
  signal rst_pcie_n_s                : std_logic;
  signal rxm_write_response_valid_s  : std_logic;  
  signal rxm_response_s              : std_logic_vector(1 downto 0);  
  signal rxm_wait_request_ret_1_s    : std_logic;
  signal rxm_wait_request_ret_2_s    : std_logic;
  
  -- PCIF Module PCIe Hard IP Macro Interface
  signal mcaddr_s                : std_logic_vector(21 downto 0);
  signal mcdatain_s              : std_logic_vector(31 downto 0);
  signal mcrwn_s                 : std_logic;
  signal mccs_s                  : std_logic;
  signal mcdataout_s             : std_logic_vector(31 downto 0);
  signal rst_mc_n_s              : std_logic;
  signal clk_mc_s                : std_logic;
  
  
  -- process: pc_ram
  subtype word_t is std_logic_vector(31 downto 0);
  type memory_t is array(2047 downto 0) of word_t;
  signal pcie_ram_s                      : memory_t;

  signal pcie_en_rt_1_s                  : std_logic;
  signal pcie_cnt_en_s                   : std_logic;
  signal pcie_ba_addr_s                  : unsigned(9 downto 0);  
  signal next_write_s                    : std_logic;
  signal core_en_rt_1_s                  : std_logic;
  signal core_cnt_en_s                   : std_logic;
  signal next_read_s                     : std_logic;
  
  -- process: core_ram
  signal core_ram_s                      : memory_t;

  -- process: check_mcdatain
  signal exp_mcdatain_s                  : std_logic_vector(31 downto 0);
  signal mmcs_ret_1_s                    : std_logic;  
  
  -- process: check_mcdataout
  signal exp_mcdataout_s                 : std_logic_vector(31 downto 0);
  
  
  -- process: stim_gen
  signal pcie_en_s                       : std_logic;
  signal pcie_awren_s                    : std_logic;
  signal pcie_aa_s                       : unsigned(9 downto 0);
  signal pcie_ai_s                       : std_logic_vector(31 downto 0);
  signal core_en_s                       : std_logic;  
  signal core_awren_s                    : std_logic;
  signal core_aa_s                       : unsigned(9 downto 0);
  signal core_ai_s                       : std_logic_vector(31 downto 0);  
  signal rxm_write_gap_s                 : std_logic;
  signal rxm_read_gap_s                  : std_logic;  
  
  -- general
  signal test_finished                   : boolean := false;
  
  
  -- Global variables.
  shared variable testbench_passed_v     : boolean := true;


  -- Component Declarations
  component pcif 
  port( 
    clk_pcie                 : IN     std_logic;
    clk_mc                   : IN     std_logic;
    mcdataout                : IN     std_logic_vector (31 DOWNTO 0);
    rst_mc_n                 : IN     std_logic;
    rst_pcie_n               : IN     std_logic;
    rxm_address              : IN     std_logic_vector (21 DOWNTO 0);
    rxm_byte_enable          : IN     std_logic_vector (3 DOWNTO 0);
    rxm_read                 : IN     std_logic;
    rxm_write                : IN     std_logic;
    rxm_write_data           : IN     std_logic_vector (31 DOWNTO 0);
    mcaddr                   : OUT    std_logic_vector (21 DOWNTO 0);
    mccs                     : OUT    std_logic;
    mcdatain                 : OUT    std_logic_vector (31 DOWNTO 0);
    mcrwn                    : OUT    std_logic;
    rxm_read_data            : OUT    std_logic_vector (31 DOWNTO 0);
    rxm_read_data_vald       : OUT    std_logic;
    rxm_wait_request         : OUT    std_logic;
    rxm_write_response_valid : OUT    std_logic;
    rxm_response             : OUT    std_logic_vector (1 DOWNTO 0)
  );
  end component;
  

  begin
    -- Instance port mappings.
    pcif_i : pcif
      port map(
       clk_pcie                 =>     clk_pcie_s,
       clk_mc                   =>     clk_mc_s,
       mcdataout                =>     mcdataout_s,
       rst_mc_n                 =>     rst_mc_n_s,
       rst_pcie_n               =>     rst_pcie_n_s,
       rxm_address              =>     rxm_address_s,
       rxm_byte_enable          =>     rxm_byte_enable_s,
       rxm_read                 =>     rxm_read_s, 
       rxm_write                =>     rxm_write_s,  
       rxm_write_data           =>     rxm_write_data_s, 
       mcaddr                   =>     mcaddr_s,
       mccs                     =>     mccs_s,
       mcdatain                 =>     mcdatain_s,  
       mcrwn                    =>     mcrwn_s, 
       rxm_read_data            =>     rxm_read_data_s,
       rxm_read_data_vald       =>     rxm_read_data_vald_s,
       rxm_wait_request         =>     rxm_wait_request_s,
       rxm_write_response_valid =>     rxm_write_response_valid_s,
       rxm_response             =>     rxm_response_s      
  );
    

------------------------------------------------------------------------------
-- PROCESS : pc_ram
-- FUNCTION: Provides RAM to mimic the data delivery from the PC/Computer
------------------------------------------------------------------------------
pcie_ram : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then
    pcie_en_rt_1_s <= '0';    
    pcie_cnt_en_s <= '0';
    pcie_ba_addr_s <= (others => '0');
    next_write_s <= '0';
    rxm_write_data_s <= (others => '0');  
    rxm_address_s <= (others => '0');
    rxm_write_s <= '0';  
    rxm_read_s              <= '0';    
    rxm_byte_enable_s       <= (others => '0');
    core_en_rt_1_s <= '0';    
    core_cnt_en_s <= '0';
    next_read_s <= '0';
    rxm_wait_request_ret_1_s <= '0';
    rxm_wait_request_ret_2_s <= '0';
  elsif (rising_edge(clk_pcie_s)) then
    if (pcie_awren_s = '1') then
      pcie_ram_s(TO_INTEGER(pcie_aa_s)) <= pcie_ai_s;
    end if;
    
   
    pcie_en_rt_1_s <= pcie_en_s;
    
    -- Check that during writes from the PCIe to the FDAS Configuration registers
    -- if rxm_wait_request transitions from high to low then one cycle later 
    -- the rxm_write_response_valid = 1
    -- but at all other times rxm_write_response_valid = 0
    -- Also check that rxm_response is always "00"
    rxm_wait_request_ret_1_s <= rxm_wait_request_s;
    rxm_wait_request_ret_2_s <= rxm_wait_request_ret_1_s;
    if pcie_en_s = '1' then
      if rxm_wait_request_ret_2_s = '1' and rxm_wait_request_ret_1_s = '0' then
        if rxm_write_response_valid_s = '0' or rxm_response_s /= "00" then 
          testbench_passed_v := false;
        end if;
      else
        if rxm_write_response_valid_s = '1' or rxm_response_s /= "00" then 
          testbench_passed_v := false;
        end if;   
      end if;
    end if;
    
    
    -- start the request to write FDAS
    if pcie_en_rt_1_s = '0' and pcie_en_s = '1' then
      pcie_cnt_en_s                     <= '1';
      pcie_ba_addr_s                    <= (others => '0');
      rxm_write_data_s                  <= pcie_ram_s(0); 
      rxm_address_s                     <= (others => '0');
      rxm_write_s                       <= '1';  
      rxm_read_s                        <= '0';    
      rxm_byte_enable_s                 <= (others => '1');
    end if;
     
    
    -- if wait_request is low and write is requested and not all data used increment the address
    if rxm_write_gap_s = '1' then
      if pcie_cnt_en_s = '1' and rxm_wait_request_s = '0' then 
        rxm_write_s  <= '0'; 
        next_write_s <= '1';
      end if; 
    else
      if pcie_cnt_en_s = '1' and rxm_wait_request_s = '0' then 
        rxm_write_s  <= '1'; 
        next_write_s <= '1';
      end if; 
    end if;

    if pcie_cnt_en_s = '1' and next_write_s = '1' and pcie_ba_addr_s < 1023 then
       rxm_write_s  <= '1'; 
       next_write_s <= '0';
       rxm_address_s <= STD_LOGIC_VECTOR(UNSIGNED(rxm_address_s) + 1);
       rxm_write_data_s <= pcie_ram_s(TO_INTEGER(pcie_ba_addr_s) + 1);
       pcie_ba_addr_s <= pcie_ba_addr_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if pcie_cnt_en_s = '1' and rxm_wait_request_s = '0' and pcie_ba_addr_s = 1023 then
      pcie_cnt_en_s <= '0';
      rxm_write_s <= '0';
      next_write_s <= '0';
    end if;
 
    
     core_en_rt_1_s <= core_en_s;
        -- start the request to write FDAS
    if core_en_rt_1_s = '0' and core_en_s = '1' then
      core_cnt_en_s                     <= '1';
      pcie_ba_addr_s                    <= (others => '0');
      rxm_write_data_s                  <= (others => '0'); 
      rxm_address_s                     <= (others => '0');
      rxm_write_s                       <= '0';  
      rxm_read_s                        <= '1';    
      rxm_byte_enable_s                 <= (others => '1');
      
    end if;
     
    -- if wait_request is low and write is requested and not all data used increment the address
    if rxm_read_gap_s = '1' then
      if core_cnt_en_s = '1' and rxm_wait_request_s = '0' then 
        rxm_read_s  <= '0'; 
        next_read_s <= '1';
      end if; 
    else
      if core_cnt_en_s = '1' and rxm_wait_request_s = '0' then 
        rxm_read_s  <= '1'; 
        next_read_s <= '1';
      end if; 
    end if;
       
    if core_cnt_en_s = '1' and next_read_s = '1' and pcie_ba_addr_s < 1023 then
       rxm_read_s  <= '1'; 
       next_read_s <= '0';
       rxm_address_s <= STD_LOGIC_VECTOR(UNSIGNED(rxm_address_s) + 1);
       pcie_ba_addr_s <= pcie_ba_addr_s + 1;
    end if;
    
    -- at the end of the transfer deassert the write req when DDRIF has sampled the data
    if core_cnt_en_s = '1' and rxm_wait_request_s = '0' and pcie_ba_addr_s = 1023 then
      core_cnt_en_s <= '0';
      rxm_read_s <= '0';
      next_read_s <= '0';
    end if;   
    
    
    
  end if;
end process pcie_ram; 
  
  
------------------------------------------------------------------------------
-- PROCESS : core_ram
-- FUNCTION: Provides RAM to mimic the data storage in the FDAS Core
------------------------------------------------------------------------------
core_ram : process (clk_mc_s, rst_mc_n_s)
      
begin
  if rst_mc_n_s = '0' then
   mcdataout_s <= (others => '0');
  elsif (rising_edge(clk_mc_s)) then
    if (core_awren_s = '1') then
      core_ram_s(TO_INTEGER(core_aa_s)) <= core_ai_s;
    end if;
      mcdataout_s <= core_ram_s(TO_INTEGER(UNSIGNED(mcaddr_s)));
      
    
  end if;
end process core_ram;   
  

------------------------------------------------------------------------------
-- PROCESS : check_mcdatain
-- FUNCTION: Check the data arriving at the FDAS core
------------------------------------------------------------------------------
check_mcdatain : process (clk_mc_s, rst_mc_n_s)
      
begin
  if rst_mc_n_s = '0' then  
    exp_mcdatain_s <= (others => '0');
    mmcs_ret_1_s <= '0';
  elsif (rising_edge(clk_mc_s)) then
   
  
    -- start the request to write FDAS
    if pcie_en_rt_1_s = '0' and pcie_en_s = '1' then
      exp_mcdatain_s                    <= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32));
    end if;
    
    mmcs_ret_1_s <= mccs_s;
    
    if mccs_s = '1' and mmcs_ret_1_s = '0' and mcrwn_s = '0' then 
      exp_mcdatain_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_mcdatain_s) + 1);
      if mcdatain_s /= exp_mcdatain_s then
        testbench_passed_v := false;
      end if;
    end if;   
    
  end if;
end process check_mcdatain; 


------------------------------------------------------------------------------
-- PROCESS : check_mcdataout
-- FUNCTION: Check the data arriving at the PCIe Hard Macro
------------------------------------------------------------------------------
check_mcdataout : process (clk_pcie_s, rst_pcie_n_s)
      
begin
  if rst_pcie_n_s = '0' then  
    exp_mcdataout_s <= (others => '0');
  elsif (rising_edge(clk_pcie_s)) then
   
  
    -- start the request to write FDAS
    if core_en_rt_1_s = '0' and core_en_s = '1' then
      exp_mcdataout_s                    <= STD_LOGIC_VECTOR(TO_UNSIGNED(1,32));
    end if;
    
    if rxm_read_data_vald_s = '1'  then 
      exp_mcdataout_s <= STD_LOGIC_VECTOR(UNSIGNED(exp_mcdataout_s) + 1);
      if rxm_read_data_s /= exp_mcdataout_s then
        testbench_passed_v := false;
      end if;
    end if;   
    
  end if;
end process check_mcdataout; 

------------------------------------------------------------------------------
-- PROCESS : clkgen1
-- FUNCTION: Generates clk_mc. Main system clock
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
-- PROCESS : clkgen2
-- FUNCTION: Generates clk_pcie
------------------------------------------------------------------------------
clkgen2 : process
begin
  while not test_finished loop
    clk_pcie_s <= '0', '1' after ck_pcie_per_c/2;
    wait for ck_pcie_per_c;
  end loop;
  wait;
end process clkgen2;




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
    variable  outline_v 	      : line;
    
    
   
--------------------------------------------------------------------------------
-------------------------- PROCEDURES ------------------------------------------
--------------------------------------------------------------------------------


  -- 1) Procedure to output a string.
  procedure puts(msg : string) is
  begin
    write(outline_v, msg);
    writeline(output,outline_v);
  end procedure puts;

  
  -- 2) Procedure to generate a heading.
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
  
  -- PCIF Module PCIe Hard Macro Interface
  -- rxm_address_s           <= (others => '0');
  -- rxm_write_data_s        <= (others => '0');
  -- rxm_byte_enable_s       <= (others => '0');
  -- rxm_read_s              <= '0';
  -- rxm_write_s             <= '0';
 
  -- PCIF Module FDAS Core Interface
  -- mcdataout_s             <= (others => '0');
  rst_mc_n_s                <= '0';
  rst_pcie_n_s              <= '0';
  run(2);
  rst_mc_n_s                <= '1';
  rst_pcie_n_s              <= '1';
 
  -- Test Bench
  pcie_en_s <= '0';
  core_en_s <= '0';
  rxm_write_gap_s <= '1'; 
  rxm_read_gap_s <= '1';   
  
   -- Load the values into the memory mimicing the PCIe  interface
  for i in 0 to 1023 loop 
    pcie_awren_s <= '1';
    pcie_ai_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 1, 32)); 
    pcie_aa_s <= (TO_UNSIGNED(i, 10));
    run(1);
  end loop;
  pcie_awren_s <= '0';
  run(1);  
  
    -- Load the values into the memory mimicing the FDAS Core
  for i in 0 to 1023 loop 
    core_awren_s <= '1';
    core_ai_s(31 downto 0) <= STD_LOGIC_VECTOR(TO_UNSIGNED(i + 1, 32)); 
    core_aa_s <= (TO_UNSIGNED(i, 10));
    run(1);
  end loop;
  core_awren_s <= '0';
  run(1);   
  
  
  

  test_1_v := '1';
  test_2_v := '1';
  test_3_v := '1';
  test_4_v := '1';
  test_5_v := '1';
----------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------- 

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 1: TC.CLD.DM.01: Write to the FDAS Core with gap in RXM_WRITE                                                                           ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 1: TC.CLD.DM.01: Write to the FDAS Core with gap in RXM_WRITE");
  
  rxm_write_gap_s <= '1'; 
  pcie_en_s <= '1';
  
  
  run(50000);

  pcie_en_s <= '0';
  
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 2: TC.CLD.DM.02: Read from the FDAS Core with gap in RXM_READ                                                                           ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_2_v = '1' then  
  puts("Test 2: TC.CLD.DM.02: Read from the FDAS Core with gap in RXM_READ");
  
  rxm_read_gap_s <= '1';
  core_en_s <= '1';
  
  
  run(50000);

  core_en_s <= '0';
  
  
end if;  

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 3: TC.CLD.DM.01: Write to the FDAS Core with no gap in RXM_WRITE                                                                        ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_1_v = '1' then  
  puts("Test 3: TC.CLD.DM.01: Write to the FDAS Core with no gap in RXM_WRITE");
  
  rxm_write_gap_s <= '0'; 
  pcie_en_s <= '1';
  
  
  run(50000);

  pcie_en_s <= '0';
  
  
end if;

---------------------------------------------------------------------------------------------------------------------------------------------------- 
--- Test 4: TC.CLD.DM.02: Read from the FDAS Core with no gap in RXM_READ                                                                        ---
---                                                                                                                                              ---                                                                                                     ---                                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------- 
if test_4_v = '1' then  
  puts("Test 4: TC.CLD.DM.02: Read from the FDAS Core with no gap in RXM_READ");
  
  rxm_read_gap_s <= '0';
  core_en_s <= '1';
  
  
  run(50000);

  core_en_s <= '0';
  
  
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




