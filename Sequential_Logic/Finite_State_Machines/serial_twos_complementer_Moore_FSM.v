module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=2'b00,B=2'b01,C=2'b10,D=2'b11;
    reg [1:0] state,next_state;
    
    always @(*)begin
        case(state)
            A:next_state=x?B:A;
            B:next_state=x?D:C;
            C:next_state=x?D:C;
            D:next_state=x?D:C;
            default: next_state=A;
        endcase
    end
    
    always @(*)begin
        case(state)
            A : z=1'b0;
            B : z=1'b1;
            C : z=1'b1;
            D : z=1'b0;
            default: z=1'b0;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) state<=A;
        else       state<=next_state;
    end

endmodule