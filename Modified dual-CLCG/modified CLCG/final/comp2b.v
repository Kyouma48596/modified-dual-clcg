module comp2b
(
	input wire [1:0] A,
	input wire [1:0] B,
	output wire A_big,
	output wire B_big
);
//signals
wire [1:0] A_;
wire [1:0] B_;
wire [6:0] w;
//logic
assign A_ = ~A;
assign B_ = ~B;
and A0 (w[6], A_[1], B[1]),
	A1 (w[5], A[1], B_[1]),
	A2 (w[4], A_[0], B[0]),
	A3 (w[3], A[0], B_[0]),
	A4 (w[1], w[4], w[2]),
	A5 (w[0], w[2], w[3]);
nor N0 (w[2], w[6], w[5]);
or 	O0 (A_big, w[6], w[1]),
	O1 (B_big, w[5], w[0]);

endmodule