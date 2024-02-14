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
    
    parameter   LEFT      = 7'b0000001,
                RIGHT     = 7'b0000010,
                LEFT_FALL = 7'b0000100,
                RIGHT_FALL= 7'b0001000,
                LEFT_DIG  = 7'b0010000,
                RIGHT_DIG = 7'b0100000,
                DEATH     = 7'b1000000;

    parameter DEATH_TIME = 8'd19;
    reg[6:0] state,next_state;
    reg[8:0] count_time;
    always @(posedge clk or posedge areset) begin
        if(areset)   count_time<=8'd0;
        else 
            if(state==LEFT_FALL |state==RIGHT_FALL)
                count_time<=count_time+8'd1;
            else  count_time<=8'd0;
    end
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
                    if(count_time<=DEATH_TIME)
                        next_state=LEFT;
                    else 
                        next_state=DEATH;
                else
                    next_state=state;
            RIGHT_FALL:
                if(ground)
                    if(count_time<=DEATH_TIME)
                        next_state=RIGHT;
                    else 
                        next_state=DEATH;
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
            DEATH:
                    next_state=state;
            default:
                    next_state=LEFT;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if(areset)   state<=LEFT;
        else         state<=next_state;
    end
    
    assign walk_left =(state!=DEATH)&(state==LEFT);
        assign walk_right=(state!=DEATH)&(state==RIGHT);
        assign aaah      =(state!=DEATH)&(state==LEFT_FALL|state==RIGHT_FALL);
        assign digging   =(state!=DEATH)&(state==LEFT_DIG|state==RIGHT_DIG);

endmodule