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
		uvm_config_db#(virtual apb_if)::set( null, "", "apb_vif", apb_if_inst);
		run_test("apb_test");
	end

	initial begin
	   $fsdbDumpvars;
	end

endmodule


