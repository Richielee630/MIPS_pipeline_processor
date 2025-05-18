`timescale 1ns / 1ps

module mips_top_4_to_1_mux #(parameter w = 32)(
    input wire [1:0] sel,
    input wire [w-1:0] in0,in1,in2,in3,
    output reg [w-1:0] RD
    );
    always@(*) begin
    case(sel)
    2'b00: RD = in0; // n[3:0]
    2'b01: RD = in1; // go
    2'b10: RD = in2; // ResDone, ResErr
    2'b11: RD = in3;//Result
    default: RD = {32'bx};
    endcase
    end
endmodule

