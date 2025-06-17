`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    16:50:05 10/16/2012 
// Module Name:    FPAddSub_AlignShift2
// Project Name: 	 Floating Point Project
// Author:			 Fredrik Brosser
//
// Description:	 Alignment shift stage 2, performs 3|2|1 shift
//
//////////////////////////////////////////////////////////////////////////////////

module FPAddSub_AlignShift2(

		// Input ports
	input [3:0] MminP,						// Smaller mantissa after 16|12|8|4 shift
	input [1:0] Shift,						// Shift amount
	
	// Output ports
	output [3:0] Mmin );						// The smaller mantissa
	
	assign Mmin = MminP >> Shift;		

endmodule
