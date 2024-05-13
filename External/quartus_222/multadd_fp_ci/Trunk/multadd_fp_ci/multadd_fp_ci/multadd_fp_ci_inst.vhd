	component multadd_fp_ci is
		port (
			fp32_mult_a  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_mult_a
			fp32_mult_b  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_mult_b
			fp32_chainin : in  std_logic_vector(31 downto 0) := (others => 'X'); -- fp32_chainin
			clr0         : in  std_logic                     := 'X';             -- reset
			clr1         : in  std_logic                     := 'X';             -- reset
			clk          : in  std_logic                     := 'X';             -- clk
			ena          : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- ena
			fp32_result  : out std_logic_vector(31 downto 0)                     -- fp32_result
		);
	end component multadd_fp_ci;

	u0 : component multadd_fp_ci
		port map (
			fp32_mult_a  => CONNECTED_TO_fp32_mult_a,  --  fp32_mult_a.fp32_mult_a
			fp32_mult_b  => CONNECTED_TO_fp32_mult_b,  --  fp32_mult_b.fp32_mult_b
			fp32_chainin => CONNECTED_TO_fp32_chainin, -- fp32_chainin.fp32_chainin
			clr0         => CONNECTED_TO_clr0,         --         clr0.reset
			clr1         => CONNECTED_TO_clr1,         --         clr1.reset
			clk          => CONNECTED_TO_clk,          --          clk.clk
			ena          => CONNECTED_TO_ena,          --          ena.ena
			fp32_result  => CONNECTED_TO_fp32_result   --  fp32_result.fp32_result
		);

