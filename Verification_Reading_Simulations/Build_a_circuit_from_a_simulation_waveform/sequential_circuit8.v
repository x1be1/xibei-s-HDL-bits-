module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always @(negedge clock) begin
        q<=p;
    end
    
    always @(*) begin
        if(clock)
                p=a;
            else
                p=p;
        end

endmodule