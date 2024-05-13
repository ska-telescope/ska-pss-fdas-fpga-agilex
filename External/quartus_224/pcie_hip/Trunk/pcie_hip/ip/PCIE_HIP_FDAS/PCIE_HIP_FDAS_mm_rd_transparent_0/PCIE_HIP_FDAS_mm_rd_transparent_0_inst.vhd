	component PCIE_HIP_FDAS_mm_rd_transparent_0 is
		generic (
			DATA_WIDTH       : integer := 512;
			BYTE_SIZE        : integer := 8;
			ADDRESS_WIDTH    : integer := 26;
			BURSTCOUNT_WIDTH : integer := 4
		);
		port (
			clk              : in  std_logic                                                 := 'X';             -- clk
			reset            : in  std_logic                                                 := 'X';             -- reset
			s0_waitrequest   : out std_logic;                                                                    -- waitrequest
			s0_readdata      : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                          -- readdata
			s0_readdatavalid : out std_logic;                                                                    -- readdatavalid
			s0_response      : out std_logic_vector(1 downto 0);                                                 -- response
			s0_burstcount    : in  std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0) := (others => 'X'); -- burstcount
			s0_address       : in  std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0)    := (others => 'X'); -- address
			s0_read          : in  std_logic                                                 := 'X';             -- read
			m0_waitrequest   : in  std_logic                                                 := 'X';             -- waitrequest
			m0_readdata      : in  std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0)       := (others => 'X'); -- readdata
			m0_readdatavalid : in  std_logic                                                 := 'X';             -- readdatavalid
			m0_response      : in  std_logic_vector(1 downto 0)                              := (others => 'X'); -- response
			m0_burstcount    : out std_logic_vector((((BURSTCOUNT_WIDTH-1)-0)+1)-1 downto 0);                    -- burstcount
			m0_address       : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                       -- address
			m0_read          : out std_logic                                                                     -- read
		);
	end component PCIE_HIP_FDAS_mm_rd_transparent_0;

	u0 : component PCIE_HIP_FDAS_mm_rd_transparent_0
		generic map (
			DATA_WIDTH       => INTEGER_VALUE_FOR_DATA_WIDTH,
			BYTE_SIZE        => INTEGER_VALUE_FOR_BYTE_SIZE,
			ADDRESS_WIDTH    => INTEGER_VALUE_FOR_ADDRESS_WIDTH,
			BURSTCOUNT_WIDTH => INTEGER_VALUE_FOR_BURSTCOUNT_WIDTH
		)
		port map (
			clk              => CONNECTED_TO_clk,              -- clock.clk
			reset            => CONNECTED_TO_reset,            -- reset.reset
			s0_waitrequest   => CONNECTED_TO_s0_waitrequest,   --    s0.waitrequest
			s0_readdata      => CONNECTED_TO_s0_readdata,      --      .readdata
			s0_readdatavalid => CONNECTED_TO_s0_readdatavalid, --      .readdatavalid
			s0_response      => CONNECTED_TO_s0_response,      --      .response
			s0_burstcount    => CONNECTED_TO_s0_burstcount,    --      .burstcount
			s0_address       => CONNECTED_TO_s0_address,       --      .address
			s0_read          => CONNECTED_TO_s0_read,          --      .read
			m0_waitrequest   => CONNECTED_TO_m0_waitrequest,   --    m0.waitrequest
			m0_readdata      => CONNECTED_TO_m0_readdata,      --      .readdata
			m0_readdatavalid => CONNECTED_TO_m0_readdatavalid, --      .readdatavalid
			m0_response      => CONNECTED_TO_m0_response,      --      .response
			m0_burstcount    => CONNECTED_TO_m0_burstcount,    --      .burstcount
			m0_address       => CONNECTED_TO_m0_address,       --      .address
			m0_read          => CONNECTED_TO_m0_read           --      .read
		);

