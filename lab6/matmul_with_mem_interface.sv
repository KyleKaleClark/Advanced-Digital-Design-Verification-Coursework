`define DWIDTH 8
`define AWIDTH 10
`define MEM_SIZE 1024

`define MAT_MUL_SIZE 4
`define MASK_WIDTH 4
`define LOG2_MAT_MUL_SIZE 2

`define BB_MAT_MUL_SIZE `MAT_MUL_SIZE
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define REG_DATAWIDTH 16
`define REG_ADDRWIDTH 8
`define ADDR_STRIDE_WIDTH 8
`define MAX_BITS_POOL 3


//APB defines
`define IDLE 2'b00
`define SETUP 2'b01
`define READ_ACCESS 2'b10
`define WRITE_ACCESS 2'b11
`define REG_START_ADDR 4'h0
`define REG_DONE_ADDR 4'h1

//matrix signals specifically
`define REG_ADDR_A_ADDR 4'h2
`define REG_ADDR_B_ADDR 4'h3
`define REG_ADDR_C_ADDR 4'h4
`define REG_STRIDE_A_ADDR 4'h5
`define REG_STRIDE_B_ADDR 4'h6
`define REG_STRIDE_C_ADDR 4'h7



//APB mode
module matrix_multiplication(
clk, 
resetn, 
pe_resetn,
PSEL,
PENABLE,
PWRITE,
PADDR,
PWDATA,
PRDATA,
PREADY,
a_data,
a_addr,
a_mem_access,
b_data,
b_addr,
b_mem_access,
c_data_out,
c_addr,
c_data_available
	
 );

input clk;
input resetn;
input pe_resetn;

input PSEL;
input PENABLE;
input PWRITE;
input [3:0]PADDR;
input [15:0]PWDATA;
output logic [15:0] PRDATA;
output logic PREADY;

//Expose memory to top level
input logic[4*`DWIDTH-1:0] a_data;
output logic[`AWIDTH-1:0] a_addr;
output logic a_mem_access;

input logic[4*`DWIDTH-1:0] b_data;
output logic[`AWIDTH-1:0] b_addr;
output logic b_mem_access;

output logic[4*`DWIDTH-1:0] c_data_out;
output logic[`AWIDTH-1:0] c_addr;
output logic c_data_available;

logic [3:0] state;
  
//We will utilize port 0 (addr0, d0, we0, q0) to interface with the matmul.
//Unused ports (port 1 signals addr1, d1, we1, q1) will be connected to the "external" signals i.e. signals that exposed to the external world.
//Signals that are external end in "_ext".
//addr is the address of the BRAM, d is the data to be written to the BRAM, we is write enable, and q is the data read from the BRAM. 



logic      start;
   
logic start_mat_mul, done_mat_mul, done;
assign start_mat_mul = start; //clarity sake
   
logic  PCLK, PRESETn;
assign PCLK = clk;
assign PRESETn = resetn;
logic [`AWIDTH-1:0] address_mat_a;
logic [`AWIDTH-1:0] address_mat_b;
logic [`AWIDTH-1:0] address_mat_c;
logic [`ADDR_STRIDE_WIDTH-1:0] address_stride_a;
logic [`ADDR_STRIDE_WIDTH-1:0] address_stride_b;
logic [`ADDR_STRIDE_WIDTH-1:0] address_stride_c;
  

   always_ff @ (posedge PCLK) begin

      if (PRESETn == 0) begin
	 state <= `IDLE;
	 PRDATA <= 0;
	 PREADY <= 0;
	 start <= 0;
	 address_mat_a <= 0;
	 address_mat_b <= 0;
	 address_mat_c <= 0;
	 address_stride_a <= 0;
	 address_stride_b <= 0;
	 address_stride_c <= 0;
      end
      else begin
	 case(state)
	   `IDLE: begin
	      PREADY <= 0;
	      if (PSEL && !PENABLE) begin
		 state <= `SETUP;
	      end
	   end

	   `SETUP: begin
	      PREADY <= 0;
	      if (PSEL && PENABLE) begin
		 if (PWRITE) begin
		    state <= `WRITE_ACCESS;
		 end else begin
		    state <= `READ_ACCESS;
		 end
	      end
	   end // case: `SETUP


	   `WRITE_ACCESS: begin
	      PREADY <= 1;
	      if (PWRITE && PENABLE) begin
		 case (PADDR)
		   `REG_START_ADDR: begin
		      start <= PWDATA[0]; //cpu writes 1 to kick it
		   end
		   `REG_ADDR_A_ADDR: begin
		      address_mat_a <= PWDATA[`AWIDTH-1:0];
		   end
		   
		   `REG_ADDR_B_ADDR: begin
		      address_mat_b <= PWDATA[`AWIDTH-1:0];
		   end
		   
		   `REG_ADDR_C_ADDR: begin
		      address_mat_c <= PWDATA[`AWIDTH-1:0];
		   end

		   `REG_STRIDE_A_ADDR: begin
		      address_stride_a <= PWDATA[`ADDR_STRIDE_WIDTH-1:0];
		   end
		   
		   `REG_STRIDE_B_ADDR: begin
		      address_stride_b <= PWDATA[`ADDR_STRIDE_WIDTH-1:0];
		   end
		   
		   `REG_STRIDE_C_ADDR: begin
		      address_stride_c <= PWDATA[`ADDR_STRIDE_WIDTH-1:0];
		   end
		   		   
		 endcase // case (PADDR)
		 state <= `IDLE;

	      end
	   end // case: `WRITE_ACCESS
	   

	   `READ_ACCESS: begin
	      PREADY <= 1;
	      if (!PWRITE && PENABLE) begin
		 case (PADDR)
		   `REG_DONE_ADDR: begin
		      PRDATA <= {done, 15'b0}; //cpu reads donezo
		      $display("Setting PRDATA to 0x%04h, done=%b", {done, 15'b0}, done);
		      
		   end		   
		 endcase // case (PADDR)
		 if (PREADY)
 		   state <= `IDLE;
	      end
	      else if (!PSEL || !PENABLE)
		state <= `IDLE;
	   end // case: `READ_ACCESS

	   default: begin
	      PREADY <= 0;
	      state <= `IDLE;
	   end
	 endcase // case (state)
      end // else: !if(PRESETn == 0)   
   end // always_ff @ (posedge PCLK)
   
   


   //keep done signal until reset
   always_ff @(posedge PCLK) begin
      if (PRESETn == 0) begin
	 done <= 0;
      end
      else if (done_mat_mul) begin
	 done <= 1;
      end
   end
   
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_out_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_out_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_in_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_in_NC;


logic reset;
assign reset = ~resetn;
assign pe_reset = ~pe_resetn;

//matmul instance
    matmul_4x4_systolic u_matmul_4x4(
        .clk(clk),
        .reset(reset),
        .pe_reset(pe_reset),
        .start_mat_mul(start_mat_mul),
        .done_mat_mul(done_mat_mul),
        .address_mat_a(address_mat_a),
        .address_mat_b(address_mat_b),
        .address_mat_c(address_mat_c),
        .address_stride_a(address_stride_a),
        .address_stride_b(address_stride_b),
        .address_stride_c(address_stride_c),
        .a_data(a_data),
        .b_data(b_data),
        .a_data_in(a_data_in_NC),
        .b_data_in(b_data_in_NC),
        .c_data_in({`BB_MAT_MUL_SIZE*`DWIDTH{1'b0}}),
        .c_data_out(c_data_out),
        .a_data_out(a_data_out_NC),
        .b_data_out(b_data_out_NC),
        .a_addr(a_addr),
        .b_addr(b_addr),
        .c_addr(c_addr),
        .c_data_available(c_data_available),
        .validity_mask_a_rows(4'b1111),
        .validity_mask_a_cols_b_rows(4'b1111),
        .validity_mask_b_cols(4'b1111),
        .final_mat_mul_size(8'd4),
        .a_loc(8'd0),
        .b_loc(8'd0),
	.a_mem_access(a_mem_access),
	.b_mem_access(b_mem_access)
    );

endmodule  


