`timescale 1ns / 1ps

module FPAddSub_AlignShift1(
	
	// Input portsi
	input logic [3:0] MminP,						
	input logic [2:0] Shift,						// Shift amount
	
	// Output ports
	output logic [4:0] Mmin );						// The smaller mantissa
	
	assign Mmin = ({1'b1, MminP, 3'b000} >> Shift);
endmodule
