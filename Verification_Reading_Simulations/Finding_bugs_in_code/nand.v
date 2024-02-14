module top_module (input a, input b, input c, output out);//
    wire out_mid;
    andgate inst1 (out_mid,a,b,c,1'b1,1'b1);
	assign  out=~out_mid;
endmodule
