module LCG_test;
//signals
reg start;
reg [3:0] seed;
reg [3:0] a;
reg [3:0] b;
reg [3:0] r;
reg [3:0] m;
reg rst;
wire [3:0] x_i1;
reg clk1;
reg clk2;
//instantiation
LCG uut (start, seed, a, b, r, m, rst, x_i1, clk1,clk2);
//clock
always
	#5 clk1 = ~clk1;
always 
        #10 clk2 = ~clk2;

//dumping
initial
	begin
	$dumpfile("lcgg.vcd");
        $dumpvars(0,LCG_test);
        clk1 = 1'b0;
        clk2 = 1'b0;
        start = 1'b0;
        rst = 1'b0;
        seed = 3;
        a = 5;
        b = 1;
        r = 2;
        m = 8;
        #1 rst = 1'b1;
        #2 rst = 1'b0;
        #20 start = 1'b1;

        #300 $finish;
	end
endmodule