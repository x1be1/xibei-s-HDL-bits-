// +FHDR----------------------------------------------------------------------------
// 
//                
// ---------------------------------------------------------------------------------
// Filename      : PS2_packet_parser
// Author        : xibei
// Created On    : 2023-02-06 21:25
// Last Modified : 2022-02-16 19:27
// ---------------------------------------------------------------------------------
// Description   : HDLbits PS/2协议（数据包解析）题目解答
//
//
// -FHDR----------------------------------------------------------------------------


module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    parameter   BYTE1 = 4'b0001,
                BYTE2 = 4'b0010,
                BYTE3 = 4'b0100,
                DONE  = 4'b1000;
    reg [3:0] state,next_state;

    // State transition logic (combinational)
    always @(*) begin
        case(state)
            BYTE1:
            //next_state=in[3]?BYTE2:BYTE2;
                if(in[3])
                    next_state=BYTE2;
                else
                    next_state=BYTE1;
            BYTE2:
                    next_state=BYTE3;
            BYTE3:
                    next_state=DONE;
            DONE:
                if(in[3])
                    next_state=BYTE2;
                else
                    next_state=BYTE1;
            default:
                    next_state=BYTE1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset)  state<=BYTE1;
        else       state<=next_state;
    end
    
    // Output logic
    assign done = (state==DONE);

endmodule
