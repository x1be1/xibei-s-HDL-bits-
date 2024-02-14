module top_module (
    input clk,
    input d,
    output q
);
    reg q_pedge,q_nedge;
    always @(posedge clk)begin
        q_pedge<=d;
    end
    always @(negedge clk)begin
        q_nedge <=d;
    end
    assign q=clk?q_pedge:q_nedge;

endmodule