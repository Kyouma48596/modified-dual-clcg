
module mr2mmm_CON
#(parameter M = 8)
(
  input wire start,
  input wire clk, rst,
  output reg [1:0] R1_en,
  output reg [1:0] done,
  output reg [1:0] SR1_en,
  output reg [1:0] SR2_en,
  output reg clrR1, clrR2, clrSR1, clrSR2,
  output reg step,
  input wire [M-1:0] n
);
//params
localparam INITIAL = 3'b000, START = 3'b001, DONE = 3'b010, S0 = 3'b011, S1 = 3'b100, S2 = 3'b101, CHECK = 3'b110;
localparam DO_NOTHING = 2'b00, SHIFT_LEFT = 2'b01, SHIFT_RIGHT = 2'b10, PARALLEL_LOAD = 2'b11;
//signals
reg [2:0] r_state;
reg [2:0] r_next;
reg [M-1:0] counter;
//register
always @ (posedge clk or posedge rst)
begin
  if(rst)
    r_state <= INITIAL;
  else 
    r_state <= r_next;
end

always @(posedge rst)
    begin
        step = 0;
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
      INITIAL :
      begin
      //#1;
        counter = 0;
        if (start)
          r_next = START;
        else 
          r_next = INITIAL;
      end

      START :
      begin
      //#1;
        clrR2 = 0;
        SR1_en = 2'b11;
        clrSR2 = 1;
        clrR1 = 1;
        r_next = CHECK;
      end

      CHECK :
      begin
      //#1;
        if(counter<n)
            r_next = S0;
        else 
            r_next = DONE;
      end

      S0 :
      begin
      //#1;
        SR2_en = PARALLEL_LOAD;
        r_next = S1;
      end

      S1 :
      begin
      //#1;
        r_next = S2;
        SR2_en = SHIFT_RIGHT;
      end

      S2 :
      begin
      //#1;
        R1_en = PARALLEL_LOAD;
        SR1_en = SHIFT_RIGHT;
        counter = counter + 1;
        r_next = CHECK;
      end

      DONE :
      begin
      //#1;
        if(step==0)
            begin
                r_next = INITIAL;
                step = 1; 
            end
        else
            begin
                step = 0;
                r_next = INITIAL;
                done = PARALLEL_LOAD; 
            end
      end
    endcase
  end
endmodule