// Testbench for 32-bit RCA
module ripple_carry_adder_tb;
    reg signed [31:0] a, b;
    reg cin;
    reg clk;
    wire signed [31:0] sum;
    wire cout, overflow;

    integer success_count = 0;
    integer failure_count = 0;
    integer test_case = 1;

    // Instantiate the RCA module
    ripple_carry_adder_routing uut (
        .a(a),
        .b(b),
        .cin(cin),
        .clk(clk),
        .sum(sum),
        .cout(cout),
        .overflow(overflow)
    );

    task run_test;
        input signed [31:0] input_a;
        input signed [31:0] input_b;
        input input_cin;
        input signed [31:0] expected_sum;
        input expected_overflow;
        begin
            a = input_a;
            b = input_b;
            cin = input_cin;
            #10; // Wait for propagation
            if (sum === expected_sum && overflow === expected_overflow) begin
                $display("TestCase#%0d: success", test_case);
                success_count = success_count + 1;
            end else begin
                $display("TestCase#%0d: failed with input %0d and %0d and output %0d and overflow status %0d", 
                    test_case, a, b, sum, overflow);
                failure_count = failure_count + 1;
            end
            test_case = test_case + 1;
        end
    endtask

    initial begin
        // Test cases
        clk =0;
        
        run_test(32'sd2147483647, 32'sd1, 1'b0, -32'sd2147483648, 1'b1); // Overflow of positive numbers
        run_test(-32'sd2147483648, -32'sd1, 1'b0, 32'sd2147483647, 1'b1); // Overflow of negative numbers
        run_test(32'sd100, -32'sd50, 1'b0, 32'sd50, 1'b0); // Positive and negative
        run_test(32'sd12345, 32'sd54321, 1'b0, 32'sd66666, 1'b0); // Two positive numbers
        run_test(-32'sd12345, -32'sd54321, 1'b0, -32'sd66666, 1'b0); // Two negative numbers

        // Random cases
        run_test(32'sd123456, -32'sd654321, 1'b0, -32'sd530865, 1'b0);
        run_test(32'sd0, 32'sd0, 1'b0, 32'sd0, 1'b0);
        run_test(-32'sd100000, 32'sd99999, 1'b0, -32'sd1, 1'b0);

        // Summary report
        $display("Total Success Cases: %0d", success_count);
        $display("Total Failure Cases: %0d", failure_count);
        $finish;
    end
endmodule