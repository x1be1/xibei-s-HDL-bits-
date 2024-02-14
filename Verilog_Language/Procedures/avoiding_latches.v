module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    always @(*) begin
        left=1'b0;down=1'b0;right=1'b0;up=1'b0; //给一个默认初始值确保在所有可能的情况下为输出分配值0 
        case (scancode)                         //除非 case 语句覆盖赋值
            16'he06b: left=1;
            16'he072: down=1;
            16'he074: right=1;
            16'he075: up=1;
        endcase
    end
endmodule                  
 