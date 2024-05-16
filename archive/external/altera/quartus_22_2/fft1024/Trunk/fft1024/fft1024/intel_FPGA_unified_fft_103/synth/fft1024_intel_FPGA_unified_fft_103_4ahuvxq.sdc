create_clock -period 2.857 -name {clk} [get_ports {clk}]

# find any clock pin to use as a reference pin to reduce clock skew
set sys_regs [query_collection -list_format [get_fanouts -through [get_pins -hierarchical *|clk] clk]]

# make reset synchronous with the clock
set_input_delay -clock clk -reference_pin  [lindex $sys_regs 0]|clk 0 rst
