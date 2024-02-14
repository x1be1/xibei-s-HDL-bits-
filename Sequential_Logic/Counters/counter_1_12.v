module top_module (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q,
    output c_enable,
    output c_load,
    output reg [3:0] c_d
); 
    assign c_enable=enable;
    assign c_load=(Q==4'd12&&enable)||reset?1'b1:1'b0;
    assign c_d=4'd1;
    
    count4  the_counter(clk,c_enable,c_load,c_d,Q);

endmodule
