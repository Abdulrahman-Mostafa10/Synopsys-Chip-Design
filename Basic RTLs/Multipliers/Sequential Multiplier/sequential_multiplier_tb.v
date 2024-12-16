
`timescale 1ns/1ps
module multiplier_tb;
    reg signed [31:0] a, b;
    wire signed [63:0] mult;  // Output of multiplication
    integer passed = 0;  // To track the number of passed test cases

    // Instantiate the multiplier module
    sequential_multiplier_sn multiplier (
        .a(a),
        .b(b),
        .mult(mult)
    );

    initial begin
        // TestCase#1: Multiplying a positive and a negative number
        a = 32'd25;       // positive
        b = -32'd4;       // negative
        #10;
        if (mult !== -100) begin
            $display("TestCase#1: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#1: success");
        end
        
        // TestCase#2: Multiplying two positive numbers
        a = 32'd15;       // positive
        b = 32'd3;        // positive
        #10;
        if (mult !== 45) begin
            $display("TestCase#2: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#2: success");
        end
        
        // TestCase#3: Multiplying two negative numbers
        a = -32'd10;      // negative
        b = -32'd5;       // negative
        #10;
        if (mult !== 50) begin
            $display("TestCase#3: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#3: success");
        end
        
        // TestCase#4: Multiplying a negative and a positive number
        a = -32'd7;       // negative
        b = 32'd6;        // positive
        #10;
        if (mult !== -42) begin
            $display("TestCase#4: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#4: success");
        end
        
        // TestCase#5: Multiplying by zero
        a = 32'd0;        // zero
        b = 32'd14;       // positive
        #10;
        if (mult !== 0) begin
            $display("TestCase#5: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#5: success");
        end
        
        // TestCase#6: Multiplying by one
        a = 32'd1;        // one
        b = 32'd99;       // positive
        #10;
        if (mult !== 99) begin
            $display("TestCase#6: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#6: success");
        end
        
        // TestCase#7: Random case 1
        a = 32'd12345;     // positive
        b = -32'd6789;     // negative
        #10;
        if (mult !== -83810205) begin
            $display("TestCase#7: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#7: success");
        end
        
        // TestCase#8: Random case 2
        a = -32'd5432;     // negative
        b = 32'd1234;      // positive
        #10;
        if (mult !== -6703088) begin
            $display("TestCase#8: failed with input a=%d, b=%d, output mult=%d", a, b, mult);
        end else begin
            passed = passed + 1;
            $display("TestCase#8: success");
        end
        
        // Final report: total number of successful test cases
        $display("Total Successful Test Cases: %d", passed);
    end
endmodule
