module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT=4'b0001,RIGHT=4'b0010,LEFT_FALL=4'b0100,RIGHT_FALL=4'b1000;
    reg [3:0] state,next_state;
    
    always @(*) begin
        case(state)
            LEFT: 
                if(ground)   next_state <= bump_left?RIGHT:LEFT;
                else         next_state <= LEFT_FALL;
            RIGHT:
                if(ground)   next_state <= bump_right?LEFT:RIGHT;
                else         next_state <= RIGHT_FALL;
            LEFT_FALL:
                if(ground)   next_state <= LEFT;
                else         next_state <= state;
            RIGHT_FALL:
                if(ground)   next_state <= RIGHT;
                else         next_state <= state;
            default:         next_state <= LEFT;
        endcase
    end
        
        always @(posedge clk or posedge areset) begin
            if(areset)   state<=LEFT;
            else         state<=next_state;
        end
        
        assign walk_left  = (state==LEFT);
        assign walk_right = (state==RIGHT);
        assign aaah       = (state==LEFT_FALL |state==RIGHT_FALL);

endmodule