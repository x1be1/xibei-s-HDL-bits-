module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk) begin
        if(j==0&&k==0) Q<=Q;
        else if(j==0&&k==1) Q<=1'b0;
        else if(j==1&&k==0) Q<=1'b1;
        else Q<=~Q;
    end
            
endmodule
/*module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    always @(posedge clk) begin
        Q<=j?(k ? ~Q : 1'b1):(k ? 1'b0 : Q);
    end
            
endmodule