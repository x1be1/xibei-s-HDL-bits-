module top_module ( input clk, input d, output q );
    wire q0,q1;     //从左到右为q0,q1
    my_dff instance1(.clk(clk),.d(d),.q(q0)      ); 
    my_dff instance2(.clk(clk),.d(q0),.q(q1)     );
    my_dff instance3(.clk(clk),.d(q1),.q(q)      );
endmodule