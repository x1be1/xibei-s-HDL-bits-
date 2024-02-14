module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter   IDLE  =  4'b0000,
                START =  4'b0011,
                STOP  =  4'b0010,
                WAIT  =  4'b0100;
    reg [3:0] state,next_state;
    integer data_count;
    

    
    always @(posedge clk) begin
        if(reset) data_count<=0;
        else
            if     (state==START)  data_count<=data_count+1;
            else if(state==WAIT)   data_count<=data_count;
            else                   data_count<=0;
    end
    
    always @(*) begin
        case(state)
            IDLE:
                if(!in)    next_state=START;
                else       next_state=state;
            START:
                if(data_count==8)
                    if(in) next_state=STOP;
                    else   next_state=WAIT;
                else       next_state=state;
            STOP:
                if(!in)    next_state=START;
                else       next_state=IDLE;
            WAIT:
                if(in)     next_state=IDLE;
                else       next_state=state;
            default:       next_state=IDLE;
        endcase
    end
        always @(posedge clk) begin
        if(reset)  state<=IDLE;
        else       state<=next_state;
    end
    assign done=(state==STOP);
    
endmodule