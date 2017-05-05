import tiny8_types::*;

module tiny_tb;

`define PERIOD 10
`define EDGE (PERIOD / 2)

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic mem_resp;
logic mem_read;
logic mem_write;
tiny8_word mem_addr;
tiny8_word mem_rdata;
tiny8_word mem_wdata;

initial clk = 0;
always #`EDGE clk = ~clk;

tiny8v1 dut (.*);
memory memory (.*);

endmodule
