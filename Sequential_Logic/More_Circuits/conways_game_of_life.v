module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [323:0]  r_data;        //16*16扩展为18*18
    reg [323:0]  q_next;       //q的下一个状态

    integer i,j,cnt;
    
    //用于将18*18的矩阵铺展成r_data[323:0]中的18*18个元素 
    always @(*)begin
        r_data[17:0]   = {q[240],q[255:240],q[255]};    //第一行
        r_data[323:306]= {q[0],q[15:0],q[15]};          //第18行
        for (i=1;i<17;i=i+1) begin                      //1-17行可使用for循环进行表示
            r_data[i*18 +:18] = {q[(i-1)*16],q[(i-1)*16 +:16],q[i*16-1]}; // +: 变量[起始地址 +:数据位宽]=变量[起始地址+数据位宽-1：起始地址]
        end                                                               // -: 变量[结束地址 -:数据位宽]=变量[结束地址：结束地址-数据位宽+1]
    end
    
    //用于判断当前元素周围的8个元素的值，1则累加，0则不变   
    always @(*)
        for(i=0;i<16;i=i+1) begin
            for(j=0;j<16;j=j+1) begin
                cnt = r_data[i*18+j]             //第一行
                    + r_data[i*18+j+1]
                    + r_data[i*18+j+2]
                    + r_data[(i+1)*18+j]         //第二行 因为本行包含被判断的元素本身不需要排除，所以只有两个
                    + r_data[(i+1)*18+j+2]
                    + r_data[(i+2)*18+j]         //第三行
                    + r_data[(i+2)*18+j+1]
                    + r_data[(i+2)*18+j+2];
                
                //用于判断cnt(邻居为1的数量)从而决定q的下一个状态
                case(cnt)
                    0,1: q_next[i*16+j] = 0;
                    2  : q_next[i*16+j] = q[i*16+j];
                    3  : q_next[i*16+j] = 1;
                default: q_next[i*16+j] = 0;
                endcase
            end
    end
    
    //out
    always @(posedge clk) begin
            if(load) q<=data;
            else     q<=q_next;
    end
    
endmodule