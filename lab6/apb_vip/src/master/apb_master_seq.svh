/*--------------------------------------------------------------
 *  File Name 	: apb_master_seq.svh
 *  Title 		: APB master default sequence (write and read tr.) 	
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

`ifndef _APB_MASTER_SEQ_
`define _APB_MASTER_SEQ_

import uvm_pkg::*;
`include "uvm_macros.svh"

class apb_master_seq extends uvm_sequence#(apb_master_seq_item);

	`uvm_object_utils(apb_master_seq)

	//--------------------------------------------------------------------
	//	Methods
	//--------------------------------------------------------------------
	extern function new (string name = "apb_master_seq");
	extern task body();
endclass

// Function: new
// Definition: class constructor	
function apb_master_seq::new(string name ="apb_master_seq");
	super.new(name);
endfunction

// Function: body
// Definition: body method that gets executed once sequence is started 
task apb_master_seq::body();
	apb_master_seq_item m_apb_master_seq_item;
	
	repeat(1) begin
		m_apb_master_seq_item = apb_master_seq_item::type_id::create("m_apb_master_seq_item");
		start_item(m_apb_master_seq_item);
		assert (m_apb_master_seq_item.randomize());
		finish_item(m_apb_master_seq_item);
	end
endtask


//Making our Custy Sequence for our testbench:
`define REG_DATAWIDTH 16
`define REG_ADDRWIDTH 8

class apb_custom_test_seq extends apb_master_seq;

   `uvm_object_utils(apb_custom_test_seq)

   localparam REG_START_ADDR = 4'h0;
   localparam REG_DONE_ADDR = 4'h1;
   //matrix signals specifically
   localparam REG_ADDR_A_ADDR = 4'h2;
   localparam REG_ADDR_B_ADDR = 4'h3;
   localparam REG_ADDR_C_ADDR = 4'h4;
   localparam REG_STRIDE_A_ADDR = 4'h5;
   localparam REG_STRIDE_B_ADDR = 4'h6;
   localparam REG_STRIDE_C_ADDR = 4'h7;
   



   //methods
   extern function new (string name = "apb_custom_test_seq");
   extern task body();
   extern task apb_write(input [`REG_ADDRWIDTH-1:0] addr, input [`REG_DATAWIDTH-1:0] data);
   extern task apb_read(input [`REG_ADDRWIDTH-1:0] addr, output [`REG_DATAWIDTH-1:0] data);

endclass // apb_custom_test_seq

function apb_custom_test_seq::new(string name = "apb_custom_test_seq");
   super.new(name);
endfunction // new

task apb_custom_test_seq::body();

   bit [15:0] done_signal; //this seems wrong now, but it worked in original tb

   `uvm_info(get_type_name(), "starting test seq", UVM_LOW)

   //init addr/strides
   apb_write(REG_ADDR_A_ADDR, 10'd0);
   apb_write(REG_ADDR_A_ADDR, 10'd0);
   apb_write(REG_ADDR_B_ADDR, 10'd0);
   apb_write(REG_ADDR_C_ADDR, 10'd0);
   apb_write(REG_STRIDE_A_ADDR, 8'd1);
   apb_write(REG_STRIDE_B_ADDR, 8'd1);
   apb_write(REG_STRIDE_C_ADDR, 8'd1);

   //start
   apb_write(REG_START_ADDR, 1);

   done_signal = 16'h0;   //intentional, worked in original tb
   while (!done_signal[15]) begin
      apb_read(REG_DONE_ADDR, done_signal); //intentional from og tb
   end

   //stop op
   apb_write(REG_START_ADDR, 0);
   #100ns;
   `uvm_info(get_type_name(), "custom seq ended :D", UVM_LOW)

endtask // body


task apb_custom_test_seq::apb_write(input [`REG_ADDRWIDTH-1:0] addr, input [`REG_DATAWIDTH-1:0] data);

   apb_master_seq_item req;
   req = apb_master_seq_item::type_id::create("req");
   start_item(req);

   //set trans fields from seq_items
   req.addr = addr;
   req.data = data;
   req.apb_tr = apb_base_seq_item::WRITE;

   finish_item(req);
   `uvm_info(get_type_name(), $sformatf("write: addr=0x%08h, data = 0x%08h", addr, data), UVM_MEDIUM)
   
endtask // apb_write

task apb_custom_test_seq::apb_read(input [`REG_ADDRWIDTH-1:0] addr, output [`REG_DATAWIDTH-1:0] data);

   apb_master_seq_item req;
   req = apb_master_seq_item::type_id::create("req");
   start_item(req);

   //set trans
   req.addr = addr;
   req.apb_tr = apb_base_seq_item::READ;

   finish_item(req);
//   get_response(rsp);
   data = req.data;
   `uvm_info(get_type_name(), $sformatf("read : addr=0x%08h, data = 0x%08h", addr, data), UVM_MEDIUM)
   
endtask // apb_read

	
`endif
