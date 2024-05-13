----------------------------------------------------------------------------
-- Module Name:  ddrif2_ddr_mux
--
-- Source Path:  
--
-- Requirements Covered:
-- <list of requirements tags>
--
-- Functional Description:
--
-- ddr mux 
--
----------------------------------------------------------------------------
-- Rev  Eng     Date     Revision History
--
-- 0.1  RMD  19/6/2017   Initial revision.
-- 0.2  RMD  05/09/2017  Changed reset name to rst_ddr_n
--                       Added fixed signals
-- 0.3  RMD  02/09/2022  Changed AMM_BYTE_EN from 72 bits to 64 bits
--                       since DDRIF2 only supplies 64 bytes (i.e. 512 bits)
--                       of data to the DDR Controller
---------------------------------------------------------------------------
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;




architecture synth of ddrif2_ddr_mux is
--------------------------------------------------------------------------------
--                           SIGNALS
--------------------------------------------------------------------------------

-- wait_gen process
signal read_write_wait_s             :       std_logic; -- generated wait (wait_request qualified by write or read as appropriate)

-- edge_det process
signal read_write_wait_ret_1_s       :       std_logic; -- retime of  read_write_wait_s
signal side_data_s                   :       std_logic_vector(511 downto 0); -- DDR write data in siding
signal side_address_s                :       std_logic_vector(31 downto 0); -- DDR address in siding
signal side_write_s                  :       std_logic; -- DDR write request in siding
signal side_read_s                   :       std_logic; -- DDR read request in siding

-- path_sel process
signal data_sel_s                    :       std_logic_vector(511 downto 0); -- siding/normal path selected data
signal address_sel_s                 :       std_logic_vector(31 downto 0); -- siding/normal path selected address
signal write_sel_s                   :       std_logic; -- siding/normal path selected write request
signal read_sel_s                    :       std_logic; -- siding/normal path selected read request

-- retime process
signal amm_write_data_s              :       std_logic_vector(511 downto 0); -- Data to be written to DDR
signal amm_address_s                 :       std_logic_vector(31 downto 0); -- Adrress to DDR
signal amm_write_s                   :       std_logic;  -- Write request
signal amm_read_s                    :       std_logic;  -- Read request

-- ddr_read_sel process
signal amm_read_data_out_s           :       std_logic_vector(511 downto 0); -- Data read from DDR
signal pcie_amm_read_data_valid_s    :       std_logic;  -- Read Data valid signal for PCIE
signal proc_amm_read_data_valid_s    :       std_logic;  -- Read Data valid signal for FDAS Processing Module        


begin






------------------------------------------------------------------------------
-- Process: wait_gen
-- Select the Address for DDR memory
--
-----------------------------------------------------------------------------
wait_gen: process(amm_write_s, amm_read_s, amm_wait_request)
begin
 
    read_write_wait_s <= '0';
      
   if (amm_write_s  = '1' and AMM_WAIT_REQUEST = '1') or 
      (amm_read_s  = '1' and AMM_WAIT_REQUEST = '1')then
        read_write_wait_s <= '1';
   end if;
        
  
end process wait_gen;    


------------------------------------------------------------------------------
-- Process: egde_det
-- Detect the rising edge of read_write_wait_s 
-- And the rising edge of read_write_wait_s, capture the information in the siding
-- which has further selection and retime
-----------------------------------------------------------------------------
edge_det: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    read_write_wait_ret_1_s <= '0'; 
    side_data_s <= (others => '0');
    side_address_s <= (others => '0');
    side_write_s <= '0';
    side_read_s <= '0';   
  elsif rising_edge(clk_ddr) then
    
    
    read_write_wait_ret_1_s <= read_write_wait_s;
    if read_write_wait_ret_1_s = '0' and read_write_wait_s = '1' then
      side_data_s <= DDR_DATA;
      side_address_s <= DDR_ADDR;
      side_write_s <= WRITE;   
      side_read_s <= READ;   
    end if;        
     
  end if;
end process edge_det;    
 
 
 
------------------------------------------------------------------------------
-- Process: path_sel
-- Select either the main path or the siding for the write operation
-- 
-----------------------------------------------------------------------------
path_sel: process(read_write_wait_ret_1_s, DDR_DATA, DDR_ADDR, WRITE, READ, side_data_s, side_address_s, side_write_s, side_read_s )


begin

  if read_write_wait_ret_1_s = '0' then
    data_sel_s <= DDR_DATA;
    address_sel_s <= DDR_ADDR;
    write_sel_s <= WRITE;
    read_sel_s <= READ;
  else 
    data_sel_s <= side_data_s;
    address_sel_s <= side_address_s;
    write_sel_s <= side_write_s;
    read_sel_s <= side_read_s;
  end if;
  

end process path_sel;     



------------------------------------------------------------------------------
-- Process: retime
-- Retime the selected signals
--
-----------------------------------------------------------------------------
retime: process(clk_ddr, rst_ddr_n)
begin

  if rst_ddr_n  = '0' then
    amm_write_data_s <= (others => '0');
    amm_address_s <= (others => '0');
    amm_write_s <= '0';
    amm_read_s  <= '0';
  elsif rising_edge(clk_ddr) then
    
    if read_write_wait_s = '0' then
      amm_write_data_s <= data_sel_s;
      amm_address_s <= address_sel_s;
      amm_write_s <= write_sel_s;
      amm_read_s <= read_sel_s;
    end if;       
    
  end if;
end process retime;    



------------------------------------------------------------------------------
-- Process: ddr_read_sel
-- Select the path for the data read from DDR memory
--
-----------------------------------------------------------------------------
ddr_read_sel: process(clk_ddr, rst_ddr_n)
begin

  
  if rst_ddr_n  = '0' then
    amm_read_data_out_s <= (others => '0');
    pcie_amm_read_data_valid_s <= '0';
    proc_amm_read_data_valid_s <= '0';
  elsif rising_edge(clk_ddr) then
    
    -- default
    pcie_amm_read_data_valid_s <= '0';
    proc_amm_read_data_valid_s <= '0';
    
    -- select the correct path for the data 
    if READ_WRITE_SEL = '0' then
      if PCIE_PROC_SEL = '1' then
        pcie_amm_read_data_valid_s <= AMM_READ_DATA_VALID;
      else
        proc_amm_read_data_valid_s <= AMM_READ_DATA_VALID;
      end if;
    end if;
    
    -- data can be simply retimed as the valid determines whether it is stored
    amm_read_data_out_s <= AMM_READ_DATA;
       
  end if;
      
end process ddr_read_sel;     

-- Concurrent assignments
assign_amm_burstcount : AMM_BURSTCOUNT <= "0000001";  -- Burst Count, Fixed at 1
aassign_mm_byte_en_s  : AMM_BYTE_EN <= "1111111111111111111111111111111111111111111111111111111111111111"; -- Byte Enable, Fixed for 64 bytes
assign_write_data : AMM_WRITE_DATA <= amm_write_data_s;
assign_write_request : AMM_WRITE <= amm_write_s;
assign_read_request : AMM_READ <= amm_read_s;
assign_addr : AMM_ADDRESS <= amm_address_s;
assign_write_wait: WAIT_REQ <= read_write_wait_ret_1_s;
assign_read_data : AMM_READ_DATA_OUT <= amm_read_data_out_s;
assign_pcie_valid : PCIE_AMM_READ_DATA_VALID <= pcie_amm_read_data_valid_s;
assign_proc_valid : PROC_AMM_READ_DATA_VALID <= proc_amm_read_data_valid_s;


end architecture synth;


