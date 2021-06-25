module merging_circuit
(
	input wire a,
	input wire b,
	input wire c,
	output wire m
);
//signals
wire b_;
assign b_ = ~b;
wire w;
//logic
and A0 (w, a, b_);
or 	O0 (m, w, c);

endmodule