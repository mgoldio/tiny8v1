import tiny8_types::*;

module datapath
(
    input clk,
    
    /* register loads */
    input load_pc,
    input load_ir,
    input load_acc,
    input load_rs,
    input load_rd,

    input tiny8_aluop aluop,

    /* mux selects */
);

tiny8_word pc_in;
tiny8_word pc_out;

register pc
(
    .clk,
    .load(load_pc),
    .in(pc_in),
    .out(pc_out)
);

tiny8_word ir_in;
tiny8_word ir_out;

register ir
(
    .clk,
    .load(load_ir),
    .in(ir_in),
    .out(ir_out)
);

tiny8_word acc_in;
tiny8_word acc_out;

register acc
(
    .clk,
    .load(load_acc),
    .in(acc_in),
    .out(acc_out)
);

tiny8_word rs_in;
tiny8_word rd_in;
tiny8_word rs_out;
tiny8_word rd_out;

regfile regfile
(
    .clk,
    .load1(load_rs),
    .load2(load_rd),
    .in1(rs_in),
    .in2(rd_in),
    .r1(rs),
    .r2(rd),
    .out1(rs_out),
    .out2(rd_out)
);

tiny8_word alu_in1;
tiny8_word alu_in2;
tiny8_word alu_out;

alu alu
(
    .aluop,
    .a(alu_in1),
    .b(alu_in2),
    .f(alu_out)
);

endmodule
