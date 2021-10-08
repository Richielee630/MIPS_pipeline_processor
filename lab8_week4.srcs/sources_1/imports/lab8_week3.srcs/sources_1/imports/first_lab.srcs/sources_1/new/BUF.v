`timescale 1ns / 1ps

module Buffer(
input oe,
input [31:0] in,
output [31:0] out
    );
assign out = oe? in:32'bz; 
//always@(*) begin
//   if (oe) out = in;
//   else out = 32'bz;
//end

endmodule
