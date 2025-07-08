

module FPAddSub_NormalizeShift1(
	
	// Input ports
	input logic [8:0] MminP,						// Smaller mantissa after 16|12|8|4 shift
	input logic [2:0] Shift,						// Shift amount
	
	// Output ports
	output logic [8:0] Mmin );						// The smaller mantissa
	
always_comb 

	Mmin = MminP << Shift;	
	
endmodule
