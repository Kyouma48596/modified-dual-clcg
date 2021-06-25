`include "mux4_1.v"
`include "op2adder.v"
`include "op3adder.v"
`include "register.v"

module mr2mmm_DP
#(parameter M = 8)
(
	input wire clk, rst,
	input wire [1:0] R1_en,
	input wire [1:0] done,
	input wire [1:0] SR1_en,
	input wire [1:0] SR2_en,
	input wire clrR1, clrR2, clrSR1, clrSR2,
	input wire step,
	input wire [M-1:0] A, B, C, N, n,
	output wire [M+1:0] out
);
//signals
wire [M+1:0] R1_kp1, R1_k, M2_k, M3_k, M1_k, w, SR1_k;
wire [M+1:0] A_3out, A_2out;
wire cy, q0;
supply0 gnd;
//extra reg
reg [M+1:0] S;
always @(posedge step)
	S <= R1_k;
//q0 gen
xor X0 (q0, R1_k[0], M2_k[0]);
assign w = {1024{q0}} & N;
//instantiation
register #(.N(M+2)) R1  (clk, rst, R1_en, clrR1, R1_kp1, R1_k, gnd);
register #(.N(M+2)) R2  (clk, gnd, done,clrR2, M3_k, out, gnd);
register #(.N(M)) SR1 (clk, rst, SR1_en,clrSR1, M1_k, SR1_k, gnd);
register #(.N(M+2)) SR2 (clk, rst, SR2_en,clrSR2, A_3out, R1_kp1, gnd);
mux2_1 #(.N(M)) M1    (C, A, step, M1_k);
mux4_1 #(.N(M+2)) M2 	  (S, 1024'd0, B, 1024'd0, {step,SR1_k[0]}, M2_k);
mux2_1 #(.N(M+2)) M3 	  (R1_kp1, A_2out, cy, M3_k);
op2adder #(.N(M+2)) A_2 (R1_kp1, N, A_2out, cy);
op3adder #(.N(M+2)) A_3 (R1_k, M2_k, w, A_3out);
endmodule