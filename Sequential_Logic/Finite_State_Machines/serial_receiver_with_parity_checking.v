module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter   IDLE  =  4'b0000,
                START =  4'b0011,
                STOP  =  4'b0010,
                WAIT  =  4'b0100;
    reg [3:0] state,next_state;
    integer data_count;
    wire odd;
    
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
                if(data_count==9)
                    if(in) 
                        if(odd)
                            next_state=STOP;
                        else   
                            next_state=IDLE;
                    else    next_state=WAIT;
                else        next_state=state;
            STOP:
                if(!in)     next_state=START;
                else        next_state=IDLE;
            WAIT:
                if(in)      next_state=IDLE;
                else        next_state=state;
            default:        next_state=IDLE;
        endcase
    end
        always @(posedge clk) begin
        if(reset)  state<=IDLE;
        else       state<=next_state;
    end
    assign done=(state==STOP);

    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if(reset)   out_byte<=8'b0;
        else if(state==START && data_count<8)    
                    out_byte[data_count]<=in;
        else        out_byte<=out_byte;
    end
    
    parity parity_check(.clk(clk),.reset(state!=START),.in(in),.odd(odd));

endmodule
