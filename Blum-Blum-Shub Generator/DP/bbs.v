`include "mr2mmm_DP.v"
`include "mr2mmm_CON.v"
`include "mux2_1.v"
module bbs
#(parameter M = 16)
(
	input wire clk, rst, start, load,
	input wire [M-1:0] seed, C, N, n,
	output wire b_i
);
//signals
wire [M-1:0] x_i, x_ip1, Z; 
wire [1:0] R1_en, done, SR1_en, SR2_en;
//op reg
reg [M-1:0] b;
always @(Z)
	b <= Z;
assign b_i = b[0];
assign x_ip1 = b; 
//instantiation
mux2_1 #(.N(M))M0 (x_ip1, seed, load, x_i);
mr2mmm_DP #(.M(M))datapath(clk, rst, R1_en, done, SR1_en, SR2_en, clrR1, clrR2, clrSR1, clrSR2, step, x_i, x_i, C, N, n, Z);
mr2mmm_CON #(.M(M))controller(start, clk, rst, R1_en, done, SR1_en, SR2_en, clrR1, clrR2, clrSR1, clrSR2, step, n);
endmodule