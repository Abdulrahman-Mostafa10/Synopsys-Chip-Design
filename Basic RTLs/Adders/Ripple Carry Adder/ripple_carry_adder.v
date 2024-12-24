module ripple_carry_adder(
    input signed [31:0] a,
    input signed [31:0] b,
    input clk,
    input cin,
    output signed [31:0] sum,
    output cout,
    output overflow
);
    wire [32:0] carry; // Intermediate carry
    assign carry[0] = cin;

    // Generate 32 full adders for each bit
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : bit_adder
                full_adder FA (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );        
            end
    endgenerate

    assign cout = carry[32]; // Final carry out
    assign overflow = carry[31] ^ carry[32]; // Overflow detection for signed addition
endmodule