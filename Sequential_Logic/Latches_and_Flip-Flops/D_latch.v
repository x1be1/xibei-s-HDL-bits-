module top_module (
    input d, 
    input ena,
    output q);
    always @(*) begin
        if(ena) q=d; 
        else q=q;
    end
endmodule
//这是一个锁存器