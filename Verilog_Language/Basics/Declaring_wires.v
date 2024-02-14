`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire and_in1,and_in2;
    assign out=and_in1|and_in2;
    assign out_n=~out;
    assign and_in1=a&b;
	assign and_in2=c&d;
endmodule
