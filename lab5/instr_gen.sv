`include "uvm_macros.svh"
import uvm_pkg::*;

//Add -ntb_opts uvm to the VCS command line

class instruction extends uvm_transaction;
  rand bit [4:0] reg_a, reg_b, reg_c;
  rand bit [5:0] opcode, funct;
  rand bit [15:0] mem_addr, branch;

bit[31:0] instr; 

  constraint unique_regs { 
  	reg_a inside {[1:4]};
	reg_b inside {[1:4]};
	reg_c inside {[1:4]};
  }

  			 	//Rtpe      LW          SW          BEQ
  constraint valid_opcode {
	  	opcode inside {6'b000000, 6'b100011, 6'b101011, 6'b000100};
  }
  
  				//And	     Or
  constraint valid_funct {
	  	funct inside {6'b100100, 6'b100000};
  }

  constraint valid_mem {
	  	mem_addr inside {16'd4, 16'd8, 16'd12, 16'd16};
  }

  constraint valid_branch {
	  	branch inside {16'd1, 16'd2, 16'd3, 16'd4};
  }


 

function void print_me();

  // ----------- R-type: opcode == 0 (ADD / AND) -----------
  if (opcode == 6'b000000) begin
    $display("R-type reg_a=%0d reg_b=%0d  reg_c=%0d  funct=%02h", reg_a, reg_b, reg_c, funct );
  end

  // ----------- I-type: LW / SW / BEQ ---------------------
  else begin
    $display("I-type  opcode=%02h  reg_a=%0d  reg_b=%0d  mem_addr=%0d", opcode, reg_a, reg_b, mem_addr );
  end
endfunction

function void post_randomize();
	if (opcode == 6'b000000) begin
		instr = {opcode,reg_a,reg_b,reg_c,5'b00000,funct};
	end

	else if (opcode == 6'b000100) begin
		instr = {opcode, reg_a, reg_b, branch};
	end

	else begin
		instr = {opcode, reg_a, reg_b, mem_addr};
	end
endfunction
	
endclass

class instruction_generator;

//Dynamic array to hold individual instructions	
instruction instr_list[];
instruction pair_list[];
bit [31:0] machine_code_list[$];
rand bit [2:0] gap;

  	//Constraint to determine number of instructions between pairs
  	constraint valid_gap {
		gap inside {4'd1,4'd2,4'd3,4'd4};
 	}
 	
  	function void generate_individual();
		instr_list = new[15];

	  	for (int i = 0; i <15; i++) begin
			instr_list[i] = new();
		  	assert(instr_list[i].randomize());
     		  	instr_list[i].print_me();
		end

  	endfunction

//Function to generate dependent instruction pairs
//Also creates 1 to 4 instructions between the pair
function instruction generate_pairs();
	assert(randomize(gap));
	pair_list = new[gap + 2];
	pair_list[0] = new();
	pair_list[gap+1] = new();

    	assert(pair_list[0].randomize() with {reg_c==1;});

	for (int i = 1; i < gap+1; i++) begin
		pair_list[i] = new();
		assert(pair_list[i].randomize() with {reg_b != 1; reg_a != 1;});
	end

	assert(pair_list[gap+1].randomize() with {reg_b==1;});

	$display("--- generate_pairs() produced %0d additional instructions ---", gap);
  	foreach (pair_list[i]) begin
   	$write("[%0d] ", i);
   	pair_list[i].print_me();
	end

endfunction
   
//Traverses both the individual and paired instruction arrays
//Adds the 32 bit instruction to the machine_code_list
function void generate_sequence();
	machine_code_list = {};
	foreach (instr_list[i])
		machine_code_list.push_back(instr_list[i].instr);
	foreach (pair_list[i])
		machine_code_list.push_back(pair_list[i].instr);

endfunction

function void generate_machine_code();
	$writememh ("../memfile.dat", machine_code_list);
endfunction

function void display_all();
endfunction

endclass

module testbench;
  instruction_generator gen;

  initial begin
    gen = new();
    gen.generate_individual();
    gen.generate_pairs();
    gen.generate_sequence();
    gen.generate_machine_code();
    gen.display_all();

    //Copy memory from gen to the instr mem
    //OR: Call $readmemh on that file you wrote using $writememh
    //Deassert reset
  end
endmodule

