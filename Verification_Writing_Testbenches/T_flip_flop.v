module top_module ();
    reg clk;
    reg reset;
    reg t;
    
    wire q;
    
    tff uut(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
            );
    
    always @(posedge clk) begin
        if(reset) t<=1'b0;
        else      t<=1'b1;
    end
        
    initial begin
        reset=1'd0;
        #10
        reset=1'd1;
        #10
        reset=1'd0;
    end
    
    initial begin
        clk=0;
    end

    always begin
        #5 clk=~clk;
    end 

endmodule