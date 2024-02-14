module top_module (
    input clk,
    input x,
    output z
); 
    wire D0,D1,D2;
    reg Q0,Q1,Q2;
    
    assign D0=x ^  Q0;
    assign D1=x & ~Q1;
    assign D2=x | ~Q2;
    
    myDFF DFF_0(clk,D0,Q0);
    myDFF DFF_1(clk,D1,Q1);
    myDFF DFF_2(clk,D2,Q2);
    
    assign z=~(Q0 | Q1 | Q2);

endmodule
//DFF模块
module myDFF(
    input clk,
    input d,
    output q
);
    always @(posedge clk) begin
        q<=d;
    end
endmodule
    