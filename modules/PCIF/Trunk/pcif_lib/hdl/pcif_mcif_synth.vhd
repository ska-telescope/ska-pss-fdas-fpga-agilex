----------------------------------------------------------------------------
-- Module Name:  pcif_mcif
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- PCIe Avalon-MM to Micro Interface conversion block
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  04/07/2017   Initial revision.
-- 0.2  RMD  07/09/2017   Changed to the clk_mc domain to allow a lower
--                        frequency than clk_sys if necessary (future prooofing.
--                        Added rst_pcie_n signal.
-- 0.3  RMD  03/11/2017   Corrected latching of read data for one cycle only.
--                        Wait Request now asserted at reset.
--                        Increased the number of cycles per access to 7.
--                        Design now ensures back-to-back transfers are
--                        supported.
-- 0.4 RMD   23/11/2017   Added timeout to ensure RXM_WAIT_REQUEST will
--                        eventually respond to an access. 
-- 0.5 RMD   11/03/2022   Added rxm_write_response_valid and rxm_response[1:0] as
--                        the Agilex PCIe Hard Macro requires these signals
--                        and it is mandatory that they are driven according
--                        to the Avalon specification.
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture synth of pcif_mcif is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------


-- rx_path process
signal rxm_write_ret_s              : std_logic_vector(2 downto 0);   -- Shift register for write request edge detection
signal rxm_read_ret_s               : std_logic_vector(2 downto 0);   -- Shift register for read request edge detection 
signal mcaddr_s                     : std_logic_vector(21 downto 0);  -- MCI address to FDAS Core 
signal mcdatain_s                   : std_logic_vector(31 downto 0);  -- MCI data to FDAS Core 
signal mcrwn_s                      : std_logic;                      -- MCI read/write signal to FDAS Core 
signal mccs_s                       : std_logic;                      -- MCI select to FDAS Core 
signal access_cnt_s                 : unsigned(2 downto 0);           -- MCI access cycle counter
signal mcdataout_latched_s          : std_logic_vector(31 downto 0);  -- MCI data (latched) from the FDAS Core


-- tx_path process
signal rxm_wait_request_s           : std_logic;                      -- Wait Request to PCIe Hard IP Macro
signal mccs_ret_s                   : std_logic_vector(2 downto 0);   -- Shift register for MCI select edge detection 
signal rxm_read_data_s              : std_logic_vector(31 downto 0);  -- MCI data from FDAS Core to PCIe Hard Macro
signal valid_set_s                  : std_logic;                      -- internal valid flag
signal rxm_read_data_valid_s        : std_logic;                      -- Valid data flag to PCIe Hard Macro
signal rxm_write_ret_1_s            : std_logic;  
signal rxm_read_ret_1_s             : std_logic; 
signal write_rise_s                 : std_logic; 
signal read_rise_s                  : std_logic; 
signal write_rise_cnt_s             : unsigned(1 downto 0); 
signal read_rise_cnt_s              : unsigned(1 downto 0); 
signal timeout_cnt_s                : unsigned(4 downto 0);
signal rxm_write_response_valid_s   : std_logic;                      -- Write Response Valid to PCIe Hard Macro
                                                                      -- The signal to the PCIe Hard IP Macro
                                                                      -- must occur one cycle or more after the                                                                                             
                                                                      -- wait request signal has pulsed low

begin


------------------------------------------------------------------------------
-- Process: rx_path
-- Transfer incoming PCIe RXM signals onto the clk_mc domain 
--
-----------------------------------------------------------------------------
rx_path: process(clk_mc, rst_mc_n)
begin

  if rst_mc_n  = '0' then
    rxm_write_ret_s       <= (others => '0');
    rxm_read_ret_s        <= (others => '0');
    mcaddr_s              <= (others => '0');
    mcdatain_s            <= (others => '0');
    mcrwn_s               <= '0';
    mccs_s                <= '0';
    access_cnt_s          <= (others => '0');
    mcdataout_latched_s   <= (others => '0');
  elsif rising_edge(clk_mc) then
    
     rxm_write_ret_s <= rxm_write_ret_s(1 downto 0) & write_rise_s;
     rxm_read_ret_s <= rxm_read_ret_s(1 downto 0) & read_rise_s;
    
    if access_cnt_s > 0 then
      access_cnt_s <= access_cnt_s - 1;
    else
      mccs_s <= '0';
      mcrwn_s <= '1';  
      -- latch the MCDATAOUT when MCCS de-asserts (i.e. at the end of the read cycle)
      if mccs_s = '1' then
        mcdataout_latched_s <= MCDATAOUT;
      end if;
    end if;

    
    
    if rxm_write_ret_s(1) = '1' and rxm_write_ret_s(2) = '0' then -- rising edge
      mcaddr_s <= RXM_ADDRESS;
      mcdatain_s <= RXM_WRITE_DATA;
      mcrwn_s <= '0';
      mccs_s <= '1';
      access_cnt_s <= "111";
    end if;
   

    if rxm_read_ret_s(1) = '1' and rxm_read_ret_s(2) = '0' then -- rising edge
      mcaddr_s <= RXM_ADDRESS;
      mcdatain_s <= (others => '0');
      mcrwn_s <= '1';
      mccs_s <= '1';
      access_cnt_s <= "111";
    end if;

    

 
  end if;
end process rx_path;
   
   
------------------------------------------------------------------------------
-- Process: tx_path
-- Tranfer MCI signals onto the clk_pcie domain 
--
-----------------------------------------------------------------------------
tx_path: process(clk_pcie, rst_pcie_n)
begin

  if rst_pcie_n  = '0' then
    rxm_wait_request_s       <= '1';
    mccs_ret_s               <= (others => '0');  
    rxm_read_data_s          <= (others => '0'); 
    rxm_write_ret_1_s        <= '0';  
    rxm_read_ret_1_s         <= '0'; 
    write_rise_s             <= '0'; 
    read_rise_s              <= '0'; 
    write_rise_cnt_s         <= (others => '0'); 
    read_rise_cnt_s          <= (others => '0'); 
    valid_set_s              <= '0';
    rxm_read_data_valid_s    <= '0';
    timeout_cnt_s            <= (others => '0'); 
    rxm_write_response_valid_s <= '0';
    RXM_WRITE_RESPONSE_VALID <= '0';
  elsif rising_edge(clk_pcie) then
    
    
    -- default
    rxm_wait_request_s <= '1';
    valid_set_s <= '0';
    rxm_read_data_valid_s <= '0';
    write_rise_cnt_s <= write_rise_cnt_s + 1;
    read_rise_cnt_s <= read_rise_cnt_s + 1;
    rxm_write_response_valid_s <= '0';
    RXM_WRITE_RESPONSE_VALID <= rxm_write_response_valid_s; -- This effectively delays the RXM_WRITE_RESPONSE_VALID by
                                                            -- one clock cycle compared to the RXM_WAIT_REQUEST signal
    
    if timeout_cnt_s > 0 then
      timeout_cnt_s <= timeout_cnt_s -1;
    end if;
    
    if write_rise_cnt_s = 1 then
      write_rise_s <= '0';
    end if;

    if read_rise_cnt_s = 1 then
      read_rise_s <= '0';
    end if;

    -- shift incoming signals into shift registers
    rxm_write_ret_1_s <= RXM_WRITE;
    rxm_read_ret_1_s <= RXM_READ;

    if RXM_WRITE = '1' and rxm_write_ret_1_s = '0' then
      write_rise_s <= '1';
      write_rise_cnt_s <= (others => '0');
      timeout_cnt_s <= (others => '1');
    end if;
    
    if RXM_READ = '1' and rxm_read_ret_1_s = '0' then
      read_rise_s <= '1';
      read_rise_cnt_s <= (others => '0');
      timeout_cnt_s <= (others => '1');
    end if;

    
    -- retime the falling edge of mccs_s onto the clk_pcie domain
    -- shift incoming signals into shift registers
    mccs_ret_s <= mccs_ret_s(1 downto 0) & mccs_s;
   
  
    if (mccs_ret_s(1) = '0' and mccs_ret_s(2) = '1') or timeout_cnt_s = 1 then -- falling edge of mcc_s or timeout matured
      rxm_read_data_s <= (others => '0');
      rxm_wait_request_s <= '0';
      if RXM_READ = '1' then -- if read 
        rxm_read_data_s <= mcdataout_latched_s;
        valid_set_s <= '1';
      else -- the access must have been a write access     
        rxm_write_response_valid_s <= '1'; -- This signal will be delayed by one cycle to 
                                           -- become the RXM_WRITE_RESPONSE_VALID signal so that it occurs one
                                           -- cycle after the RXM_WAIT_REQUEST signal
      end if;       
      
      timeout_cnt_s <= (others => '0'); -- park position
    end if;
    
    -- Ensure that at the end of the access the retimes of RXM_WRITE
    -- and RXM_READ are set to 0, so that if RXM_WRITE or RXM_READ are low
    -- for less than one CLK_PCIE cycle a new access will still be 
    -- detected. This ensures back-to-back acesses are supported.
    if rxm_wait_request_s = '0' then
      rxm_write_ret_1_s <= '0';
      rxm_read_ret_1_s <= '0';
    end if;

    -- ensure the rxm_read_data_valid_s is asserted at least one cycle
    -- after RXM_READ has been accepted by FDAS    
    if valid_set_s = '1' then
      rxm_read_data_valid_s <= '1';
    end if;
 
  end if;
end process tx_path;


-- Concurrent assignments
assign_mcaddr : MCADDR <= mcaddr_s; 
assign_mcdatain : MCDATAIN <= mcdatain_s;
assign_mcrwn : MCRWN <= mcrwn_s;
assign_mmcs : MCCS <= mccs_s;
assign_rxm_wait_request : RXM_WAIT_REQUEST <= rxm_wait_request_s;
assign_rxm_read_data : RXM_READ_DATA <= rxm_read_data_s;
assign_rxm_read_data_valid : RXM_READ_DATA_VALID <= rxm_read_data_valid_s;
assign_response : RXM_RESPONSE <= "00"; -- The Agilex PCIe Hard Macro does not currently process the response code 
                                        -- and the Agilex documentation states it should be set to "00"

end architecture synth;

