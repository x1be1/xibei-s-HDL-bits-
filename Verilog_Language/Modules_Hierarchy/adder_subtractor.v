module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,     //sub连接至cin，当sub=1作减法器时提供额外的加1
    output [31:0] sum
);
    wire [31:0] b1;
    wire cin1;
    assign b1=b^{32{sub}}; //当sub=1例如 1001^1111=0110
    add16 instance1(.sum(sum[15:0]),.a(a[15:0]),.b(b1[15:0]),.cin(sub),.cout(cin1) );
    add16 instance2(.sum(sum[31:16]),.a(a[31:16]),.b(b1[31:16]),.cin(cin1));

endmodule