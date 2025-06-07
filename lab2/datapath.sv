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
    input logic clk, reset,
    input logic memtoreg, pcsrc,
    input logic alusrc, logicdst,
    input logic logicwrite, jump,
    input logic [2:0] alucontrol,
    output logic zero,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic [31:0] aluout, writedata,
    input logic[31:0] readdata
);

logic [31:0] if_pc4_out, if_instruction_out, memwb_result, id_instruction_out, id_pc4_out, id_signimm_out, id_srca_out;
logic [31:0] ex_signimmsh, ex_pcbranch, ex_srcb, ex_writereg, mem_aluout;

InstrFet IF (clk, reset, pcsrc, jump, instr, ex_pcbranch, if_pc4_out, if_instruction_out, pc);
InstrDec ID (clk, reset, logicwrite, if_pc4_out, if_instruction_out, memwb_result, id_instruction_out, id_pc4_out, id_signimm_out, id_srca_out, writedata);
Exec EX (clk, reset, alusrc, logicdst, alucontrol, id_instruction_out, id_pc4_out, id_signimm_out, id_srca_out, writedata, ex_signimmsh, aluout, ex_pcbranch, ex_srcb, ex_writereg, zero);
mem MEM (clk, reset, aluout, mem_aluout);
memwb WB (memtoreg, mem_aluout, readdata, memwb_result);

endmodule

//Instruction Fetch Combinational Logic
module InstrFet (
	input logic clk, reset, pcsrc, jump,
	input logic [31:0] instr, ex_pcbranch,
	output logic [31:0] if_pc4_out, if_instruction_out, pc);

logic [31:0] pcnextbr, pcplus4,pcnext;

mux2 #(32) pcbrmux(pcplus4, ex_pcbranch, pcsrc, pcnextbr);
mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
flopr #(32) pcreg(clk, reset, pcnext, pc);
adder pcadd1 (pc, 32'b100, pcplus4);

//Instruction Fetch to Instruction Decode Pipeline Registers

always_ff @ (posedge clk or posedge reset)

	if (reset) begin 
		if_instruction_out <= 0;
		if_pc4_out <= 0;
	end

	else begin
		if_instruction_out <= instr;
		if_pc4_out <= pcplus4;
	end

endmodule
//Instruction Decode Combinational Logic
module InstrDec (
	input logic clk, reset, logicwrite,
	input logic [31:0] if_pc4_out, if_instruction_out, result,
	output logic [31:0] id_instruction_out, id_pc4_out, id_signimm_out, id_srca_out, id_writedata_out);

logic [4:0] writereg;
logic [31:0] srca, signimm, writedata;

logicfile rf(clk, logicwrite, if_instruction_out[25:21], if_instruction_out[20:16], writereg, result, srca, writedata);
signext se(if_instruction_out[15:0], signimm);

//Instruction Decode to Execute Pipeline Registers
always_ff @ (posedge clk or posedge reset)
	
	if (reset) begin

		id_instruction_out <= 0;
		id_pc4_out <= 0;
		id_signimm_out <= 0;
		id_srca_out <= 0;
		id_writedata_out <= 0;
	end

	else begin

		id_instruction_out <= if_instruction_out;
		id_pc4_out <= if_pc4_out;
		id_signimm_out <= signimm;
		id_srca_out <= srca;
		id_writedata_out <= writedata;
	end

endmodule

//Execute Combinational Logic

module Exec (
	input logic clk, reset, alusrc, logicdst,
	input logic [2:0] alucontrol,
	input logic [31:0] id_instruction_out, id_pc4_out, id_signimm_out, id_srca_out, id_writedata_out,
	output logic [31:0] ex_signimmsh, ex_aluout, ex_pcbranch, ex_srcb, ex_writereg,
	output logic ex_zero);

logic [31:0] signimmsh, pcbranch, srcb, aluout;
logic [4:0] writereg;
logic zero;

mux2 #(32) srcbmux(id_writedata_out, id_signimm_out, alusrc, srcb);
mux2 #(5) wrmux(id_instruction_out[20:16], id_instruction_out[15:11], logicdst, writereg);
alu alu(id_srca_out, srcb, alucontrol, aluout, zero);
sl2 immsh(id_signimm_out, signimmsh);
adder pcadd2(id_pc4_out, signimmsh, pcbranch);

//Execute to Memory Pipeline Registers

always_ff @ (posedge clk or posedge reset)

	if (reset) begin
		ex_signimmsh <= 0;
		ex_aluout <= 0;
		ex_pcbranch <= 0;
		ex_srcb <= 0;
		ex_writereg <= 0;
	end

	else begin
		ex_signimmsh <= signimmsh;
		ex_aluout <= aluout;
		ex_pcbranch <= pcbranch;
		ex_srcb <= srcb;
		ex_writereg <= writereg;
	end

endmodule

//Memory Combinational Logic

module mem (
	input logic clk, reset,
	input logic [31:0] ex_aluout,
	output logic [31:0] mem_aluout);

//Memory to Memory Writeback Pipeline Register

always_ff @ (posedge clk or posedge reset)
	if (reset) 
		mem_aluout <= 0;
	else
		mem_aluout <= ex_aluout;
endmodule

//Memory Writeback Combinational Logic

module memwb (
	input logic memtoreg,
	input logic [31:0] mem_aluout, readdata,
	output logic [31:0] memwb_result);


mux2 #(32) resmux(mem_aluout, readdata, memtoreg, memwb_result);

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
