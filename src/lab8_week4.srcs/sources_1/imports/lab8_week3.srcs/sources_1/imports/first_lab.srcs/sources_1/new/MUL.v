`timescale 1ns / 1ps

module MUL(
input [3:0] X,
input [31:0] Y,
output [31:0] Z
    );

assign Z = X * Y ;

endmodule
