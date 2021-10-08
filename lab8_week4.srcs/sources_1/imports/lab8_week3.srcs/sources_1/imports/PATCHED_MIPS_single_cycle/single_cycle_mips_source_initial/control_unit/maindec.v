module maindec (
        input  wire [5:0] opcode,
        input  wire [5:0] funct,
        output wire       branch,
        output wire       jump,
        output wire       reg_dst,
        output wire       we_reg,
        output wire       alu_src,
        output wire       we_dm,
        output wire       dm2reg,
        output wire [1:0] alu_op,
        //additional cu
        output wire         shift,
        output wire         jr,
        output wire         jump_alink,
        output wire         multu,
        output wire [1:0]   mflo_hi
    );

    reg [14:0] ctrl;

    assign {branch, jump, reg_dst, we_reg, alu_src, we_dm, dm2reg, alu_op, shift, jr, jump_alink, multu, mflo_hi} = ctrl;

    always @ (opcode,funct) begin
        case (opcode)
            6'b00_0000: begin
                case(funct)//set op = 10
                6'b00_0000: ctrl = 15'b0_0_1_1_1_0_0_10_1_0_0_0_00;  //shift left/right logical
                6'b00_0010: ctrl = 15'b0_0_1_1_1_0_0_10_1_0_0_0_00;  //shift right logical
                6'b01_1001: ctrl = 15'b0_0_1_0_0_0_0_10_0_0_0_1_00;  //multu
                6'b01_0010: ctrl = 15'b0_0_1_1_0_0_0_10_0_0_0_0_10;  //mflo 
                6'b01_0000: ctrl = 15'b0_0_1_1_0_0_0_10_0_0_0_0_11;  //mfhi
                6'b00_1000: ctrl = 15'b0_0_0_0_0_0_0_10_0_1_0_0_00;  //jr
                default: ctrl = 15'b0_0_1_1_0_0_0_10_0_0_0_0_00; // for normal R-type(and, or, add, sub,slt) 
                endcase
            end
            6'b00_1000: ctrl = 15'b0_0_0_1_1_0_0_00_0_0_0_0_00; // ADDI
            6'b00_0100: ctrl = 15'b1_0_0_0_0_0_0_01_0_0_0_0_00; // BEQ
            6'b00_0010: ctrl = 15'b0_1_0_0_0_0_0_00_0_0_0_0_00; // J
            6'b10_1011: ctrl = 15'b0_0_0_0_1_1_0_00_0_0_0_0_00; // SW
            6'b10_0011: ctrl = 15'b0_0_0_1_1_0_1_00_0_0_0_0_00; // LW
            6'b00_0011: ctrl = 15'b0_1_0_1_0_0_0_00_0_0_1_0_00;//jump_alink
            default:    ctrl = 15'b0_0_0_0_0_0_0_00_0_0_0_0_00;
        endcase
    end

endmodule