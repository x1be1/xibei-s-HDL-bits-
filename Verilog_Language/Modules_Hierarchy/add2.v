module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cin1,cin2;
    assign cin1=0;
    add16 instance1(.sum(sum[15:0]),.a(a[15:0]),.b(b[15:0]),.cin(cin1),.cout(cin2));
    add16 instance2(.sum(sum[31:16]),.a(a[31:16]),.b(b[31:16]),.cin(cin2));

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
    assign sum=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);//由一位全加器逻辑式可得
endmodule
/* 也可用add1中所用的实例化方法
wire cin1,cin2;
    wire [15:0] s1,s2;
    assign cin1=0;
    add16 instance1(.sum(s1),.a(a[15:0]),.b(b[15:0]),.cin(cin1),.cout(cin2));
    add16 instance2(.sum(s2),.a(a[31:16]),.b(b[31:16]),.cin(cin2));
    assign sum={s2,s1};