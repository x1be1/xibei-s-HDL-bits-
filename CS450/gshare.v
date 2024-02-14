module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    reg [1:0] PHT[127:0];
    integer i;
    always@(posedge clk,posedge areset) begin
        if(areset) begin
            predict_history <= 7'd0;
            for(i=0;i<=127;i++) PHT[i] <= 2'b01;
        end
        else begin
            if(train_mispredicted&&train_valid) begin
                predict_history <= {train_history[5:0],train_taken};            
            end
            else if(predict_valid) begin
                predict_history <= {predict_history[5:0],predict_taken};
            end
            if(train_valid) begin
                if(train_taken) begin 
                    PHT[train_pc^train_history] <= (PHT[train_pc^train_history] == 2'b11)? PHT[train_pc^train_history]:PHT[train_pc^train_history] + 2'd1;
                end
                else begin              
                    PHT[train_pc^train_history] <= (PHT[train_pc^train_history] == 2'b00)? PHT[train_pc^train_history]:PHT[train_pc^train_history] - 2'd1;
                end            
            end           
        end
    end
    assign predict_taken = PHT[predict_pc^predict_history][1];
endmodule