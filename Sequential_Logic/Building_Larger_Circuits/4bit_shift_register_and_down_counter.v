module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    always @(posedge clk) begin
        if(shift_ena&&!count_ena)
                q<={q[2:0],data};
        else if(!shift_ena&&count_ena)
                q<=q-4'd1;
        else    
                q<=q;
    end

endmodule
