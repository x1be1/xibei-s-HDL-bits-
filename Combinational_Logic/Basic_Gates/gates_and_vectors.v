module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    assign out_both[2:0]={in[2]&in[3],in[1]&in[2],in[0]&in[1]};
    assign out_any[3:1]= {in[2]|in[3],in[1]|in[2],in[0]|in[1]};
    assign out_different[3:0]={in[3]^in[0],in[2]^in[3],in[1]^in[2],in[0]^in[1]};
endmodule
/*
    assign out_any = in[3:1] | in[2:0];
	assign out_both = in[2:0] & in[3:1];
	assign out_different = in ^ {in[0], in[3:1]};