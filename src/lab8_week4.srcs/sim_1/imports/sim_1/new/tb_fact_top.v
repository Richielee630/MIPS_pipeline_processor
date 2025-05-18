`timescale 1ns / 1ps
module tb_fact_top;
 reg [1:0] A;
 reg WE,rst,clk;
 reg [3:0] WD;
 wire [31:0] RD;

fact_top DUT(
          .A      (A),
          .WE     (WE),
          .rst    (rst),
          .clk    (clk),
          .WD     (WD),
          .RD     (RD)
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
 //input n
 A = 2'b00; //choose WE1 to input the n 
 WE = 1'b1; //enable the AD
 WD = 4'b0011; //input 3 for n -->result = 6
 tick;

//go
 A = 2'b01; //choose WE1 to input the n 
 WE = 1'b1; //enable the AD
 WD = 4'b0001; //input 2 for n
 tick;

 WE = 1'b0;
 //check for done
 A = 2'b10;
 tick;
 while((RD[0]!= 1) && (RD[1] != 1))begin //check for done and err bit
 tick;
 end
 A = 2'b11;
tick;


//try for n = 13
reset;
 //input n
 A = 2'b00; //choose WE1 to input the n 
 WE = 1'b1; //enable the AD
 WD = 4'b1101; //input 13 
 tick;

//go
 A = 2'b01; //choose WE1 to input the n 
 WE = 1'b1; //enable the AD
 WD = 4'b0001; //input 2 for n
 tick;

 WE = 1'b0;
 //check for done
 A = 2'b10;
 tick;
 while((RD[0]!= 1) && (RD[1] != 1))begin //check for done and err bit
 tick;
 end
 A = 2'b11;
tick;

$finish;
end    
endmodule
