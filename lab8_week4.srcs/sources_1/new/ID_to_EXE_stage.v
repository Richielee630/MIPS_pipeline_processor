`timescale 1ns / 1ps

module ID_to_EXE_stage(
//control signal
input wire dm2regD, we_dmD, shiftD, jrD, jump_alinkD, jumpD, branchD, alu_srcD, reg_dstD, multuD, we_regD, clk,
input wire [2:0] alu_ctrlD,
input wire [1:0] mflo_hiD,
//data
input wire [31:0] rd1D, rd2D, sext_immD,pc_plus4D,mflohi_valD,
input wire [4:0] shamtD,rtD, rdD,

// output 
//control signal
output reg dm2regE, we_dmE, shiftE, jrE, jump_alinkE, jumpE, branchE, alu_srcE, reg_dstE, multuE, we_regE,
output reg [2:0] alu_ctrlE,
output reg [1:0] mflo_hiE,
//data
output reg [31:0] rd1E, rd2E, sext_immE, pc_plus4E,mflohi_valE,
output reg [4:0] shamtE,rtE, rdE
    );
    
always@(posedge clk)begin
    //control
    dm2regE <= dm2regD; 
    we_dmE  <= we_dmD; 
    shiftE  <= shiftD;
    jrE     <= jrD;
    jump_alinkE <= jump_alinkD;
    jumpE       <= jumpD;
    branchE     <= branchD;
    alu_srcE    <=  alu_srcD;
    reg_dstE    <= reg_dstD;
    multuE      <= multuD;
    we_regE     <= we_regD;
    alu_ctrlE   <= alu_ctrlD;
    mflo_hiE    <= mflo_hiD;
    //data
    rd1E        <=  rd1D;
    rd2E        <=  rd2D;
    sext_immE   <= sext_immD ;
    pc_plus4E   <= pc_plus4D;
    mflohi_valE <= mflohi_valD;
    shamtE      <= shamtD;
    rtE         <=  rtD;
    rdE         <= rdD;

end

endmodule
