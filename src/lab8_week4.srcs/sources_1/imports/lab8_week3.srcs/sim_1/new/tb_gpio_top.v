`timescale 1ns / 1ps
module tb_gpio_top;
reg [1:0] A;
reg WE,rst,clk;
reg [31:0] gpI1, gpI2, WD;
wire [31:0] RD, gpO1, gpO2;

gpio_top DUT(
            .A      (A),
            .WE     (WE),
            .rst    (rst),
            .clk    (clk),
            .gpI1   (gpI1), 
            .gpI2   (gpI2), 
            .WD     (WD),
            .RD     (RD),
            .gpO1   (gpO1), 
            .gpO2   (gpO2)
    );
    
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask
    
   task reset;
    begin 
    rst = 1'b1;
    tick;
    rst = 1'b0;
    end
    endtask
    
initial 
begin
reset;
//assign value for port:
gpI1 = 32'b01; 
gpI2 = 32'b10; 


WE = 1'b1;//enable

A = 2'b00; //gpI1
tick;

A = 2'b01; //gpI2
tick;

WD = 32'b11;
A = 2'b10; //gpO1
tick;

WD = 32'b100;
A = 2'b11; //gpO2
tick;
$finish;
end   

endmodule
