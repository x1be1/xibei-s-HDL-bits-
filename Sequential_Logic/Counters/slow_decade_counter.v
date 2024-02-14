module top_module (
    input clk,
    input slowena,
    input reset,       
    output  reg[3:0] q);
    always @(posedge clk) begin
        if(reset)    q<=4'd0;
        else if(!reset&&q==4'd9&&slowena)     q<=4'd0;
        else if(!reset&&slowena)    q<=q+4'd1;
        else if(!reset&&!slowena)   q<=q;
    end
endmodule
/*
module top_module (
    input clk,
    input slowena,
    input reset,       
    output reg [3:0] q);
    always @(posedge clk) begin
        if(reset)begin
            q<=4'd0;
        end
        else begin
            if(slowena&&q==4'd9)  q<=4'd0;
            else if(slowena)      q<=q+4'd1;
            else if(!slowena)     q<=q;
        end
    end
endmodule