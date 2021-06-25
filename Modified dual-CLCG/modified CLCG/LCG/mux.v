module muxer
#(parameter N = 4)
(
	input wire [N-1:0] A,
	input wire [N-1:0] B,
	input wire sel,
	output wire [N-1:0] out
);
assign out = (sel==1) ? A : B;
endmodule