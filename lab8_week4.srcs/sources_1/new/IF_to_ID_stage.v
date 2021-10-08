`timescale 1ns / 1ps

module IF_to_ID_stage(
input wire clk,
input wire [31:0] instr, pc_plus4,
output reg [31:0] instrD, pc_plus4D
    );
always@ (posedge clk)begin
    instrD <= instr;
    pc_plus4D <= pc_plus4;
end
endmodule
