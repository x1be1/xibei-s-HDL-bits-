module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
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
                    next_state=data?S1:S0;
                S1:
                    next_state=data?S2:S0; //1
                S2:
                    next_state=data?S2:S3; //11
                S3:
                    next_state=data?S4:S0; //110
                S4:
                    next_state=S4;         //1101
                default:
                    next_state=S0;
            endcase
        end

        assign start_shifting=(state==S4);

endmodule