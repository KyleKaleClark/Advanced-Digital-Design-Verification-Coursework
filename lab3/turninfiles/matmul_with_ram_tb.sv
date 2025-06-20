`timescale 1ns/1ns


`define DWIDTH 8
`define AWIDTH 10
`define MEM_SIZE 1024

`define MAT_MUL_SIZE 4
`define MASK_WIDTH 4
`define LOG2_MAT_MUL_SIZE 2

`define BB_MAT_MUL_SIZE `MAT_MUL_SIZE
`define NUM_CYCLES_IN_MAC 3
`define MEM_ACCESS_LATENCY 1
`define REG_DATAWIDTH 32
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





module matmul_tb;

    reg clk;
    reg resetn;
    reg pe_resetn;
    reg start;
    wire done;

   logic 		   PSEL;
   logic 		   PENABLE;
   logic 		   PWRITE;
   logic [3:0] 		   PADDR;
   logic [15:0] 	   PWDATA;
   logic [15:0] 	   PRDATA;
   logic		   PREADY;


   task write(input [`REG_ADDRWIDTH-1:0] addr, input [`REG_DATAWIDTH-1:0] data);
      begin
	 @(negedge clk);
	 PSEL = 1;
	 PWRITE = 1;
	 PADDR = addr;
	 PWDATA = data;
	 @(negedge clk);
	 PENABLE = 1;
	 @(negedge clk);
	 @(negedge clk);
	 PSEL = 0;
	 PENABLE = 0;
	 PWRITE = 0;
	 PADDR = 0;
	 PWDATA = 0;
	 $display("%t: PADDR %h, PWDATA %h", $time, addr, data);
      end  
   endtask

   ////////////////////////////////////////////
   //Task to read from the configuration block of the DUT
   ////////////////////////////////////////////
   task read(input [`REG_ADDRWIDTH-1:0] addr, output [`REG_DATAWIDTH-1:0] data);
      begin 
	 @(negedge clk);
	 PSEL = 1;
	 PWRITE = 0;
	 PADDR = addr;
	 @(negedge clk);
	 PENABLE = 1;
	 @(negedge clk);
	 PSEL = 0;
	 PENABLE = 0;
	 data = PRDATA;
	 PADDR = 0;
	 $display("%t: PADDR %h, PRDATA %h",$time, addr,data);
      end
   endtask


   
    //DUT
    matrix_multiplication u_matmul(
        .clk(clk), 
        .resetn(resetn), 
        .pe_resetn(pe_resetn), 
	.PSEL(PSEL),
	.PENABLE(PENABLE),
	.PWRITE(PWRITE),
	.PADDR(PADDR),
	.PWDATA(PWDATA),
	.PRDATA(PRDATA),
	.PREADY(PREADY)				   
        );
    
    //Clock Generation  
    initial 
    begin
        clk = 0;
        forever 
        begin
            #10 clk = ~clk;
        end
    end
    
    //Reset
    initial 
    begin
        resetn = 0;
        pe_resetn = 0;
        #55;
        resetn = 1;
        pe_resetn = 1;
    end


    logic [15:0] done_signal;
   
    //Perform test    
    initial 
    begin
        write(`REG_ADDR_A_ADDR, 10'd0);
        write(`REG_ADDR_B_ADDR, 10'd0);
        write(`REG_ADDR_C_ADDR, 10'd0);
        write(`REG_STRIDE_A_ADDR, 8'd1);
        write(`REG_STRIDE_B_ADDR, 8'd1);
        write(`REG_STRIDE_C_ADDR, 8'd1);
        write(`REG_START_ADDR, 1);

       done_signal = 16'd0;
       while (!done_signal[15]) begin
//	  #100;
	  read(`REG_DONE_ADDR, done_signal);
       end
        write(`REG_START_ADDR, 0);
        #100;         
 
        $finish;
    end
    
    initial begin
       #10000;
       $display("error timeout");
       $finish;
       

    end
   

//Actual test case
//  A           B        Output       Output in hex
// 8 4 6 8   1 1 3 0   98 90 82 34    62 5A 52 22
// 3 3 3 7   0 1 4 3   75 63 51 26    4B 3F 33 1A
// 5 2 1 6   3 5 3 1   62 48 44 19    3E 30 2C 13
// 9 1 0 5   9 6 3 2   54 40 46 13    36 28 2E 0D

//my vers Value Equilvanets
// 2 1 1 1   1 2 3 1   08 10 12 08
// 1 2 1 1   3 3 3 3   10 11 12 10
// 1 1 2 1   2 2 2 2   09 10 11 09
// 1 1 1 2   1 1 1 1   08 09 10 08
   
//FP VAL Value Equilvanets
// 40 30 30 30   30 40 48 30   60 64 68 60
// 30 40 30 30   48 48 48 48   64 66 68 64
// 30 30 40 30   40 40 40 40   62 64 66 62
// 30 30 40 30   30 30 30 30   60 62 64 60

   
initial begin
   //A is stored in ROW MAJOR format
   //A[0][0] (8'h08) should be the least significant byte of ram[0]
   //The first column of A should be read together. So, it needs to be 
   //placed in the first matrix_A ram location.
   //This is due to Verilog conventions declaring {MSB, ..., LSB}
        u_matmul.matrix_A.ram[3]  = {8'h40, 8'h30, 8'h30, 8'h30}; 
        u_matmul.matrix_A.ram[2]  = {8'h30, 8'h40, 8'h30, 8'h30};
        u_matmul.matrix_A.ram[1]  = {8'h30, 8'h30, 8'h40, 8'h30};
        u_matmul.matrix_A.ram[0]  = {8'h30, 8'h30, 8'h30, 8'h40};

  //B is stored in COL MAJOR format
   //B[0][0] (8'h30) should be the least significant of ram[0]
   //The first row of B should be read together. So, it needs to be 
   //placed in the first matrix_B ram location. 
        u_matmul.matrix_B.ram[3]  = {8'h30, 8'h30, 8'h30, 8'h30};
        u_matmul.matrix_B.ram[2]  = {8'h40, 8'h40, 8'h40, 8'h40};
        u_matmul.matrix_B.ram[1]  = {8'h48, 8'h48, 8'h48, 8'h48};
        u_matmul.matrix_B.ram[0]  = {8'h30, 8'h48, 8'h40, 8'h30};
end

   
initial begin
	$fsdbDumpvars;
end

endmodule
