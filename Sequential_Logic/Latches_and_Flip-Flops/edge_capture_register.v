module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_1;
    always @(posedge clk) begin
        in_1<=in;
        if(reset) out<=32'b0;
        else out<=(~in&in_1) | out;
    end

endmodule
