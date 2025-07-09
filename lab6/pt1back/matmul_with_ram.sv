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







//Design with memories

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
  PREADY	
 );

	input clk;
	input resetn;
	input pe_resetn;

   input 		   PSEL;
   input 		   PENABLE;
   input 		   PWRITE;
   input [3:0] 		   PADDR;
   input [15:0] 	   PWDATA;
   output logic [15:0] 	   PRDATA;
   output logic		   PREADY;

   
	wire [`AWIDTH-1:0] bram_addr_a;
	wire [4*`DWIDTH-1:0] bram_rdata_a;
	wire [4*`DWIDTH-1:0] bram_wdata_a;
	wire [`MASK_WIDTH-1:0] bram_we_a;

	wire [`AWIDTH-1:0] bram_addr_b;
	wire [4*`DWIDTH-1:0] bram_rdata_b;
	wire [4*`DWIDTH-1:0] bram_wdata_b;
	wire [`MASK_WIDTH-1:0] bram_we_b;
	
	wire [`AWIDTH-1:0] bram_addr_c;
	wire [4*`DWIDTH-1:0] bram_rdata_c;
	wire [4*`DWIDTH-1:0] bram_wdata_c;
	wire [`MASK_WIDTH-1:0] bram_we_c;
	

    reg [3:0] state;
  
    //We will utilize port 0 (addr0, d0, we0, q0) to interface with the matmul.
    //Unused ports (port 1 signals addr1, d1, we1, q1) will be connected to the "external" signals i.e. signals that exposed to the external world.
    //Signals that are external end in "_ext".
    //addr is the address of the BRAM, d is the data to be written to the BRAM, we is write enable, and q is the data read from the BRAM. 
    ////////////////////////////////////////////////////////////////
    // RAM matrix A 
    ////////////////////////////////////////////////////////////////
    ram matrix_A (.addr0(bram_addr_a), 
                  .d0(bram_wdata_a), 
                  .we0(bram_we_a), 
                  .q0(bram_rdata_a), 
                  .addr1(bram_addr_a_ext), 
                  .d1(bram_wdata_a_ext), 
                  .we1(bram_we_a_ext), 
                  .q1(bram_rdata_a_ext), 
                  .clk(clk));
    
    ////////////////////////////////////////////////////////////////
    // RAM matrix B 
    ////////////////////////////////////////////////////////////////
    ram matrix_B (.addr0(bram_addr_b), 
                  .d0(bram_wdata_b), 
                  .we0(bram_we_b), 
                  .q0(bram_rdata_b), 
                  .addr1(bram_addr_b_ext), 
                  .d1(bram_wdata_b_ext), 
                  .we1(bram_we_b_ext), 
                  .q1(bram_rdata_b_ext), 
                  .clk(clk));
    
    ////////////////////////////////////////////////////////////////
    // RAM matrix C 
    ////////////////////////////////////////////////////////////////
    ram matrix_C (.addr0(bram_addr_c), 
                  .d0(bram_wdata_c), 
                  .we0(bram_we_c), 
                  .q0(bram_rdata_c), 
                  .addr1(bram_addr_c_ext), 
                  .d1(bram_wdata_c_ext), 
                  .we1(bram_we_c_ext), 
                  .q1(bram_rdata_c_ext), 
                  .clk(clk));


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
   


   //A bunch of assertions we're adding
   property prop_idle_to_setup;
      @(posedge PCLK) ($rose(state == `IDLE)) |-> ##2 (state == `SETUP);
   endproperty // prop_idle_to_setup
   assert_idle_to_setup: assert property (prop_idle_to_setup)
     else $error("assertion failed: state != SETUP after 2 cycles from IDLE");


   property prop_done_to_prdata;
      @(posedge PCLK) (done == 1'b1) |-> ##3 (PRDATA == 16'h8000);
   endproperty // prop_done_to_prdata
   assert_done_to_prdata: assert property (prop_done_to_prdata)
     else $error("assertion failed: Done signal propagated to APB's PRDATA");


   property prop_setup_to_rw;
      @(posedge PCLK) (state == `SETUP) |-> ##1 (state == `READ_ACCESS || state == `WRITE_ACCESS);
   endproperty // prop_idle_to_rw
   assert_setup_to_rw: assert property (prop_setup_to_rw)
     else $error ("assertion failed: SETUP did not go to READ or WRITE");


   property prop_done_to_startoff;
      @(posedge PCLK) (PRDATA == 16'h8000) |-> ##1 (PADDR == '0 && PWDATA == 16'h0000);
   endproperty // prop_done_to_startoff
   assert_done_to_startoff: assert property (prop_done_to_startoff)
     else $error ("assertion failed: Start not turned off after done sets");
   
      


   






	

    wire c_data_available;

//Connections for bram c (output matrix)
//bram_addr_c -> connected to u_matmul_4x4 block
//bram_rdata_c -> not used
//bram_wdata_c -> connected to u_matmul_4x4 block
//bram_we_c -> set to 1 when c_data is available

    assign bram_we_c = (c_data_available) ? 4'b1111 : 4'b0000;  

//Connections for bram a (first input matrix)
//bram_addr_a -> connected to u_matmul_4x4
//bram_rdata_a -> connected to u_matmul_4x4
//bram_wdata_a -> hardcoded to 0 (this block only reads from bram a)
//bram_we_a -> hardcoded to 0 (this block only reads from bram a)

    assign bram_wdata_a = 32'b0;
    assign bram_we_a = 4'b0;
  
//Connections for bram b (second input matrix)
//bram_addr_b -> connected to u_matmul_4x4
//bram_rdata_b -> connected to u_matmul_4x4
//bram_wdata_b -> hardcoded to 0 (this block only reads from bram b)
//bram_we_b -> hardcoded to 0 (this block only reads from bram b)

    assign bram_wdata_b = 32'b0;
    assign bram_we_b = 4'b0;
  
//NC (not connected) wires 
    wire [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_out_NC;
    wire [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_out_NC;
    wire [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] a_data_in_NC;
    wire [`BB_MAT_MUL_SIZE*`DWIDTH-1:0] b_data_in_NC;

    wire reset;
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
