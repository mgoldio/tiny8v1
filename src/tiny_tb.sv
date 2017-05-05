module tiny_tb;

`define PERIOD 10
`define EDGE 5

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic mem_resp;
logic mem_read;
logic mem_write;
logic [7:0] mem_address;
logic [7:0] mem_rdata;
logic [7:0] mem_wdata;

initial clk = 0;
always #`EDGE clk = ~clk;

tiny8v1 dut (.*);
memory memory
(
    .clk,
    .read(mem_read),
    .write(mem_write),
    .address(mem_address),
    .wdata(mem_wdata),
    .resp(mem_resp),
    .rdata(mem_rdata)
);

endmodule
