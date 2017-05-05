import tiny8_types::*;

module tiny8v1
(
    input clk,
    input mem_resp,
    input tiny8_word mem_rdata,
    output mem_read,
    output mem_write,
    output tiny8_word mem_address,
    output tiny8_word mem_wdata
);

logic load_pc, load_ir, load_acc, load_rs, load_rd, load_mar, load_mdr, branch_enable, pcmux_sel, addrmux_sel, alumux1_sel, alumux2_sel, regfilemux_sel, mdrmux_sel;
logic [1:0] marmux_sel;
tiny8_aluop aluop;
tiny8_opcode opcode;

control control0
(
	.*
);

datapath datapath0
(
	.*
);

endmodule
