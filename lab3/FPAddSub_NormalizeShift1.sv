`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    16:49:36 10/16/2012 
// Module Name:    FPAddSub_NormalizeShift1 
// Project Name: 	 Floating Point Project
// Author:			 Fredrik Brosser
//
// Description:	 Normalization shift stage 1, performs 12|8|4|3|2|1|0 shift
//
//////////////////////////////////////////////////////////////////////////////////

module FPAddSub_NormalizeShift1(
		MminP,
		Shift,
		Mmin
	);
	
	// Input ports
	input logic [8:0] MminP ;						// Smaller mantissa after 16|12|8|4 shift
	input logic [2:0] Shift ;						// Shift amount
	
	// Output ports
	output logic [8:0] Mmin ;						// The smaller mantissa
	
always_comb 

	Mmin = Mminp << Shift;	
	
endmodule
