module adder
#(parameter N = 4)
(
	input wire [N-1:0] b,
	input wire [N-1:0] x_i,
	input wire [N-1:0] x_a,
	input wire [N-1:0] m,
	output wire [N-1:0] sum
);
initial 
#6;
assign sum = (b + x_i + x_a)&(m-1);
endmodule