	component mult_fp_co is
		port (
			fp32_mult_a   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_mult_a
			fp32_mult_b   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_mult_b
			clr0          : in  std_logic                     := 'X';             -- reset
			clr1          : in  std_logic                     := 'X';             -- reset
			clk           : in  std_logic                     := 'X';             -- clk
			ena           : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- ena
			fp32_result   : out std_logic_vector(31 downto 0);                    -- fp32_result
			fp32_chainout : out std_logic_vector(31 downto 0)                     -- fp32_chainout
		);
	end component mult_fp_co;

	u0 : component mult_fp_co
		port map (
			fp32_mult_a   => CONNECTED_TO_fp32_mult_a,   --   fp32_mult_a.fp32_mult_a
			fp32_mult_b   => CONNECTED_TO_fp32_mult_b,   --   fp32_mult_b.fp32_mult_b
			clr0          => CONNECTED_TO_clr0,          --          clr0.reset
			clr1          => CONNECTED_TO_clr1,          --          clr1.reset
			clk           => CONNECTED_TO_clk,           --           clk.clk
			ena           => CONNECTED_TO_ena,           --           ena.ena
			fp32_result   => CONNECTED_TO_fp32_result,   --   fp32_result.fp32_result
			fp32_chainout => CONNECTED_TO_fp32_chainout  -- fp32_chainout.fp32_chainout
		);

