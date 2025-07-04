`timescale 1ns / 1ps

module FPAddSub_AlignShift2(

	// Input ports
	input [4:0] MminP,						// Smaller mantissa after shift
	input [1:0] Shift,						// Shift amount
	
	// Output ports
	output [4:0] Mmin );						// The smaller mantissa
	
	assign Mmin = MminP >> Shift;		

endmodule
