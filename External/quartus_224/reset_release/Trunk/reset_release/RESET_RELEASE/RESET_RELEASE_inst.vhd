	component RESET_RELEASE is
		port (
			ninit_done : out std_logic   -- ninit_done
		);
	end component RESET_RELEASE;

	u0 : component RESET_RELEASE
		port map (
			ninit_done => CONNECTED_TO_ninit_done  -- ninit_done.ninit_done
		);

