import tiny8_types::*;

module memory
(
    input clk,

    input read,
    input write,
    input tiny8_word address,
    input tiny8_word wdata,
    output logic resp,
    output tiny8_word rdata
);

timeunit 1ns;
timeprecision 1ns;

tiny8_word mem [7:0];

/* memory responds immediately */
assign resp = read | write;

initial
begin
    $readmemh("memory.lst", mem);
end

always_comb
begin
    rdata = mem[address];
end

always @(posedge clk)
begin
    if (write) begin
        mem[address] = wdata;
    end
end


endmodule
