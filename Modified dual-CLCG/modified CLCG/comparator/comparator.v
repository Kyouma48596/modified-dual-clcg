`include "comp2b.v"
`include "merging_circuit.v"

module comp
(
	input wire [3:0] A,
	input wire [3:0] B,
	output wire Abig
);
//signals
wire [3:0] k;
//instantiation
comp2b C0 (A[3:2], B[3:2], k[3], k[2]);
comb2b C1 (A[1:0], B[1:0], k[1], k[0]);
merging_circuit M0 (k[1], k[2], k[3], Abig);

endmodule