# Define a virtual clock with a 20ns period
create_clock -period 20 [get_ports clk]

# Define input delay of 1ns for all input ports
set_input_delay 1 [all_inputs] -clock [get_clocks clk]

# Define output delay of 0.5ns for all output ports
set_output_delay 0.5 [all_outputs] -clock [get_clocks clk]

# Define load of 10 for all output ports
set_load 10 [all_outputs]
