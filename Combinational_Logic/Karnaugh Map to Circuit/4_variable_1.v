module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out=((~b)&(~c)) | ((~a)&(~d)) | (b&c&d) | (a&c&d);
//化简结果不唯一
endmodule