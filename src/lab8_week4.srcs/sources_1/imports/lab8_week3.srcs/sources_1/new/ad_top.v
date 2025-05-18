`timescale 1ns / 1ps

module ad_top(
input wire [31:0] A,
input wire WE,
output reg WE1, WE2, WEM,
output reg [1:0] RdSel
    );
   
 always@(*) begin
    if ((A & 32'h900) == 32'h0)begin //data memory
       WE1 = 1'b0;
       WE2 = 1'b0;
       WEM = WE;
       RdSel = 2'b0;
    end
    if ((A & 32'h900) == 32'h800)begin//fact acc
       WE1 = WE;
       WE2 = 1'b0;
       WEM = 1'b0;
       RdSel = 2'b10;
    end
    if ((A & 32'h900) == 32'h900)begin//gpio 
       WE1 = 1'b0;
       WE2 = WE;
       WEM = 1'b0;
       RdSel = 2'b11;
    end
 end   
 
endmodule
