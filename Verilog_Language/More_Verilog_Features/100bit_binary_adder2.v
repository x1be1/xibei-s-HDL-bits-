module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    generate
        genvar i;
        for(i=0;i<100;i=i+1) begin:adder
            if(i==0)begin    //按名称例化模块
                fulladder fulladder_in(.a(a[i]),.b(b[i]),.cin(cin),.cout(cout[i]),.sum(sum[i]));//第一个全加器cin即为输入的cin
            end
            else fulladder fulladder_in(.a(a[i]),.b(b[i]),.cin(cout[i-1]),.cout(cout[i]),.sum(sum[i]));//后面cin都为前一个的cout
        end
    endgenerate
endmodule
//下面是全加器模块
module fulladder(
    input a,b,cin,   
    output sum, cout );
    assign sum=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);//由一位全加器逻辑式可得 也可assign {cout,sum}=a+b+cin;
endmodule