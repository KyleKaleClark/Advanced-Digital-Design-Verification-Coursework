
all: sim clean

# This compiles with VCS and runs simulation
comp_and_sim_mult:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPMult.sv ../fp/FPMult_ExecuteModule.sv ../fp/FPMult_NormalizeModule.sv ../fp/FPMult_PrepModule.sv ../fp/FPMult_RoundModule.sv ../fp/FPMult_tb.sv -debug_access+all |& tee compile_and_sim.log

#This compiles with VCS and runs simulation
comp_and_sim_addsub:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPAddSub.sv ../fp/FPAddSub_AlignModule.sv ../fp/FPAddSub_AlignShift1.sv ../fp/FPAddSub_AlignShift2.sv ../fp/FPAddSub_ExceptionModule.sv ../fp/FPAddSub_ExecutionModule.sv ../fp/FPAddSub_NormalizeModule.sv ../fp/FPAddSub_NormalizeShift1.sv ../fp/FPAddSub_NormalizeShift2.sv ../fp/FPAddSub_PrealignModule.sv ../fp/FPAddSub_RoundModule.sv ../fp/FPAddSub_tb.sv -debug_access+all |& tee compile_and_sim.log

comp_and_sim_matmul:
		${VCS_HOME}/bin/vcs -R -full64 -sverilog ../matmul.sv ../matmul_with_ram.sv ../matmul_with_ram_tb.sv ../fp/FP*.sv -debug_access+all |& tee compile_and_sim.log

# This compiles with VCS
compile_apb:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../matmul_with_ram.sv ../matmul.sv  -debug_access+all |& tee compile_top.log


# This compiles with VCS and also generates the database for Verdi
compile_verdi_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../fp/FPMult.sv ../fp/FPMult_ExecuteModule.sv ../fp/FPMult_NormalizeModule.sv ../fp/FPMult_PrepModule.sv ../fp/FPMult_RoundModule.sv ../fp/FPMult_tb.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log
compile_verdi_addsub:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPAddSub.sv ../fp/FPAddSub_AlignModule.sv ../fp/FPAddSub_AlignShift1.sv ../fp/FPAddSub_AlignShift2.sv ../fp/FPAddSub_ExceptionModule.sv ../fp/FPAddSub_ExecutionModule.sv ../fp/FPAddSub_NormalizeModule.sv ../fp/FPAddSub_NormalizeShift1.sv ../fp/FPAddSub_NormalizeShift2.sv ../fp/FPAddSub_PrealignModule.sv ../fp/FPAddSub_RoundModule.sv ../fp/FPAddSub_tb.sv -debug_access+all -kdb -lca |& tee compile_verdi.log

compile_verdi_matmul:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../matmul.sv ../matmul_with_ram.sv ../matmul_with_ram_tb.sv ../fp/FP*.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log
#	${VCS_HOME}/bin/vcs -full64 -sverilog  ../matmul.sv ../matmul_with_ram.sv ../fp/FP*.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log

#This compiles UVM as well, but we are not using it for now
compile_uvm:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../mips_tb.sv ../top.sv ../controller.sv ../datapath.sv -debug_access+all -ntb_opts uvm |& tee compile_uvm.log


# This runs simulation
sim:
	./simv

# This launches Verdi
waves_verdi:
	$(VERDI_HOME)/bin/verdi -dbdir ./simv.daidir -ssf novas.fsdb -nologo &

clean:
	\rm -rf *.log *.h  csrc DVEFiles simv.daidir simv ucli.key vcdplus.svpd *.syn *.pvl *.mr *.svf command.log *.txt novas.conf  novas.rc  verdi_config_file  verdiLog novas.fsdb novas.log novas_dump.log

