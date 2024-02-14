module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);

    parameter SNT = 2'b00 , WNT = 2'b01;
    parameter WT  = 2'b10 ,  ST = 2'b11;
    reg [1:0] next_state;

    always @(posedge clk or posedge areset) begin
        if(areser)   state<=WNT;
        else         state<=next_state;
    end


    always @(*) begin
        case(state)
            SNT:
                if(train_valid==1&&train_taken==1)
                    next_state=WNT;
                else
                    next_state=state;
            WNT:
                if(train_valid==1&&train_taken==1)
                    next_state=WT;
                else if(train_valid==1&&train_taken==0)
                    next_state=SNT;
                else
                    next_state=state;
            WT:
                if(train_valid==1&&train_taken==1)
                    next_state=ST;
                else if(train_valid==1&&train_taken==0)
                    next_state=WNT;
                else
                    next_state=state;
            ST:
                if(train_valid==1&&train_taken==1||train_valid==0)
                    next_state=state;
                else 
                    next_state=WT;
            default:
                    next_state=WNT;
        endcase
    end

endmodule