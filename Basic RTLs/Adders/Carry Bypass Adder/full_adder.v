module full_adder(input wire a,input wire b,input wire cin,output wire out,output wire propagate,output wire cout);
assign out=a^b^cin;
assign propagate = a ^ b;  
assign cout = (a & b) | (b & cin) | (a & cin);  
endmodule;