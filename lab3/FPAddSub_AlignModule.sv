`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    	16:49:15 10/16/2012 
// Module Name:    	FPAddSub_AlignModule
// Project Name: 	 	Floating Point Project
// Author:			 	Fredrik Brosser
//
// Description:	 	The alignment module determines the larger input operand and
//							sets the mantissas, shift and common exponent accordingly.
//
//////////////////////////////////////////////////////////////////////////////////

module FPAddSub_AlignModule (

	// Input ports
	input logic [6:0] A,				// Input A, a 32-bit floating point number
	input logic [6:0] B,				// Input B, a 32-bit floating point number
	input logic [5:0] ShiftDet,
	
	// Output ports
	output logic [2:0] CExp,			// Common Exponent
	output logic MaxAB,				// Incidates larger of A and B (0/A, 1/B)
	output logic [2:0] Shift,			// Number of steps to smaller mantissa shift right
	output logic [3:0] Mmin, 			// Smaller mantissa 
	output logic [3:0] Mmax );			// Larger mantissa
	
		
	assign MaxAB = (A[6:0] < B[6:0]) ;	
	assign Shift = MaxAB ? ShiftDet[5:3] : ShiftDet[2:0] ;
	
	// Take out smaller mantissa and append shift space
	assign Mmin = MaxAB ? A[3:0] : B[3:0] ; 
	
	// Take out larger mantissa	
	assign Mmax = MaxAB ? B[3:0]: A[3:0] ;	
	
	// Common exponent
	assign CExp = (MaxAB ? B[6:4] : A[6:4]) ;		
	
endmodule
