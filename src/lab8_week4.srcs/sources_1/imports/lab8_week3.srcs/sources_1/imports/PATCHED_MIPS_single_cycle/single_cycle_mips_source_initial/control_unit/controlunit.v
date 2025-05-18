module controlunit (
        input  wire [5:0]  opcode,
        input  wire [5:0]  funct,
        output wire        branch,
        output wire        jump,
        output wire        reg_dst,
        output wire        we_reg,
        output wire        alu_src,
        output wire        we_dm,
        output wire        dm2reg,
        output wire [2:0]  alu_ctrl,
        //additional cu
        output wire         shift,
        output wire         jr,
        output wire         jump_alink,
        output wire         multu,
        output wire [1:0]   mflo_hi
    );
    
    wire [1:0] alu_op;

    maindec md (
        .opcode         (opcode),
        .funct          (funct),   //sel other kind of R-type
        .branch         (branch),
        .jump           (jump),
        .reg_dst        (reg_dst),
        .we_reg         (we_reg),
        .alu_src        (alu_src),
        .we_dm          (we_dm),
        .dm2reg         (dm2reg),
        .alu_op         (alu_op),
        //additional cu
        .shift          (shift),
        .jr             (jr),
        .jump_alink     (jump_alink),
        .multu          (multu),
        .mflo_hi        (mflo_hi) 
    );

    auxdec ad (
        .alu_op         (alu_op),
        .funct          (funct),
        .alu_ctrl       (alu_ctrl)
    );

endmodule