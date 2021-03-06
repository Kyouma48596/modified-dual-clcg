`include "mux.v"
`include "register.v"
`include "adder.v"



module LCG
(
	input wire start,
	input wire [3:0] seed,
	input wire [3:0] a,
	input wire [3:0] b,
	input wire [3:0] r,
	input wire [3:0] m,
	input wire rst,
	output wire [3:0] x_ip1,
	input wire clk1,
	input wire clk2
);
//signals
wire [3:0] x_i;
wire [3:0] x_a;
wire [3:0] adder_out;
supply0 gnd;
supply1 vcc;
//instantiation of datapath
muxer M0 		(x_ip1,seed, start, x_i);
adder A0 	(b, x_i, x_a, m, adder_out);
register R0 (clk2, adder_out, gnd, rst, r, x_ip1);
register S0 (clk1, x_i, vcc, rst, r, x_a);

endmodule