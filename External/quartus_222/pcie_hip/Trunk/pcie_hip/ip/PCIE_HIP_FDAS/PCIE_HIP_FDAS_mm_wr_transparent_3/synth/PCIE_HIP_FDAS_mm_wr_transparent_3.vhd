-- PCIE_HIP_FDAS_mm_wr_transparent_3.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
library mm_wr_transparent_10;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCIE_HIP_FDAS_mm_wr_transparent_3 is
	generic (
		DATA_WIDTH       : integer := 512;
		BYTE_SIZE        : integer := 8;
		ADDRESS_WIDTH    : integer := 26;
		BURSTCOUNT_WIDTH : integer := 4
	);
	port (
		clk            : in  std_logic                                                       := '0';             -- clock.clk
		reset          : in  std_logic                                                       := '0';             -- reset.reset
		s0_waitrequest : out std_logic;                                                                          --    s0.waitrequest
		s0_burstcount  : in  std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0)       := (others => '0'); --      .burstcount
		s0_writedata   : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => '0'); --      .writedata
		s0_address     : in  std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0)          := (others => '0'); --      .address
		s0_write       : in  std_logic                                                       := '0';             --      .write
		s0_byteenable  : in  std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0) := (others => '0'); --      .byteenable
		m0_waitrequest : in  std_logic                                                       := '0';             --    m0.waitrequest
		m0_burstcount  : out std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0);                          --      .burstcount
		m0_writedata   : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                --      .writedata
		m0_address     : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                             --      .address
		m0_write       : out std_logic;                                                                          --      .write
		m0_byteenable  : out std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0)                     --      .byteenable
	);
end entity PCIE_HIP_FDAS_mm_wr_transparent_3;

architecture rtl of PCIE_HIP_FDAS_mm_wr_transparent_3 is
	component mm_wr_transparent_cmp is
		generic (
			DATA_WIDTH       : integer := 256;
			BYTE_SIZE        : integer := 8;
			ADDRESS_WIDTH    : integer := 32;
			BURSTCOUNT_WIDTH : integer := 4
		);
		port (
			clk            : in  std_logic                                                       := 'X';             -- clk
			reset          : in  std_logic                                                       := 'X';             -- reset
			s0_waitrequest : out std_logic;                                                                          -- waitrequest
			s0_burstcount  : in  std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0)       := (others => 'X'); -- burstcount
			s0_writedata   : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => 'X'); -- writedata
			s0_address     : in  std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0)          := (others => 'X'); -- address
			s0_write       : in  std_logic                                                       := 'X';             -- write
			s0_byteenable  : in  std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0) := (others => 'X'); -- byteenable
			m0_waitrequest : in  std_logic                                                       := 'X';             -- waitrequest
			m0_burstcount  : out std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0);                          -- burstcount
			m0_writedata   : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                -- writedata
			m0_address     : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                             -- address
			m0_write       : out std_logic;                                                                          -- write
			m0_byteenable  : out std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0)                     -- byteenable
		);
	end component mm_wr_transparent_cmp;

	for mm_wr_transparent_3 : mm_wr_transparent_cmp
		use entity mm_wr_transparent_10.mm_wr_transparent;
begin

	mm_wr_transparent_3 : component mm_wr_transparent_cmp
		generic map (
			DATA_WIDTH       => DATA_WIDTH,
			BYTE_SIZE        => BYTE_SIZE,
			ADDRESS_WIDTH    => ADDRESS_WIDTH,
			BURSTCOUNT_WIDTH => BURSTCOUNT_WIDTH
		)
		port map (
			clk            => clk,            -- clock.clk
			reset          => reset,          -- reset.reset
			s0_waitrequest => s0_waitrequest, --    s0.waitrequest
			s0_burstcount  => s0_burstcount,  --      .burstcount
			s0_writedata   => s0_writedata,   --      .writedata
			s0_address     => s0_address,     --      .address
			s0_write       => s0_write,       --      .write
			s0_byteenable  => s0_byteenable,  --      .byteenable
			m0_waitrequest => m0_waitrequest, --    m0.waitrequest
			m0_burstcount  => m0_burstcount,  --      .burstcount
			m0_writedata   => m0_writedata,   --      .writedata
			m0_address     => m0_address,     --      .address
			m0_write       => m0_write,       --      .write
			m0_byteenable  => m0_byteenable   --      .byteenable
		);

end architecture rtl; -- of PCIE_HIP_FDAS_mm_wr_transparent_3
