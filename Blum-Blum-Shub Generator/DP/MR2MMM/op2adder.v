module op2adder
#(parameter N = 8)
(
	input wire [N-1:0] in1,
	input wire [N-1:0] in2,
	output wire [N-1:0] sum,
	output wire cy
);

assign sum = in1 + in2;

endmodule