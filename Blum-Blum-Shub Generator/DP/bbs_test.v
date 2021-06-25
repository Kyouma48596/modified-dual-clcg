`timescale 1ns/10ps
module bbs_test
#(parameter M = 1024);
//signals
reg clk, rst, start, load;
reg [M-1:0] seed, C, N, n;
wire b_i;
//instantiation
bbs #(.M(1024))uut (clk, rst, start, load,seed, C, N, n,b_i);

//dumping
initial
begin
	$dumpfile("mmm.vcd");
    $dumpvars(0,bbs_test);
    clk = 1'b0;
    rst = 1'b0;
    load = 1'b0;
    start = 1'b0;
    seed = 1024'd323809140;
    N = 1024'd1200000003730000000273;
    n = 71;
    C = 1024'd448256546290935196720;
    #2 rst = 1'b1;
    #1 rst = 1'b0;
    repeat(2) @(negedge clk);
    #2 start = 1'b1;
//  #110000 load = 1'b1;
    #100000 $finish;
end

//clock
always
    #5 clk = ~clk;
//load sig
always @(b_i)
    load = 1'b1;
endmodule