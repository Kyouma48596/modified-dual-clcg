`include "mux2_1.v"

module mux4_1
#(parameter N = 8)
(
	input wire [N-1:0] A,
	input wire [N-1:0] B,
	input wire [N-1:0] C,
	input wire [N-1:0] D,
	input wire [1:0] sel,
	output wire [N-1:0] out
);
wire [1:0] w;
mux2_1 M0	(w[0], w[1], sel[1], out);
mux2_1 M1 	(C, D, sel[0], w[1]);
mux2_1 M2 	(A, B, sel[0], w[0]);
endmodule