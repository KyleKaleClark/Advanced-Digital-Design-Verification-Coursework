`timescale 1ns / 1ps

module FPMult_ExecuteModule(
		a,
		b,
		Ea,
		Eb,
		Sa,
		Sb,
		Sp,
		NormE,
		NormM,
		GRS
    );

	// Input ports
	input logic [3:0] a ;
	input logic [3:0] b ;
	input logic [2:0] Ea ;						// A's exponent
	input logic [2:0] Eb ;						// B's exponent
	input logic Sa ;						// A's sign
	input logic Sb ;						// B's sign
	
	// Output ports
	output logic Sp ;						// Product sign
	output logic [3:0] NormE ;					// Normalized exponent
	output logic [3:0] NormM ;					// Normalized mantissa
	output logic GRS ;
	
	logic [9:0] Mp ;
	
	assign Sp = (Sa ^ Sb) ;						// Equal signs give a positive product
	
	assign Mp =  ({1'b1, a[3:0]}*{1'b1, b[3:0]}) ;
	
	assign NormM = (Mp[9] ? Mp[8:5] : Mp[7:4]);			// Check for overflow
	assign NormE = (Ea + Eb + Mp[9]);				// If so, increment exponent
	
	assign GRS = ((Mp[4]&(Mp[3]))|(|Mp[2:0])) ;

endmodule
