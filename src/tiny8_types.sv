package tiny8_types;

typedef logic [7:0] tiny8_word;
typedef logic [1:0] tiny8_reg;

typedef enum bit [1:0] {
    op_ads = 2'b00;
    op_bpd = 2'b01;
    op_ldp = 2'b10;
    op_stp = 2'b11;
} tiny8_opcode;

typedef enum bit [1:0] {
    alu_add,
    alu_sub,
    alu_dec,
    alu_mul
} tiny8_aluop;

endpackage : lc3b_types