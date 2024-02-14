module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(posedge clk) begin
        state<=a&b | state&a | state&b;
    end
    
    assign q=  ~state & ~a & b | ~state &  a & ~b |
                state &  a & b |  state & ~a & ~b;

endmodule