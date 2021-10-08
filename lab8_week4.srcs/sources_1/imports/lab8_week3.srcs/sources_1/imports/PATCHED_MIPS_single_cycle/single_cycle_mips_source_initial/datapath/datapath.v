module datapath (
        input  wire        clk,
        input  wire        rst,
        input  wire        branchD,
        input  wire        jumpD,
        input  wire        reg_dstD,
        input  wire        we_regD,
        input  wire        alu_srcD,
        input  wire        dm2regD,
        input  wire        we_dmD,
        input  wire [2:0]  alu_ctrlD,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dmM,
        //additional cu
        input wire         shiftD,
        input wire         jrD,
        input wire         jump_alinkD,
        input wire         multuD,
        input wire [1:0]   mflo_hiD,
        
        output wire [31:0] pc_current,instrD,
        output wire [31:0] alu_outM,
        output wire [31:0] wd_dmM,
        output wire [31:0] rd3,
        output wire we_dmM
    );

    wire [4:0]  rf_wa;
    wire        pc_srcM;
    wire [31:0] pc_plus4, pc_plus4D;
    wire [31:0] pc_pre, pc_pre1;
    wire [31:0] pc_next;
    wire [31:0] baD;
    wire [31:0] btaD;
    wire [31:0] jtaD;
    wire [31:0] alu_paE,shift_mux0;
    wire [31:0] alu_pbE,temp0;
    wire [31:0] wd_rf,temp3,temp4;
    wire        zeroE;
    wire [4:0] temp1;
    wire [31:0] multu_lo_val, multu_hi_val;
    wire [63:0] multu_val;
    wire [31:0] rd1D, rd2D,mflohi_valD, sext_immD;
    wire [4:0] shamtD, rtD, rdD; 
    
    ///for EXE
    //control signal
    wire dm2regE, we_dmE, shiftE, jrE, jump_alinkE, jumpE , branchE, alu_srcE;        
    wire reg_dstE, multuE, we_regE; 
    wire [2:0] alu_ctrlE;      
    wire [1:0] mflo_hiE;       
//data
    wire [31:0] rd1E, rd2E, sext_immE, pc_plus4E, mflohi_valE,alu_outE,wd_dmE;   
    wire [4:0]  shamtE, rtE, rdE, rf_waE;
    
    
    //mem
    //control signal
    wire dm2regM, jrM, jump_alinkM, jumpM, branchM, multuM, we_regM;
    wire [1:0] mflo_hiM;
    //data
    wire zeroM;
    wire [31:0] pc_plus4M, mflohi_valM;
    wire [4:0] rf_waM;
    
    
    //wb
    //control signal
    wire dm2regW, jrW, jump_alinkW, jumpW, multuW, we_regW;
    wire [1:0] mflo_hiW;
    //data
    wire [31:0] alu_outW, pc_plus4W, mflohi_valW, rd_dmW,wd_rfW;
    wire [4:0] rf_waW;
    
    
        
    assign wd_dmE = rd2E;
    assign rtD = instrD[20:16];
    assign rdD = instrD[15:11];
    assign shamtD = instrD[10:6];
    assign pc_srcM = branchM & zeroM;
    assign baD = {sext_immD[29:0], 2'b00};
    assign jtaD = {pc_plus4D[31:28], instrD[25:0], 2'b00};
    
    // --- PC Logic --- //
    dreg pc_reg (
            .clk            (clk),
            .rst            (rst),
            .d              (pc_next),
            .q              (pc_current)
        );

    adder pc_plus_4 (
            .a              (pc_current),
            .b              (32'd4),
            .y              (pc_plus4)
        );

    adder pc_plus_br (
            .a              (pc_plus4D),
            .b              (baD),
            .y              (btaD)
        );

    mux2 #(32) pc_src_mux (
            .sel            (pc_srcM),
            .a              (pc_plus4),
            .b              (btaD),
            .y              (pc_pre)
        );

    mux2 #(32) pc_jmp_mux (
            .sel            (jumpW),
            .a              (pc_pre),
            .b              (jtaD),
            .y              (pc_pre1)
        );
  //change from here 
  //for JR
    mux2 #(32) pc_jr_mux(             
            .sel            (jrW),
            .a              (pc_pre1),
            .b              (rd1D),
            .y              (pc_next)
        );

    //for JAL    
    mux2 #(5) jal_mux0(             
            .sel            (jump_alinkE),
            .a              (temp1),
            .b              (5'd31),
            .y              (rf_waE)
        );
    mux2 #(32) jal_mux1(             
            .sel            (jump_alinkW),
            .a              (temp3),
            .b              (pc_plus4),
            .y              (temp4)
        );
   //for MULTU  
   mux2 #(32) multu_mux0(             
            .sel            (mflo_hiW[1]),
            .a              (temp4),
            .b              (mflohi_valW),
            .y              (wd_rfW)
        );
   mux2 #(32) multu_mux1(             
            .sel            (mflo_hiD[0]),
            .a              (multu_lo_val),
            .b              (multu_hi_val),
            .y              (mflohi_valD)
        );
   MUL_op MUL0(
            .a              (alu_paE),
            .b              (alu_pbE),
            .p              (multu_val)
        ); 
   dreg MUL_lo(
            .clk            (multuW),
            .rst            (rst),
            .d              (multu_val[31:0]),
            .q              (multu_lo_val)
        );

  dreg MUL_hi(
            .clk            (multuW),
            .rst            (rst),
            .d              (multu_val[63:32]),
            .q              (multu_hi_val)
        );
        
    // IF_ ID pipline ////////////////////////////////////////////////   
  IF_to_ID_stage  IF_ID_pipline(
            .clk            (clk),
            .instr          (instr), 
            .pc_plus4       (pc_plus4),
            .instrD         (instrD), 
            .pc_plus4D      (pc_plus4D)
    );
    ///////////////////////////////////////////////////////////////////
    
    // --- RF Logic --- //
    mux2 #(5) rf_wa_mux (
            .sel            (reg_dstE),
            .a              (rtE),
            .b              (rdE),
            .y              (temp1)
        );

    regfile rf (
            .clk            (clk),
            .we             (we_regW),
            .ra1            (instrD[25:21]),
            .ra2            (instrD[20:16]),
            .ra3            (ra3),
            .wa             (rf_waW),
            .wd             (wd_rfW),
            .rd1            (rd1D),
            .rd2            (rd2D),
            .rd3            (rd3),
            .rst            (rst)
        );

  ////////////////////////ID_to_EXE////////////////////////////////////////
ID_to_EXE_stage  ID_to_EXE_pipline(
//control signal 
            .dm2regD        (dm2regD), 
            .we_dmD         (we_dmD), 
            .shiftD         (shiftD), 
            .jrD            (jrD), 
            .jump_alinkD    (jump_alinkD), 
            .jumpD          (jumpD), 
            .branchD        (branchD), 
            .alu_srcD       (alu_srcD), 
            .reg_dstD       (reg_dstD), 
            .multuD         (multuD), 
            .we_regD        (we_regD), 
            .clk            (clk),
            .alu_ctrlD      (alu_ctrlD),
            .mflo_hiD       (mflo_hiD),
//data
            .rd1D           (rd1D), 
            .rd2D           (rd2D), 
            .sext_immD      (sext_immD),
            .pc_plus4D      (pc_plus4D),
            .mflohi_valD    (mflohi_valD),
            .shamtD         (shamtD),
            .rtD            (rtD), 
            .rdD            (rdD),

// output 
//control signal
            .dm2regE        (dm2regE), 
            .we_dmE         (we_dmE), 
            .shiftE         (shiftE), 
            .jrE            (jrE), 
            .jump_alinkE    (jump_alinkE), 
            .jumpE          (jumpE), 
            .branchE        (branchE), 
            .alu_srcE       (alu_srcE), 
            .reg_dstE       (reg_dstE), 
            .multuE         (multuE), 
            .we_regE        (we_regE),
            .alu_ctrlE      (alu_ctrlE),
            .mflo_hiE       (mflo_hiE),
//data
            .rd1E           (rd1E), 
            .rd2E           (rd2E), 
            .sext_immE      (sext_immE), 
            .pc_plus4E      (pc_plus4E),
            .mflohi_valE    (mflohi_valE),
            .shamtE         (shamtE),
            .rtE            (rtE), 
            .rdE            (rdE)
    );
    
/////////////////////ID_to_EXE////////////////////////////////////////////
  
    signext se (
            .a              (instrD[15:0]),
            .y              (sext_immD)
        );
                
          //for Shift
    mux2 #(32) shiftlr_mux0(             
            .sel            (shiftE),
            .a              (rd1E),
            .b              (wd_dmE),
            .y              (alu_paE)
        );
    mux2 #(32) shiftlr_mux1(             
            .sel            (shiftE),
            .a              (temp0),
            .b              ({27'b0,shamtE}),
            .y              (alu_pbE)
        );
    // --- ALU Logic --- //
    mux2 #(32) alu_pb_mux (
            .sel            (alu_srcE),
            .a              (wd_dmE),
            .b              (sext_immE),
            .y              (temp0)
        );

    alu alu (
            .op             (alu_ctrlE),
            .a              (alu_paE),
            .b              (alu_pbE),
            .zero           (zeroE),
            .y              (alu_outE)
        );
//////////////EXE_TO_MEM////////////////////////////////////////////////////
EXE_to_MEM_stage EXE_to_MEM_pipline(
//control signal
            .dm2regE            (dm2regE), 
            .we_dmE             (we_dmE), 
            .jrE                (jrE), 
            .jump_alinkE        (jump_alinkE), 
            .jumpE              (jumpE), 
            .branchE            (branchE), 
            .multuE             (multuE), 
            .we_regE            (we_regE), 
            .clk                (clk),
            .mflo_hiE           (mflo_hiE),
//data
            .zeroE              (zeroE),
            .alu_outE           (alu_outE), 
            .pc_plus4E          (pc_plus4E), 
            .mflohi_valE        (mflohi_valE), 
            .wd_dmE             (wd_dmE),
            .rf_waE             (rf_waE),
// output 
//control signal
            .dm2regM            (dm2regM),
            .we_dmM             (we_dmM), 
            .jrM                (jrM), 
            .jump_alinkM        (jump_alinkM), 
            .jumpM              (jumpM), 
            .branchM            (branchM),
            .multuM             (multuM), 
            .we_regM            (we_regM),
            .mflo_hiM           (mflo_hiM),
//data
            .zeroM              (zeroM),
            .alu_outM           (alu_outM), 
            .pc_plus4M          (pc_plus4M), 
            .mflohi_valM        (mflohi_valM), 
            .wd_dmM             (wd_dmM),
            .rf_waM             (rf_waM)
    );
////////////////////////////////////////////////////////////////////////////////////////////


    // --- MEM Logic --- //
    mux2 #(32) rf_wd_mux (
            .sel            (dm2regW),
            .a              (alu_outW),
            .b              (rd_dmW),
            .y              (temp3)
        );
//////////////////////////////////////////MEM_to_WB_pipline////////////////////
MEM_to_WB_stage MEM_to_WB_pipline(
//control signal
    .dm2regM        (dm2regM), 
    .jrM            (jrM), 
    .jump_alinkM    (jump_alinkM), 
    .jumpM          (jumpM), 
    .multuM         (multuM), 
    .we_regM        (we_regM), 
    .clk            (clk),
    .mflo_hiM       (mflo_hiM),
//data
    .alu_outM       (alu_outM), 
    .pc_plus4M      (pc_plus4M), 
    .mflohi_valM    (mflohi_valM), 
    .rd_dmM         (rd_dmM),
    .rf_waM         (rf_waM),

// output 
//control signal
    .dm2regW        (dm2regW), 
    .jrW            (jrW), 
    .jump_alinkW    (jump_alinkW), 
    .jumpW          (jumpW), 
    .multuW         (multuW), 
    .we_regW        (we_regW),
    .mflo_hiW       (mflo_hiW),
//data
    .alu_outW       (alu_outW), 
    .pc_plus4W      (pc_plus4W), 
    .mflohi_valW    (mflohi_valW), 
    .rd_dmW         (rd_dmW),
    .rf_waW         (rf_waW)
    );
    
endmodule


















