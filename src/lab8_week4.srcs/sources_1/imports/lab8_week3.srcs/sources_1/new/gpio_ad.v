`timescale 1ns / 1ps

module gpio_ad(
input wire [1:0] A,
input wire WE,
output reg WE1, WE2, 
output wire [1:0] RdSel
    );
always@(*) begin
    case(A)
        2'b00: begin
        WE1 = 1'B0;
        WE2 = 1'b0;
        end
        2'b01: begin
        WE1 = 1'B0;
        WE2 = 1'B0;
        end
        2'b10: begin
        WE1 = WE;
        WE2 = 1'b0;
        end
        2'b11: begin
        WE1 = 1'b0;
        WE2 = WE;
        end
        default: begin
        WE1 = 1'bx;
        WE2 = 1'bx;
        end
        endcase
 end   
 assign RdSel = A; 
 
endmodule
