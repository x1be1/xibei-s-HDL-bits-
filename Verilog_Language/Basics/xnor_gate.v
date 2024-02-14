
module top_module( 
    input a, 
    input b, 
    output out );
    assign out=a?(b?1:0):(b?0:1);// 或者out=~(a^b) 

endmodule