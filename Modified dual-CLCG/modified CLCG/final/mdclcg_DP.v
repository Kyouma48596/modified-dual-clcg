
module mdclcg_DP
(
	input wire clk1,
	input wire clk2,
	input wire start,
	input wire [15:0] a,
	input wire [15:0] b,
	input wire [3:0] m,
	input wire [3:0] r,
	input wire [15:0] seed,
	output wire z_i,
	input wire rst
);

//signals
wire [3:0] p_ip1;
wire [3:0] q_ip1;
wire [3:0] x_ip1;
wire [3:0] y_ip1;
wire  c_i;
wire  b_i;
//instantiation
generator L3 (start, seed[15:12], a[15:12], b[15:12], r, m, rst, p_ip1, clk1, clk2);
generator L2 (start, seed[11:8], a[11:8], b[11:8], r, m, rst, q_ip1, clk1, clk2);
generator L1 (start, seed[7:4], a[7:4], b[7:4], r, m, rst, x_ip1, clk1, clk2);
generator L0 (start, seed[3:0], a[3:0], b[3:0], r, m, rst, y_ip1, clk1, clk2);
comp C1 (p_ip1, q_ip1, c_i);
comp C0 (x_ip1, y_ip1, b_i);
//output
xor g0 (z_i, c_i, b_i);

endmodule