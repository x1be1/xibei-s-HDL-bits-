module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if(reset) q<=8'h34; //0x是十六进制
        else      q<=d;
    end

endmodule