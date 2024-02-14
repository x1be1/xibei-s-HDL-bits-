module top_module ( input [1:0] A, input [1:0] B, output z ); 
    always @(*) begin
        if(A==B) z=1'b1;
        else     z=1'b0;
    end

endmodule
//也可以用三目运算  assign z=(A==B)?1'b1:1'b0;
