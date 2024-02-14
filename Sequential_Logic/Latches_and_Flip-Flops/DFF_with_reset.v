module top_module (
    input clk,
    input reset,         
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        if(reset) q<=8'b0; //当复位信号为1时，此处我们默认清零
        else      q<=d;
    end

endmodule