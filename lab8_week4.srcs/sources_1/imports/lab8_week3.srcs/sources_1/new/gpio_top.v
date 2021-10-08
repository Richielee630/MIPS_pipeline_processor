`timescale 1ns / 1ps

module gpio_top(
input [1:0] A,
input WE,rst,clk,
input [31:0] gpI1, gpI2, WD,
output [31:0] RD, gpO1, gpO2
    );
wire WE1, WE2 ;
wire [1:0] RdSel;

gpio_ad gpio_ad( 
    .A          (A),
    .WE         (WE),
    .WE1        (WE1), 
    .WE2        (WE2), 
    .RdSel      (RdSel)
    );
    
fact_reg reg0( //gpO1
    .clk        (clk), 
    .rst        (1'b0),
    .D          (WD),//0....Sel,Err
    .Load_Reg   (WE1),
    .Q          (gpO1)
    );
    
fact_reg reg1( //gpO2
    .clk        (clk), 
    .rst        (1'b0),
    .D          (WD),
    .Load_Reg   (WE2),
    .Q          (gpO2)
    );
    
mips_top_4_to_1_mux four2_to1_mux(
    .sel            (RdSel),
    .in0            (gpI1),
    .in1            (gpI2),
    .in2            (gpO1),
    .in3            (gpO2),
    .RD             (RD)
    );

endmodule
