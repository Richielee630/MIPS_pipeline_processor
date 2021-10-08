module mips_top (
        input  wire        clk,
        input  wire        rst,
        input  wire [4:0]  ra3,
        input wire [31:0]  gpI1,gpI2,
        output wire        we_dmM,
        output wire [31:0] pc_current,
        output wire [31:0] instr,
        output wire [31:0] alu_outM,
        output wire [31:0] wd_dmM,
        output wire [31:0] rd_dmM,
        output wire [31:0] rd3,
        output wire [31:0] gpO1, gpO2
    );

    wire [31:0] DONT_USE, DMemData, FactData, GPIOData;
    wire WE1, WE2, WEM;
    wire [1:0] RdSel;
    imem imem (
            .a              (pc_current[7:2]),
            .y              (instr)
        );

    mips mips (
            .clk            (clk),
            .rst            (rst),
            .ra3            (ra3),
            .instr          (instr),
            .rd_dmM          (rd_dmM),
            .we_dmM          (we_dmM),
            .pc_current     (pc_current),
            .alu_outM        (alu_outM),
            .wd_dmM          (wd_dmM),
            .rd3            (rd3)
        );
        
    ad_top address_decoder(
            .A              (alu_outM),
            .WE             (we_dmM),
            .WE1            (WE1), 
            .WE2            (WE2), 
            .WEM            (WEM),
            .RdSel          (RdSel)
        );
    dmem dmem (
            .clk            (clk),
            .we             (WEM),
            .a              (alu_outM[7:2]),
            .d              (wd_dmM),
            .q              (DMemData),
            .rst            (rst)
        );
        
     fact_top   factorial_acc(
            .A              (alu_outM[3:2]),
            .WE             (WE1),
            .rst            (rst),
            .clk            (clk),
            .WD             (wd_dmM[3:0]),
            .RD             (FactData)
        );
        
        gpio_top GPIO(
            .A              (alu_outM[3:2]),
            .WE             (WE2),
            .rst            (rst),
            .clk            (clk),
            .gpI1           (gpI1), 
            .gpI2           (gpI2), 
            .WD             (wd_dmM),
            .RD             (GPIOData), 
            .gpO1           (gpO1), 
            .gpO2           (gpO2)
    );
    
    mips_top_4_to_1_mux four_to1_mux_mips(
    .sel            (RdSel),
    .in0            (DMemData),
    .in1            (DMemData),
    .in2            (FactData),
    .in3            (GPIOData),
    .RD             (rd_dmM)
    );
endmodule