module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] a1,a2,b1,b2,s1,s2;
    wire cin1,cin2;
    assign cin1=0,a1=a[15:0],a2=a[31:16],b1=b[15:0],b2=b[31:16];
    add16 instance1(.sum(s1),.a(a1),.b(b1),.cin(cin1),.cout(cin2));
    add16 instance2(.sum(s2),.a(a2),.b(b2),.cin(cin2));
    assign sum={s2,s1};

endmodule
/* 将vector直接在模块中实例化例如  .a(a[15:0])
wire [15:0] s1,s2;
    wire cin1,cin2;
    assign cin1=0;
    add16 instance1(.sum(s1),.a(a[15:0]),.b(b[15:0]),.cin(cin1),.cout(cin2));
    add16 instance2(.sum(s2),.a(a[31:16]),.b(b[31:16]),.cin(cin2));
    assign sum={s2,s1};
