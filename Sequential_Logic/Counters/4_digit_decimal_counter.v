module top_module (
    input clk,
    input reset,   
    output [3:1] ena,
    output reg[15:0] q);
    
    BCD_count counter0(clk,reset,1'b1,q[3:0]);
    BCD_count counter1(clk,reset,ena[1],q[7:4]);
    BCD_count counter2(clk,reset,ena[2],q[11:8]);
    BCD_count counter3(clk,reset,ena[3],q[15:12]);
    assign ena[3:1]={(q[11:0]==12'h999),(q[7:0]==8'h99),(q[3:0]==4'h9)};
    

endmodule
//BCD计数器模块
module BCD_count(
    input clk,
    input reset,
    input ena,
    output reg[3:0] q
);
    always @(posedge clk)begin
        if(reset)       q<=4'h0;
        else if(!reset&&ena)    q<=(q==4'h9)?4'h0:q+4'h1; 
        else if(!ena&&!reset)   q<=q;
    end
endmodule
