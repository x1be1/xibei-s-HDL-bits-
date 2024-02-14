module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    parameter   IDLE   = 4'b0000,
                STATE1 = 4'b0001,
                STATE2 = 4'b0010,
                STATE3 = 4'b0100;
    reg [3:0] state,next_state;
    
    always @(*)begin
        case(state)
            IDLE:next_state<=x?STATE1:IDLE;
            STATE1:next_state<=x?STATE1:STATE2;
            STATE2:next_state<=x?STATE1:IDLE;
            default: next_state<=IDLE;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if(!aresetn)  state<=IDLE;
        else         state<=next_state;
    end
    
    assign z=(state==STATE2) && x;

endmodule
/*
module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S=0, S1=1, S10=2;
	reg[1:0] state, next;		
	
	
	always@(posedge clk, negedge aresetn)
		if (!aresetn)
			state <= S;
		else
			state <= next;

    
	always@(*) begin
		case (state)
			S: next = x ? S1 : S;
			S1: next = x ? S1 : S10;
			S10: next = x ? S1 : S;
			default: next = 'x;
		endcase
	end

	always@(*) begin
		case (state)
			S: z = 0;
			S1: z = 0;
			S10: z = x;		// This is a Mealy state machine: The output can depend (combinational) on the input.
			default: z = 1'bx;
		endcase
	end
	
endmodule
