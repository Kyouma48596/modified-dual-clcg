module register
#(parameter N = 8)
(
    input wire clk, reset,
    input wire [1:0] data_ctrl,
    input wire clr,
    input wire [N-1:0] p_in,
    output wire [N-1:0] p_out,
    output wire s_out
);
//params
localparam DO_NOTHING = 2'b00, SHIFT_LEFT = 2'b01, SHIFT_RIGHT = 2'b10, PARALLEL_LOAD = 2'b11;
//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//register
always @(posedge clk or posedge reset)
    begin
        if(reset || clr) r_contents <= 0;
        else r_contents <= r_next;
    end

//next state logic
assign r_next = (data_ctrl==DO_NOTHING) ? r_contents : 
                (data_ctrl==SHIFT_RIGHT) ? {1'b0, r_contents[N-1:1]} :
                (data_ctrl==SHIFT_LEFT) ? {r_contents[N-2:0], 1'b0} : 
                (data_ctrl==PARALLEL_LOAD) ? p_in :
                r_contents;

//output logic
assign p_out = r_contents;
assign s_out = r_contents[0];

endmodule