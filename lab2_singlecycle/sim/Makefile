
all: sim clean

# This compiles with VCS and runs simulation
comp_and_sim_mips:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../top.v ../mips_tb.v -debug_access+all |& tee compile_and_sim.log

comp_and_sim_top:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../even_odd_tb.v ../even_odd.v -debug_access+all |& tee compile_and_sim.log

# This compiles with VCS
compile_mips:
	${VCS_HOME}/bin/vcs -full64 -sverilog ../top.v ../mips_tb.v -debug_access+all |& tee compile.log

compile_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog ../even_odd_tb.v ../even_odd.v ../top.v -debug_access+all |& tee compile_top.log



# This compiles with VCS and also generates the database for Verdi
compile_verdi_mips:
	${VCS_HOME}/bin/vcs -full64 -sverilog ../top.v ../mips_tb.v -debug_access+all -kdb -lca  |& tee compile_verdi.log

compile_verdi_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog ../even_odd_tb.v ../even_odd.v ../top.v -debug_access+all -kdb -lca  |& tee compile_verdi.log

#This compiles UVM as well, but we are not using it for now
compile_uvm:
	${VCS_HOME}/bin/vcs -full64 -sverilog ../top.v ../mips_tb.v -debug_access+all -ntb_opts uvm |& tee compile_uvm.log


# This runs simulation
sim:
	./simv

# This launches Verdi
waves_verdi:
	$(VERDI_HOME)/bin/verdi -dbdir ./simv.daidir -ssf novas.fsdb -nologo

clean:
	\rm -rf *.log *.h  csrc DVEFiles simv.daidir simv ucli.key vcdplus.vpd *.syn *.pvl *.mr *.vf command.log *.txt novas.conf  novas.rc  verdi_config_file  verdiLog novas.fsdb novas.log novas_dump.log

