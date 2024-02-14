module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire [6:1] enable;
    wire [7:0] hh_r;
    
    assign enable[1] = ena && (ss[3:0]==4'h9);
    assign enable[2] = enable[1] && (ss[7:4]==4'h5);
    assign enable[3] = enable[2] && (mm[3:0]==4'h9); 
    assign enable[4] = enable[3] && (mm[7:4]==4'h5);
    assign enable[5] = enable[4] && (hh_r[3:0]==4'hb); //hb=11
    assign enable[6] = enable[5] && (hh_r[7:4]==4'h1);
    //模块例化
    BCD_count #(.START(4'h0),.END_r(4'h9)) ss0 (clk, reset, ena, ss[3:0]);
    BCD_count #(.START(4'h0),.END_r(4'h5)) ss1 (clk, reset, enable[1], ss[7:4]);
    BCD_count #(.START(4'h0),.END_r(4'h9)) mm0 (clk, reset, enable[2], mm[3:0]);
    BCD_count #(.START(4'h0),.END_r(4'h5)) mm1 (clk, reset, enable[3], mm[7:4]);
    BCD_count #(.START(4'h0),.END_r(4'hb)) hh0 (clk, reset, enable[4], hh_r[3:0]);
    BCD_count #(.START(4'h0),.END_r(4'h1)) hh1 (clk, reset, enable[5], hh_r[7:4]);
    
    assign pm=(hh_r[7:4]==4'h1);
    assign hh=(hh_r[3:0]==4'h0)?8'h12:((hh_r[3:0]>4'h9)?{4'h1,hh_r[3:0]-4'ha}:{4'h0,hh_r[3:0]});// ha=10
    
endmodule
//BCD计数器模块
module BCD_count(
    input clk,
    input reset,
    input ena,
    output reg[3:0] q
);
    parameter START=4'h0,END_r=4'h9; 
    always @(posedge clk) begin
        if(reset)             q<=START;
        else if(!reset&&ena)  q<=(q==END_r)?START:q+4'h1;
        else if(!reset&&!ena) q<=q;
    end 
endmodule