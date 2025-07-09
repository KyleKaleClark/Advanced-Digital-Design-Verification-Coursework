class memory_driver extends uvm_driver#(memory_transaction);
	`uvm_component_utils(memory_driver)

	virtual memory_if vif;
	memory_transaction tr;

	string direction;
	bit [4*`DWIDTH-1:0] mem_model[*];


	function new (string name = "memory_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual memory_if)::get(this, "","vif",vif))
			`uvm_fatal("DRIVER", "No virtual interface specified")
		if (!uvm_config_db#(string)::get(this,"","direction", direction))
			`uvm_fatal("DRIVER", "Could not identify READ or WRITE")
	endfunction


	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		init_signals();
		wait_for_reset();
		get_and_drive();
	endtask

	virtual task init_signals();
		if (direction == "READ") begin
			vif.data <= 0;
		end
	endtask

	virtual task wait_for_reset();
		wait(!vif.reset);
	endtask

	virtual task get_and_drive();
		forever begin
			@(posedge vif.en);
				tr = memory_transaction::type_id::create("tr");
				seq_item_port.get_next_item(tr);

				if (direction == "WRITE") begin
					mem_model[vif.addr] <= vif.data;
					tr.data <= vif.data;
					tr.addr <= vif.addr;
					tr.dir <= WRITE;
					`uvm_info("DRIVER", $sformatf("WRITE: addr=0x%0h, data=0x%0h",vif.addr,vif.data),UVM_MEDIUM)
				end

				else begin
					vif.data <= mem_model[vif.addr];
					tr.data <= vif.data;
					tr.addr <= vif.addr;
					tr.dir <= READ;
					`uvm_info("DRIVER", $sformatf("READ: addr=0x%0h, data=0x%0h", vif.addr,vif.data),UVM_MEDIUM)
				end
				
				seq_item_port.item_done();
		end
	endtask
endclass

				

