module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
	wire and_in1,and_in2,and_in3,and_in4;
    assign p1y=and_in1|and_in2;
    assign p2y=and_in3|and_in4;
    assign and_in1=p1a&p1c&p1b;
    assign and_in2=p1f&p1e&p1d;
    assign and_in3=p2a&p2b;
    assign and_in4=p2c&p2d;
endmodule