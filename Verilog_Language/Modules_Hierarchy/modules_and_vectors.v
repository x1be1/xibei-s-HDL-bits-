module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q0,q1,q2;        //从左到右为q0,q1,q2
    my_dff8 instance1(.clk(clk),.d(d),.q(q0)    ); 
    my_dff8 instance2(.clk(clk),.d(q0),.q(q1)   );
    my_dff8 instance3(.clk(clk),.d(q1),.q(q2)   );
    always @(*)                 //posedge sel or posedge clk
        begin
            case(sel)
                2'b00: q<=d;
                2'b01: q<=q0;
				2'b10: q<=q1;
                2'b11: q<=q2;
            endcase
        end
endmodule
