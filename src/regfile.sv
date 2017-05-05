import tiny8_types::*;

module regfile
(
    input clk,

    input load1,
    input load2,
    input tiny8_word in1,
    input tiny8_word in2,
    input tiny8_reg r1,
    input tiny8_reg r2,

    output tiny8_word out1,
    output tiny8_word out2
);

tiny8_word data [3:0] /* synthesis ramstyle = "logic" */;

initial
begin
    for (int i = 0; i < $size(data); i++) begin
        data[i] = '0;
    end
end

always_ff @(posedge clk)
begin
    if (load1 == 1'b1) begin
        data[r1] = in1;
    end
end

always_ff @(posedge clk)
begin
    if (load2 == 1'b1) begin
        data[r2] = in2;
    end
end

always_comb
begin
    out1 = data[r1];
end 

always_comb
begin
    out2 = data[r2];
end 

endmodule
