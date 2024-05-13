	component ifft1024 is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			rst        : in  std_logic                     := 'X';             -- reset_n
			validIn    : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- valid
			channelIn  : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- channel
			d          : in  std_logic_vector(63 downto 0) := (others => 'X'); -- data
			validOut   : out std_logic_vector(0 downto 0);                     -- valid
			channelOut : out std_logic_vector(7 downto 0);                     -- channel
			q          : out std_logic_vector(63 downto 0)                     -- data
		);
	end component ifft1024;

	u0 : component ifft1024
		port map (
			clk        => CONNECTED_TO_clk,        --    clk.clk
			rst        => CONNECTED_TO_rst,        --    rst.reset_n
			validIn    => CONNECTED_TO_validIn,    --   sink.valid
			channelIn  => CONNECTED_TO_channelIn,  --       .channel
			d          => CONNECTED_TO_d,          --       .data
			validOut   => CONNECTED_TO_validOut,   -- source.valid
			channelOut => CONNECTED_TO_channelOut, --       .channel
			q          => CONNECTED_TO_q           --       .data
		);

