module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter IDLE = 4'd0 , S1  = 4'd1 , S2 = 4'd2 , S3 = 4'd3 , S4 = 4'd4;
        parameter S5 = 4'd5,G_HIGH = 4'd6,G_LOW = 4'd7,F_HIGH = 4'd8;
    reg [3:0] state,next_state;

    always @(posedge clk) begin
        if(!resetn)     state <= IDLE;
        else            state <= next_state;
    end

    always @(*) begin
        case(state)
            IDLE:       next_state = F_HIGH;
            F_HIGH:     next_state = S1;
            S1:         next_state = x?S2:S1;
            S2:         next_state = x?S2:S3;
            S3:         next_state = x?S4:S1;
            S4:         next_state = y?G_HIGH:S5;
            S5:         next_state = y?G_HIGH:G_LOW;
            G_HIGH:     next_state = G_HIGH;
            G_LOW:      next_state = G_LOW;
            default:    next_state = IDLE;
        endcase
    end

    assign f = (state == F_HIGH);
    assign g = (state == S4 || state == S5 || state == G_HIGH);
endmodule