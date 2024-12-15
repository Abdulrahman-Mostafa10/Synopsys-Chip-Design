
module carry_ripple_adder_bypass(
    input wire [3:0] a,        // 4-bit input a
    input wire [3:0] b,        // 4-bit input b
    input wire cin,            // Carry-in
    output wire [3:0] out,     // Sum output
    output wire bypass,        // Bypass signal
    output wire cout           // Carry-out
);

// Array for storing carry and propagate signals
wire [3:0] carry;
wire [3:0] propagate;

// Generate block to instantiate the full adders
genvar index;
generate 
    for (index = 0; index < 4; index = index + 1) begin : full_adder
        full_adder FA (
            .a(a[index]),               // Pass a[index] to the full adder
            .b(b[index]),               // Pass b[index] to the full adder
            .cin((index == 0) ? cin : carry[index - 1]), // Carry-in logic
            .out(out[index]),           // Sum output
            .propagate(propagate[index]),  // Propagate signal
            .cout(carry[index])        // Carry-out
        );
    end
endgenerate

// Calculate bypass as the AND of all propagate signals
assign bypass = propagate[0] & propagate[1] & propagate[2] & propagate[3];

// Carry-out is the carry from the last adder
assign cout = carry[3];

endmodule