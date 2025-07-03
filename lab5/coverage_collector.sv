interface instr_mem_if(input logic clk, input logic reset);

   logic [31:0] instr;
   logic [31:0] pc;

endinterface // instr_mem_if


class transaction extends uvm_sequence_item;

   rand bit [5:0] opcode;
   rand bit [4:0] rs, rt, rd;
   rand bit [15:0] immediate;
   rand bit [31:0] pc;
   rand time timestamp;
   rand bit [4:0] reg_c;

   `uvm_object_utils(transaction)

   function new(string name = "transaction");
      super.new(name);
   endfunction
   
endclass // transaction



class instr_monitor extends uvm_monitor;
  `uvm_component_utils(instr_monitor)

  virtual instr_mem_if vif;
  uvm_analysis_port #(transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
     ap = new("ap", this);      //ap port 
  endfunction

  function void build_phase(uvm_phase phase);
    //Get vif from resource db
     super.build_phase(phase);
     `uvm_info("BUILD_PHASE", "instr_mon entered build_phase", UVM_LOW);
     if (!uvm_config_db#(virtual instr_mem_if)::get(this, "", "vif", vif)) begin
	`uvm_fatal("no vif", "intf not set");
     end else begin
	`uvm_info("BUILD_PHASE", "instr_mon vif gotten :D", UVM_LOW);
     end

  endfunction

  task run_phase(uvm_phase phase);
    transaction tr;
     `uvm_info("RUN_PHASE", "isntr_mon run_phase entere", UVM_LOW);
    //wait for reset
    forever begin
       @(posedge vif.clk);
       `uvm_info("RUN_PHASE", "vif.clk happens :)", UVM_LOW);
       if (!vif.reset) begin
	  `uvm_info("RUN_PHASE", "!vif.reset happens :)", UVM_LOW);
	  tr = new(); //create transaction so we can write it out to subs

	  tr.opcode = vif.instr[31:26];
	  tr.rs = vif.instr[25:21];
	  tr.rt = vif.instr[20:16];
	  tr.rd = vif.instr[15:11];
	  tr.reg_c = vif.instr[15:11];
	  tr.immediate = vif.instr[15:0];
	  tr.pc = vif.pc;
	  tr.timestamp = $time;

	  `uvm_info("monitored: ", $sformatf("instr: opcode 0x%h, pc=0x%h", tr.opcode, tr.pc), UVM_DEBUG);

	  ap.write(tr);
       end // if (!vif.reset)
       
    end
  endtask
endclass


class instr_coverage extends uvm_subscriber #(transaction);
   `uvm_component_utils(instr_coverage)

   uvm_analysis_imp #(transaction, instr_coverage) imp;

   transaction tr;
   transaction instr_q[$];

   //for the instr stuff
   bit [5:0] prev_op;
   bit [5:0] curr_op;

   //for gap stuff
   int 	     cycle_cnt = 0;
   int 	     last_lw_cycle = 0;
   int 	     gap_lw = 0;
   
   
   
   covergroup instr_fields_cg;
      coverpoint tr.opcode {
	 bins add = {6'h00};
	 bins lw = {6'h23};
	 bins sw = {6'h2b};
	 bins beq = {6'h04};
      }
      coverpoint tr.reg_c;
   endgroup

   covergroup instr_order_cg;

      cp_order: coverpoint {prev_op, curr_op}
	{
	 bins lw_add = { {6'h23, 6'h00} };
	 bins lw_sw =  { {6'h23, 6'h2b} };
	 bins lw_beq = { {6'h23, 6'h04} };
	 }
   endgroup

   covergroup instr_gap_cg;
      cp_gap_lw: coverpoint gap_lw 
	{
	 bins gaps = {[1:4]};
      }
   endgroup

   
   function new(string name, uvm_component parent);
      super.new(name, parent);
      imp = new("imp", this);
      instr_fields_cg = new();
      instr_order_cg = new();
      instr_gap_cg = new();
   endfunction

   function void write(transaction t);
      this.tr = t;
      instr_q.push_back(tr);     
      //Create a queue
      //Call sample of various cgs
      if (instr_q.size() > 10)
	instr_q.pop_front();
      
      instr_fields_cg.sample();


      //ordering stuff
      this.curr_op = tr.opcode;
      instr_order_cg.sample();
      this.prev_op = tr.opcode;

      //gap stuff
      cycle_cnt = cycle_cnt + 1;
      if (tr.opcode == 6'h23) begin
	 if (last_lw_cycle != 0) begin
	    gap_lw = cycle_cnt - last_lw_cycle;
	    if (gap_lw >= 1 && gap_lw <= 4)
	      instr_gap_cg.sample();
	 end
	 last_lw_cycle = cycle_cnt;
      end
   endfunction
endclass

class instr_env extends uvm_env;
  `uvm_component_utils(instr_env)

  instr_monitor mon;
  instr_coverage cov;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     mon = instr_monitor::type_id::create("mon", this);
     cov = instr_coverage::type_id::create("cov", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    mon.ap.connect(cov.imp);
  endfunction
endclass

class my_test extends uvm_test;

   `uvm_component_utils(my_test)

   instr_env env;
   
   function new (string name = "my_test", uvm_component parent = null);
      super.new (name, parent);
   endfunction

   function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      env  = instr_env::type_id::create ("env", this);
   endfunction // build_phase


   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("RUN_PHASE", "my_test run_phase active", UVM_LOW);
      #1000;
      `uvm_info("RUN_PHASE", "my_test run_phase completing", UVM_LOW);
      phase.drop_objection(this);
   endtask // run_phase

endclass

module top_cov;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //DUT instance
  //Interface
   logic clk, reset;
   logic [31:0] writedata, dataadr;
   logic 	memwrite;

   top_mips dut(
           .clk(clk),
           .reset(reset),
           .writedata(writedata),
           .dataadr(dataadr),
           .memwrite(memwrite)
	   );

   instr_mem_if instr_if(clk, reset);

   assign instr_if.instr = dut.instr;
   assign instr_if.pc = dut.pc;

   initial begin
      clk = 0;
      forever #5 clk = ~clk;
   end

   initial begin
      forever begin
	 #10;
	 $display("CLK=%b RESET=%b TIME=%0t", clk, reset, $time);
	 $display("PC=%h INSTR=%h", dut.pc, dut.instr);
	 $display("-------------------------------------------");
      end
   end
   
   

   initial begin
      reset = 1;
      #20;
      reset = 0;
   end


   initial begin
      $display("RUNNING TOP = top_cov.sv @ time %0t", $time);
   end
   

   
   instruction_generator gen;
   
  //Resource db population

  initial begin
    //Code from the instr generator part:
     gen = new();

     gen.generate_individual();
     gen.generate_pairs();
     gen.generate_sequence();
     gen.generate_machine_code();
     gen.display_all();

     $display("finished instr generation");
     
     //Note you will merge the codes from the instr generator and the coverage collector properly. I'm just showing something basic.

     uvm_config_db#(virtual instr_mem_if)::set(null, "*", "vif", instr_if);
     
     //Copy memory from gen to the instr mem
     //OR: Call $readmemh on that file you wrote using $writememh
     //Deassert reset
     run_test("my_test");
  end // initial begin

   initial begin
      $fsdbDumpfile("novas.fsdb");
      $fsdbDumpvars(0);
      #1_000_000_000;
      $display("ERROR ERROR timeout....");
      $finish;
   end


   
endmodule
