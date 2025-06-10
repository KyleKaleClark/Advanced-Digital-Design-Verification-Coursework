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
    output logic zeroM,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic [31:0] aluoutM, writedataM,
    input logic[31:0] readdata
);

//IF to ID pipeline logic
logic [31:0] pcplus4D, instrD;
logic stallF, stallD;
//ID to EX pipeline logic
logic [31:0] instrE, pcplus4E, signimmE, srcaE, srcbE, writedataE;
logic regwriteE, memtoregE, memwriteE, branchE, alusrcE, regdstE;
logic [2:0] alucontrolE;
logic [4:0] rtE, rdE, rsE, writeregE;
logic flushE;
//EX to MEM pipeline logic
logic [31:0] instrM, pcbranchM;
logic regwriteM, memtoregM, memwriteM, branchM;
logic [4:0] writeregM;
//MEM to WB pipeline logic
logic [31:0] instrW, aluoutW, readdataW;
logic regwriteW, memtoregW;
logic [4:0] writeregW;


//Hazard unit for stalling only on lw instructions. ID_EX register will have
//all input control signals to zero for stall
logic[1:0] forwardAE, forwardBE;


hazardunit hazardunit(memtoregE, instrD[25:21], instrD[20:16], regwriteM, regwriteW, rsE, rtE, writeregM, writeregW, 
			forwardAE, forwardBE, stallF, stallD, flushE);

//Instruction Fetch Combinational Logic:
logic [31:0] pcnextbr, pcplus4, pcnext;

adder pcadd1 (pc, 32'b100, pcplus4);

mux2_dontcare #(32) pcbrmux(pcplus4, pcbranchM, pcsrc, pcnextbr);
mux2_dontcare #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

flopr #(32) pcreg(stallF, clk, reset, pcnext, pc);

//Instruction Fetch to Instruction Decode Pipeline Registers


IF_ID IF_ID (stallD, clk, reset, instr, pcplus4, instrD, pcplus4D);

//Instruction Decode Combinational Logic

logic [31:0] srca, signimmD,result, writedata;

logicfile rf(clk, regwriteW, instrD[25:21], instrD[20:16], writeregW, result, srca, writedata);
signext se(instrD[15:0], signimmD);

//Instruction Decode to Execute Pipeline Registers

ID_EX ID_EX (flushE, clk, reset, branch, regwrite, memtoreg, memwrite, alusrc, regdst, instrD, pcplus4D, srca, writedata, signimmD, instrD[20:16], instrD[15:11], instrD[25:21], alucontrol,
	regwriteE, memwriteE, memtoregE, branchE, alusrcE, regdstE, instrE, srcaE, writedataE, signimmE,
	pcplus4E, rtE, rdE, rsE, alucontrolE);

//Execute Combinational Logic

logic [31:0] signimmsh, pcbranch, srcb, aluout;
logic zero;

mux2 #(32) srcbmux(writedataE, signimmE, alusrcE, srcbE);

mux2 #(5) wrmux(rtE, rdE, regdstE, writeregE);

alu alu(srcaE, srcbE, alucontrolE, aluout, zero);

sl2 immsh(signimmE, signimmsh);
adder pcadd2(pcplus4E, signimmsh, pcbranch);



//Execute to Memory Pipeline Registers

EX_MEM EX_MEM (clk, reset, regwriteE, memtoregE, memwriteE, branchE, zero, instrE, writedataE, aluout, pcbranch, writeregE,
	regwriteM, memtoregM, memwriteM, branchM, zeroM, aluoutM, writedataM, pcbranchM,
	instrM, writeregM);


//Memory Combinational Logic


//Memory to Memory Writeback Pipeline Registers

MEM_WB MEM_WB (clk, reset, regwriteM, memtoregM, instrM, aluoutM, readdata, writeregM, regwriteW, memtoregW, instrW,
	aluoutW, readdataW, writeregW);


//Memory Writeback Combinational Logic



mux2 #(32) resmux(aluoutW, readdataW, memtoregW, result);



endmodule






//Instruction fetch to instruction decode register module

module IF_ID (
	input logic stallD,
	input logic clk, reset, 
	input logic [31:0] instr, pcplus4,
	output logic [31:0] instrD, pcplus4D
	);

always_ff @ (posedge clk or posedge reset)

	case(reset)

		1 : 
		begin
			instrD <= 0;
			pcplus4D <= 0;
		end

		0 :
		begin
			case(stallD)

				1'bx :
				begin
					instrD <= instr;
					pcplus4D <= pcplus4;
				end
				1'b0 :
				begin
					instrD <= instr;
					pcplus4D <= pcplus4;
				end
			endcase
		end
	endcase

	

endmodule

//Instruction decode to execution register module

module ID_EX (

	input logic flushE, clk, reset, branch, regwrite, memtoreg, memwrite, alusrc, regdst,
	input logic [31:0] instrD, pcplus4D, srca, writedata, signimm,
	input logic [4:0] rt, rd, rsD,
	input logic [2:0] alucontrol,
	output logic regwriteE, memwriteE, memtoregE, branchE, alusrcE, regdstE,
	output logic [31:0] instrE, srcaE, writedataE, signimmE, pcplus4E,
	output logic [4:0] rtE, rdE, rsE,
	output logic [2:0] alucontrolE
);

always_ff @ (posedge clk or posedge reset)
	
	if (reset || flushE == 1'b1) begin

		regwriteE <= 0;
		memwriteE <= 0;
		branchE <= 0;
		alusrcE <= 0;
		regdstE <=0;
		memtoregE <=0;
		instrE <= 0;
		srcaE <= 0;
		writedataE <= 0;
		signimmE <= 0;
		pcplus4E <= 0;
		rtE <= 0;
		rdE <= 0;
		rsE <= 0;
		alucontrolE <= 0;
	end

	else begin
		
		regwriteE <= regwrite;
		memwriteE <= memwrite;
		branchE <= branch;
		alusrcE <= alusrc;
		regdstE <= regdst;
		memtoregE <= memtoreg;
		instrE <= instrD;
		srcaE <= srca;
		writedataE <= writedata;
		signimmE <= signimm;
		pcplus4E <= pcplus4D;
		rtE <= rt;
		rdE <= rd;
		rsE <= rsD;
		alucontrolE <= alucontrol;
		
	end

endmodule

//Execution to memory register module

module EX_MEM (
	input logic clk, reset, regwriteE, memtoregE, memwriteE, branchE, zero, 
	input logic [31:0] instrE, writedataE, aluout, pcbranchE,
	input logic [4:0] writereg,
	output logic regwriteM, memtoregM, memwriteM, branchM, zeroM,
	output logic [31:0] aluoutM, writedataM, pcbranchM, instrM,
	output logic [4:0] writeregM);

always_ff @ (posedge clk or posedge reset)

	if (reset) begin
		
		regwriteM <= 0;
		memtoregM <= 0;
		memwriteM <= 0;
		branchM <= 0;
		zeroM <= 0;
		aluoutM <= 0;
		writedataM <= 0;
		pcbranchM <= 0;
		writeregM <= 0;
		instrM <= 0;

	end

	else begin

		regwriteM <= regwriteE;
		memtoregM <= memtoregE;
		memwriteM <= memwriteE;
		branchM <= branchE;
		zeroM <= zero;
		aluoutM <= aluout;
		writedataM <= writedataE;
		pcbranchM <= pcbranchE;
		writeregM <= writereg;
		instrM <= instrE;
	end

endmodule

//Memory to writeback register module

module MEM_WB (
	input logic clk, reset, regwriteM, memtoregM,
	input logic[31:0] instrM, aluoutM, readdata,
	input logic[4:0] writeregM,
	output logic regwriteW, memtoregW,
	output logic [31:0] instrW, aluoutW, readdataW,
	output logic [4:0] writeregW);

always_ff @ (posedge clk or posedge reset)
	if (reset) begin 
		regwriteW <= 0;
		memtoregW <= 0;
		instrW <= 0;
		aluoutW <= 0;
		readdataW <= 0;
		writeregW <= 0;
	
	end

	else begin
		regwriteW <= regwriteM;
		memtoregW <= memtoregM;
		instrW <= instrM;
		aluoutW <= aluoutM;
		readdataW <= readdata;
		writeregW <= writeregM;
	end

endmodule

module hazardunit(input memtoregE,
						input logic [4:0] rsD, rtD,
						input logic regwriteM, regwriteW,
						input logic [4:0] rsE, rtE, 
						input logic [4:0] writeregM, writeregW,
						output logic [1:0] forwardAE, forwardBE,
						output logic stallF, stallD, flushE);
		logic lwstall;
		
		
		
		always_comb
		begin
			//This is for stalling when data hazard occurs
		
			lwstall = ((rsD==rtE)||(rtD==rtE))&&memtoregE;
			stallF = lwstall;
			stallD = lwstall;
			flushE = lwstall;
		
		end
		
		always_ff @(lwstall)
		begin
				case(lwstall)
					1'b1: $display("lwstall=%b", lwstall);
				endcase
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
    input logic stallF,clk, reset,
    input [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);
    always @ (posedge clk, posedge reset)
        if (reset) q <= 0;
        else
	begin
		case (stallF)
		1'b0 :	q <= d;
		1'bx : q <= d;
		endcase
	end
endmodule
