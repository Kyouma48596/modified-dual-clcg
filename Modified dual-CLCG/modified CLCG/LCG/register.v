module register
#(parameter N = 4)
(
	input wire clk,
	input wire [N-1:0] p_in,
	input wire shift,
	input wire rst,
	input wire [N-1:0] r,
	output wire [N-1:0] p_out
);
//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;
//register
always @(posedge clk or posedge rst)
begin
	if(rst)
		r_contents <= 0;
	else 
		begin
			r_contents <= r_next;	
		end
end
//next state logic
assign r_next = (shift==1) ? p_in<<r :
				p_in;
//output logic
assign p_out = r_contents;

endmodule