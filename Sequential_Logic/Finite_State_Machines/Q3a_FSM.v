module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=1'b0,B=1'b1;

    reg state,next_state;

    reg [1:0] count,w_cout;
    
    always@(posedge clk) begin
        if(reset)               state <= A;
        else                    state <= next_state;
    end
    
    always@ (*) begin
        case(state)
            A:                  next_state = s ? B:A;
            B:                  next_state = B;
            default:            next_state=A;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
            count <= 2'd0;
        end
        else if(state == B) begin
            if(count == 2'd2) begin
                count <= 2'd0;
            end
            else begin
                count <= count + 2'd1;
            end
        end
        else begin
            count <= 2'd0;
        end
    end
    
    always@(posedge clk) begin
        if(reset) begin
            w_cout <= 2'd0;
        end
        else if(state == B) begin
            if(count == 2'd0) begin
                w_cout <= w ? 2'd1:2'd0; //key point
            end
            else if(w == 1'b1) begin
                w_cout <= w_cout + 1'd1;
            end
            else begin
                w_cout <= w_cout;
            end
        end
        else begin
            w_cout <= 2'd0;
        end
    end
    
    always@* begin
        case(state)
            A: z = 1'b0;
            B: z = (count == 2'd0 && w_cout == 2'd2);
        endcase
    end

endmodule