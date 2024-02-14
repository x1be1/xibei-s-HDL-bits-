module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [100:0] cin_mid;
    assign cin_mid[0]=cin;
    generate
        genvar i;
        for(i=0;i<100;i=i+1)begin:bcd_fadd
            bcd_fadd bcd_fadd_in(
                .a(a[4*i+3:4*i]),
                .b(b[4*i+3:4*i]),
                .cin(cin_mid[i]),
                .cout(cin_mid[i+1]),
                .sum(sum[4*i+3:4*i])
            );
        end
    endgenerate
    assign cout=cin_mid[100];

endmodule