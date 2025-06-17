`timescale 1ns / 1ps

module FPAddSub_NormalizeShift2(

	//input ports
	input logic [8:0] PSSum,					// The Pre-Shift-Sum
	input logic[2:0] CExp,
	input logic [2:0] Shift,					// Amount to be shifted

	// Output ports
	output logic[3:0] NormM,				// Normalized mantissa
	output logic [3:0] NormE,					// Adjusted exponent
	output logic ZeroSum,						// Zero flag
	output logic NegE,							// Flag indicating negative exponent
	output logic R,								// Round bit
	output logic S,								// Final sticky bit
	output logic FG );

	// Internal signals
	//logic MSBShift ;						// Flag indicating that a second shift is needed
	logic [3:0] ExpOF ;					// MSB set in sum indicates overflow
	logic [3:0] ExpOK ;					// MSB not set, no adjustment
	logic [8:0] ShiftedSum;

	// Calculate normalized exponent and mantissa, check for all-zero sum
	//
	assign ShiftedSum = PSSum << Shift;

	//assign MSBShift = PSSum[8] ;		// Check MSB in unnormalized sum
	assign ZeroSum = ~|PSSum ;			// Check for all zero sum

	assign ExpOK = CExp - Shift ;		// Adjust exponent for new normalized mantissa
	assign NegE = NormE[3] ;			// Check for exponent overflow
	assign ExpOF = ExpOK + 1'b1 ;		// If MSB set, add one to exponent(x2)
	assign NormE = ShiftedSum[8] ? ExpOF : ExpOK ;			// Check for exponent overflow
	assign NormM = ShiftedSum[8:5] ;		// The new, normalized mantissa
	
	// Also need to compute sticky and round bits for the rounding stage
	assign FG = ShiftedSum[4] ; 
	assign R = ShiftedSum[3] ;
	assign S = |ShiftedSum[2:0] ;
	
endmodule
