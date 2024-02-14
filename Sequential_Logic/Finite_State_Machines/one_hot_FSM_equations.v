module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    parameter A = 6'b000001, B = 6'b000010, C = 6'b000100;
    parameter D = 6'b001000, E = 6'b010000, F = 6'b100000;
    
    wire [5:0] Y;
    
    always@(*)begin
        case(y)
            A:             Y = w ? B : A;
            B:             Y = w ? C : D;
            C:             Y = w ? E : D;
            D:             Y = w ? F : A;
            E:             Y = w ? E : D; 
            F:             Y = w ? C : D;
            default:       Y = A;
        endcase
    end
    
    assign Y1=y[0]&w;
    assign Y3=y[1]&~w | y[2]&~w | y[4]&~w |y[5] &~w;

endmodule
