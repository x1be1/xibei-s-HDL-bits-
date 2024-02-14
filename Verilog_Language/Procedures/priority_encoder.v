module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) begin
        case(in)
            4'b0000: pos=2'b00;
            4'b0001: pos=2'h0;    //也可用十进制，十六进制save typing
            4'b0010: pos=2'h1;
            4'b0011: pos=2'h0;
            4'b0100: pos=2'h2;
            4'b0101: pos=2'h0;
            4'b0110: pos=2'h1;
            4'b0111: pos=2'h0;
            4'b1000: pos=2'h3;
            4'b1001: pos=2'h0;
            4'b1010: pos=2'h1;
            4'b1011: pos=2'h0;
            4'b1100: pos=2'h2;
            4'b1101: pos=2'h0;
            4'b1110: pos=2'h1;
            4'b1111: pos=2'h0;
            default : pos=2'b00;
        endcase
    end               
endmodule
/*更简易方法
always @(*) begin
    casez (in[3:0])
        4'bzzz1: out = 0;   // in[3:1] can be anything
        4'bzz1z: out = 1;
        4'bz1zz: out = 2;
        4'b1zzz: out = 3;
        default: out = 0;
    endcase
end