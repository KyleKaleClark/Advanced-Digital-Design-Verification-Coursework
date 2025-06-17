`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    17:34:18 10/16/2012 
// Module Name:    FPAddSub_NormalizeShift2 
// Project Name: 	 Floating Point Project
// Author:			 Fredrik Brosser
//
// Description:	 Normalization shift stage 2, calculates post-normalization
//						 mantissa and exponent, as well as the bits used in rounding		
//
//////////////////////////////////////////////////////////////////////////////////

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
	logic MSBShift ;						// Flag indicating that a second shift is needed
	logic [3:0] ExpOF ;					// MSB set in sum indicates overflow
	logic [3:0] ExpOK ;					// MSB not set, no adjustment
	
	// Calculate normalized exponent and mantissa, check for all-zero sum
	assign MSBShift = PSSum[8] ;		// Check MSB in unnormalized sum
	assign ZeroSum = ~|PSSum ;			// Check for all zero sum
	assign ExpOK = CExp - Shift ;		// Adjust exponent for new normalized mantissa
	assign NegE = NormE[3] ;			// Check for exponent overflow
	assign ExpOF = CExp - Shift + 1'b1 ;		// If MSB set, add one to exponent(x2)
	assign NormE = MSBShift ? ExpOF : ExpOK ;			// Check for exponent overflow
	assign NormM = PSSum[8:5] ;		// The new, normalized mantissa
	
	// Also need to compute sticky and round bits for the rounding stage
	assign FG = PSSum[4] ; 
	assign R = PSSum[3] ;
	assign S = |PSSum[2:0] ;
	
endmodule
