module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [3:0] cout_mid;
    FA F0 (.a(x[0]),.b(y[0]),.sum(sum[0]),.cout(cout_mid[0]),.cin(1'b0));
    FA F1 (.a(x[1]),.b(y[1]),.sum(sum[1]),.cin(cout_mid[0]),.cout(cout_mid[1]));
    FA F2 (.a(x[2]),.b(y[2]),.sum(sum[2]),.cin(cout_mid[1]),.cout(cout_mid[2]));
    FA F3 (.a(x[3]),.b(y[3]),.sum(sum[3]),.cin(cout_mid[2]),.cout(cout_mid[3]));
    assign sum[4]=cout_mid[3];
endmodule
module FA( 
    input a, b, cin,
    output cout, sum );
    assign sum=a^b^cin;
    assign cout=(a&b) | (b&cin) | (a&cin);

endmodule
//上述为本人方法
/*更简单的方法：
module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	assign sum = x+y;	相当于{sum}=x+y;因为sum[4]=cout;
endmodule