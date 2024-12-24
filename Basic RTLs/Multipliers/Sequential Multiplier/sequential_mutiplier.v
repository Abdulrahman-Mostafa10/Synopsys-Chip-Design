module sequential_multiplier (
    input signed [31:0] a,   // Multiplier
    input signed [31:0] b,   // Multiplicand
    input clk,               
    input reset,             
    output reg signed [63:0] mult // Output product
);
    reg signed [63:0] multiplicand;  // Sign-extended multiplicand
    reg signed [63:0] product;       // Accumulating product
    reg [31:0] multiplier;           // Unsigned multiplier (explicit handling for sign)
    reg [5:0] count;                 // Counter for 32 cycles

    always @(posedge clk) begin
        if (reset) begin
            product <= 64'b0;                        // Clear product
            multiplicand <= {{32{b[31]}}, b};        // Sign-extend b to 64 bits
            multiplier <= a[31] ? ~a + 1 : a;        // Take absolute value of a
            count <= 6'b0;                           // Reset counter
            mult <= 64'b0;                           // Clear output
        end else begin
            if (count < 32) begin
                if (multiplier[0] == 1) begin        // Check the LSB of the multiplier
                    product <= product + multiplicand; // Add multiplicand if bit is 1
                end
                multiplicand <= multiplicand << 1;   // Shift multiplicand left
                multiplier <= multiplier >> 1;       // Shift multiplier right (unsigned shift)
                count <= count + 1;                  // Increment counter
            end else begin
                if (a[31]) begin
                    mult <= ~product + 1;            // Negate product if a was negative
                end else begin
                    mult <= product;                 // Assign product directly
                end
            end
        end
    end
endmodule
