module mr2mmm_CON
#(parameter M = 8)
(
	input wire start,
	input wire clk, rst,
	output wire [1:0] R1_en,
	output wire [1:0] done,
	output wire [1:0] SR1_en,
	output wire [1:0] SR2_en,
	output wire clrR1, clrR2, clrSR1, clrSR2,
	output wire step,
	input wire [M-1:0] N
);
//params
localparam INITIAL = 3'b000, START = 3'b001, DONE = 3'b010, S0 = 3'b011, S1 = 3'b100, S2 = 3'b101, CHECK = 3'b110,DO_NOTHING = 2'b00, SHIFT_LEFT = 2'b01, SHIFT_RIGHT = 2'b10, PARALLEL_LOAD = 2'b11;
//signals
reg [2:0] r_state;
wire [2:0] r_next;
reg [M-1:0] counter = 0;
//register
always @ (posedge clk or posedge rst)
begin
	if(rst)
		r_state <= INITIAL;
	else 
		r_state <= r_next;
end

always @(posedge &done)
	begin
		step = 1;
	end

//OP and NS logic
always @(*)
	begin
		R1_en = 2'b00;
		done = 2'b00;
		SR1_en = 2'b00;
		SR2_en = 2'b00;
		clrR1 = 0;
		clrSR2 = 0;
		clrSR1 = 0;
		clrR2 = 0;
		r_next = r_state;
		case (r_state)
		begin
			INITIAL :
			begin
				if (start)
					r_next = START;
				else 
					r_next = INITIAL;
			end

			START :
			begin
				clrR2 = 1;
				SR1_en = 2'b11;
				clrSR2 = 1;
				clrR1 = 1;
				r_next = CHECK;
			end

			CHECK :
			begin
				if(counter<N-1)
					r_next = S0;
				else
					r_next = DONE;
			end

			S0 :
			begin
				SR2_en = PARALLEL_LOAD;
				r_next = S1;
			end

			S1 :
			begin
				SR2_en = SHIFT_RIGHT;
				r_next = S2;
			end

			S2 :
			begin
				R1_en = PARALLEL_LOAD;
				SR1_en = SHIFT_RIGHT;
				counter = counter + 1;
				r_next = CHECK;
			end

			DONE :
			begin
				if(step==0)
					r_next = INITIAL;
				else 
					begin
						r_next = DONE;
						done = PARALLEL_LOAD;
					end
			end
		end
		endcase
	end
endmodule