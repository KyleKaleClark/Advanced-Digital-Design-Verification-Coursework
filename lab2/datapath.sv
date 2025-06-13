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
    output [31:0] MEM_aluout, MEM_writedata,
    input [31:0] readdata,
    input branch, memwrite,
    output MEM_memwrite,
    output [31:0] ID_instr,
    input prejump
);

    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [31:0] signimm, signimmsh;
    logic [31:0] srca, srcb;
    logic [31:0] result;

   logic [31:0]  cnt;    //count, either the PC counter or Cycle counter
   logic [31:0]  wb_dat; //used to take destination registers current value and feed into ALU

   
//fetch signals
   //data signals
   logic [31:0]  IF_pc4, IF_instr;
//   assign IF_instr = instr;
   assign IF_pc4 = pcplus4;
   assign IF_instr = instr;


 
//decode signals
   //data signals
   logic [31:0]  ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4;
   logic [4:0] 	 ID_rte, ID_rde;
   logic [2:0] 	 ID_alucontrol;
   
   assign ID_rte = ID_instr[20:16];
   assign ID_rde = ID_instr[15:11];
   
   //control signals
   logic 	 ID_memwrite, ID_memtoreg, ID_regwrite, ID_branch, ID_alusrc, ID_regdst;

   //for clarity sake
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
//   assign EX_writedata = EX_srcb_premux;
   
   logic [4:0] 	 EX_rte, EX_rde, EX_rse, EX_writereg;
   logic 	 EX_zero;
   
   //control signals
   logic 	 EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch,  EX_alusrc, EX_regdst;
   logic [2:0] 	 EX_alucontrol;
   

   
//memory signals
   //data signals
   logic [31:0]  MEM_instr, MEM_aluout, MEM_writedata, MEM_pcbranch, MEM_readdata;
   logic [4:0] 	 MEM_writereg;
   logic MEM_zero;
   assign MEM_readdata = readdata;  //for clarity sake
   

   //control signals
   logic 	 MEM_memwrite, MEM_memtoreg, MEM_regwrite, MEM_branch, MEM_pcsrc;
   
//wb signals
   //data signals
   logic [31:0]  WB_instr, WB_aluout, WB_readdata, WB_result;
   logic [4:0] 	 WB_writereg;

   //control signals
   logic 	 WB_regwrite, WB_memtoreg;
   

//   MULADD
   logic [31:0]  EX_wb_dat, MEM_wb_dat;
   

//Pipeline flipflops
   
   IF_ID ifid(ID_stall, clk, reset, IF_instr, IF_pc4, ID_instr, ID_pc4);


   ID_EX idex(EX_flush, ID_instr[25:21], clk, reset, ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4, ID_rte, ID_rde, ID_memwrite, ID_memtoreg, ID_regwrite, ID_branch, ID_alusrc,
	      ID_regdst, ID_alucontrol, EX_instr, EX_srca, EX_srcb_premux, EX_signimm, EX_pc4, EX_rte, EX_rde, EX_rse, EX_memwrite, EX_memtoreg, EX_regwrite,
	      EX_branch, EX_alusrc, EX_regdst, EX_alucontrol, wb_dat, EX_wb_dat);
      
   EX_MEM exmem(clk, reset, EX_instr, EX_aluout, EX_writedata, EX_pcbranch, EX_writereg, EX_zero, EX_memwrite, EX_memtoreg, EX_regwrite,
		EX_branch, MEM_instr, MEM_aluout, MEM_writedata, MEM_pcbranch, MEM_writereg, MEM_zero, MEM_memwrite, MEM_memtoreg,
		MEM_regwrite, MEM_branch, EX_wb_dat, MEM_wb_dat);
   
   MEM_WB memwb(clk, reset, MEM_instr, MEM_aluout, MEM_readdata, MEM_writereg, MEM_regwrite, MEM_memtoreg, WB_instr, WB_aluout, 
		WB_readdata, WB_writereg, WB_regwrite, WB_memtoreg);
   

   //Hazard Handling
   logic [1:0] 	 EX_forwardA, EX_forwardB;
   logic 	 IF_stall, ID_stall, EX_flush;
   
   hazardunit hz(EX_memtoreg, ID_instr[25:21], ID_instr[20:16], MEM_regwrite, WB_regwrite, EX_instr[25:21], EX_instr[20:16], MEM_writereg, WB_writereg, EX_forwardA, EX_forwardB, IF_stall, ID_stall, EX_flush);
   
   

    //performance monitor
    perfmon pf(clk, reset, instr[25], pc, cnt); //use nonopcode MSB as the flag for it, and count it as an ALUop


    // next PC logic
    flopr #(32) pcreg(IF_stall, clk, reset, pcnext, pc); //this is fine its preflops stuff anyways
    adder pcadd1 (pc, 32'b100, pcplus4); //good this gets flip flopped
    sl2 immsh(EX_signimm, EX_signimmsh); //good!
    adder pcadd2(EX_pc4, EX_signimmsh, EX_pcbranch); //good!


   //for clarity sake
   logic [31:0]  jmp_pc;
   assign jmp_pc = {pcplus4[31:28], instr[25:0], 2'b00};
   
    mux_dontcare #(32) pcbrmux(pcplus4, MEM_pcbranch, MEM_pcsrc, pcnextbr);
    mux_dontcare #(32) pcmux(pcnextbr, jmp_pc, prejump, pcnext); //im unsure....i think its fine


    //extra connections for muladd
    logic [4:0]	 result_a;
    assign result_a = EX_instr[15:11];
   
    // logicister file logic
                                     //rs            //rt          //rd add rd dat                           //muladd adr, data   
    logicfile rf(clk, WB_regwrite, ID_instr[25:21], ID_instr[20:16], WB_writereg, WB_result, ID_srca, ID_srcb, result_a, wb_dat);
    mux2 #(5) wrmux(EX_rte, EX_rde, EX_regdst, EX_writereg); //??
    mux2 #(32) resmux(WB_aluout, WB_readdata, WB_memtoreg, WB_result);
    signext se(ID_instr[15:0], ID_signimm);
    
    // ALU logic
    logic [31:0]  EX_srca2;
    logic [31:0]  EX_writedata;

    mux_dontcare3 muxsrca(EX_srca, WB_result, MEM_aluout, EX_forwardA, EX_srca2);
    mux_dontcare3 muxwritedata(EX_srcb_premux, WB_result, MEM_aluout, EX_forwardB, EX_writedata);

    mux2 #(32) srcbmux(EX_writedata, EX_signimm, EX_alusrc, EX_srcb); 
                                                                  //pf //muladd
    alu alu(EX_srca2, EX_srcb, EX_alucontrol, EX_aluout, EX_zero, cnt, wb_dat); //good

   assign MEM_pcsrc = MEM_branch & MEM_zero;
   
   
endmodule


//////////////////////////////////////////////////////////////////////
// logicister File Module
//////////////////////////////////////////////////////////////////////
module logicfile (
    input 	  clk,
    input 	  we3,
    input [4:0]   ra1, ra2, wa3,
    input [31:0]  wd3,
    output [31:0] rd1, rd2,
    input [31:0] result_a,		  
    output [31:0] wd3_out //muladd
);
    
    logic [31:0] rf[31:0];
    // three ported logicister file
    // read two ports combinationally
    // write third port on rising edge of clock
    // logicister 0 hardwired to 0
    always @ (posedge clk)
        if (we3) rf[wa3] <= wd3;

    assign rd1 = (ra1 != 0) ? ((we3 && ra1 == wa3) ? wd3 : rf[ra1]) : 0;
    assign rd2 = (ra2 != 0) ? ((we3 && ra2 == wa3) ? wd3 : rf[ra2]) : 0;
    assign wd3_out = rf[result_a]; //muladd
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
    input logic              IF_stall,				     
    input 		     clk, reset,
    input [WIDTH-1:0] 	     d,
    output logic [WIDTH-1:0] q
);
    always @ (posedge clk, posedge reset)
        if (reset) q <= 0;
        else begin
	   case(IF_stall)
	     1'b0: q<=d;
	     1'bx: q<=d;
	   endcase // case (IF_stall)
	end
   
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
     input ID_stall, clk, reset,
     input [31:0] IF_instr, IF_pc4,
     output logic [31:0] ID_instr, ID_pc4
     );
   
   always_ff @(posedge clk) begin
      case(ID_stall)
	1'bx:
	  begin
	     ID_instr <= IF_instr;
	     ID_pc4 <= IF_pc4;
	  end
	1'b0:
	  begin
	     ID_instr <= IF_instr;
	     ID_pc4 <= IF_pc4;
	  end
	
      endcase // case (ID_stall)
      
   end
   
endmodule
 
  
module ID_EX(
     input logic 	 EX_flush,
     input logic [4:0]   ID_rse,
     input 		 clk, reset,
     input [31:0] 	 ID_instr, ID_srca, ID_srcb, ID_signimm, ID_pc4,
     input [4:0] 	 ID_rte, ID_rde,
     input 		 ID_memwrite, ID_memtoreg, ID_regwrite, ID_branch, ID_alusrc, ID_regdst,
     input [2:0] 	 ID_alucontrol,
     output logic [31:0] EX_instr, EX_srca, EX_srcb_premux, EX_signimm, EX_pc4,
     output logic [4:0]  EX_rte, EX_rde, EX_rse,
     output logic 	 EX_memwrite, EX_memtoreg, EX_regwrite, EX_branch, EX_alusrc, EX_regdst,
     output logic [2:0]  EX_alucontrol,
     input logic [31:0]  wb_dat,
     output logic [31:0] EX_wb_dat
     );
   
   always_ff @(posedge clk) begin
   if(EX_flush == 1'b1) begin
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
      EX_rse <= '0;
      EX_wb_dat <= '0;
      
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
      EX_rse <= ID_rse;
      EX_wb_dat <= wb_dat;
      
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
     output logic 	 MEM_memwrite, MEM_memtoreg, MEM_regwrite, MEM_branch,
     input logic [31:0] EX_wb_dat,
     output logic [31:0] MEM_wb_dat
     );
   
   always_ff @(posedge clk) begin
   begin
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
      MEM_wb_dat <= EX_wb_dat;
      
   end 
   end
      
endmodule

module MEM_WB(
     input 		 clk, reset,
     input [31:0] 	 MEM_instr, MEM_aluout, MEM_readdata,
     input [4:0] 	 MEM_writereg,
     input 		 MEM_regwrite, MEM_memtoreg,
     output logic [31:0] WB_instr, WB_aluout, WB_readdata,
     output logic [4:0]  WB_writereg,
     output logic 	 WB_regwrite, WB_memtoreg
     );
   
   always_ff @(posedge clk) begin
   begin
      WB_instr <= MEM_instr;
      WB_aluout <= MEM_aluout;
      WB_readdata <= MEM_readdata;
      WB_writereg <= MEM_writereg;
      WB_regwrite <= MEM_regwrite;
      WB_memtoreg <= MEM_memtoreg;            
   end 
   end
      
endmodule



//hazard unit
module hazardunit(
    input logic        EX_memtoreg,
    input logic [4:0]  ID_rse, ID_rte,
    input logic        MEM_regwrite, WB_regwrite,
    input logic [4:0]  EX_rse, EX_rte,
    input logic [4:0]  MEM_writereg, WB_writereg,
    output logic [1:0] EX_forwardA, EX_forwardB,
    output logic       IF_stall, ID_stall, EX_flush
		  );
   logic 	       lwstall;

   always_comb begin
      
      if ((EX_rse!=5'b00000)&&(EX_rse==MEM_writereg)&&MEM_regwrite) EX_forwardA = 2'b10;
      else if ((EX_rse!=5'b00000)&&(EX_rse==WB_writereg)&&WB_regwrite) EX_forwardA = 2'b01;
      else EX_forwardA = 2'b00;

      if ((EX_rte!=5'b00000)&&(EX_rte==MEM_writereg)&&MEM_regwrite) EX_forwardB = 2'b10;
      else if ((EX_rte!=5'b00000)&&(EX_rte==WB_writereg)&&WB_regwrite) EX_forwardB = 2'b01;
      else EX_forwardB = 2'b00;     
      
   
      lwstall = ((ID_rse==EX_rte)||(ID_rte==EX_rte))&&EX_memtoreg;
      IF_stall = lwstall;
      ID_stall = lwstall;
      EX_flush = lwstall;
      
   end // always_comb


endmodule // hazardunit

  

module mux_dontcare(input logic [31:0] d0, d1, input logic s, output logic [31:0] y);

   always_comb
     begin
	case(s)
	  1'b0: y = d0;
	  1'bx: y = d0;
	  1'b1: y = d1;
	endcase // case (s)
     end
endmodule // mux_dontcare


module mux_dontcare3(input logic [31:0] d0, d1, d2, input logic [1:0] s, output logic [31:0] y);

   always_comb begin
      case(s)
	2'bxx: y=d0;
	2'b00: y=d0;
	2'b01: y=d1;
	2'b10: y=d2;
      endcase // case (s)
      
   end
   
   
endmodule // mux_dontcare3



