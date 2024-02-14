module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] cnt;
    
    assign tc=(cnt==10'h0)?1'b1:1'b0;
    
    always @(posedge clk) begin
        if(load)   cnt<=data;
        else begin
            if(cnt==10'h0)     cnt<=10'h0;
            else			   cnt<=cnt-1'h1;
        end
    end

endmodule