module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cin1,cin2,cin3;
    wire [15:0] a1,a2,b1,b2,cout;//切记定义为[15:0]十六位
    wire [15:0]s1,s2;
    assign  cin1=0,cin2=0,cin3=1;
    assign  a1=a[15:0],a2=a[31:16],b1=b[15:0],b2=b[31:16];
    add16 instance1(.sum(sum[15:0]),.a(a1),.b(b1),.cin(cin1),.cout(cout));
    add16 instance2(.sum(s1),.a(a2),.b(b2),.cin(cin2));
    add16 instance3(.sum(s2),.a(a2),.b(b2),.cin(cin3));
    always @(*)
        begin
            if(cout) sum[31:16]=s2;
            else     sum[31:16]=s1;
        end
endmodule