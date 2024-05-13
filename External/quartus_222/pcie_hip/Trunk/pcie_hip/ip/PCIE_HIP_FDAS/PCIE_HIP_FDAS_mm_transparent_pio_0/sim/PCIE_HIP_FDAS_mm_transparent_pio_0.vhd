-- PCIE_HIP_FDAS_mm_transparent_pio_0.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
library mm_transparent_pio_10;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PCIE_HIP_FDAS_mm_transparent_pio_0 is
	generic (
		DATA_WIDTH       : integer := 64;
		BYTE_SIZE        : integer := 8;
		ADDRESS_WIDTH    : integer := 22;
		BURSTCOUNT_WIDTH : integer := 1;
		RESPONSE_WIDTH   : integer := 2
	);
	port (
		clk                   : in  std_logic                                                       := '0';             -- clock.clk
		reset                 : in  std_logic                                                       := '0';             -- reset.reset
		s0_waitrequest        : out std_logic;                                                                          --    s0.waitrequest
		s0_readdata           : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                --      .readdata
		s0_readdatavalid      : out std_logic;                                                                          --      .readdatavalid
		s0_writeresponsevalid : out std_logic;                                                                          --      .writeresponsevalid
		s0_response           : out std_logic_vector((((RESPONSE_WIDTH-1)-0)+1)-1 downto 0);                            --      .response
		s0_burstcount         : in  std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0)       := (others => '0'); --      .burstcount
		s0_writedata          : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => '0'); --      .writedata
		s0_address            : in  std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0)          := (others => '0'); --      .address
		s0_write              : in  std_logic                                                       := '0';             --      .write
		s0_read               : in  std_logic                                                       := '0';             --      .read
		s0_byteenable         : in  std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0) := (others => '0'); --      .byteenable
		m0_waitrequest        : in  std_logic                                                       := '0';             --    m0.waitrequest
		m0_readdata           : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => '0'); --      .readdata
		m0_readdatavalid      : in  std_logic                                                       := '0';             --      .readdatavalid
		m0_writeresponsevalid : in  std_logic                                                       := '0';             --      .writeresponsevalid
		m0_response           : in  std_logic_vector((((RESPONSE_WIDTH-1)-0)+1)-1 downto 0)         := (others => '0'); --      .response
		m0_burstcount         : out std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0);                          --      .burstcount
		m0_writedata          : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                --      .writedata
		m0_address            : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                             --      .address
		m0_write              : out std_logic;                                                                          --      .write
		m0_read               : out std_logic;                                                                          --      .read
		m0_byteenable         : out std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0)                     --      .byteenable
	);
end entity PCIE_HIP_FDAS_mm_transparent_pio_0;

architecture rtl of PCIE_HIP_FDAS_mm_transparent_pio_0 is
	component mm_transparent_pio_cmp is
		generic (
			DATA_WIDTH       : integer := 32;
			BYTE_SIZE        : integer := 8;
			ADDRESS_WIDTH    : integer := 20;
			BURSTCOUNT_WIDTH : integer := 4;
			RESPONSE_WIDTH   : integer := 2
		);
		port (
			clk                   : in  std_logic                                                       := 'X';             -- clk
			reset                 : in  std_logic                                                       := 'X';             -- reset
			s0_waitrequest        : out std_logic;                                                                          -- waitrequest
			s0_readdata           : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                -- readdata
			s0_readdatavalid      : out std_logic;                                                                          -- readdatavalid
			s0_writeresponsevalid : out std_logic;                                                                          -- writeresponsevalid
			s0_response           : out std_logic_vector((((RESPONSE_WIDTH-1)-0)+1)-1 downto 0);                            -- response
			s0_burstcount         : in  std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0)       := (others => 'X'); -- burstcount
			s0_writedata          : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => 'X'); -- writedata
			s0_address            : in  std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0)          := (others => 'X'); -- address
			s0_write              : in  std_logic                                                       := 'X';             -- write
			s0_read               : in  std_logic                                                       := 'X';             -- read
			s0_byteenable         : in  std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0) := (others => 'X'); -- byteenable
			m0_waitrequest        : in  std_logic                                                       := 'X';             -- waitrequest
			m0_readdata           : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)             := (others => 'X'); -- readdata
			m0_readdatavalid      : in  std_logic                                                       := 'X';             -- readdatavalid
			m0_writeresponsevalid : in  std_logic                                                       := 'X';             -- writeresponsevalid
			m0_response           : in  std_logic_vector((((RESPONSE_WIDTH-1)-0)+1)-1 downto 0)         := (others => 'X'); -- response
			m0_burstcount         : out std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0);                          -- burstcount
			m0_writedata          : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                -- writedata
			m0_address            : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                             -- address
			m0_write              : out std_logic;                                                                          -- write
			m0_read               : out std_logic;                                                                          -- read
			m0_byteenable         : out std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0)                     -- byteenable
		);
	end component mm_transparent_pio_cmp;

	for mm_transparent_pio_0 : mm_transparent_pio_cmp
		use entity mm_transparent_pio_10.mm_transparent_pio;
begin

	mm_transparent_pio_0 : component mm_transparent_pio_cmp
		generic map (
			DATA_WIDTH       => DATA_WIDTH,
			BYTE_SIZE        => BYTE_SIZE,
			ADDRESS_WIDTH    => ADDRESS_WIDTH,
			BURSTCOUNT_WIDTH => BURSTCOUNT_WIDTH,
			RESPONSE_WIDTH   => RESPONSE_WIDTH
		)
		port map (
			clk                   => clk,                   -- clock.clk
			reset                 => reset,                 -- reset.reset
			s0_waitrequest        => s0_waitrequest,        --    s0.waitrequest
			s0_readdata           => s0_readdata,           --      .readdata
			s0_readdatavalid      => s0_readdatavalid,      --      .readdatavalid
			s0_writeresponsevalid => s0_writeresponsevalid, --      .writeresponsevalid
			s0_response           => s0_response,           --      .response
			s0_burstcount         => s0_burstcount,         --      .burstcount
			s0_writedata          => s0_writedata,          --      .writedata
			s0_address            => s0_address,            --      .address
			s0_write              => s0_write,              --      .write
			s0_read               => s0_read,               --      .read
			s0_byteenable         => s0_byteenable,         --      .byteenable
			m0_waitrequest        => m0_waitrequest,        --    m0.waitrequest
			m0_readdata           => m0_readdata,           --      .readdata
			m0_readdatavalid      => m0_readdatavalid,      --      .readdatavalid
			m0_writeresponsevalid => m0_writeresponsevalid, --      .writeresponsevalid
			m0_response           => m0_response,           --      .response
			m0_burstcount         => m0_burstcount,         --      .burstcount
			m0_writedata          => m0_writedata,          --      .writedata
			m0_address            => m0_address,            --      .address
			m0_write              => m0_write,              --      .write
			m0_read               => m0_read,               --      .read
			m0_byteenable         => m0_byteenable          --      .byteenable
		);

end architecture rtl; -- of PCIE_HIP_FDAS_mm_transparent_pio_0