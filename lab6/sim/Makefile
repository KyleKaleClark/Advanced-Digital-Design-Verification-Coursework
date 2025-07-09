
all: sim clean

# This compiles with VCS and runs simulation
comp_and_sim_mult:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPMult.sv ../fp/FPMult_ExecuteModule.sv ../fp/FPMult_NormalizeModule.sv ../fp/FPMult_PrepModule.sv ../fp/FPMult_RoundModule.sv ../fp/FPMult_tb.sv -debug_access+all |& tee compile_and_sim.log

#This compiles with VCS and runs simulation
comp_and_sim_addsub:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPAddSub.sv ../fp/FPAddSub_AlignModule.sv ../fp/FPAddSub_AlignShift1.sv ../fp/FPAddSub_AlignShift2.sv ../fp/FPAddSub_ExceptionModule.sv ../fp/FPAddSub_ExecutionModule.sv ../fp/FPAddSub_NormalizeModule.sv ../fp/FPAddSub_NormalizeShift1.sv ../fp/FPAddSub_NormalizeShift2.sv ../fp/FPAddSub_PrealignModule.sv ../fp/FPAddSub_RoundModule.sv ../fp/FPAddSub_tb.sv -debug_access+all |& tee compile_and_sim.log


# This compiles with VCS
compile_apb:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../matmul_with_ram.sv ../matmul.sv  -debug_access+all |& tee compile_top.log


# This compiles with VCS and also generates the database for Verdi
compile_verdi_top:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../fp/FPMult.sv ../fp/FPMult_ExecuteModule.sv ../fp/FPMult_NormalizeModule.sv ../fp/FPMult_PrepModule.sv ../fp/FPMult_RoundModule.sv ../fp/FPMult_tb.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log
compile_verdi_addsub:
	${VCS_HOME}/bin/vcs -R -full64 -sverilog ../fp/FPAddSub.sv ../fp/FPAddSub_AlignModule.sv ../fp/FPAddSub_AlignShift1.sv ../fp/FPAddSub_AlignShift2.sv ../fp/FPAddSub_ExceptionModule.sv ../fp/FPAddSub_ExecutionModule.sv ../fp/FPAddSub_NormalizeModule.sv ../fp/FPAddSub_NormalizeShift1.sv ../fp/FPAddSub_NormalizeShift2.sv ../fp/FPAddSub_PrealignModule.sv ../fp/FPAddSub_RoundModule.sv ../fp/FPAddSub_tb.sv -debug_access+all -kdb -lca |& tee compile_verdi.log

#	${VCS_HOME}/bin/vcs -full64 -sverilog  ../matmul.sv ../matmul_with_ram.sv ../fp/FP*.sv -debug_access+all -kdb -lca  |& tee compile_verdi.log

#This compiles UVM as well, but we are not using it for now
compile_uvm:
	${VCS_HOME}/bin/vcs -full64 -sverilog  ../mips_tb.sv ../top.sv ../controller.sv ../datapath.sv -debug_access+all -ntb_opts uvm |& tee compile_uvm.log




VCS_FLAGS = -full64 -sverilog -debug_access+all -ntb_opts uvm

SV_FILES = ../fp/FP*.sv ../matmul.sv ../matmul_with_ram.sv ../matmul_with_mem_interface.sv

UVM_FILES = ../apb_vip/src/common/apb_if.sv ../apb_vip/src/common/apb_common_pkg.sv ../apb_vip/src/master/apb_master_pkg.sv ../apb_vip/src/slave/apb_slave_pkg.sv ../apb_vip/tb/apb_test.svh ../apb_vip/tb/apb_env.svh ../apb_vip/tb/testbench.sv

MEM_UVM_FILES = ../apb_vip/src/common/apb_if.sv ../apb_vip/src/common/apb_common_pkg.sv ../apb_vip/src/master/apb_master_pkg.sv ../apb_vip/src/slave/apb_slave_pkg.sv ../apb_vip/tb/apb_env.svh ../memory_pkg.svh ../memory_tb.sv

INC_DIRS = +incdir+../apb_vip/src/common +incdir+../apb_vip/src/master +incdir+../apb_vip/tb +incdir+../apb_vip/src/slave +incdir+../

#Just for this final APB UVM stuff
compile_verdi_matmul:
	${VCS_HOME}/bin/vcs ${INC_DIRS} ${VCS_FLAGS} ${SV_FILES} ${UVM_FILES} -kdb -lca -R +UVM_PHASE_TRACE +UVM_VERBOSITY=UVM_HIGH +UVM_OBJECTION_TRACE |& tee compile_verdi.log

compile_verdi_memory:
	${VCS_HOME}/bin/vcs ${INC_DIRS} ${VCS_FLAGS} ${SV_FILES} ${MEM_UVM_FILES} -kdb -lca -R +UVM_PHASE_TRACE +UVM_VERBOSITY=UVM_HIGH +UVM_OBJECTION_TRACE |& tee compile_verdi.log
# This runs simulation
sim:
	./simv

# This launches Verdi
waves_verdi:
	$(VERDI_HOME)/bin/verdi -dbdir ./simv.daidir -ssf novas.fsdb -nologo &

clean:
	\rm -rf *.log *.h  csrc DVEFiles simv.daidir simv ucli.key vcdplus.svpd *.syn *.pvl *.mr *.svf command.log *.txt novas.conf  novas.rc  verdi_config_file  verdiLog novas.fsdb novas.log novas_dump.log

