module top_module ( input x, input y, output z );
    assign z=((~x)&(~y))|(x&y); //真值表对应方法

endmodule
//观察得为同或门 z=~(a^b);
