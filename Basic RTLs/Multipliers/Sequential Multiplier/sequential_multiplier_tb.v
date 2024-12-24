`timescale 1ns / 1ps
module sequential_multiplier_tb;
    reg signed [31:0] a;
    reg signed [31:0] b;
    reg clk;
    reg reset;
    wire signed [63:0] mult;
    integer passed = 0;  // To track the number of passed test cases
    sequential_multiplier uut (
        .a(a),
        .b(b),
        .clk(clk),
        .reset(reset),
        .mult(mult)
    );

    always #10 clk = ~clk;


    initial begin
        clk = 0;
        // Test case 1: Positive * Negative
        reset = 1; 
        a = 32'd10;
        b = -32'd5;
        #40;
        reset = 0; 
        #660;
        if (mult == -50) begin
	passed = passed + 1;
            $display("TestCase#1: success");
        end else begin
            $display("TestCase#1: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 2: Positive * Positive
        reset = 1; 
        a = 32'd5;
        b = 32'd20;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd100) begin
	passed = passed + 1;
            $display("TestCase#2: success");
        end else begin
            $display("TestCase#2: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 3: Negative * Negative
        reset = 1; 
        a = -32'd4;
        b = -32'd8;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd32) begin
           passed = passed + 1; 
	   $display("TestCase#3: success");
        end else begin
            $display("TestCase#3: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 4: Negative * Positive
        reset = 1; 
        a= -32'd9;
        b = 32'd5;
        #40;
        reset = 0; 
        #660;
        if (mult == -45) begin
	    passed = passed + 1;
            $display("TestCase#4: success");
        end else begin
            $display("TestCase#4: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 5: Multiplication by zero
        reset = 1; 
        a = 0;
        b = 32'd30;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd0) begin
	    passed = passed + 1;
            $display("TestCase#5: success");
        end else begin
            $display("TestCase#5: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 6: Multiplication by one
        reset = 1; 
        a = 32'd1;
        b = 32'd10;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd10) begin
	    passed = passed + 1;
            $display("TestCase#6: success");
        end else begin
            $display("TestCase#6: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 7: Random Test Case 1
        reset = 1; 
        a = 32'd6;
        b = 32'd6;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd36) begin
	    passed = passed + 1;
            $display("TestCase#7: success");
        end else begin
            $display("TestCase#7: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end

        // Test case 8: Random Test Case 2
        reset = 1; 
        a= -32'd20;
        b = -32'd4;
        #40;
        reset = 0; 
        #660;
        if (mult == 32'd80) begin
	    passed = passed + 1;
            $display("TestCase#8: success");
        end else begin
            $display("TestCase#8: failed with input A = %d, B = %d, Output = %d", a, b, mult);
        end
 	// Final report: total number of successful test cases
        $display("Total Successful Test Cases: %d", passed);
    end
endmodule
