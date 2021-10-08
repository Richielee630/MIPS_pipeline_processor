module mips (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input  wire [31:0] instr,
        input  wire [31:0] rd_dmM,
        output wire        we_dmM,
        output wire [31:0] pc_current,
        output wire [31:0] alu_outM,
        output wire [31:0] wd_dmM,
        output wire [31:0] rd3
    );
    
    wire       branchD,we_dmD;
    wire       jumpD;
    wire       reg_dstD;
    wire       we_regD;
    wire       alu_srcD;
    wire       dm2regD;
    wire [2:0] alu_ctrlD;
    //additional cu
    wire         shiftD;
    wire         jrD;
    wire         jump_alinkD;
    wire         multuD;
    wire [1:0]   mflo_hiD;
    wire [31:0] instrD;
    datapath dp (
            .clk            (clk),
            .rst            (rst),
            .branchD         (branchD),
            .jumpD           (jumpD),
            .reg_dstD        (reg_dstD),
            .we_regD         (we_regD),
            .alu_srcD        (alu_srcD),
            .dm2regD         (dm2regD),
            .we_dmD         (we_dmD),
            .alu_ctrlD       (alu_ctrlD),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dmM          (rd_dmM),
            .pc_current     (pc_current),
            .instrD         (instrD),
            .alu_outM        (alu_outM),
            .wd_dmM          (wd_dmM),
            .rd3            (rd3),
            .shiftD          (shiftD),
            .jrD             (jrD),
            .jump_alinkD     (jump_alinkD),
            .multuD          (multuD),
            .mflo_hiD        (mflo_hiD),
            .we_dmM          (we_dmM)
        );

    controlunit cu (
            .opcode         (instrD[31:26]),
            .funct          (instrD[5:0]),
            .branch         (branchD),
            .jump           (jumpD),
            .reg_dst        (reg_dstD),
            .we_reg         (we_regD),
            .alu_src        (alu_srcD),
            .we_dm          (we_dmD),
            .dm2reg         (dm2regD),
            .alu_ctrl       (alu_ctrlD),
            .shift          (shiftD),
            .jr             (jrD),
            .jump_alink     (jump_alinkD),
            .multu          (multuD),
            .mflo_hi        (mflo_hiD)
        );

endmodule