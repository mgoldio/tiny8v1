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
    input pcmux_sel,
    input [1:0] addrmux_sel,
    input alumux1_sel,
    input alumux2_sel,
    input regfilemux_sel,

    /* outputs */
    output tiny8_opcode opcode,

    /* mem signals */
    output tiny8_word mem_addr,
    output tiny8_word mem_wdata,
    input tiny8_word mem_rdata
);

tiny8_word pc_out;
tiny8_word ir_out;
tiny8_word acc_out;
tiny8_word rs_out;
tiny8_word rd_out;
tiny8_word alu_out;
tiny8_word pcmux_out;
tiny8_word addrmux_out;
tiny8_word alumux1_out;
tiny8_word alumux2_out;
tiny8_word regfilemux_out;
tiny8_reg rs;
tiny8_reg rd;
logic [1:0] delta2;
logic [3:0] imm4;

register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

register ir
(
    .clk,
    .load(load_ir),
    .in(mem_rdata),
    .out(ir_out)
);

register acc
(
    .clk,
    .load(load_acc),
    .in(acc_out + alu_out),
    .out(acc_out)
);

regfile regfile
(
    .clk,
    .load1(load_rs),
    .load2(load_rd),
    .in1(alu_out),
    .in2(regfilemux_out),
    .r1(rs),
    .r2(rd),
    .out1(rs_out),
    .out2(rd_out)
);

alu alu
(
    .aluop,
    .a(alumux1_out),
    .b(alumux2_out),
    .f(alu_out)
);

mux2 pcmux
(
    .sel(pcmux_sel),
    .a(pc_out + 1'b1),
    .b(pc_out + imm4),
    .f(pcmux_out)
);


mux4 addrmux
(
    .sel(addrmux_sel),
    .a(pc_out),
    .b(rs_out),
    .c(rd_out),
    .d(),
    .f(addrmux_out)
);

mux2 alumux1
(
    .sel(alumux1_sel),
    .a(rs_out),
    .b(rd_out),
    .f(alumux1_out)
);

mux2 alumux2
(
    .sel(alumux2_sel),
    .a({6'd0, delta2}),
    .b({4'd0, imm4}),
    .f(alumux2_out)
);

mux2 regfilemux
(
    .sel(regfilemux_sel),
    .a(alu_out),
    .b(mem_rdata),
    .f(regfilemux_out)
);

ir instr
(
    .clk,
    .load(load_ir),
    .in(mem_rdata),
    .opcode,
    .rs,
    .rd,
    .delta2,
    .imm4
);

endmodule
