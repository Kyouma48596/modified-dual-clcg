`include "mux_2-1.v"
`include "mux_4-1.v"
`include "op2adder.v"
`include "op3adder.v"
`include "register.v"

module mr2mmm
#(parameter M = 8)
(
	input wire clk, rst,
	input wire [1:0] R1_en,
	input wire [1:0] done,
	input wire [1:0] SR1_en,
	input wire [1:0] SR2_en,
	input wire clrR1, clrR2, clrSR1, clrSR2,
	input wire step,
	input wire [M-1:0] A, B, C, S, N, n,
	output wire [M-1:0] out
);
//signals
wire [7:0] R1_kp1, R1_k, SR1_k, M2_k, A_3out, A_2out, M3_k, M1_k, cy, q0, w;
supply0 gnd;
//q0 gen
XOR X0 (w, R1_k[0], M2_k[0]);
AND A0 (q0, w, N);
//instantiation
register #(.N(8)) R1  (clk, rst, R1_en, clrR1, R1_kp1, R1_k, gnd);
register #(.N(8)) R2  (clk, rst, done, clrR2, M2_k, out, gnd);
register #(.N(8)) SR1 (clk, rst, SR1_en, clrSR1, M1_k, gnd, SR1_k);
register #(.N(8)) SR2 (clk, rst, SR2_en, clrSR2, A_3out, R1_kp1, gnd);
mux2_1 #(.N(8)) M1    (C, A, step, M2_k);
mux4_1 #(.N(8)) M2 	  (S, 0, B, 0, {step,SR1_k}, M2_k);
mux2_1 #(.N(8)) M3 	  (R1_kp1, A_2out, cy);
op2adder #(.N(8)) A_2 (R1_kp1, -N, A_2out, cy);
op3adder #(.N(8)) A_3 (R1_k, M2_k, q0);
endmodule