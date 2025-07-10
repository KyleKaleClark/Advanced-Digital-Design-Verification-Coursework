import uvm_pkg::*;
`include "uvm_macros.svh"

import apb_master_pkg::*;
import apb_slave_pkg::*;
`include "apb_env.svh"



class memory_test_sequence extends uvm_sequence;
		`uvm_object_utils(memory_test_sequence)

		function new(string name = "memory_test_sequence");
			super.new(name);
		endfunction
		
		memory_env env;
//		apb_env aenv;
   apb_master_agent apb_agent;

   
		virtual task body();
		
			apb_master_seq apb_master_sequence;
			//apb_poll_sequence apb_poll_seq;
			memory_sequence mem_a_seq, mem_b_seq, mem_c_seq;

			`uvm_info("VIRT SEQ", "Starting virtual sequence", UVM_MEDIUM)

//		   if (!uvm_config_db#(memory_env)::get(null, get_full_name(), "env", env)) begin
//		      `uvm_fatal("VIRT_SEQ", "Cannot get env from config")
//		   end

		   apb_agent = env.apb_agent;
		   

		   
			fork 
				begin
					mem_a_seq = memory_sequence::type_id::create("mem_a_seq");
					mem_a_seq.start(env.mem_a_agent.sequencer);
				end
				begin
					mem_b_seq = memory_sequence::type_id::create("mem_b_seq");
					mem_b_seq.start(env.mem_b_agent.sequencer);
				end
				begin
					mem_c_seq = memory_sequence::type_id::create("mem_c_seq");
					mem_c_seq.start(env.mem_c_agent.sequencer);
				end
			join_none

//			apb_master_sequence = apb_master_seq::type_id::create("apb_master_sequence");
//			apb_master_sequence.start(aenv.apb_master_agent.sequencer);

			`uvm_info("VIRT SEQ", "Completed virtual sequence", UVM_MEDIUM)
		endtask
endclass

class memory_test extends uvm_test;
	`uvm_component_utils(memory_test)

	memory_env env;


	bit [4*`DWIDTH-1:0] matrix_a[`MAT_MUL_SIZE][`MAT_MUL_SIZE];
	bit [4*`DWIDTH-1:0] matrix_b[`MAT_MUL_SIZE][`MAT_MUL_SIZE];
	bit [4*`DWIDTH-1:0] matrix_c[`MAT_MUL_SIZE][`MAT_MUL_SIZE];

	function new(string name = "memory_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		env = memory_env::type_id::create("env",this);

	        uvm_config_db#(memory_env)::set(this, "*", "env", env);
	   
	   
		randomize_matrix();
		expected_results();

	endfunction

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);

		configure_memory_models();

	endfunction

	function void randomize_matrix();
		for (int i = 0; i < `MAT_MUL_SIZE; i++) begin
			for (int j = 0; j < `MAT_MUL_SIZE; j++) begin
				matrix_a[i][j] = $urandom_range(0,255);
				matrix_b[i][j] = $urandom_range(0,255);
			end
		end
	
	`uvm_info("TEST", "Randomized matrix A and B", UVM_MEDIUM)

	endfunction
	
	function void expected_results();
		for (int i = 0; i < `MAT_MUL_SIZE; i++) begin
			for (int j = 0; j < `MAT_MUL_SIZE; j++) begin
				matrix_c[i][j] = matrix_a[i][j] * matrix_b[i][j];
			end
		end
	
	`uvm_info("TEST", "Calculated expected results in matrix C", UVM_MEDIUM)

	endfunction
	

	//Associates matrix values to memory addresses
	function void configure_memory_models();
		for (int i = 0; i < `MAT_MUL_SIZE; i++) begin
			for (int j = 0; j < `MAT_MUL_SIZE; j++) begin
				env.mem_a_agent.mem_model[i * `MAT_MUL_SIZE + j] = matrix_a[i][j];
				env.mem_b_agent.mem_model[i * `MAT_MUL_SIZE + j] = matrix_b[i][j];
			end
		end
	
	`uvm_info("TEST", "Configured memory A and B models", UVM_MEDIUM)

	endfunction

	

	virtual task run_phase(uvm_phase phase);
		memory_test_sequence vseq;

		phase.raise_objection(this);

		`uvm_info("TEST", "Starting matrix multiplication", UVM_MEDIUM)

		vseq = memory_test_sequence::type_id::create("vseq");
	   vseq.env = this.env;
		vseq.start(null);

		#1000;

		check_results();

		phase.drop_objection(this);
	endtask


	function void check_results();
		bit [4*`DWIDTH-1:0] result;
		bit test_passed = 1;

		`uvm_info("TEST", "Checking results", UVM_MEDIUM)

		for (int i = 0; i < `MAT_MUL_SIZE; i++) begin
			for (int j = 0; j < `MAT_MUL_SIZE; j++) begin
				int addr = i * `MAT_MUL_SIZE + j;
				if (env.mem_c_agent.mem_model.exists(addr)) begin
					result = env.mem_c_agent.mem_model[addr];	
					if (result != matrix_c[i][j]) begin
						`uvm_error("TEST", $sformatf("Mismatch at [%0d][%0d]: expected = 0x%0h, actual - 0x%0h", i ,j, matrix_c[i][j], result))
						test_passed = 0;
					end
				end 
				else begin
					`uvm_error("TEST", $sformatf("No result written to address [%0d][%0d]",i,j))
					test_passed = 0;
				end
			end
		end
		
		if (test_passed) begin
			`uvm_info("TEST", "Passed, all results match expected", UVM_MEDIUM)
		end
		else begin
			`uvm_info("TEST", "Failed, results do not match expected", UVM_MEDIUM)
		end
	endfunction
endclass






