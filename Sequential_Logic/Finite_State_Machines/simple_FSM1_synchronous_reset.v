module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
    parameter A=0,B=1;

    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            present_state<=B;
            out<=1;
        end else begin
            case (present_state)
                B : next_state=in?B:A;
                A : next_state=in?A:B;
                default: next_state=B;
            endcase

            // State flip-flops
            present_state = next_state;   

            case (present_state)
                A : out=0;
                B : out=1;
            endcase
        end
    end

endmodule