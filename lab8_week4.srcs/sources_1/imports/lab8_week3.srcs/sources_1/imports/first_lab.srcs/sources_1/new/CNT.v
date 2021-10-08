`timescale 1ns / 1ps

module CNT(
input [3:0] D,
input Load_cnt, en, clk,rst,
output reg [3:0] Q
    );
//initial begin
//     Q = 4'bzzzz;
//end
 always@ (posedge clk) begin
    if (rst) Q = 0;
    else if(en) begin
        if (Load_cnt) Q = D;
        else          Q = Q - 1;
    end
    else Q = Q;     
 end
    
endmodule
