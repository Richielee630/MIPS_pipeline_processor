module tb_mips_top;

    reg         clk;
    reg         rst;
    reg  [31:0]  gpI1,gpI2;
    wire        we_dm;
    wire [31:0] pc_current;
    wire [31:0] instr;
    wire [31:0] alu_out;
    wire [31:0] wd_dm;
    wire [31:0] rd_dm;
    wire [31:0] DONT_USE;
    wire [31:0] gpO1, gpO2;
    
    integer i;
    
    mips_top DUT (
            .clk            (clk),
            .rst            (rst),
            .gpI1           (gpI1), 
            .gpI2           (gpI2),
            .we_dm          (we_dm),
            .ra3            (5'h0),
            .pc_current     (pc_current),
            .instr          (instr),
            .alu_out        (alu_out),
            .wd_dm          (wd_dm),
            .rd_dm          (rd_dm),
            .rd3            (DONT_USE),
            .gpO1           (gpO1), 
            .gpO2           (gpO2)
        );
    
    task tick; 
    begin 
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask

    task reset;
    begin 
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
//        gpI1 = {27'b0,5'b1_0011};// input 3 for n and sel low output 
        gpI1 = {27'b0,5'b0_0011};// input 3 for n and sel low output 
        gpI2 = gpO1;
        for(i = 0; i <25; i = i + 1)
        begin
            gpI2 = gpO1;
            tick; 
        end
          
//        reset;
//        gpI1 = {27'b0,5'b1_1111};// input 3 for n and sel low output 
//        gpI2 = gpO1;
//        for(i = 0; i <20; i = i + 1)
//        begin
//            gpI2 = gpO1;
//            tick; 
//        end
//        gpI2 = gpO1;
        $finish;
    end

endmodule