	component PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0 is
		generic (
			DATA_WIDTH     : integer := 64;
			BYTE_SIZE      : integer := 8;
			ADDRESS_WIDTH  : integer := 22;
			RESPONSE_WIDTH : integer := 2
		);
		port (
			clk                   : in  std_logic                                                       := 'X';             -- clk
			reset                 : in  std_logic                                                       := 'X';             -- reset
			s0_waitrequest        : out std_logic;                                                                          -- waitrequest
			s0_readdata           : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                -- readdata
			s0_readdatavalid      : out std_logic;                                                                          -- readdatavalid
			s0_writeresponsevalid : out std_logic;                                                                          -- writeresponsevalid
			s0_response           : out std_logic_vector((((RESPONSE_WIDTH-1)-0)+1)-1 downto 0);                            -- response
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
			m0_writedata          : out std_logic_vector((((DATA_WIDTH-1)-0)+1)-1 downto 0);                                -- writedata
			m0_address            : out std_logic_vector((((ADDRESS_WIDTH-1)-0)+1)-1 downto 0);                             -- address
			m0_write              : out std_logic;                                                                          -- write
			m0_read               : out std_logic;                                                                          -- read
			m0_byteenable         : out std_logic_vector(((((DATA_WIDTH/BYTE_SIZE)-1)-0)+1)-1 downto 0)                     -- byteenable
		);
	end component PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0;

	u0 : component PCIE_HIP_FDAS_mm_transparent_no_burst_pio_0
		generic map (
			DATA_WIDTH     => INTEGER_VALUE_FOR_DATA_WIDTH,
			BYTE_SIZE      => INTEGER_VALUE_FOR_BYTE_SIZE,
			ADDRESS_WIDTH  => INTEGER_VALUE_FOR_ADDRESS_WIDTH,
			RESPONSE_WIDTH => INTEGER_VALUE_FOR_RESPONSE_WIDTH
		)
		port map (
			clk                   => CONNECTED_TO_clk,                   -- clock.clk
			reset                 => CONNECTED_TO_reset,                 -- reset.reset
			s0_waitrequest        => CONNECTED_TO_s0_waitrequest,        --    s0.waitrequest
			s0_readdata           => CONNECTED_TO_s0_readdata,           --      .readdata
			s0_readdatavalid      => CONNECTED_TO_s0_readdatavalid,      --      .readdatavalid
			s0_writeresponsevalid => CONNECTED_TO_s0_writeresponsevalid, --      .writeresponsevalid
			s0_response           => CONNECTED_TO_s0_response,           --      .response
			s0_writedata          => CONNECTED_TO_s0_writedata,          --      .writedata
			s0_address            => CONNECTED_TO_s0_address,            --      .address
			s0_write              => CONNECTED_TO_s0_write,              --      .write
			s0_read               => CONNECTED_TO_s0_read,               --      .read
			s0_byteenable         => CONNECTED_TO_s0_byteenable,         --      .byteenable
			m0_waitrequest        => CONNECTED_TO_m0_waitrequest,        --    m0.waitrequest
			m0_readdata           => CONNECTED_TO_m0_readdata,           --      .readdata
			m0_readdatavalid      => CONNECTED_TO_m0_readdatavalid,      --      .readdatavalid
			m0_writeresponsevalid => CONNECTED_TO_m0_writeresponsevalid, --      .writeresponsevalid
			m0_response           => CONNECTED_TO_m0_response,           --      .response
			m0_writedata          => CONNECTED_TO_m0_writedata,          --      .writedata
			m0_address            => CONNECTED_TO_m0_address,            --      .address
			m0_write              => CONNECTED_TO_m0_write,              --      .write
			m0_read               => CONNECTED_TO_m0_read,               --      .read
			m0_byteenable         => CONNECTED_TO_m0_byteenable          --      .byteenable
		);

