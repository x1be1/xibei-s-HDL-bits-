module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    wire q32,q22,q2,q1;
    assign q32=q[0]^1'b0;
    assign q22=q[0]^q[22];
    assign q2 =q[0]^q[2];
    assign q1 =q[0]^q[1];
    
    always @(posedge clk) begin
        if(reset)  q<=32'h1;
        else       q<={q32,q[31:23],q22,q[21:3],q2,q1};
    end
        

endmodule