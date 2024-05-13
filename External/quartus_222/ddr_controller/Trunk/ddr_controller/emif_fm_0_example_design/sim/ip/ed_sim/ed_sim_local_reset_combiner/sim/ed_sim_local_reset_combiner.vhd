-- ed_sim_local_reset_combiner.vhd

-- Generated using ACDS version 22.2 94

library IEEE;
library altera_emif_local_reset_combiner_191;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ed_sim_local_reset_combiner is
	port (
		local_reset_req_out_0 : out std_logic;        --   local_reset_req_out_0.local_reset_req
		local_reset_done_in_0 : in  std_logic := '0'; -- local_reset_status_in_0.local_reset_done
		clk                   : in  std_logic := '0'; --             generic_clk.clk
		reset_n               : in  std_logic := '0'; -- generic_conduit_reset_n.pll_locked
		local_reset_req       : in  std_logic := '0'; --         local_reset_req.local_reset_req,  Signal from user logic to request the memory interface to be reset and recalibrated. Reset request is sent by transitioning the local_reset_req signal from low to high, then keeping the signal at the high state for a minimum of 2 EMIF core clock cycles, then transitioning the signal from high to low. local_reset_req is asynchronous in that there is no setup/hold timing to meet, but it must meet the minimum pulse width requirement of 2 EMIF core clock cycles.
		local_reset_done      : out std_logic         --      local_reset_status.local_reset_done, Signal from memory interface to indicate whether it has completed a reset sequence, is currently out of reset, and is ready for a new reset request.  When local_reset_done is low, the memory interface is in reset.
	);
end entity ed_sim_local_reset_combiner;

architecture rtl of ed_sim_local_reset_combiner is
	component altera_emif_local_reset_combiner_cmp is
		generic (
			NUM_OF_RESET_REQ_IFS    : integer := 1;
			NUM_OF_RESET_STATUS_IFS : integer := 1
		);
		port (
			local_reset_req_out_0  : out std_logic;        -- local_reset_req
			local_reset_done_in_0  : in  std_logic := 'X'; -- local_reset_done
			clk                    : in  std_logic := 'X'; -- clk
			reset_n                : in  std_logic := 'X'; -- pll_locked
			local_reset_req        : in  std_logic := 'X'; -- local_reset_req
			local_reset_done       : out std_logic;        -- local_reset_done
			local_reset_req_out_1  : out std_logic;        -- local_reset_req
			local_reset_req_out_2  : out std_logic;        -- local_reset_req
			local_reset_req_out_3  : out std_logic;        -- local_reset_req
			local_reset_req_out_4  : out std_logic;        -- local_reset_req
			local_reset_req_out_5  : out std_logic;        -- local_reset_req
			local_reset_req_out_6  : out std_logic;        -- local_reset_req
			local_reset_req_out_7  : out std_logic;        -- local_reset_req
			local_reset_req_out_8  : out std_logic;        -- local_reset_req
			local_reset_req_out_9  : out std_logic;        -- local_reset_req
			local_reset_req_out_10 : out std_logic;        -- local_reset_req
			local_reset_req_out_11 : out std_logic;        -- local_reset_req
			local_reset_req_out_12 : out std_logic;        -- local_reset_req
			local_reset_req_out_13 : out std_logic;        -- local_reset_req
			local_reset_req_out_14 : out std_logic;        -- local_reset_req
			local_reset_req_out_15 : out std_logic;        -- local_reset_req
			local_reset_done_in_1  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_2  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_3  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_4  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_5  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_6  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_7  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_8  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_9  : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_10 : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_11 : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_12 : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_13 : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_14 : in  std_logic := 'X'; -- local_reset_done
			local_reset_done_in_15 : in  std_logic := 'X'  -- local_reset_done
		);
	end component altera_emif_local_reset_combiner_cmp;

	for local_reset_combiner : altera_emif_local_reset_combiner_cmp
		use entity altera_emif_local_reset_combiner_191.altera_emif_local_reset_combiner;
begin

	local_reset_combiner : component altera_emif_local_reset_combiner_cmp
		generic map (
			NUM_OF_RESET_REQ_IFS    => 1,
			NUM_OF_RESET_STATUS_IFS => 1
		)
		port map (
			local_reset_req_out_0  => local_reset_req_out_0, --   local_reset_req_out_0.local_reset_req
			local_reset_done_in_0  => local_reset_done_in_0, -- local_reset_status_in_0.local_reset_done
			clk                    => clk,                   --             generic_clk.clk
			reset_n                => reset_n,               -- generic_conduit_reset_n.pll_locked
			local_reset_req        => local_reset_req,       --         local_reset_req.local_reset_req
			local_reset_done       => local_reset_done,      --      local_reset_status.local_reset_done
			local_reset_req_out_1  => open,                  --             (terminated)
			local_reset_req_out_2  => open,                  --             (terminated)
			local_reset_req_out_3  => open,                  --             (terminated)
			local_reset_req_out_4  => open,                  --             (terminated)
			local_reset_req_out_5  => open,                  --             (terminated)
			local_reset_req_out_6  => open,                  --             (terminated)
			local_reset_req_out_7  => open,                  --             (terminated)
			local_reset_req_out_8  => open,                  --             (terminated)
			local_reset_req_out_9  => open,                  --             (terminated)
			local_reset_req_out_10 => open,                  --             (terminated)
			local_reset_req_out_11 => open,                  --             (terminated)
			local_reset_req_out_12 => open,                  --             (terminated)
			local_reset_req_out_13 => open,                  --             (terminated)
			local_reset_req_out_14 => open,                  --             (terminated)
			local_reset_req_out_15 => open,                  --             (terminated)
			local_reset_done_in_1  => '0',                   --             (terminated)
			local_reset_done_in_2  => '0',                   --             (terminated)
			local_reset_done_in_3  => '0',                   --             (terminated)
			local_reset_done_in_4  => '0',                   --             (terminated)
			local_reset_done_in_5  => '0',                   --             (terminated)
			local_reset_done_in_6  => '0',                   --             (terminated)
			local_reset_done_in_7  => '0',                   --             (terminated)
			local_reset_done_in_8  => '0',                   --             (terminated)
			local_reset_done_in_9  => '0',                   --             (terminated)
			local_reset_done_in_10 => '0',                   --             (terminated)
			local_reset_done_in_11 => '0',                   --             (terminated)
			local_reset_done_in_12 => '0',                   --             (terminated)
			local_reset_done_in_13 => '0',                   --             (terminated)
			local_reset_done_in_14 => '0',                   --             (terminated)
			local_reset_done_in_15 => '0'                    --             (terminated)
		);

end architecture rtl; -- of ed_sim_local_reset_combiner