module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 
    assign s = a+b;
    assign overflow =(a[7]&&b[7] && ~s[7]) ||(~a[7]&&~b[7]&&s[7]);
     //a[7]，b[7]为符号位，s[7]为运算结果符号位
     //当a[7]=b[7]=0(同正)，s[7]=1（结果为负）时，负溢出
     //当a[7]=b[7]=1(同负)，s[7]=0（结果为正）时，正溢出
endmodule
