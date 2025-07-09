import uvm_pkg::*;
`include "uvm_macros.svh"
import memory_pkg::*;

module testbench;

logic clk, reset;

apb_if apb_interface(clk, reset);
memory_if mem_a_if(clk, reset);
memory_if mem_b_if(clk, reset);
memory_if mem_c_if(clk, reset);

matrix_multiplication dut(
	.clk(clk),
	.resetn(reset),
	.pe_resetn(reset),
	.PSEL(apb_interface.PSEL),
	.PENABLE(apb_interface.PENABLE),
	.PWRITE(apb_interface.PWRITE),
	.PADDR(apb_interface.PADDR),
	.PWDATA(apb_interface.PWDATA),
	.PRDATA(apb_interface.PRDATA),
	.PREADY(apb_interface.PREADY),
	.a_data(mem_a_if.data),
	.a_addr(mem_a_if.addr),
	.a_mem_access(mem_a_if.en),
	.b_data(mem_b_if.data),
	.b_addr(mem_b_if.addr),
	.b_mem_access(mem_b_if.en),
	.c_data_out(mem_c_if.data),
	.c_addr(mem_c_if.addr),
	.c_data_available(mem_c_if.en)
);

always begin
	clk <= 1'b0;
	#5;
	clk <= 1'b1;
	#5;
end

initial begin
	uvm_config_db#(virtual apb_if)::set(null, "*", "apb_vif", apb_interface);
	uvm_config_db#(virtual memory_if)::set(null, "*mem_a*", "vif", mem_a_if);
	uvm_config_db#(virtual memory_if)::set(null, "*mem_b*", "vif", mem_b_if);
	uvm_config_db#(virtual memory_if)::set(null, "*mem_c*", "vif", mem_c_if);

	run_test("memory_test");
end

endmodule
