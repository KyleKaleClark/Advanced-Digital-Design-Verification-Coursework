



module FPMult(
		a,
		b,
		result,
		flags
    );
	
	// Input Ports
	input logic [7:0] a;					// Input A, a 8-bit floating point number
	input logic [7:0] b;					// Input B, a 8-bit floating point number
	
	// Output ports
	output logic [7:0] result ;					// Product, result of the operation, 8-bit FP number
	output logic [4:0] flags ;				// Flags indicating exceptions according to IEEE754
	
	// Internal signals
	
	logic Sa ;			// A's sign
	logic Sb ;			// B's sign
	logic Sp ;			// Product sign
	logic [2:0] Ea ;		// A's exponent
	logic [2:0] Eb ;		// B's exponent
	logic [2:0] Ep ;		// Product exponent
	logic [3:0] Ma ;		// A's mantissa
	logic [3:0] Mb ;		// B's mantissa
	logic [9:0] Mp ;		// Product mantissa
	logic [4:0] InputExc ;		// Exceptions in inputs
	logic [3:0] NormM ;		// Normalized mantissa
	logic [3:0] NormE ;		// Normalized exponent
	logic [4:0] RoundM;
	logic [4:0] RoundMP;
	logic [3:0] RoundE;
	logic [3:0] RoundEP;
	logic GRS ;	
        logic      zeroFlag;
   
	
	// Prepare the operands for alignment and check for exceptions
	FPMult_PrepModule PrepModule(a, b, Sa, Sb, Ea, Eb, Ma, Mb, InputExc, zeroFlag) ;
	
	// Perform (unsigned) mantissa multiplication
//	FPMult_ExecuteModule ExecuteModule(Ma, Mb, Ea, Eb, Sa, Sb, Sp, NormE, NormM, GRS) ;
	FPMult_ExecuteModule ExecuteModule(.a(Ma), .b(Mb), .Ea(Ea), .Eb(Eb), 
					   .Sa(Sa), .Sb(Sb), .Sp(Sp), 
					   .NormE(NormE), .NormM(NormM), .GRS(GRS)) ;
	
	// Normalize the result if there is overflow (MSB of mantissa set)
//	FPMult_NormalizeModule NormalizeModule(NormM, NormE, RoundE, RoundEP, RoundM, RoundMP) ;
	FPMult_NormalizeModule NormalizeModule(.NormM(NormM), .NormE(NormE), .RoundE(RoundE), 
					       .RoundEP(RoundEP), .RoundM(RoundM), .RoundMP(RoundMP)) ;
	
	// Round result and if necessary, perform a second (post-rounding) normalization step
	FPMult_RoundModule RoundModule(zeroFlag, RoundM, RoundMP, RoundE, RoundEP, Sp, GRS, InputExc, result, flags) ;		
			
	
		
				
endmodule
