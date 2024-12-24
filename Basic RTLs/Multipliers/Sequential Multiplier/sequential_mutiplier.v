module sequential_multiplier (
    input wire [31:0] a, // Multiplier
    input wire [31:0] b, // Multiplicand
    output reg [63:0] mult // Product
);
    reg [63:0] temp_mul; // Temporary register for accumulation
    reg [63:0] temp_b;   // Sign-extended multiplicand
    integer i;           // Loop index

    always @(*) begin
        temp_mul = 64'b0; // Initialize the product to zero
        temp_b = { {32{b[31]}}, b }; // Sign-extend multiplicand

        // Loop through each bit of the multiplier
        for (i = 0; i < 32; i = i + 1) begin
            if (a[i] == 1'b1) begin
                if (i == 31 && a[i] == 1'b1) 
                    temp_mul = temp_mul - (temp_b << i); // Subtract for negative MSB
                else
                    temp_mul = temp_mul + (temp_b << i); // Add for positive bits
            end
        end
    end

    // Assign the final result to the output (use blocking assignment since temp_mul is reg)
    always @(*) begin
        mult = temp_mul;
    end
endmodule

