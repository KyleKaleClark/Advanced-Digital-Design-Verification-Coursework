`define DWIDTH 8
`define AWIDTH 10

interface memory_if (input logic clk, reset);

	logic [`AWIDTH-1:0] addr;
	logic [4*`DWIDTH-1:0] data;
	logic en;

	modport read_side (input clk, reset, addr, en, output data);
	modport write_side (input clk, reset, addr, en, data);

endinterface


