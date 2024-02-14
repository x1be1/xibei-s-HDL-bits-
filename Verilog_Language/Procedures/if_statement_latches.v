module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving  ); //

    always @(*) begin
        if (cpu_overheated)
           shut_off_computer = 1;
        else shut_off_computer=0;
    end

    always @(*) begin
        if (arrived |gas_tank_empty)//在到达目的地or油箱空的情况下，满足其一停止驾驶
           keep_driving = 0;
        else keep_driving=1;
    end
endmodule
/*原来错误示范
always @(*) begin
    if (cpu_overheated)
       shut_off_computer = 1;   //未考虑未过热即cpu_overheated=0,eles语句添加未考虑情况
end

always @(*) begin
    if (~arrived) //只考虑未到达时的状况即arrived=0，（~arrived=1)
       keep_driving = ~gas_tank_empty;
end
