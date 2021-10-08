module auxdec (
        input  wire [1:0] alu_op,
        input  wire [5:0] funct,
        output wire [2:0] alu_ctrl
    );

    reg [2:0] ctrl;

    assign {alu_ctrl} = ctrl;

    always @ (alu_op, funct) begin
        case (alu_op)
            2'b00: ctrl = 3'b010;          // ADD
            2'b01: ctrl = 3'b110;          // SUB
            default: case (funct)           //for R-type
                6'b10_0100: ctrl = 3'b000; // AND
                6'b10_0101: ctrl = 3'b001; // OR
                6'b10_0000: ctrl = 3'b010; // ADD
                6'b10_0010: ctrl = 3'b110; // SUB
                6'b10_1010: ctrl = 3'b111; // SLT
                //for additional cu
                6'b00_0000: ctrl = 3'b011; // sll
                6'b00_0010: ctrl = 3'b100; // srl
                6'b01_1001: ctrl = 3'b000; // multu
                6'b01_0010: ctrl = 3'b000; // mflo
                6'b01_0000: ctrl = 3'b000; // mfhi
                6'b00_1000: ctrl = 3'b000; // jr
                default:    ctrl = 3'bxxx;
            endcase
        endcase
    end

endmodule