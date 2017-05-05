import tiny8_types::*;

module tiny8v1
(
    input clk,
    input mem_resp,
    input tiny8_word mem_rdata,
    output mem_read,
    output mem_write,
    output tiny8_word mem_addr,
    output tiny8_word mem_wdata
);

logic load_pc;
logic load_ir;
logic load_acc;
logic load_rs;
logic load_rd;
tiny8_aluop aluop;
logic lcmux_sel;
logic [1:0] addrmux_sel;
logic alumux1_sel;
logic alumux2_sel;
logic regfilemux_sel;

control control (.*);
datapath datapath (.*);

endmodule
