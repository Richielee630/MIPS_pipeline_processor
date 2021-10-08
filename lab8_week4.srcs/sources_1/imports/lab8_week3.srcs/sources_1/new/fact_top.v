`timescale 1ns / 1ps

module fact_top(
 input [1:0] A,
 input WE,rst,clk,
 input [3:0] WD,
 output [31:0] RD
    );
reg ResDone,ResErr;
wire WE1, WE2, go, GoPulse,Done, Err, GoPulseCmb;
wire [31:0] Result,nf;
wire [1:0] RdSel;
wire [3:0] n;

fact_ad fact_ad( 
    .A          (A),
    .WE         (WE),
    .WE1        (WE1), 
    .WE2        (WE2), 
    .RdSel      (RdSel)
    );
    
fact_reg #(4) reg0( //n
    .clk        (clk), 
    .rst        (rst),
    .D          (WD),
    .Load_Reg   (WE1),
    .Q          (n)
    );
wire WDe = WD[0];
fact_reg #(1) reg1(// go
    .clk        (clk), 
    .rst        (rst),
    .D          (WDe),
    .Load_Reg   (WE2),
    .Q          (go)
    );

assign GoPulseCmb = WDe & WE2;
fact_reg #(1) reg2(//GoPulse
    .clk        (clk), 
    .rst        (rst),
    .D          (GoPulseCmb),
    .Load_Reg   (1'b1),
    .Q          (GoPulse)
    );
    
Accelerator factor(//factorial acc
    .go         (GoPulse), 
    .clk        (clk),
    .rst        (rst),
    .in         (n),
    .err        (Err), 
    .done       (Done),
    .out        (nf)
    );

//Factorial Result Done Reg
always@ (posedge clk, posedge rst)begin
if (rst) ResDone <= 1'b0;
else ResDone <=(~GoPulseCmb)&(Done | ResDone);
end

//Factorial Result Err Reg
always @(posedge clk, posedge rst)begin
if (rst) ResErr <= 1'b0;
else ResErr <=(~GoPulseCmb)&(Err | ResErr);
end

fact_reg reg3(//nf
    .clk        (clk), 
    .rst        (1'b0),
    .D          (nf),
    .Load_Reg   (Done),
    .Q          (Result)
    );
    
   four2one_mux_fact four_to1_mux_fact(
    .sel            (RdSel),
    .in0            ({28'b0,n}),
    .in1            ({31'b0,go}),
    .in2            ({30'b0,ResErr,ResDone}),
    .in3            (Result),
    .RD             (RD)
    );
  
endmodule
