`timescale 1ns / 1ps

module MUX(
input sel,
input [31:0] n0, n1,
output [31:0] out
    );

assign out = sel? n1:n0;

endmodule
