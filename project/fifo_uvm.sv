import uvm_pkg::*;
`include "uvm_macros.svh"


import "DPI-C" function int push(int wdata);
import "DPI-C" function int pop();
import "DPI-C" function int rst_r_ptr();
import "DPI-C" function int rst_w_ptr();
import "DPI-C" function int is_empty();
import "DPI-C" function int is_full();
import "DPI-C" function int get_r_ptr();
import "DPI-C" function int get_w_ptr();


class fifo_transaction extends uvm_sequence_item;

   rand bit [7:0] wdata;
   rand bit winc;
   rand bit rinc;
   rand bit wrst_n;
   rand bit rrst_n;

   bit [7:0] rdata;
   bit 	     wfull;
   bit 	     rempty;

   //timing
   int 	     write_delay;
   int 	     read_delay;

   `uvm_object_utils_begin(fifo_transaction)
      `uvm_field_int(wdata, UVM_ALL_ON)
      `uvm_field_int(winc, UVM_ALL_ON)
      `uvm_field_int(rinc, UVM_ALL_ON)
      `uvm_field_int(wrst_n, UVM_ALL_ON)
      `uvm_field_int(rrst_n, UVM_ALL_ON)
      `uvm_field_int(rdata, UVM_ALL_ON)
      `uvm_field_int(wfull, UVM_ALL_ON)
      `uvm_field_int(rempty, UVM_ALL_ON)
      `uvm_field_int(write_delay, UVM_ALL_ON)
      `uvm_field_int(read_delay, UVM_ALL_ON)
   `uvm_object_utils_end
   

   function new(string name = "fifo_transaction");
      super.new(name);
   endfunction // new


//   constraint c_reset_logic{
//      
//			    }

endclass // fifo_transaction


interface fifo_if(input wclk, input rclk);

   logic [7:0] wdata, rdata;
   logic       winc, rinc;
   logic       wrst_n, rrst_n;
   logic       wfull, rempty;
   
endinterface // fifo_if


class fifo_sequencer extends  uvm_sequencer #(fifo_transaction);

   `uvm_component_utils(fifo_sequencer)

   function new(string name = "fifo_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction // new

endclass // fifo_sequencer



class fifo_driver extends uvm_driver #(fifo_transaction);

   `uvm_component_utils(fifo_driver)

   virtual     fifo_if vif;

   function new (string name = "fifo_driver", uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);
      if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
	`uvm_fatal("DRIVER", "vif not found")
   endfunction // build_phase


   task run_phase(uvm_phase phase);

      fifo_transaction req;

      //init signals
      vif.wdata <= 0;
      vif.winc <= 0;
      vif.wrst_n <= 0;
      vif.rinc <= 0;
      vif.rrst_n <= 0;

      //wait for reset release
      repeat(10) @(posedge vif.wclk);
      vif.wrst_n <= 1;
      vif.rrst_n <= 1;

      forever begin
	 seq_item_port.get_next_item(req);
	 drive_transaction(req);
	 seq_item_port.item_done();
      end
   endtask // run_phase
   
   task drive_transaction(fifo_transaction req);

      //drive reset
      if (!req.wrst_n) begin
	 vif.wrst_n <= 0;
	 vif.wdata <= 0;
	 vif.winc <= 0;
	 @(posedge vif.wclk);
	 rst_w_ptr(); //dpi model
	 return;
      end

      if(!req.rrst_n) begin
	 vif.rrst_n <= 0;
	 vif.rinc <= 0;
	 @(posedge vif.rclk);
	 rst_r_ptr(); //dpi stuff
	 return;
      end

      //release resets
      vif.wrst_n <= req.wrst_n;
      vif.rrst_n <= req.rrst_n;

      
      //drive write trans
      if (req.wrst_n && req.winc) begin
	 vif.wdata <= req.wdata;
	 vif.winc <= 1;

	 @(posedge vif.wclk);


	 vif.winc <= 0;
	 vif.wdata <= 0;

	 push(req.wdata); //pass into dpi fifo
	 `uvm_info("DRIVER", $sformatf("PUSH: %h", req.wdata), UVM_MEDIUM)
      end else begin
	 vif.winc <= 0;
	 @(posedge vif.wclk);
      end


      //drive reads
      if (req.rrst_n && req.rinc) begin
	 vif.rinc <= 1;
	 @(posedge vif.rclk);
	 vif.rinc <= 0;
      end else begin
	 @(posedge vif.rclk);
      end
            

      //add delays if req
      if (req.write_delay > 0) repeat(req.write_delay) @(vif.wclk);
      if (req.read_delay >0) repeat(req.read_delay) @(vif.rclk);
      
   endtask // drive_transaction
endclass // fifo_driver

class fifo_monitor extends uvm_monitor;

   `uvm_component_utils(fifo_monitor)

   virtual fifo_if vif;
   uvm_analysis_port #(fifo_transaction) ap;

   //golden model stuff
   logic [7:0] golden_data;
   logic       golden_empty, golden_full;
   logic [7:0] golden_rptr, golden_wptr;


   function new(string name = "fifo_monitor", uvm_component parent);
      super.new(name, parent);
      ap = new("ap", this);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
	`uvm_fatal("MONITOR", "vif couldn't get got")
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      fifo_transaction txn;

      forever begin
	 @(posedge vif.wclk);
	 //update gold model
	 golden_full = is_full();
	 golden_wptr = get_w_ptr();

	 //check for writes
	 if (vif.winc && vif.wrst_n) begin
	    txn = fifo_transaction::type_id::create("write_txn");
	    txn.wdata = vif.wdata;
	    txn.winc = 1;
	    txn.wfull = vif.wfull;

	    //check full
	    check_full_flag(txn);
	    ap.write(txn);
	 end


	 @(posedge vif.rclk);
	 //check for reads
	 golden_empty = is_empty();
	 golden_rptr = get_r_ptr();
	 
	 if (vif.rinc && vif.rrst_n) begin
	    golden_data = pop();
	    txn = fifo_transaction::type_id::create("read_txn");
	    txn.rinc = 1;
	    txn.rdata = vif.rdata;
	    txn.rempty = vif.rempty;
	    //check rdata & empty
	    check_read_data(txn);
	    check_empty_flag(txn);
	    ap.write(txn);
	 end
      end // forever begin


      
   endtask // run_phase
   


   //actual monitoring functions   
   function void check_read_data(fifo_transaction txn);
      if (golden_data == txn.rdata) begin
	 `uvm_info("MONITOR", $sformatf("Successful read: golden data: %h || DUT: %h", golden_data, txn.rdata), UVM_MEDIUM)
      end else begin
	 `uvm_error("MONITOR", $sformatf("FAIL!! READ: golden data: %h || DUT: %h", golden_data, txn.rdata))
      end
   endfunction // check_read_data

   function void check_empty_flag(fifo_transaction txn);
      if (golden_empty) begin
	 if (golden_empty == txn.rempty) begin
	    `uvm_info("MONITOR", $sformatf("Successful empty flag match!"), UVM_MEDIUM)
	 end else begin
	    `uvm_error("MONITOR", $sformatf("FAIL!! Empty mismatch: golden: %b || DUT: %b", golden_empty, txn.rempty))
	 end
      end      
   endfunction // check_empty_flag

   function void check_full_flag(fifo_transaction txn);
      if (golden_full) begin
	 if (golden_full == txn.wfull) begin
	    `uvm_info("MONITOR", "Sucessfull full flag check!", UVM_MEDIUM)
	 end else begin
	    `uvm_error("MONITOR", $sformatf("FAIL!! Full mismatch: golden: %b || DUT: %b", golden_full, txn.wfull))
	 end
      end
   endfunction // check_full_flag
   
   
endclass // fifo_monitor

class fifo_scoreboard extends uvm_scoreboard;

   `uvm_component_utils(fifo_scoreboard)

   uvm_analysis_imp #(fifo_transaction, fifo_scoreboard) ap_imp;

   //the stats
   int wcnt;
   int rcnt;
   int errcnt;

   function new(string name = "fifo_scoreboard", uvm_component parent);
      super.new(name, parent);
      ap_imp = new("ap_imp", this);
   endfunction // new

   function void write(fifo_transaction txn);
      if (txn.winc) wcnt++;
      if (txn.rinc) rcnt++;
   endfunction // write

   function void report_phase(uvm_phase phase);
      `uvm_info("SCOREBOARD", $sformatf("Test summary: Writes=%0d, Reads=%0d, Errors=%0d", wcnt, rcnt, errcnt), UVM_LOW)
   endfunction // report_phase
   
   
endclass // fifo_scoreboard




class fifo_agent extends uvm_agent;

   `uvm_component_utils(fifo_agent)

   fifo_driver driver;
   fifo_monitor monitor;
   fifo_sequencer sequencer;

   function new(string name = "fifo_agent", uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      driver = fifo_driver::type_id::create("driver", this);
      monitor = fifo_monitor::type_id::create("monitor", this);

      if (get_is_active() == UVM_ACTIVE) begin
	 sequencer = fifo_sequencer::type_id::create("sequencer", this);
      end
   endfunction // build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (get_is_active() === UVM_ACTIVE) begin
	 driver.seq_item_port.connect(sequencer.seq_item_export);
      end
   endfunction // connect_phase

endclass // fifo_agent

class fifo_env extends uvm_env;

   `uvm_component_utils(fifo_env)

   fifo_agent agent;
   fifo_scoreboard scoreboard;

   
   
   function new(string name = "fifo_env", uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      agent = fifo_agent::type_id::create("agent", this);
      scoreboard = fifo_scoreboard::type_id::create("scoreboard", this);
   endfunction // build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.monitor.ap.connect(scoreboard.ap_imp);
   endfunction // connect_phase

endclass // fifo_env

class fifo_base_sequence extends uvm_sequence #(fifo_transaction);

   `uvm_object_utils(fifo_base_sequence)

   function new(string name = "fifo_base_sequence");
      super.new(name);
   endfunction // new
   
   
endclass // fifo_base_sequence

class fifo_fill_sequence extends fifo_base_sequence;

   `uvm_object_utils(fifo_fill_sequence)

   function new(string name = "fifo_fill_sequence");
      super.new(name);
   endfunction // new

   task body();
      fifo_transaction req;

      `uvm_info("SEQUENCE", "starting fifo fill test", UVM_LOW)

      //reset
      req = fifo_transaction::type_id::create("reset_req");
      req.wrst_n = 0;
      req.rrst_n = 0;
      req.winc = 0;
      req.rinc = 0;
      start_item(req);
      finish_item(req);

      //let go reset
      req = fifo_transaction::type_id::create("reset_release");
      req.wrst_n = 1;
      req.rrst_n = 1;
      req.winc = 0;
      req.rinc = 0;
      start_item(req);
      finish_item(req);


      //fill fifo w/ sequential data
      for (int i = 1; i <= 15; i++) begin
	 req = fifo_transaction::type_id::create($sformatf("write_%0d_enable", i));
	 req.wdata = i;
	 req.winc = 1;
	 req.rinc = 0;
	 req.wrst_n = 1;
	 req.rrst_n = 1;
	 //req.write_delay = 1;
	 start_item(req);
	 finish_item(req);

	 req = fifo_transaction::type_id::create($sformatf("write_%0d_disable", i));	 
	 req.wdata = i;
	 req.winc = 0;
	 req.rinc = 0;
	 req.wrst_n = 1;
	 req.rrst_n = 1;
	 //req.write_delay = 1;
	 start_item(req);
	 finish_item(req);

	 
      end
      
      `uvm_info("SEQUENCE", "FIFO fill test complete!", UVM_LOW)
   endtask // body

endclass // fifo_fill_sequence

class fifo_empty_sequence extends fifo_base_sequence;

   `uvm_object_utils(fifo_empty_sequence)

   function new(string name = "fifo_empty_sequence");
      super.new(name);
   endfunction // new

   task body();
      fifo_transaction req;

      `uvm_info("SEQUENCE", "Starting FIFO Empty seq", UVM_LOW)

      for(int i = 0; i <= 15; i++) begin
	 req = fifo_transaction::type_id::create($sformatf("read_%0d", i));
	 req.winc = 0;
	 req.rinc = 1;
	 req.wrst_n = 1;
	 req.rrst_n = 1;
	 req.read_delay = 1;
	 start_item(req);
	 finish_item(req);
      end
      

      `uvm_info("SEQUENCE", "FIFO empty test complete", UVM_LOW)
   endtask // body
   
   
endclass // fifo_empty_sequence


//Randomized Sequences
class fifo_random_burst extends fifo_base_sequence;

   `uvm_object_utils(fifo_random_burst)

   function new(string name = "fifo_random_burst");
      super.new(name);
   endfunction // new

   task body();

      fifo_transaction req;
      int fifo_depth = 0; //current depth
      int total_ops = 0;
      int max_ops = 32; //however long we want to go

      `uvm_info("SEQUENCE", "Starting FIFO randomized burst", UVM_LOW)

      //hard resets before starting
      req = fifo_transaction::type_id::create("reset_req");
      req.wrst_n = 0;
      req.rrst_n = 0;
      req.winc = 0;
      req.rinc = 0;
      start_item(req);
      finish_item(req);

      req = fifo_transaction::type_id::create("reset_release");
      req.wrst_n = 1;
      req.rrst_n = 1;
      req.winc = 0;
      req.rinc = 0;
      start_item(req);
      finish_item(req);

      
      while(total_ops < max_ops) begin

	 int burst_len = $urandom_range(1, 8); //burst lengths
	 int do_write = $urandom_range(0, 1); //pick read/writes randomly
	 
	 if (do_write || fifo_depth < 3) begin
	    //write burst
	    for (int i = 0; i < burst_len && total_ops < max_ops; i++) begin
	       req = fifo_transaction::type_id::create($sformatf("burst_write_%0d", total_ops));
	       req.wdata = $urandom_range(0, 255);
	       req.winc = 1;
	       req.rinc = 0;
	       req.wrst_n = 1;
	       req.rrst_n = 1;
	       start_item(req);
	       finish_item(req);
	       fifo_depth++;
	       total_ops++;
	       
	    end // for (int i = 0; i < burst_len && total_ops < max_ops; i++)
	 end // if (do_write || fifo_depth == 0)

	 else begin 
	    //do read burst
	    for (int i = 0; i < burst_len && fifo_depth > 0 && total_ops < max_ops; i++) begin
	       req = fifo_transaction::type_id::create($sformatf("burst_read_%0d", total_ops));
	       req.winc = 0;
	       req.rinc = 1;
	       req.wrst_n = 1;
	       req.rrst_n = 1;
	       start_item(req);
	       finish_item(req);
	       fifo_depth--;
	       total_ops++;
	    end // for (int i = 0; i < burst_len && fifo_depth > 0 && total_ops < max_ops; i++)
	 end // else: !if(do_write || fifo_depth == 0)
      end // while (total_ops < max_ops)
      
   `uvm_info("SEQUENCE", "FIFO randomized bursts complete", UVM_LOW)
   endtask // body
   

endclass // fifo_random_burst









class fifo_test extends uvm_test;

   `uvm_component_utils(fifo_test)

   fifo_env env;

   function new(string name = "fifo_test", uvm_component parent);
      super.new(name, parent);
   endfunction // new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = fifo_env::type_id::create("env", this);
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      fifo_fill_sequence fill_seq;
      fifo_empty_sequence empty_seq;
      //randomized burst one      
      fifo_random_burst burst_seq;
      
      
      phase.raise_objection(this);

      fill_seq = fifo_fill_sequence::type_id::create("fill_seq");
      fill_seq.start(env.agent.sequencer);

      empty_seq = fifo_empty_sequence::type_id::create("empty_seq");
      empty_seq.start(env.agent.sequencer);


      `uvm_info("SEQUENCE", "\n\nStarting Randomized Burst Sequence", UVM_LOW)
      burst_seq = fifo_random_burst::type_id::create("burst_seq");
      burst_seq.start(env.agent.sequencer);
      //concurrent one here

      #1000;
      phase.drop_objection(this);
   endtask // run_phase
   

endclass // fifo_test


module fifo_tb_top;

   logic wclk, rclk;

   initial begin
      wclk = 0;
      forever #5 wclk = ~wclk;
   end

   initial begin
      rclk = 0;
      forever #10 rclk = ~rclk;
   end

   //interface
   fifo_if vif(wclk, rclk);


   fifo dut(
	    .wclk(wclk),
	    .rclk(rclk),
	    .wdata(vif.wdata),
	    .rdata(vif.rdata),
	    .winc(vif.winc),
	    .rinc(vif.rinc),
	    .wrst_n(vif.wrst_n),
	    .rrst_n(vif.rrst_n),
	    .wfull(vif.wfull),
	    .rempty(vif.rempty)
	    );

   initial begin
      uvm_config_db#(virtual fifo_if)::set(null, "*", "vif", vif);
      run_test("fifo_test");
   end

   initial begin
      $fsdbDumpvars();
   end
   
   

endmodule // fifo_tb_top
