module top_module( 
    input [2:0] in,
    output [1:0] out );
    always @(*) begin
        case(in)
            3'b000:out=2'd0;
            3'b001:out=2'd1;
            3'b010:out=2'd1;
            3'b011:out=2'd2;
            3'b100:out=2'd1;
            3'b101:out=2'd2;
            3'b110:out=2'd2;
            3'b111:out=2'd3;
            default:out=2'd0;
        endcase
    end

endmodule
/*
	// in[2:0] out[1:0]
	// 000      00
	// 001      01
	// 010      01
	// 011      10
	// 100      01
	// 101      10
	// 110      10
	// 111      11
	assign out[0] = (~in[2] & ~in[1] & in[0]) | (~in[2] & in[1] & ~in[0]) | (in[2] & ~in[1] & ~in[0]) | (in[2] & in[1] & in[0]);
	assign out[1] = (in[1] & in[0]) | (in[2] & in[0]) | (in[2] & in[1]);