`timescale 1ns / 1ps

module four2one_mux_fact #(parameter w = 32)(
    input wire [1:0] sel,
    input wire [w-1:0] in0,in1,in2,in3,
    output reg [w-1:0] RD
    );
    always@(*) begin
    case(sel)
    2'b00: RD = {{28'b0},in0[3:0]}; // n[3:0]
    2'b01: RD = {{31'b0},in1[0]}; // go
    2'b10: RD = {{30'b0},in2[1:0]}; // ResDone, ResErr
    2'b11: RD = in3;//Result
    default: RD = {32'bx};
    endcase
    end
endmodule
