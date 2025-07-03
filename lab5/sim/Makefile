
all: sim clean

# This compiles with VCS and runs simulation
comp_and_sim_top:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog -ntb_opts uvm ../instr_gen.sv -debug_access+all |& tee compile_and_sim.log

# This compiles with VCS
compile_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../mips_tb.sv ../top.sv ../controller.sv ../datapath.sv -debug_access+all |& tee compile_top.log



# This compiles with VCS and also generates the database for Verdi
compile_verdi_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../mips_tb.sv ../top.sv ../controller.sv ../datapath.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log


#This compiles UVM as well, but we are not using it for now
compile_uvm:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../mips_tb.sv ../top.sv ../controller.sv ../datapath.sv -debug_access+all -ntb_opts uvm |& tee compile_uvm.log





#coverage stuff
compile_cov:
	${VCS_HOME}/bin/vcs -full64 -sverilog  -ntb_opts uvm +ntb_random_seed=$$(date +%s) ../instr_gen.sv ../coverage_collector.sv ../top_mips.sv ../controller.sv ../datapath.sv -debug_access+all -cm line+cond+fsm+tgl -top top_cov |& tee compile_top.log


compile_verdi_cov:
	${VCS_HOME}/bin/vcs -full64 -sverilog -ntb_opts uvm +ntb_random_seed=$$(date +%s) ../instr_gen.sv ../coverage_collector.sv ../top_mips.sv ../controller.sv ../datapath.sv -debug_access+all -kdb -lca -cm line+cond+fsm+tgl -top top_cov |& tee compile_verdi.log


# This runs simulation
sim:
	./simv +vcs+cm.log +ntb_random_seed=$$(date +%s)

# This launches Verdi
waves_verdi:
	$(VERDI_HOME)/bin/verdi -dbdir ./simv.daidir -ssf novas.fsdb -nologo -cov -covdir simv.vdb  &

#waves_verdi:
#	$(VERDI_HOME)/bin/verdi -dbdir ./simv.daidir -ssf novas.fsdb -nologo &

clean:
	\rm -rf *.log *.h  csrc DVEFiles simv.daidir simv ucli.key vcdplus.svpd *.syn *.pvl *.mr *.svf command.log *.txt novas.conf  novas.rc  verdi_config_file  verdiLog novas.fsdb novas.log novas_dump.log

