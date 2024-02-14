module top_module (input x, input y, output z);
    wire z1,z2,z3,z4,or_in,and_in;
    A IA1(.x(x),.y(y),.z(z1));
    B IB1(.x(x),.y(y),.z(z2));
    A IA2(.x(x),.y(y),.z(z3));
    B IB2(.x(x),.y(y),.z(z4));
    assign or_in=z1|z2;
    assign and_in=z3&z4;
    assign z=or_in^and_in;
endmodule

module A (input x, input y, output z);
    assign z=(x^y)&x;
endmodule

module B ( input x, input y, output z );
    assign z=((~x)&(~y))|(x&y); 
endmodule