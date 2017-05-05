import tiny8_types::*;

module ir
(
    input clk,
    input load,
    input tiny8_word in,
    output tiny8_opcode opcode,
    output tiny8_reg rs,
    output tiny8_reg rd,
    output logic [1:0] delta2,
    output logic [3:0] imm4
);

tiny8_word data;

always_ff @(posedge clk)
begin
    if (load)
        data = in;
end

assign opcode = tiny8_opcode'(data[7:6]);
assign rs = data[5:4];
assign rd = data[3:2];
assign delta2 = data[1:0];
assign imm4 = data[3:0];

endmodule
