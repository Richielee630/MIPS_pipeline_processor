`timescale 1ns / 1ps

module EXE_to_MEM_stage(
//control signal
input wire dm2regE, we_dmE, jrE, jump_alinkE, jumpE, branchE, multuE, we_regE, clk,
input wire [1:0] mflo_hiE,
//data
input wire zeroE,
input wire [31:0] alu_outE, pc_plus4E, mflohi_valE, wd_dmE,
input wire [4:0] rf_waE,

// output 
//control signal

output reg dm2regM, we_dmM, jrM, jump_alinkM, jumpM, branchM, multuM, we_regM,
output reg [1:0] mflo_hiM,
//data
output reg zeroM,
output reg [31:0] alu_outM, pc_plus4M, mflohi_valM, wd_dmM,
output reg [4:0] rf_waM
    );



always@(posedge clk)begin
//control
     case (zeroE)
        1'b0: zeroM <= zeroE;
        1'b1: zeroM <= zeroE;
    default: zeroM <= 1'b0; 
    endcase 
    
     case (branchE)
        1'b0: branchM <= branchE;
        1'b1: branchM <= branchE;
    default: branchM <= 1'b0; 
    endcase     
    
    dm2regM <= dm2regE; 
    we_dmM <= we_dmE; 
    jrM    <=  jrE;
    jump_alinkM <= jump_alinkE; 
    jumpM   <= jumpE;
   // branchM <= branchE;
    multuM   <= multuE;
    we_regM  <= we_regE;
    mflo_hiM <= mflo_hiE;
//data
    //zeroM    <= zeroE;
    alu_outM  <= alu_outE; 
    pc_plus4M  <= pc_plus4E;  
    mflohi_valM  <=  mflohi_valE;
    wd_dmM      <= wd_dmE;
    rf_waM     <= rf_waE;
end

endmodule
