`timescale 1ns / 1ps

module CMP(
input [3:0] A,B,
output  GT
    );
assign GT = (A > B)? 1:0;
//assign GT = |A[31:1];//bitwise or

endmodule
