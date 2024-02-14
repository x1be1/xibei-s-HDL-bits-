module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    parameter S0=4'd0,S1=4'd1,S2=4'd2,S3=4'd3;
    parameter S4=4'd4,S5=4'd5,S6=4'd6,S7=4'd7;
    parameter COUNTING=4'd8,DONE=4'd9;

    reg [3:0] state,next_state;

    always @(posedge clk)begin
        if(reset)   state<=S0;
        else        state<=next_state;
    end

    always @(*) begin
        case(state)
            S0:
                next_state=data?S1:S0;
            S1:
                next_state=data?S2:S0;
            S2:
                next_state=data?S2:S3;
            S3:
                next_state=data?S4:S0;
            S4:
                next_state=reset?S0:S5;
            S5:
                next_state=reset?S0:S6;
            S6:
                next_state=reset?S0:S7;
            S7:
                next_state=reset?S0:COUNTING;
            COUNTING:
                next_state=done_counting?DONE:COUNTING;
            DONE:
                next_state=ack?S0:DONE;
                default:
                    next_state=S0;
        endcase
    end

        wire shift_ena;

        assign shift_ena=(state==S4)||(state==S5)||(state==S6)||(state==S7);
        assign counting=(state==COUNTING);
        assign done=(state==DONE);

        wire done_counting;
        assign done_counting=(count==4'd0)&&(cnt==10'd0);
        //count==delay
        always @(posedge clk) begin
            if(reset)   count<=4'd0;
            else if(shift_ena)    count<={count[2:0],data};
            else if(counting)     count<=(cnt==10'd0)?count-4'd1:count;
            else                  count<=count;
        end
        //count 1000
        reg [9:0] cnt;    
        always @(posedge clk)begin
            if(reset)           cnt<=10'd999;
            else if(counting)   cnt<=(cnt==10'd0)?10'd999:cnt-10'd1;
            else                cnt<=10'd999;
        end

endmodule
