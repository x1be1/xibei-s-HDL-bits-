module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg q0,q1,q2;
    always @(posedge clk) begin
        if(!resetn)  {out,q2,q1,q0}<=4'b0;
        else         {out,q2,q1,q0}<={q2,q1,q0,in};
    end
        
endmodule
/*
module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] sr;
	always @(posedge clk) begin
		if (~resetn)		
			sr <= 0;
		else 
			sr <= {sr[2:0], in};
	end
	
	assign out = sr[3];	

endmodule