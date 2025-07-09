class memory_transaction extends uvm_sequence_item;
	bit [`AWIDTH-1:0] addr;
	rand logic [4*`DWIDTH-1:0] data;
	typedef enum {READ,WRITE} data_direction;
	data_direction dir;

	`uvm_object_utils_begin(memory_transaction)
		`uvm_field_int(addr, UVM_DEFAULT)
		`uvm_field_int(data, UVM_DEFAULT)
		`uvm_field_enum(data_direction, dir, UVM_DEFAULT)
	`uvm_object_utils_end

		function new(string name = "memory_transaction");
		super.new(name);
	endfunction: new
endclass

//Slave format, constantly running and creating transactions
class memory_sequence extends uvm_sequence #(memory_transaction);
	`uvm_object_utils (memory_sequence)

	function new(string name = "memory_sequence");
		super.new(name);
	endfunction

	virtual task body()
		memory_transaction tr;
		forever begin
			tr = memory_transaction::type_id::create("tr", , get_full_name());
			start_item(tr);
			finish_item(tr);
		end
	endtask
endclass

typedef uvm_sequencer #(memory_transaction) memory_sequencer;
