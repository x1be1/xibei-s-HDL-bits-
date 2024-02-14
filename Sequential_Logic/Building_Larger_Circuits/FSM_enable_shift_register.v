module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    parameter S0=3'd0,S1=3'd1,S2=3'd2;
    parameter S3=3'd3,S4=3'd4;
    
    reg [2:0]  state,next_state;
    
    always @(posedge clk) begin
        if(reset)  state<=S0;
        else	   state<=next_state;
    end
        
        always @(*) begin
            case(state)
                S0:	
                    next_state=reset?S0:S1;
                S1:
                    next_state=reset?S0:S2; 
                S2:
                    next_state=reset?S0:S3; 
                S3:
                    next_state=reset?S0:S4; 
                S4:
                    next_state=S4;         
                default:
                    next_state=S0;
            endcase
        end

        assign shift_ena=~(state==S4);

endmodule
