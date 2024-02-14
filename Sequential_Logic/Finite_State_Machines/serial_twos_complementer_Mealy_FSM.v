module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=1'b0,B=1'b1;
    reg state,next_state;
    
    always @(*) begin
        case(state)
            A: next_state=x?B:A;
            B: next_state=B;
            default: next_state=A;
        endcase
    end
    always @(*)begin
        case(state)
            A: z=x;
            B: z=~x;
            default:
                z=x;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset)   state<=A;
        else         state<=next_state;
    end

endmodule