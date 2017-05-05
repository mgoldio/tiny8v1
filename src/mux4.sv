import tiny8_types::*;

module mux4 #(parameter width = $size(tiny8_word))
(
	input [1:0] sel,
	input [width-1:0] a, b, c, d,
	output logic [width-1:0] f
);

always_comb
begin
	case (sel)
		2'h0 : f = a;
		2'h1 : f = b;
		2'h2 : f = c;
		2'h3 : f = d;
	endcase
end

endmodule

