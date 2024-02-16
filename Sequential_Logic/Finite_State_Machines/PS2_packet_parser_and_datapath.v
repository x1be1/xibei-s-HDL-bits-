// +FHDR----------------------------------------------------------------------------
// 
//                
// ---------------------------------------------------------------------------------
// Filename      : PS2_packet_parser_and_datapath
// Author        : xibei
// Created On    : 2023-02-06 21:25
// Last Modified : 2022-02-16 19:27
// ---------------------------------------------------------------------------------
// Description   : HDLbits PS/2协议（数据包解析和数据路径）题目解答
//
//
// -FHDR----------------------------------------------------------------------------

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	
    parameter BYTE1=4'b0001,BYTE2=4'b0010,BYTE3=4'b0100,Done=4'b1000;
    reg [3:0]state,next_state;
    // FSM from fsm_ps2
    always@(*)begin
        case(state)
            BYTE1:next_state=in[3]?BYTE2:BYTE1;
            BYTE2:next_state=BYTE3;
            BYTE3:next_state=Done;
            Done:next_state=in[3]?BYTE2:BYTE1;
            default:next_state=BYTE1;
        endcase
    end

    always@(posedge clk)begin
        if(reset)
            state<=BYTE1;
        else
            state<=next_state;
    end
    // New: Datapath to store incoming bytes.
    always@(posedge clk)begin
        if(next_state==BYTE2)begin
            if(state==BYTE1)
                out_bytes[23:16]<=in;
            else if(state==Done)
                out_bytes[23:16]<=in;
        end 
        else if(next_state==BYTE3)begin
            out_bytes[15:8]<= in;
        end 
        else if(next_state==Done||next_state==BYTE1)begin
            out_bytes[7:0]<=in; 
        end
    end 
    
    assign done=(state==Done);
endmodule
