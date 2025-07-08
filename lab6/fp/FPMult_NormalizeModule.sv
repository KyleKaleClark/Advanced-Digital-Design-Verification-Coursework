

module FPMult_NormalizeModule(
	input [3:0] NormM,			// Normalized mantissa
	input [3:0] NormE,			// Normalized exponent

	// Output Ports
	output logic [3:0] RoundE,
	output logic [3:0] RoundEP,
	output logic [4:0] RoundM,
	output logic [4:0] RoundMP 

    );

	// Input Ports
	
	assign RoundE = NormE -3;
	assign RoundEP = NormE -2 ;
	assign RoundM = NormM ;
	assign RoundMP = NormM + 1 ;

endmodule
