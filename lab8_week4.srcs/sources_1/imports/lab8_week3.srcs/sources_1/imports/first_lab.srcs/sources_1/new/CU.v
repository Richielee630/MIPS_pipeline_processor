`timescale 1ns / 1ps

module CU(
    input ok, GT, clk, go,
    output Load_cnt, Load_reg, en ,oe ,sel, done,err,rst,
    output reg [1:0] CS
    );

reg [1:0] NS;
reg [6:0] control;
parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10;
          
always@(posedge clk)begin
    if(rst) CS <= S0;
    else CS <= NS;
 end
       
          //sel, Load_cnt, en, Load_reg,oe,done,err
parameter IDLE = 7'b0000000,
          ERR  = 7'b0000011,// done and err
          Load = 7'b1111000,
          Greater = 7'b0011000,
          Done = 7'b0000110;          

always@ (CS, go, GT,ok) begin
    case(CS)
        S0: NS = go ? S1:S0;
        S1: NS = S2; 
        S2: NS = (ok && GT) ? S2:S0; 
        default : NS = go? S1:S0;
    endcase
end


always@ (CS, GT, ok, go) begin
    case(CS)
        S0: control = IDLE;
        S1: control = Load;
        S2: begin
        if (!ok) control = ERR;
        else if (ok && !GT) control = Done;
        else control = Greater;
        end
        
    endcase
end

assign {sel, Load_cnt, en, Load_reg,oe,done,err} = control;

endmodule
