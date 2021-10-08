`timescale 1ns / 1ps

module REG(
input [31:0] D,
input Load_reg, clk, rst,
output reg [31:0] Q
    );

always@ (posedge clk)begin
    if (rst) Q <= 0;
    else if (Load_reg) Q <= D;
    else Q = Q;

end
endmodule
