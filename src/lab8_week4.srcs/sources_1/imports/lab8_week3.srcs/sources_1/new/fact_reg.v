`timescale 1ns / 1ps

module fact_reg #(parameter w = 32)(
    input wire clk, rst,
    input wire [w-1:0] D,
    input wire Load_Reg,
    output reg [w-1:0] Q
    );
    always @ (posedge clk, posedge rst)
    if (rst) Q <= 0 ;
    else if (Load_Reg) Q <= D;
    else Q <= Q;
endmodule
