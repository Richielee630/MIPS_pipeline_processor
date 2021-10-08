`timescale 1ns / 1ps

module DP(
input [3:0] in,
input Load_cnt, Load_reg, en ,oe ,clk ,sel,rst,
output GT, ok, 
output [31:0] out
    );
wire [31:0] mux_out, Z, reg_Q;
wire [3:0] cnt_Q;

MUX MUX0(.sel(sel), .n0(Z), .n1(32'b1), .out(mux_out));
CNT CNT0(.D(in), .Load_cnt(Load_cnt), .en(en), .clk(clk), .rst(rst), .Q(cnt_Q));
REG REG0(.D(mux_out), .Load_reg(Load_reg), .clk(clk), .rst(rst), .Q(reg_Q));
CMP CMP0(.A(cnt_Q),.B(4'b1),.GT(GT));
CMP Err0(.A(4'b1101),.B(in),.GT(ok));
MUL MUL0(.X(cnt_Q),.Y(reg_Q),.Z(Z));
Buffer BUF0(.oe(oe),.in(reg_Q),.out(out));
       
endmodule
