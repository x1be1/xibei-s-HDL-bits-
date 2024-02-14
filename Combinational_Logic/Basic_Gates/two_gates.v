module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    wire in_12;  //也可assign out=（~（in1^in2))^in3;
    assign in_12=~(in1^in2);
    assign out=in_12^in3;   
endmodule