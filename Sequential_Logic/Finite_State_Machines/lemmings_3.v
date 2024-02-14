module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );  
    
    parameter   LEFT      = 6'b000001,
                RIGHT     = 6'b000010,
                LEFT_FALL = 6'b000100,
                RIGHT_FALL= 6'b001000,
                LEFT_DIG  = 6'b010000,
                RIGHT_DIG = 6'b100000;
    reg [5:0] state,next_state;
    
    always @(*) begin
        case(state)
            LEFT:
                if(ground)
                    next_state=dig?LEFT_DIG:(bump_left?RIGHT:LEFT);
                else
                    next_state=LEFT_FALL;
            RIGHT:
                if(ground)
                    next_state=dig?RIGHT_DIG:(bump_right?LEFT:RIGHT);
                else
                    next_state=RIGHT_FALL;
            LEFT_FALL:
                if(ground)
                    next_state=LEFT;
                else
                    next_state=state;
            RIGHT_FALL:
                if(ground)
                    next_state=RIGHT;
                else
                    next_state=state;
            LEFT_DIG:
                if(ground)
                    next_state=state;
                else
                    next_state=LEFT_FALL;
            RIGHT_DIG:
                if(ground)
                    next_state=state;
                else
                    next_state=RIGHT_FALL;
            default:
                    next_state=LEFT;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) state<=LEFT;
        else       state<=next_state;
    end
        assign walk_left =(state==LEFT);
        assign walk_right=(state==RIGHT);
        assign aaah      =(state==LEFT_FALL|state==RIGHT_FALL);
        assign digging   =(state==LEFT_DIG|state==RIGHT_DIG);
            
endmodule