	component ed_synth_ninit_done is
		port (
			ninit_done : out std_logic   -- reset
		);
	end component ed_synth_ninit_done;

	u0 : component ed_synth_ninit_done
		port map (
			ninit_done => CONNECTED_TO_ninit_done  -- ninit_done.reset
		);

