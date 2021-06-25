module mux2_1
#(parameter N = 8)
(
	input wire [N-1:0] A,
	input wire [N-1:0] B,
	input wire sel,
	output wire out
);
assign out = (sel==1) ? A : B;
endmodule