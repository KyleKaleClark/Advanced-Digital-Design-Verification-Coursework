`timescale 1ns / 1ps

module FPAddSub_RoundModule(


	// Input ports
	input logic ZeroSum,					// Sum is zero
	input logic [3:0] NormE,				// Normalized exponent
	input logic [3:0] NormM,				// Normalized mantissa
	input logic R,							// Round bit
	input logic S,							// Sticky bit
	input logic G,
	input logic Sa,							// A's sign bit
	input logic Sb,							// B's sign bit
	input logic Ctrl,						// Control bit (operation)
	input logic MaxAB,
	
	// Output ports
	output logic [7:0] Z,					// Final result
	output logic EOF );
	
	// Internal signals
	logic [4:0] RoundUpM ;			// Rounded up sum with room for overflow
	logic [3:0] RoundM ;				// The final rounded sum
	logic [3:0] RoundE ;				// Rounded exponent (note extra bit due to poential overflow	)
	logic RoundUp ;						// Flag indicating that the sum should be rounded up
	logic ExpAdd ;						// May have to add 1 to compensate for overflow 
	logic RoundOF ;						// Rounding overflow
	logic Fsgn;

	// The cases where we need to round upwards (= adding one) in Round to nearest, tie to even
	assign RoundUp = (G & ((R | S) | NormM[0])) ;
	
	// Note that in the other cases (rounding down), the sum is already 'rounded'
	assign RoundUpM = (NormM + 1) ;								// The sum, rounded up by 1
	assign RoundM = (RoundUp ? RoundUpM[3:0] : NormM) ; 	// Compute final mantissa	
	assign RoundOF = RoundUp & RoundUpM[4] ; 				// Check for overflow when rounding up

	// Calculate post-rounding exponent
	assign ExpAdd = (RoundOF ? 1'b1 : 1'b0) ; 				// Add 1 to exponent to compensate for overflow
	assign RoundE = ZeroSum ? 4'b0000 : (NormE + ExpAdd) ; 							// Final exponent

	// If zero, need to determine sign according to rounding
	assign FSgn = (ZeroSum & (Sa ^ Sb)) | (ZeroSum ? (Sa & Sb & ~Ctrl) : ((~MaxAB & Sa) | ((Ctrl ^ Sb) & (MaxAB | Sa)))) ;

	// Assign final result
	assign Z = {FSgn, RoundE[2:0], RoundM[3:0]} ;
	
	// Indicate exponent overflow
	assign EOF = RoundE[3];
	
endmodule
