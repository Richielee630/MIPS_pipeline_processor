`timescale 1ns / 1ps

module MUL_op(
    input [31:0] a,b,
    output [63:0] p
    );
    assign p = a * b; 
endmodule
