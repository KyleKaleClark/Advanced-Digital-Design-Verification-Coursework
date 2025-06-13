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
//////////////////////////////////////////////////////////////////////
module datapath (
    input clk, reset,
    input memtoreg, pcsrc,
    input alusrc, regdst,
    input regwrite, jump,
    input [2:0] alucontrol,
    output zero,
    output [31:0] pc,
    input [31:0] instr,
    output [31:0] aluout, writedata,
    input [31:0] readdata,
    input branch, memwrite		 
);

    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [31:0] signimm, signimmsh;
    logic [31:0] srca, srcb;
    logic [31:0] result;


   
//   logic 	 branch, memwrite;
   logic 	 memwrite;
   

//fetch signals
   //data signals
   logic [31:0]  IF_pc4, IF_instr;
   assign IF_instr = instr;
   assign IF_pc4 = pcplus4;
   
   //control signals

//decode signals
   //data signals
   logic [31:0]  ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4;
   logic [4:0] 	 ID_rte, ID_rde;
   assign ID_rte = ID_instr[20:16];
   assign ID_rde = ID_instr[15:11];
   
   //control signals
   logic 	 ID_memwrite, ID_memtoreg, ID_regwrite, ID_branch, ID_alucontrol, ID_alusrc, ID_regdst;

   assign ID_memwrite = memwrite;
   assign ID_memtoreg = memtoreg;
   assign ID_regwrite = regwrite;
   assign ID_branch = branch;
   assign ID_alucontrol = alucontrol;
   assign ID_alusrc = alusrc;
   assign ID_regdst = regdst;
   
   
//execute signals
   //data signals
   logic [31:0]  EX_instr, EX_srca, EX_srcb_premux, EX_srcb, EX_pc4, EX_signimm, EX_signimmsh, EX_pcbranch, EX_aluout, EX_writedata;
   logic [4:0] 	 EX_rte, EX_rde, EX_writereg;
   logic 	 EX_zero;
   
   //control signals
   logic 	 EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch, EX_alucontrol, EX_alusrc, EX_regdst;


   
//memory signals
   //data signals
   logic [31:0]  MEM_instr, MEM_aluout, MEM_writedata, MEM_pcbranch, MEM_readdata;
   logic [4:0] 	 MEM_writereg;
   logic MEM_zero;
   

   //control signals
   logic 	 MEM_memwrite, MEM_memtoreg, MEM_regwrite, MEM_branch, MEM_pcsrc;

  
   
//wb signals
   //data signals
   logic [31:0]  WB_instr, WB_aluout, WB_readdata, WB_result;
   logic [4:0] 	 WB_writereg;

   //control signals
   logic 	 WB_memwrite, WB_memtoreg;
   

   
   IF_ID ifid(clk, reset, IF_instr, IF_pc4, ID_instr, ID_pc4);
   ID_EX idex(clk, reset, ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4, ID_rte, ID_rde, ID_memwrite, ID_memtoreg, ID_regwrite,
	      ID_branch, ID_alucontrol, ID_alusrc, ID_regdst, EX_instr, EX_srca, EX_srcb_premux, EX_signimm, EX_pc4, EX_rte, EX_rde,
	      EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch, EX_alucontrol, EX_alusrc, EX_regdst);
   EX_MEM exmem(clk, reset, EX_instr, EX_aluout, EX_writedata, EX_pcbranch, EX_writereg, EX_zero, EX_memwrite, EX_memtoreg, EX_regwrite,
		EX_branch, MEM_instr, MEM_aluout, MEM_writedata, MEM_pcbranch, MEM_writereg, MEM_zero, MEM_memwrite, MEM_memtoreg,
		MEM_regwrite, MEM_branch);
   MEM_WB memwb(clk, reset, MEM_instr, MEM_aluout, MEM_readdata, MEM_writereg, MEM_memwrite, MEM_memtoreg, WB_instr, WB_aluout, 
		WB_readdata, WB_writereg, WB_memwrite, WB_memtoreg);
   






   

   logic [31:0]  cnt;    //count, either the PC counter or Cycle counter
   logic [31:0]  wb_dat; //used to take destination registers current value and feed into ALU
    //performance monitor
    perfmon pf(clk, reset, instr[25], pc, cnt); //use nonopcode MSB  as the flag for it, and count it as an ALUop
   
    // next PC logic
    flopr #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1 (pc, 32'b100, pcplus4);
    sl2 immsh(signimm, signimmsh);
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

    // logicister file logic
                                     //rs            //rt      //rd add rd dat                  //muladd
    logicfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata, wb_dat);
    mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
    mux2 #(32) resmux(aluout, readdata, memtoreg, result);
    signext se(instr[15:0], signimm);
    
    // ALU logic
    mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
                                                  //pf //muladd
    alu alu(srca, srcb, alucontrol, aluout, zero, cnt, wb_dat);
endmodule


//////////////////////////////////////////////////////////////////////
// logicister File Module
//////////////////////////////////////////////////////////////////////
module logicfile (
    input clk,
    input we3,
    input [4:0] ra1, ra2, wa3,
    input [31:0] wd3,
    output [31:0] rd1, rd2,
    output [31:0] wd3_out //muladd
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
    assign wd3_out = rf[wa3]; //muladd
endmodule

//////////////////////////////////////////////////////////////////////
// ALU Module
////////////////////////////////////////////////////////////////////// 
module alu(
    input [31:0] 	a, // First operand
    input [31:0] 	b, // Second operand
    input [2:0] 	control, // ALU control signal
    output logic [31:0] result, // ALU result
    output 		zero, // Zero flag
    input [31:0] 	cnt, //performance monitor count
    input [31:0]        wb_result //takes the results value and brings it back in 	
);

    // Define ALU operations based on control signal
    localparam ALU_AND = 3'b000; 
    localparam ALU_OR  = 3'b001; 
    localparam ALU_ADD = 3'b010; 
    localparam ALU_PERF= 3'b011;
    localparam ALU_MADD= 3'b100;
    localparam ALU_SUB = 3'b110; 
    localparam ALU_SLT = 3'b111; 
    
    // Calculate result based on control input
    always @(*) begin
        case(control)
            ALU_AND: result = a & b;                     // AND
            ALU_OR:  result = a | b;                     // OR
            ALU_ADD: result = a + b;                     // ADD
            ALU_SUB: result = a - b;                     // SUB
            ALU_SLT: result = ($signed(a) < $signed(b)); // Set Less Than (signed)
	    ALU_PERF:result = cnt;                       // Return Performance Count
	    ALU_MADD:result = (a*b)+wb_result;           // MULADD result = a*b+result
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


//permon module
module perfmon(
   input clk, reset, cyc0_instr1,
   input [31:0] pc,
   output logic [31:0] cnt
);
   logic [31:0]  pc_cnt, cyc_cnt;
   logic [31:0]  last_pc; 
   always_ff @(posedge clk or posedge reset) begin
      if (reset) begin
	 last_pc <= '0;
	 pc_cnt <= '0;
	 cyc_cnt <= '0;
      end
      else begin
	 cyc_cnt <= cyc_cnt + 1;  //inc cycle cnt every clk posedge
	 if (pc != last_pc) begin //check make sure not double counting same PC
	    pc_cnt <= pc_cnt + 1; //inc PC
	 end
	 last_pc <= pc; //update last pc
      end
   end

   //swap output btwn counters
   always_comb begin
      if (~cyc0_instr1)
	cnt = cyc_cnt;
      else
	cnt = pc_cnt;
   end
   
endmodule // perfmon











//pipelines


module IF_ID(
     input clk, reset,
     input [31:0] IF_instr, IF_pc4,
     output logic [31:0] ID_instr, ID_pc4
     );
   
   always_ff @(posedge clk or posedge reset) begin
   if(reset) begin
      ID_instr <= '0;
      ID_pc4 <= '0;
   end
   else begin
      ID_instr <= IF_instr;
      ID_pc4 <= IF_pc4;
   end
   end
   
endmodule
 
  
module ID_EX(
     input 		 clk, reset,
     input [31:0] 	 ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4,
     input [4:0] 	 ID_rte, ID_rde,
     input 		 ID_memwrite, ID_memtoreg, ID_regwrite, ID_branch, ID_alucontrol, ID_alusrc, ID_regdst,
     output logic [31:0] EX_instr, EX_srca, EX_srcb_premux, EX_signimm, EX_pc4,
     output logic [4:0]  EX_rte, EX_rde,
     output logic 	 EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch, EX_alucontrol, EX_alusrc, EX_regdst
     );
   
   always_ff @(posedge clk or posedge reset) begin
   if(reset) begin
      EX_instr <= '0;
      EX_srca <= '0;
      EX_srcb_premux <= '0;
      EX_signimm <= '0;
      EX_pc4 <= '0;
      EX_rte <= '0;
      EX_rde <= '0;
      EX_memwrite <= '0;
      EX_memtoreg <= '0;
      EX_regwrite <= '0;
      EX_branch <= '0;
      EX_alucontrol <= '0;
      EX_alusrc <= '0;
      EX_regdst <= '0;
   end
   else begin
      EX_instr <= ID_instr;
      EX_srca <= ID_srca;
      EX_srcb_premux <= ID_srcb;
      EX_signimm <= ID_signimm;
      EX_pc4 <= ID_pc4;
      EX_rte <= ID_rte;
      EX_rde <= ID_rde;
      EX_memwrite <= ID_memwrite;
      EX_memtoreg <= ID_memtoreg;
      EX_regwrite <= ID_regwrite;
      EX_branch <= ID_branch;
      EX_alucontrol <= ID_alucontrol;
      EX_alusrc <= ID_alusrc;
      EX_regdst <= ID_regdst;      
   end // else: !if(reset)
   end

endmodule

module EX_MEM(
     input 		 clk, reset,
     input [31:0] 	 EX_instr, EX_aluout, EX_writedata, EX_pcbranch,
     input [4:0] 	 EX_writereg,
     input 		 EX_zero,
     input 		 EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch,
     output logic [31:0] MEM_instr, MEM_aluout, MEM_writedata, MEM_pcbranch,
     output logic [4:0]  MEM_writereg,
     output logic 	 MEM_zero,
     output logic 	 MEM_memwrite, MEM_memtoreg, MEM_regwrite, MEM_branch
     );
   
   always_ff @(posedge clk or posedge reset) begin
   if(reset) begin
      MEM_instr <= '0;
      MEM_aluout <= '0;
      MEM_writedata <= '0;
      MEM_pcbranch <= '0;
      MEM_writereg <= '0;
      MEM_zero <= '0;
      MEM_memwrite <= '0;
      MEM_memtoreg <= '0;
      MEM_regwrite <= '0;
      MEM_branch <= '0;
   end
   else begin
      MEM_instr <= EX_instr;
      MEM_aluout <= EX_aluout;
      MEM_writedata <= EX_writedata;
      MEM_pcbranch <= EX_pcbranch;
      MEM_writereg <= EX_writereg;
      MEM_zero <= EX_zero;
      MEM_memwrite <= EX_memwrite;
      MEM_memtoreg <= EX_memtoreg;
      MEM_regwrite <= EX_regwrite;
      MEM_branch <= EX_branch;
   end // else: !if(reset)
   end
      
endmodule

module MEM_WB(
     input 		 clk, reset,
     input [31:0] 	 MEM_instr, MEM_aluout, MEM_readdata,
     input [4:0] 	 MEM_writereg,
     input 		 MEM_memwrite, MEM_memtoreg,
     output logic [31:0] WB_instr, WB_aluout, WB_readdata,
     output logic [4:0]  WB_writereg,
     output logic 	 WB_memwrite, WB_memtoreg
     );
   
   always_ff @(posedge clk or posedge reset) begin
   if(reset) begin
      WB_instr <= '0;
      WB_aluout <= '0;
      WB_readdata <= '0;
      WB_writereg <= '0;
      WB_memwrite <= '0;
      WB_memtoreg <= '0;      
   end
   else begin
      WB_instr <= MEM_instr;
      WB_aluout <= MEM_aluout;
      WB_readdata <= MEM_readdata;
      WB_writereg <= MEM_writereg;
      WB_memwrite <= MEM_memwrite;
      WB_memtoreg <= MEM_memtoreg;            
   end // else: !if(reset)
   end
      
endmodule
