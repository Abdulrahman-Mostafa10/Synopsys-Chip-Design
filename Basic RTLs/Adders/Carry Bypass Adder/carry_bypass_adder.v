module carry_bypass_adder(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire cin,
    output wire [31:0] sum,
    output wire cout,
    output wire overflow
);

    wire [7:0] carry;
    wire [7:0] bypass;
    wire [7:0] carry_bypass;
    
    genvar index;
    generate 
        for (index = 0; index < 8; index = index + 1) begin: carry_ripple
            // 4-bit Ripple Carry Adder Block
            carry_ripple_adder_bypass RA(
                .a(a[4*index +: 4]),  // 4 bits from a
                .b(b[4*index +: 4]),  // 4 bits from b
                .cin((index == 0) ? cin : carry_bypass[index-1]),  // Cin for first adder, else use carry from previous block
                .out(sum[4*index +: 4]),  // Store 4 bits of sum
                .bypass(bypass[index]),   // Propagate signal
                .cout(carry[index])       // Carry-out from the adder
            );

            // MUX to decide whether to use normal carry or bypassed carry
            mux_2x1 mux(
                .a(carry[index]),  // Carry from current block
                .b((index == 0) ? cin : carry_bypass[index - 1]), // Previous carry or Cin
                .sel(bypass[index]),  // Select carry based on bypass signal
                .out(carry_bypass[index])  // Output carry for next block
            );
        end
    endgenerate

    // Overflow detection: It occurs if the sign bits of a, b, and sum are different
    assign overflow = (a[31] == b[31]) && (a[31] != sum[31]);

    // Final carry-out (from last adder block)
    assign cout = carry_bypass[7];

endmodule

