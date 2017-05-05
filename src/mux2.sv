import tiny8_types::*;

module mux2 #(parameter width = $size(tiny8_word))
(
    input sel,
    input [width-1:0] a, b,
    output logic [width-1:0] f
);

always_comb
begin
    if (sel == 0)
        f = a;
    else
        f = b;
end

endmodule

