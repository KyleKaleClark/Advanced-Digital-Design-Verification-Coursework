/*--------------------------------------------------------------
 *  File Name 	: testbench.sv
 *  Title 		: APB testbench 	
 *  Author		: sefaveske@gmail.com	
 *  Date		: 08/19/2018
 * 
 *               ##     ####   #    #
 *              #  #   #       #    #
 *             #    #   ####   #    #
 *             ######       #  #    #
 *             #    #  #    #   #  #
 *             #    #   ####     ##
 * ------------------------------------------------------------*/
//`timescale 1ns/1ns
 
import uvm_pkg::*;
`include "uvm_macros.svh"

import apb_master_pkg::*;
import apb_slave_pkg::*;
import apb_common_pkg::*;

 `include "apb_test.svh"

//from our og tb
 `define REG_DATAWIDTH 32
 `define REG_ADDRWIDTH 8

module testbench;
	logic pclk;
	logic presetn;
	
/*  
	logic [31:0] paddr;
	logic        psel;
	logic        penable;
	logic        pwrite;
	logic [31:0] prdata;
	logic [31:0] pwdata;
*/ //old stuff, we just use the intf signals

   
	initial begin
		pclk=0;
	end
	
	initial begin
		presetn=0; 
		#40; 
		presetn=1;
	end	

	//Generate a clock
	always begin
		#10 pclk = ~pclk;
	end	
	
	// apb interface
	apb_if  apb_if_inst(pclk,presetn);


   matrix_multiplication u_matmul(
				  .clk(pclk),
				  .resetn(presetn),
				  .pe_resetn(presetn),
				  .PSEL(apb_if_inst.PSEL),
				  .PENABLE(apb_if_inst.PENABLE),
				  .PWRITE(apb_if_inst.PWRITE),
				  .PADDR(apb_if_inst.PADDR),
				  .PWDATA(apb_if_inst.PWDATA),
				  .PRDATA(apb_if_inst.PRDATA),
				  .PREADY(apb_if_inst.PREADY)
				  );




   initial begin
      wait(presetn);
      #1;
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

      `uvm_info("TESTBENCH", "matrix data injected", UVM_LOW);
   end




   
	initial begin
		uvm_config_db#(virtual apb_if)::set( null, "", "apb_vif", apb_if_inst);
		run_test("apb_test");
	end

	initial begin
	   $fsdbDumpvars;
	end

endmodule


