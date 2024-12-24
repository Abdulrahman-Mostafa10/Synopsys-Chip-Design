# Synthesis Constraints
set ::env(CLOCK_PERIOD) 20.0
set ::env(CLOCK_PORT) clk

# Define delays and loads
set_input_delay 1.0 [all_inputs]
set_output_delay 0.5 [all_outputs]
set_load 10.0 [all_outputs]

# Enable all library cells
set ::env(USE_ALL_CELLS) 1
