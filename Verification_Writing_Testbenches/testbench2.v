module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    
    q7 uut(
        .clk(clk),
        .in(in),
        .s(s)
    );
    
    initial begin
        in=1'd0;
        s=3'd2;
        #10
        in=1'd0;
        s=3'd6;
        #10
        in=1'd1;
        s=3'd2;
        #10
        in=1'd0;
        s=3'd7;
        #10
        in=1'd1;
        s=3'd0;
        #30
        in=1'd0;
        s=3'd0;
    end
    
    initial begin
        clk=0;
    end
    always begin
        #5 clk=~clk;
    end
        
    

endmodule