	component PCIE_HIP_FDAS_mm_wr_transparent_2 is
		generic (
			DATA_WIDTH       : integer := 512;
			BYTE_SIZE        : integer := 8;
			ADDRESS_WIDTH    : integer := 26;
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
	end component PCIE_HIP_FDAS_mm_wr_transparent_2;

	u0 : component PCIE_HIP_FDAS_mm_wr_transparent_2
		generic map (
			DATA_WIDTH       => INTEGER_VALUE_FOR_DATA_WIDTH,
			BYTE_SIZE        => INTEGER_VALUE_FOR_BYTE_SIZE,
			ADDRESS_WIDTH    => INTEGER_VALUE_FOR_ADDRESS_WIDTH,
			BURSTCOUNT_WIDTH => INTEGER_VALUE_FOR_BURSTCOUNT_WIDTH
		)
		port map (
			clk            => CONNECTED_TO_clk,            -- clock.clk
			reset          => CONNECTED_TO_reset,          -- reset.reset
			s0_waitrequest => CONNECTED_TO_s0_waitrequest, --    s0.waitrequest
			s0_burstcount  => CONNECTED_TO_s0_burstcount,  --      .burstcount
			s0_writedata   => CONNECTED_TO_s0_writedata,   --      .writedata
			s0_address     => CONNECTED_TO_s0_address,     --      .address
			s0_write       => CONNECTED_TO_s0_write,       --      .write
			s0_byteenable  => CONNECTED_TO_s0_byteenable,  --      .byteenable
			m0_waitrequest => CONNECTED_TO_m0_waitrequest, --    m0.waitrequest
			m0_burstcount  => CONNECTED_TO_m0_burstcount,  --      .burstcount
			m0_writedata   => CONNECTED_TO_m0_writedata,   --      .writedata
			m0_address     => CONNECTED_TO_m0_address,     --      .address
			m0_write       => CONNECTED_TO_m0_write,       --      .write
			m0_byteenable  => CONNECTED_TO_m0_byteenable   --      .byteenable
		);

