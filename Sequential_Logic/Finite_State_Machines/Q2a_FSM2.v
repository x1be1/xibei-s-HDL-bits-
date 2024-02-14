module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter   A = 3'b000 , B = 3'b001;  //A为IDLE即空闲状态
    parameter   C = 3'b010 , D = 3'b100;
    
    reg [2:0] state,next_state;

    always @(posedge clk) begin
        if(resetn==1'b0)   state<=A;
        else               state<=next_state;  
    end

    always @(*) begin
    case(state)
        A:begin
            casez(r)
                3'b000:   
                    next_state=A;
                3'bzz1:   
                    next_state=B;
                3'bz1z:   
                    next_state=C;
                3'b1zz:   
                    next_state=D;
                default:  
                    next_state=A;
            endcase
        end
        B:
            next_state=r[1]?B:A;
        C:
            next_state=r[2]?C:A;
        D:
            next_state=r[3]?D:A;
        default:
            next_state=A;
    endcase
end

    always @(*) begin
        g=3'b000;
        case(state)
            B:  g[1]=1'b1;
            C:  g[2]=1'b1;
            D:  g[3]=1'b1;
        endcase
    end

endmodule