class memory_env extends uvm_env;
	`uvm_component_utils(memory_env)

	apb_master_agent apb_agent;
	memory_agent mem_a_agent;
	memory_agent mem_b_agent;
	memory_agent mem_c_agent;

	function new(string name = "memory_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);


	apb_agent = apb_master_agent::type_id::create("apb_agent",this);

	mem_a_agent = memory_agent::type_id::create("mem_a_agent",this);
	mem_b_agent = memory_agent::type_id::create("mem_b_agent",this);
	mem_c_agent = memory_agent::type_id::create("mem_c_agent",this);

	uvm_config_db#(string)::set(this, "mem_a_agent", "direction", "READ");
	uvm_config_db#(string)::set(this, "mem_b_agent", "direction", "READ");
	uvm_config_db#(string)::set(this, "mem_c_agent", "direction", "WRITE");
	
	endfunction

endclass
