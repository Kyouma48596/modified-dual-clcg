module op3adder
#(parameter N = 8)
(
	input wire [N-1:0] in1,
	input wire [N-1:0] in2,
	input wire [N-1:0] in3,
	output wire [N-1:0] sum
);

assign sum = in1 + in2 + in3;

endmodule