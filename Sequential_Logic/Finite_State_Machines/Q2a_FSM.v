module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    parameter A = 3'd0, B = 3'd1, C = 3'd2;
    parameter D = 3'd3, E = 3'd4, F = 3'd5;
    
    reg [2:0] state,next_state;

    always @(posedge clk) begin
        if(reset)  state<=A;
        else       state<=next_state;
    end
    
    always@(*)begin
        case(state)
            A:             next_state = w ? B : A;
            B:             next_state = w ? C : D;
            C:             next_state = w ? E : D;
            D:             next_state = w ? F : A;
            E:             next_state = w ? E : D; 
            F:             next_state = w ? C : D;
            default:       next_state = A;
        endcase
    end
    
    assign z=(state==E)||(state==F);

endmodule
