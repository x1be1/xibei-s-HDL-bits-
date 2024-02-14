module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    assign out=in[sel*4+3],in[sel*4+2],in[sel*4+1],in[sel*4+0];

endmodule  
/*
assign out=in[sel*4+3 -:4];
搬运原话（由于这种写法不太好理解）：
elect starting at index "sel*4", then select a total width of 4 bits with increasing (+:) index number.
Select starting at index "sel*4+3", then select a total width of 4 bits with decreasing (-:) index number.