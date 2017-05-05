import tiny8_types::*;

module alu
(
    input tiny8_aluop aluop,
    input tiny8_word a, b,
    output tiny8_word f
);

always_comb
begin
    f = '0;
    case (aluop)
        alu_add : begin
            f = a + b;
        end
        alu_sub : begin
            f = a - b;
        end
        alu_dec : begin
            f = a - 8'b1;
        end
        alu_mul : begin
        /* since we know this is only 4 bits, we simply shift and add to avoid
         * multiplication */
            if (b[0]) f += a;
            if (b[1]) f += a << 1;
            if (b[2]) f += a << 2;
            if (b[3]) f += a << 3;
        end
        default : begin 
            $display("Unknown aluop");
        end
    endcase
end

endmodule

