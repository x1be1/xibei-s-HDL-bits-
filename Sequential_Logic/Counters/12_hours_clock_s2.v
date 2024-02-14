module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    
	reg [3:0] s0; //秒针的个位
    reg [3:0] s1; //秒针的十位
    
    //秒计数
    always @(posedge clk) begin
        if(reset)	begin
            s0<=4'h0;
        end 
        else if(ena)	begin
                if (s0==4'h9)	begin
                s0<=4'h0;
                end 
                else begin
                s0<=s0+1'b1;
                end
            end
    end
    
    always @(posedge clk)	begin
        if(reset) begin
            s1<=4'h0	;
        end 
        else if (ena&&s0==4'h9) begin
            if (s1==4'h5) begin
                s1<=4'h0;
            end 
            else begin
            s1<=s1+1'b1;
            end
        end
    end
    //分计数
    reg [3:0] m0; //分针的个位
    reg [3:0] m1; //分针的十位
    
    always @(posedge clk) begin
        if(reset) begin
            m0<=4'd0;
        end 
        else if(ena&&s0==4'h9&&s1==4'h5) begin//当秒计时到59时，就需要考虑分计时
            if(m0==4'h9)	begin   //此时为 x9分59秒 此时显然m0需要置零
                m0<=4'h0;
            end 
            else begin
                m0<=m0+1'b1 ;      //当m0未满9时，继续计数
            end
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            m1<=4'h0;
        end 
        else if(ena&&s0==4'd9&&s1==4'd5&&m0==4'd9) begin
            if(m1==4'h5)	begin
                m1<=4'h0;
            end 
            else begin
                m1<=m1+1'b1 ;
            end
        end
    end
    //时计数
    reg[3:0]h0; //时的个位
    reg[3:0]h1; //时的十位  只能取0,1;

    always @(posedge clk) begin
        if(reset) begin
        h0<= 4'd2;
        end 
        else if(ena&&s0==4'h9&&s1==4'h5&&m0==4'h9&&m1==4'h5&h0==4'h2&&h1==4'h1) begin 
        h0<=4'h1;   //12:59:59 下一时刻为01:00:00
        end 
        else if(ena&&s0==4'h9&&s1==4'h5&&m0==4'h9&&m1==4'h5) begin    //此时为xx:59:59
            if(h0==4'h9) begin
            h0<=4'h0;//满9置零
            end 
            else begin
            h0<=h0+1'b1;  //当h0未满9时，继续计数
            end
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            h1<=4'h1;
        end
        else if(ena==1'b1&&s0==4'h9&&s1==4'h5&&m0==4'h9&&m1==4'h5&h0==4'h2&&h1==4'h1) begin //此时为12:59:59
                h1<=4'h0;//01：00：00
        end 
        else if(ena==1'b1&&s0==4'h9&&s1==4'h5&&m0==4'h9&&m1==4'h5&h0==4'h9) begin   //x9:59:59 当h0未满9时h1不会改变
            h1<=h1+1'b1;
        end
        else  h1<=h1;
    end
    
    reg	r_pm;
    
    //am or pm
    always @(posedge clk)	begin
        if (reset) r_pm<=1'b0;
        else if (ena&&s0==4'h9&&s1==4'h5&&m0==4'h9&&m1==4'h5&&h0==4'h1&&h1==4'h1) begin
        r_pm<=~r_pm;   //pm每十二个小时翻转一次，即满足11：59：59下一状态pm翻转
        end
    end
    //赋值
    assign hh={h1,h0};	
    assign mm={m1,m0};
    assign ss={s1,s0};
    assign pm=r_pm;
    
endmodule
