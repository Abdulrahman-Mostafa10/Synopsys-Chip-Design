`timescale 1ns/1ps

module carry_bypass_adder_tb;
  reg clk;                // Clock signal
  reg signed [31:0] a, b;
  reg cin;

  wire signed [31:0] sum;
  wire cout, overflow;

  carry_bypass_adder_routing BPA (
    .a(a),
    .b(b),
    .cin(cin),
    .clk(clk),
    .sum(sum),
    .cout(cout),
    .overflow(overflow)
  );
   // Generate the clock signal
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Clock period = 20ns (50MHz frequency)
    end
  integer passed = 0;

  initial begin


    a = 2147483647;  
    b = 1;           
    cin = 0;
    #10;


    if (sum !== -2147483648  || overflow !== 1) begin
      $display("TestCase#1: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#1: success");
    end


    a = -2147483648;  
    b = -1;          
    cin = 0;
    #10;


    if (sum !== 2147483647  || overflow !== 1) begin
      $display("TestCase#2: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#2: success");
    end


    a = 52;
    b = -31;
    cin = 0;
    #10;


    if (sum !== 21  || overflow !== 0) begin
      $display("TestCase#3: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#3: success");
    end


    a = 152;
    b = 2539;
    cin = 0;
    #10;


    if (sum !== 2691  || overflow !== 0) begin
      $display("TestCase#4: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#4: success");
    end


    a = -495955;
    b = -4548;
    cin = 0;
    #10;


    if (sum !== -500503  || overflow !== 0) begin
      $display("TestCase#5: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#5: success");
    end


    a = -451;
    b = 4498;
    cin = 0;
    #10;


    if (sum !== 4047  || overflow !== 0) begin
      $display("TestCase#6: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#6: success");
    end


    a = 4561;
    b = -89;
    cin = 0;
    #10;


    if (sum !== 4472  || overflow !== 0) begin
      $display("TestCase#7: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#7: success");
    end


    a = 0;
    b = 0;
    cin = 0;
    #10;


    if (sum !== 0  || overflow !== 0) begin
      $display("TestCase#8: failed with input a=%d, b=%d, output sum=%d, overflow=%d", a, b, sum, overflow);
    end else begin
      passed = passed + 1;
      $display("TestCase#8: success");
    end


    $display("Total Successful Test Cases: %d", passed);

    #100000;


  end

endmodule
