module top_module( 
    input [99:0] in,
    output [99:0] out
);
    genvar i;
    generate
        for(i=0;i<100;i=i+1)begin:reverse_bit //reverse_bit是模块命名
        assign out[i]=in[99-i];
        end
    endgenerate
endmodule
/*
    always @(*)begin
        for(int i=0;i<100;i=i+1)
            out[i]=in[99-i];
        end
endmodule
/*
    integer i;
    always @(*)begin
        for(i=0;i<100;i=i+1)
            out[i]=in[99-i];
        end
endmodule