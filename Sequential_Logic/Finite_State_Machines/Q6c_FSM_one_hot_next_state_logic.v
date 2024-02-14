module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    parameter A = 6'b000001, B = 6'b000010, C = 6'b000100;
    parameter D = 6'b001000, E = 6'b010000, F = 6'b100000;
    
    wire [6:1] Y;
    
    always@(*)begin
        case(y)
            A:             Y = w ? A : B;
            B:             Y = w ? D : C;
            C:             Y = w ? D : E;
            D:             Y = w ? A : F;
            E:             Y = w ? D : E; 
            F:             Y = w ? D : C;
            default:       Y = A;
        endcase
    end
    
    assign Y2=y[1] & ~w;
    assign Y4=y[2] & w | y[3] & w | y[5] & w |y[6] & w;


endmodule