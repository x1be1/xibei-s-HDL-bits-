module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010;
    parameter S3 = 3'b011, S4 = 3'b100;
    
    reg [2:0]   Y;
    
    
    always@(*)begin
        case(y)
            S0:             Y = x ? S1 : S0;
            S1:             Y = x ? S4 : S1;
            S2:             Y = x ? S1 : S2;
            S3:             Y = x ? S2 : S1;
            S4:             Y = x ? S4 : S3;
            default:        Y = S0;
        endcase
    end
    
    assign z = (y == S3 || y == S4);
    assign Y0=Y[0];           
            
endmodule