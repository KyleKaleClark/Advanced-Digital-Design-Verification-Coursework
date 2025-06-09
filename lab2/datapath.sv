//////////////////////////////////////////////////////////////////////
// ===================================================================
// This file has the following module implementations:
// 1. datapath
// 2. regfile
// 3. alu
// 4. adder
// 5. mux2
// 6. sl2
// 7. signext
// 8. flopr
// ===================================================================
//////////////////////////////////////////////////////////////////////
// Datapath module
//////////////////////////////////////////////////////////////////////
module datapath (
    input logic clk, reset, branch, memwrite,
    input logic memtoreg, pcsrc,
    input logic alusrc, regdst,
    input logic regwrite, jump,
    input logic [2:0] alucontrol,
    output logic ex_zero_out,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic [31:0] ex_aluout, ex_writedata_out,
    input logic[31:0] readdata
);

//IF to ID pipeline logic
logic [31:0] if_pc4_out, if_instruction_out;
//ID to EX pipeline logic
logic [31:0] id_pc4_out, id_instruction_out, id_srca_out, id_writedata_out, id_signimm_out;
logic id_regwrite_out, id_memtoreg_out, id_memwrite_out, id_branch_out, id_alusrc_out, id_regdst_out;
logic [2:0] id_alucontrol_out;
logic [4:0] id_rt_out, id_rd_out;
//EX to MEM pipeline logic
logic [31:0] ex_instruction_out, ex_pcbranch_out;
logic ex_regwrite_out, ex_memtoreg_out, ex_memwrite_out, ex_branch_out;
logic [4:0] ex_writereg_out;
//MEM to WB pipeline logic
logic [31:0] mem_instruction_out, mem_aluout, mem_readdata_out;
logic mem_regwrite_out, mem_memtoreg_out;
logic [4:0] mem_writereg_out;



//Instruction Fetch Combinational Logic

logic [31:0] pcnextbr, pcplus4, pcnext;

adder pcadd1 (pc, 32'b100, pcplus4);

mux2_dontcare #(32) pcbrmux(pcplus4, ex_pcbranch_out, pcsrc, pcnextbr);
mux2_dontcare #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

flopr #(32) pcreg(clk, reset, pcnext, pc);

//Instruction Fetch to Instruction Decode Pipeline Registers


IF_ID IF_ID (clk, reset, instr, pcplus4, if_instruction_out, if_pc4_out);

//Instruction Decode Combinational Logic

logic [31:0] srca, signimm, id_writedata, memwb_result, writedata;

logicfile rf(clk, mem_regwrite_out, if_instruction_out[25:21], if_instruction_out[20:16], mem_writereg_out, memwb_result, srca, writedata);
signext se(if_instruction_out[15:0], signimm);

//Instruction Decode to Execute Pipeline Registers

ID_EX ID_EX (clk, reset, branch, regwrite, memtoreg, memwrite, alusrc, regdst, if_instruction_out, if_pc4_out, srca, writedata, signimm, if_instruction_out[20:16], if_instruction_out[15:11], alucontrol,
	id_regwrite_out, id_memwrite_out, id_memtoreg_out, id_branch_out, id_alusrc_out, id_regdst_out, id_instruction_out, id_srca_out, id_writedata_out, id_signimm_out,
	id_pc4_out, id_rt_out, id_rd_out, id_alucontrol_out);

//Execute Combinational Logic

logic [31:0] signimmsh, pcbranch, srcb, aluout;
logic [4:0] writereg;
logic zero;

mux2 #(32) srcbmux(id_writedata_out, id_signimm_out, id_alusrc_out, srcb);

mux2 #(5) wrmux(id_instruction_out[20:16], id_instruction_out[15:11], regdst, writereg);

alu alu(id_srca_out, srcb, alucontrol, aluout, zero);

sl2 immsh(id_signimm_out, signimmsh);
adder pcadd2(id_pc4_out, signimmsh, pcbranch);

//Execute to Memory Pipeline Registers

EX_MEM EX_MEM (clk, reset, id_regwrite_out, id_memtoreg_out, id_memwrite_out, id_branch_out, zero, id_instruction_out, id_writedata_out, aluout, pcbranch, writereg,
	ex_regwrite_out, ex_memtoreg_out, ex_memwrite_out, ex_branch_out, ex_zero_out, ex_aluout, ex_writedata_out, ex_pcbranch_out,
	ex_instruction_out, ex_writereg_out);


//Memory Combinational Logic


//Memory to Memory Writeback Pipeline Registers

MEM_WB MEM_WB (clk, reset, ex_regwrite_out, ex_memtoreg_out, ex_instruction_out, ex_aluout, readdata, ex_writereg_out, mem_regwrite_out, mem_memtoreg_out, mem_instruction_out,
	mem_aluout, mem_readdata_out, mem_writereg_out);


//Memory Writeback Combinational Logic



mux2 #(32) resmux(mem_aluout, mem_readdata_out, mem_memtoreg_out, memwb_result);



endmodule






//Instruction fetch to instruction decode register module

module IF_ID (
	input logic clk, reset, 
	input logic [31:0] instruction, pcplus4,
	output logic [31:0] if_instruction_out, if_pc4_out
	);

always_ff @ (posedge clk or posedge reset)

	if (reset) begin 
		if_instruction_out <= 0;
		if_pc4_out <= 0;
	end

	else begin
		if_instruction_out <= instruction;
		if_pc4_out <= pcplus4;
	end

endmodule

//Instruction decode to execution register module

module ID_EX (

	input logic clk, reset, branch, regwrite, memtoreg, memwrite, alusrc, regdst,
	input logic [31:0] if_instruction_out, if_pc4_out, srca, writedata, sigimm,
	input logic [4:0] rt, rd,
	input logic [2:0] alucontrol,
	output logic id_regwrite_out, id_memwrite_out, id_memtoreg_out, id_branch_out, id_alusrc_out, id_regdst_out,
	output logic [31:0] id_instruction_out, id_srca_out, id_writedata_out, id_sigimm_out, id_pc4_out,
	output logic [4:0] id_rt_out, id_rd_out,
	output logic [2:0] id_alucontrol_out
);

always_ff @ (posedge clk or posedge reset)
	
	if (reset) begin

		id_regwrite_out <= 0;
		id_memwrite_out <= 0;
		id_branch_out <= 0;
		id_alusrc_out <= 0;
		id_regdst_out <=0;
		id_memtoreg_out <=0;
		id_instruction_out <= 0;
		id_srca_out <= 0;
		id_writedata_out <= 0;
		id_sigimm_out <= 0;
		id_pc4_out <= 0;
		id_rt_out <= 0;
		id_rd_out <= 0;
		id_alucontrol_out <= 0;
	end

	else begin
		
		id_regwrite_out <= regwrite;
		id_memwrite_out <= memwrite;
		id_branch_out <= branch;
		id_alusrc_out <= alusrc;
		id_regdst_out <= regdst;
		id_memtoreg_out <= memtoreg;
		id_instruction_out <= if_instruction_out;
		id_srca_out <= srca;
		id_writedata_out <= writedata;
		id_sigimm_out <= sigimm;
		id_pc4_out <= if_pc4_out;
		id_rt_out <= rt;
		id_rd_out <= rd;
		id_alucontrol_out <= alucontrol;
		
	end

endmodule

//Execution to memory register module

module EX_MEM (
	input logic clk, reset, id_regwrite_out, id_memtoreg_out, id_memwrite_out, id_branch_out, zero, 
	input logic [31:0] id_instruction_out, id_writedata_out, aluout, pcbranch,
	input logic [4:0] writereg,
	output logic ex_regwrite_out, ex_memtoreg_out, ex_memwrite_out, ex_branch_out, ex_zero_out,
	output logic [31:0] ex_aluout, ex_writedata_out, ex_pcbranch_out, ex_instruction_out,
	output logic [4:0] ex_writereg_out);

always_ff @ (posedge clk or posedge reset)

	if (reset) begin
		
		ex_regwrite_out <= 0;
		ex_memtoreg_out <= 0;
		ex_memwrite_out <= 0;
		ex_branch_out <= 0;
		ex_zero_out <= 0;
		ex_aluout <= 0;
		ex_writedata_out <= 0;
		ex_pcbranch_out <= 0;
		ex_writereg_out <= 0;
		ex_instruction_out <= 0;

	end

	else begin

		ex_regwrite_out <= id_regwrite_out;
		ex_memtoreg_out <= id_memtoreg_out;
		ex_memwrite_out <= id_memwrite_out;
		ex_branch_out <= id_branch_out;
		ex_zero_out <= zero;
		ex_aluout <= aluout;
		ex_writedata_out <= id_writedata_out;
		ex_pcbranch_out <= pcbranch;
		ex_writereg_out <= writereg;
		ex_instruction_out <= id_instruction_out;
	end

endmodule

//Memory to writeback register module

module MEM_WB (
	input logic clk, reset, ex_regwrite_out, ex_memtoreg_out,
	input logic[31:0] ex_instruction_out, ex_aluout, readdata,
	input logic[4:0] ex_writereg_out,
	output logic mem_regwrite_out, mem_memtoreg_out,
	output logic [31:0] mem_instruction_out, mem_aluout, mem_readdata_out,
	output logic [4:0] mem_writereg_out);

always_ff @ (posedge clk or posedge reset)
	if (reset) begin 
		mem_regwrite_out <= 0;
		mem_memtoreg_out <= 0;
		mem_instruction_out <= 0;
		mem_aluout <= 0;
		mem_readdata_out <= 0;
		mem_writereg_out <= 0;
	
	end

	else begin
		mem_regwrite_out <= ex_regwrite_out;
		mem_memtoreg_out <= ex_memtoreg_out;
		mem_instruction_out <= ex_instruction_out;
		mem_aluout <= ex_aluout;
		mem_readdata_out <= readdata;
		mem_writereg_out <= ex_writereg_out;
	end

endmodule

//////////////////////////////////////////////////////////////////////
// logicister File Module
//////////////////////////////////////////////////////////////////////
module logicfile (
    input clk,
    input we3,
    input [4:0] ra1, ra2, wa3,
    input [31:0] wd3,
    output [31:0] rd1, rd2
);
    
    logic [31:0] rf[31:0];
    // three ported logicister file
    // read two ports combinationally
    // write third port on rising edge of clock
    // logicister 0 hardwired to 0
    always @ (posedge clk)
        if (we3) rf[wa3] <= wd3;

    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

//////////////////////////////////////////////////////////////////////
// ALU Module
////////////////////////////////////////////////////////////////////// 
module alu(
    input [31:0] a,          // First operand
    input [31:0] b,          // Second operand
    input [2:0] control,     // ALU control signal
    output logic [31:0] result, // ALU result
    output zero              // Zero flag
);

    // Define ALU operations based on control signal
    localparam ALU_AND = 3'b000; //x00
    localparam ALU_OR  = 3'b001; //x01
    localparam ALU_ADD = 3'b010; //x02
    localparam ALU_SUB = 3'b110; //x03
    localparam ALU_SLT = 3'b111; //x04
    
    // Calculate result based on control input
    always @(*) begin
        case(control)
            ALU_AND: result = a & b;                     // AND
            ALU_OR:  result = a | b;                     // OR
            ALU_ADD: result = a + b;                     // ADD
            ALU_SUB: result = a - b;                     // SUB
            ALU_SLT: result = ($signed(a) < $signed(b)); // Set Less Than (signed)
            default: result = 32'bx;                     // Undefined operation
        endcase
    end
    
    // Set zero flag when result is 0
    assign zero = (result == 32'b0);
    
endmodule


//////////////////////////////////////////////////////////////////////
// Adder Module
//////////////////////////////////////////////////////////////////////
module adder (
    input [31:0] a, b,
    output [31:0] y
);
    assign y = a + b;
endmodule

//////////////////////////////////////////////////////////////////////
// 2-to-1 Multiplexer Module with dont care
//////////////////////////////////////////////////////////////////////
module mux2_dontcare # (parameter WIDTH = 8) (
	input logic[WIDTH-1:0] d0, d1,
	input logic s,
	output logic[WIDTH-1:0] y);

  always_ff @(*)

  begin

	case(s)
		1'b0 : y<=d0;
		1'bx : y<=d0;
		1'b1 : y<=d1;

	endcase
  end

endmodule

//////////////////////////////////////////////////////////////////////
// 3-to-1 Multiplexer Module with dont care
//////////////////////////////////////////////////////////////////////
module mux3_dontcare # (parameter WIDTH = 8) (
    input logic[WIDTH-1:0] d0, d1, d2,
    input logic [1:0] s,
    output logic [WIDTH-1:0] y
);
  always_ff @(*)

  begin
	case(s)
		2'bxx : y<=d0;
		2'b00 : y<=d0;
		2'b01 : y<=d1;
		2'b10 : y<=d2; 
	endcase
  end

endmodule

//////////////////////////////////////////////////////////////////////
// 2-to-1 Multiplexer Module
//////////////////////////////////////////////////////////////////////
module mux2 # (parameter WIDTH = 8) (
    input [WIDTH-1:0] d0, d1,
    input s,
    output [WIDTH-1:0] y
);
    assign y = s ? d1 : d0;
endmodule


//////////////////////////////////////////////////////////////////////
// Shift Left by 2 Module
//////////////////////////////////////////////////////////////////////
module sl2 (
    input [31:0] a,
    output [31:0] y
);
    // shift left by 2
    assign y = {a[29:0], 2'b00};
endmodule


//////////////////////////////////////////////////////////////////////
// Sign Extension Module
//////////////////////////////////////////////////////////////////////
module signext (
    input [15:0] a,
    output [31:0] y
);
    assign y = {{16{a[15]}}, a};
endmodule


//////////////////////////////////////////////////////////////////////
// Flop logicister Module
//////////////////////////////////////////////////////////////////////
module flopr # (parameter WIDTH = 8)(
    input clk, reset,
    input [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);
    always @ (posedge clk, posedge reset)
        if (reset) q <= 0;
        else q <= d;
endmodule
