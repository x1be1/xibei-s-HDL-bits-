module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    parameter A=4'b0000,B=4'b0010,C=4'b0100,D=4'b1000;
    reg [3:0] state,next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A:next_state=in?B:A;
            B:next_state=in?B:C;
            C:next_state=in?D:A;
            D:next_state=in?B:C;
            default:next_state=A;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if(areset) state<=A;
        else       state<=next_state;
    end
    // Output logic
    assign out=(state==D);

endmodule