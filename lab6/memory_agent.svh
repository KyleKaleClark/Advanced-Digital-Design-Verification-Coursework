class memory_agent extends uvm_agent;
	`uvm_component_utils(memory_agent)

	memory_driver driver;
	memory_sequencer sequencer;
	
	string direction;
	bit [4*`DWIDTH-1:0]mem_model[*];

	function new(string name = "memory_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

	if (!uvm_config_db#(string)::get(this,"","direction", direction))
		`uvm_fatal("AGENT", "Could not identify READ or WRITE")

	driver = memory_driver::type_id::create("driver",this);
	sequencer = memory_sequencer::type_id::create("sequencer",this);

	uvm_config_db#(string)::set(this, "driver", "direction", direction;

	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction

endclass

