module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010;
    parameter S3 = 3'b011, S4 = 3'b100;
    
    reg	[2:0]	state;
    reg [2:0]	next_state;
    
    always@(posedge clk) begin
        if(reset)begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end
    
    always@(*)begin
        case(state)
            S0:             next_state = x ? S1 : S0;
            S1:             next_state = x ? S4 : S1;
            S2:             next_state = x ? S1 : S2;
            S3:             next_state = x ? S2 : S1;
            S4:             next_state = x ? S4 : S3;
            default:        next_state = S0;
        endcase
    end
    
    assign z = (state == S3 || state == S4);           
            
endmodule
