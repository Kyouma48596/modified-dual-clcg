iverilog -o mmm bbs_test.v bbs.v
vvp mmm
gtkwave .\mmm.vcd