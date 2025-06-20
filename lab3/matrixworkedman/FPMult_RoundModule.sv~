`timescale 1ns / 1ps


module FPMult_RoundModule(
		RoundM,
		RoundMP,
		RoundE,
		RoundEP,
		Sp,
		GRS,
		InputExc,
		Z,
		Flags
    );

	// Input Ports
	input logic [4:0] RoundM ;									// Normalized mantissa
	input logic [4:0] RoundMP ;									// Normalized exponent
	input logic [3:0] RoundE ;									// Normalized mantissa + 1
	input logic [3:0] RoundEP ;									// Normalized exponent + 1
	input logic Sp ;												// Product sign
	input logic GRS ;
	input logic [4:0] InputExc ;
	
	// Output Ports
	output logic [7:0] Z ;										// Final product
	output logic [4:0] Flags ;
	
	// Internal Signals
	logic [3:0] FinalE ;									// Rounded exponent
	logic [4:0] FinalM;
	logic [4:0] PreShiftM;
	
	assign PreShiftM = GRS ? RoundMP : RoundM ;	// Round up if R and (G or S)
	
	// Post rounding normalization (potential one bit shift> use shifted mantissa if there is overflow)
	assign FinalM = (PreShiftM[4] ? {1'b0, PreShiftM[4:1]} : PreShiftM[4:0]) ;
	
	assign FinalE = (PreShiftM[4] ? RoundEP : RoundE) ; // Increment exponent if a shift was done
	
	assign Z = {Sp, FinalE[2:0], FinalM[3:0]} ;   // Putting the pieces together
	assign Flags = InputExc[4:0];

endmodule
