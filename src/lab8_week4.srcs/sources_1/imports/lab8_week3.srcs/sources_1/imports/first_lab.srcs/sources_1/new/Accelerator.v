`timescale 1ns / 1ps

module Accelerator(
input go, clk,rst,
input [3:0] in,
output err, done,
output [31:0] out
    );
    
wire ok, GT, Load_cnt, Load_reg, en, oe, sel;
wire [1:0] CS;

CU CU0(.ok(ok), .GT(GT), .clk(clk), .go(go), .Load_cnt(Load_cnt), .Load_reg(Load_reg), .en(en), .oe(oe), .sel(sel), .done(done), .err(err),.rst(rst),.CS(CS));
DP DP0(.in(in), .Load_cnt(Load_cnt), .Load_reg(Load_reg) , .en(en) ,.oe(oe) , .clk(clk), .sel(sel), .rst(rst), .GT(GT), .ok(ok), .out(out));
    
endmodule
