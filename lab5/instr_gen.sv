
//Add -ntb_opts uvm to the VCS command line

class instruction extends uvm_transaction;
  rand bit [4:0] reg_a, reg_b, reg_c;
  rand bit [5:0] opcode, funct;
  rand bit [15:0] mem_addr;
  ...

  constraint unique_regs { 
  	reg_a inside {[1:4]};
	reg_b inside {[1:4]};
	reg_c inside {[1:4]};
  }

  			 	//Rtpe      LW          SW          BEQ
  constraint valid_opcode {
	  	opcode inside {6'b000000, 6'b100011, 6'b101011, 6'b000100}
  }
  
  				//And	     Or
  constraint valid funct {
	  	funct inside {6'b100100, 6'b100000}
  }

  constraint valid mem {
	  	mem_addr inside {16'd4, 16'd8, 16'd12, 16'd16}
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

endclass

class instruction_generator;
  instruction instr_list[];
  bit [31:0] machine_code_list[];

  function void generate_individual();
      ...
      assert(instr_list[i].randomize());
      ...
  endfunction

  function instruction generate_pairs();
    ...
    txn1.randomize() with { reg_a = 1; };
    txn2.randomize() with { reg_a = 1; };
  endfunction

  function void insert_gaps();
  endfunction

  function void generate_sequence();
  endfunction

  function void generate_machine_code();
  ...
  $writememh (...);
  ..
  endfunction

  function void display_all();
  endfunction
endclass

module testbench;
  instruction_generator gen;

  initial begin
    gen = new();
    gen.generate_machine_code();
    gen.display_all();

    //Copy memory from gen to the instr mem
    //OR: Call $readmemh on that file you wrote using $writememh
    //Deassert reset
  end
endmodule

