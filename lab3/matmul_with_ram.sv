
`timescale 1ns/1ns
`define DWIDTH 8
`define AWIDTH 11
`define MEM_SIZE 2048

`define MAT_MUL_SIZE 4
`define MASK_WIDTH 4
`define LOG2_MAT_MUL_SIZE 2

`define BB_MAT_MUL_SIZE `MAT_MUL_SIZE
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define REG_DATAWIDTH 16
`define REG_ADDRWIDTH 4
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


//Design with memories
module matrix_multiplication(
  clk, 
  clk_mem, 
  resetn, 
  pe_resetn,
//  address_mat_a,
//  address_mat_b,
//  address_mat_c,
//  address_stride_a,
//  address_stride_b,
//  address_stride_c, 
  bram_addr_a_ext,
  bram_rdata_a_ext,
  bram_wdata_a_ext,
  bram_we_a_ext,
  bram_addr_b_ext,
  bram_rdata_b_ext,
  bram_wdata_b_ext,
  bram_we_b_ext,
  bram_addr_c_ext,
  bram_rdata_c_ext,
  bram_wdata_c_ext,
  bram_we_c_ext,
//  start,  //starts the matrix multiplication operation
//  done,   //asserts when the matrix multiplication operation is complete
//  PCLK,  //accounted for from clk
//  PRESETn, //accounted for from reset
  PSEL,
  PENABLE,
  PWRITE,
  PADDR,
  PWDATA,
  PRDATA,
  PREADY			     
);

  input clk;
  input clk_mem;
  input resetn;
  input pe_resetn;
//  input [`AWIDTH-1:0] address_mat_a;
//  input [`AWIDTH-1:0] address_mat_b;
//  input [`AWIDTH-1:0] address_mat_c;
//  input [`ADDR_STRIDE_WIDTH-1:0] address_stride_a;
//  input [`ADDR_STRIDE_WIDTH-1:0] address_stride_b;
//  input [`ADDR_STRIDE_WIDTH-1:0] address_stride_c;  
  input  [`AWIDTH-1:0] bram_addr_a_ext;
  output [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_rdata_a_ext;
  input  [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_wdata_a_ext;
  input  [`MASK_WIDTH-1:0] bram_we_a_ext;
  input  [`AWIDTH-1:0] bram_addr_b_ext;
  output [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_rdata_b_ext;
  input  [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_wdata_b_ext;
  input  [`MASK_WIDTH-1:0] bram_we_b_ext;
  input  [`AWIDTH-1:0] bram_addr_c_ext;
  output [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_rdata_c_ext;
  input  [`MAT_MUL_SIZE*`DWIDTH-1:0] bram_wdata_c_ext;
  input  [`MASK_WIDTH-1:0] bram_we_c_ext;
//  input start;
//  output done;
   input 		   PSEL;
   input 		   PENABLE;
   input 		   PWRITE;
   input [3:0] 		   PADDR;
   input [15:0] 	   PWDATA;
   output logic [15:0] 	   PRDATA;
   output logic		   PREADY;
   

   
	logic [`AWIDTH-1:0] bram_addr_a;
	logic [4*`DWIDTH-1:0] bram_rdata_a;
	logic [4*`DWIDTH-1:0] bram_wdata_a;
	logic [`MASK_WIDTH-1:0] bram_we_a;
	logic bram_en_a;

	logic [`AWIDTH-1:0] bram_addr_b;
	logic [4*`DWIDTH-1:0] bram_rdata_b;
	logic [4*`DWIDTH-1:0] bram_wdata_b;
	logic [`MASK_WIDTH-1:0] bram_we_b;
	logic bram_en_b;
	
	logic [`AWIDTH-1:0] bram_addr_c;
	logic [4*`DWIDTH-1:0] bram_rdata_c;
	logic [4*`DWIDTH-1:0] bram_wdata_c;
	logic [`MASK_WIDTH-1:0] bram_we_c;
	logic bram_en_c;

//  reg [3:0] state;
  reg [1:0] state; //3 slave states

////////////////////////////////////////////////////////////////
// BRAM matrix A 
////////////////////////////////////////////////////////////////
ram matrix_A (
  .addr0(bram_addr_a),
  .d0(bram_wdata_a), 
  .we0(bram_we_a), 
  .q0(bram_rdata_a), 
  .addr1(bram_addr_a_ext),
  .d1(bram_wdata_a_ext), 
  .we1(bram_we_a_ext), 
  .q1(bram_rdata_a_ext), 
  .clk(clk_mem));

////////////////////////////////////////////////////////////////
// BRAM matrix B 
////////////////////////////////////////////////////////////////
ram matrix_B (
  .addr0(bram_addr_b),
  .d0(bram_wdata_b), 
  .we0(bram_we_b), 
  .q0(bram_rdata_b), 
  .addr1(bram_addr_b_ext),
  .d1(bram_wdata_b_ext), 
  .we1(bram_we_b_ext), 
  .q1(bram_rdata_b_ext), 
  .clk(clk_mem));

////////////////////////////////////////////////////////////////
// BRAM matrix C 
////////////////////////////////////////////////////////////////
ram matrix_C (
  .addr0(bram_addr_c),
  .d0(bram_wdata_c), 
  .we0(bram_we_c), 
  .q0(bram_rdata_c), 
  .addr1(bram_addr_c_ext),
  .d1(bram_wdata_c_ext), 
  .we1(bram_we_c_ext), 
  .q1(bram_rdata_c_ext), 
  .clk(clk_mem));

logic start;
logic done_mat_mul;
/*// Provided State Machine	
   always_ff @(posedge clk) begin
      if (resetn == 1'b0) begin
        state <= 4'b0000;
        start <= 1'b0;
      end else begin
        case (state)
        4'b0000: begin
          start <= 1'b0;
          if (start == 1'b1) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        
        4'b0001: begin
          start <= 1'b1;	      
          state <= 4'b1010;                    
        end      
        
        
        4'b1010: begin                 
          if (done_mat_mul == 1'b1) begin
            start <= 1'b0;
            state <= 4'b0000;
          end
          else begin
            state <= 4'b1010;
          end
        end
       
      endcase  
	end 
  end
*/
   logic PCLK, PRESETn, PREADY;
   assign PCLK = clk;
   assign PRESETn = resetn;
   assign PREADY = 1'b1;


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
	      if (PSEL && !PENABLE) begin
		 state <= `SETUP;
	      end
	   end

	   `SETUP: begin
	      if (PSEL && PENABLE) begin
		 if (PWRITE) begin
		    state <= `WRITE_ACCESS;
		 end else begin
		    state <= `READ_ACCESS;
		 end
	      end else begin
		 state <= `IDLE;
	      end
	   end // case: `SETUP


	   `WRITE_ACCESS: begin
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
	      end
	      state <= `IDLE;
	   end // case: `WRITE_ACCESS
	   

	   `READ_ACCESS: begin
	      if (!PWRITE && PENABLE) begin
		 case (PADDR)
		   `REG_DONE_ADDR: begin
		      PRDATA <= {done_mat_mul, 15'b0}; //cpu reads donezo
		   end		   
		 endcase // case (PADDR)
	      end
	      state <= `IDLE;

	   end // case: `READ_ACCESS

	   default: begin
	      state <= `IDLE;
	   end
	 endcase // case (state)
      end // else: !if(PRESETn == 0)   
   end // always_ff @ (posedge PCLK)
   
   
   
  
   
   

   
logic c_data_available;

assign done = done_mat_mul;

//Connections for bram c (output matrix)
//bram_addr_c -> connected to u_matmul_4x4 block
//bram_rdata_c -> not used
//bram_wdata_c -> connected to u_matmul_4x4 block
//bram_we_c -> set to 1 when c_data is available
//bram_en_c -> hardcoded to 1 

  assign bram_en_c = 1'b1;
  assign bram_we_c = (c_data_available) ? 4'b1111 : 4'b0000;  

//Connections for bram a (first input matrix)
//bram_addr_a -> connected to u_matmul_4x4
//bram_rdata_a -> connected to u_matmul_4x4
//bram_wdata_a -> hardcoded to 0 (this block only reads from bram a)
//bram_we_a -> hardcoded to 0 (this block only reads from bram a)
//bram_en_a -> hardcoded to 1

  assign bram_wdata_a = 32'b0;
  assign bram_en_a = 1'b1;
  assign bram_we_a = 4'b0;
  
//Connections for bram b (second input matrix)
//bram_addr_b -> connected to u_matmul_4x4
//bram_rdata_b -> connected to u_matmul_4x4
//bram_wdata_b -> hardcoded to 0 (this block only reads from bram b)
//bram_we_b -> hardcoded to 0 (this block only reads from bram b)
//bram_en_b -> hardcoded to 1

  assign bram_wdata_b = 32'b0;
  assign bram_en_b = 1'b1;
  assign bram_we_b = 4'b0;
  
//NC wires 
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_out_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_out_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_in_NC;
logic [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_in_NC;

logic reset;
assign reset = ~resetn;
assign pe_reset = ~pe_resetn;

matmul_4x4_systolic u_matmul_4x4(
  .clk(clk),
  .reset(reset),
  .pe_reset(pe_reset),
  .start_mat_mul(start),
  .done_mat_mul(done_mat_mul),
  .address_mat_a(address_mat_a),
  .address_mat_b(address_mat_b),
  .address_mat_c(address_mat_c),
  .address_stride_a(address_stride_a),
  .address_stride_b(address_stride_b),
  .address_stride_c(address_stride_c),
  .a_data(bram_rdata_a),
  .b_data(bram_rdata_b),
  .a_data_in(a_data_in_NC),
  .b_data_in(b_data_in_NC),
  .c_data_in({`BB_MAT_MUL_SIZE*`DWIDTH{1'b0}}),
  .c_data_out(bram_wdata_c),
  .a_data_out(a_data_out_NC),
  .b_data_out(b_data_out_NC),
  .a_addr(bram_addr_a),
  .b_addr(bram_addr_b),
  .c_addr(bram_addr_c),
  .c_data_available(c_data_available),
  .validity_mask_a_rows(4'b1111),
  .validity_mask_a_cols_b_rows(4'b1111),
  .validity_mask_b_cols(4'b1111),  
  .final_mat_mul_size(8'd4),
  .a_loc(8'd0),
  .b_loc(8'd0)
);

endmodule  



//////////////////////////////////
//Dual port RAM
//////////////////////////////////
module ram (
    addr0, 
    d0, 
    we0, 
    q0,  
    addr1,
    d1,
    we1,
    q1,
    clk);

    input [`AWIDTH-1:0] addr0;
    input [`MASK_WIDTH*`DWIDTH-1:0] d0;
    input [`MASK_WIDTH-1:0] we0;
    output reg [`MASK_WIDTH*`DWIDTH-1:0] q0;
    input [`AWIDTH-1:0] addr1;
    input [`MASK_WIDTH*`DWIDTH-1:0] d1;
    input [`MASK_WIDTH-1:0] we1;
    output reg [`MASK_WIDTH*`DWIDTH-1:0] q1;
    
    input clk;

    reg [31:0] ram[((1<<`AWIDTH)-1):0];

    always @(posedge clk)  
    begin 
        if (|we0 == 1'b1)
        begin
            ram[addr0] <= d0;
        end
        q0 <= ram[addr0];
    end
        
    always @(posedge clk)  
    begin
        if(|we1 == 1'b1)
        begin
            ram[addr1] <= d1;
        end
        
        q1 <= ram[addr1];
    end
    
endmodule
