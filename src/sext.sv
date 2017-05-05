import tiny8_types::*;

module sext #(parameter width = $size(tiny8_word))
(
    input [width-1:0] in,
    output tiny8_word out
);

assign out = $signed({in});

endmodule : sext
