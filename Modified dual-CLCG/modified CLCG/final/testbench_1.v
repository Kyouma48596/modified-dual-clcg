`timescale 1 ns/10 ps
module testbench_1;

//signals
reg start, clk1, clk2, rst;
reg [15:0] a, b, seed;
reg [3:0] m, r;
wire z_i;

//instantiation
mdclcg_DP mdclcg(clk1, clk2, start, a, b, m, r, seed, z_i, rst);

//dumping
initial
	begin
        $dumpfile("mdclcg.vcd");
        $dumpvars(0,testbench_1);
        clk1 = 1'b0;
        clk2 = 1'b0;
        start = 1'b0;
        rst = 1'b0;
        a = 16'b0101_0101_0101_0101;
        b = 16'b0001_0111_0101_0011;
        m = 8;
        r = 2;
        seed = 16'b0011_0100_0010_0111;
        #1 rst = 1'b1;
        #1 rst = 1'b0;
        #15 start = 1'b1;
        #500 $finish;
	end

//clock
always
        #5 clk1 = ~clk1;
always 
        #10 clk2 = ~clk2;

endmodule