`timescale 1ns / 1ps

module MEM_to_WB_stage(
//control signal
input wire dm2regM, jrM, jump_alinkM, jumpM, multuM, we_regM, clk,
input wire [1:0] mflo_hiM,
//data
input wire [31:0] alu_outM, pc_plus4M, mflohi_valM, rd_dmM,
input wire [4:0] rf_waM,

// output 
//control signal
output reg dm2regW, jrW, jump_alinkW, jumpW, multuW, we_regW,
output reg [1:0] mflo_hiW,
//data
output reg [31:0] alu_outW, pc_plus4W, mflohi_valW, rd_dmW,
output reg [4:0] rf_waW
    );
    
 always @ (posedge clk)begin
 //control signal
    case (jrM)
    1'b0: jrW <= 1'b0;
    1'b1: jrW <= 1'b1;
    default: jrW <= 1'b0;
    endcase 
    
     case (jump_alinkM)
        1'b0: jump_alinkW <= 1'b0;
        1'b1: jump_alinkW <= 1'b1;
    default: jump_alinkW <= 1'b0;
    endcase 
        
     case (jumpM)
        1'b0: jumpW <= 1'b0;
        1'b1: jumpW <= 1'b1;
    default: jumpW <= 1'b0; 
    endcase 
    
     case (dm2regM)
        1'b0: dm2regW <= 1'b0;
        1'b1: dm2regW <= 1'b1;
    default: dm2regW <= 1'b0; 
    endcase 
    
    
    //dm2regW         <= dm2regM; 
    //jrW             <= jrM; 
    //jump_alinkW     <= jump_alinkM;
    //jumpW           <=  jumpM;
    multuW          <=  multuM;
    we_regW         <= we_regM;
    mflo_hiW        <= mflo_hiM;
//data
    alu_outW        <= alu_outM;
    pc_plus4W       <=  pc_plus4M;
    mflohi_valW     <=  mflohi_valM;
    rd_dmW          <= rd_dmM;
    rf_waW          <= rf_waM;
 
 end
endmodule
