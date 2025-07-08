

//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    01:56:20 09/07/2012 
// Module Name:    FPAddSub
// Project Name: 	 Floating Point Project
// Author:			 Fredrik Brosser
//
// Description:	 Top Module for a 32-bit floating point adder/subtractor.
//						 Follows the IEEE754 Single Precision standard.
//						 Supports only the default rounding mode.
//
//	Inputs:
//				a (32 bits)			: Single precision IEEE754 floating point number
//				b (32 bits)			: Single precision IEEE754 floating point number
//				operation (1 bit)	: Single control bit. 0/Addition, 1/Subtraction
//
//
// Outputs:
//				result (32 bits)	: Result of the operation, in IEEE754 Single format
//				flags	 (5 bits)	: Flags indicating exceptions:
//											Bit 4: Overflow
//											Bit 3: Underflow
//											Bit 2: Divide by Zero
//											Bit 1: Invalid/NaN
//											Bit 0: Inexact
//
//////////////////////////////////////////////////////////////////////////////////

module FPAddSub(
	
	// Input ports
	input logic [7:0] a, 					// Input A, a 8-bit floating point number
	input logic [7:0] b,					// Input B, a 8-bit floating point number
	input logic operation,					// Operation select signal
	
	// Output ports
	output logic [7:0] result,				// Result of the operation
	output logic [4:0] flags );				// Flags indicating exceptions according to IEEE754
	
	
	// Internal logics between modules
	logic [6:0] Aout ;					// A - sign
	logic [6:0] Bout ;					// B - sign
	logic Opout ;						// Operation 
	logic Sa ;						// A's sign
	logic Sb ;						// B's sign
	logic MaxAB ;						// Indicates the larger of A and B(0/A, 1/B)
	logic [2:0] CExp ;					// Common Exponent
	logic [2:0] Shift_1 ;					// Number of steps to smaller mantissa shift right (align)
	logic [3:0] Mmax ;					// Larger mantissa
	logic [4:0] InputExc ;					// Input numbers are exceptions
	logic [5:0] ShiftDet ;
	logic [3:0] Mmin;					// Smaller mantissa
	logic [4:0] Mmin2 ;					
	logic [4:0] Mmin3 ;					
	logic [8:0] Mmin4 ;					
	logic [8:0] Mmin5;
	logic [9:0] Sum ;
	logic PSgn ;
	logic Opr ;
	logic [2:0] Shift_2 ;					// Number of steps to shift sum left (normalize)
	logic [3:0] NormM ;					// Normalized mantissa
	logic [3:0] NormE;					// Adjusted exponent
	logic ZeroSum ;						// Zero flag
	logic NegE ;						// Flag indicating negative exponent
	logic R ;						// Round bit
	logic S ;						// Final sticky bit
	logic FG ;						// Final sticky bit
	logic [7:0] Z ;
	logic EOF ;
        logic      oneZero;
   
	
	// Prepare the operands for alignment and check for exceptions
	FPAddSub_PrealignModule PrealignModule
	(	// Inputs
		a, b, operation,
		// Outputs
		Sa, Sb, ShiftDet, InputExc, Aout, Bout, Opout, oneZero) ;
		
	// Prepare the operands for alignment and check for exceptions
	FPAddSub_Align AlignModule
	(	// Inputs
		Aout, Bout, ShiftDet,
		// Outputs
		CExp, MaxAB, Shift_1, Mmin, Mmax) ;	

	// Alignment Shift Stage 1
	FPAddSub_AlignShift1 AlignShift1
	(  // Inputs
		Mmin, Shift_1, oneZero,
		// Outputs
		Mmin2) ;

	/* Alignment Shift Stage 3 and compution of guard and sticky bits
	FPAddSub_AlignShift2 AlignShift2  
	(  // Inputs
		Mmin2, Shift_1[1:0],
		// Outputs
		Mmin3 );
		*/				
	// Perform mantissa addition
	FPAddSub_ExecutionModule ExecutionModule
	(  // Inputs
		Mmax, Mmin2, Sa, Sb, MaxAB, Opout,
		// Outputs
		Sum, PSgn, Opr) ;
	
	// Prepare normalization of result
	FPAddSub_NormalizeModule NormalizeModule
	(  // Inputs
		Sum, 
		// Outputs
		Mmin4, Shift_2) ;

					
	/* Normalization Shift Stage 1
	FPAddSub_NormalizeShift1 NormalizeShift1
	(  // Inputs
		Mmin4, Shift_2,
		// Outputs
		Mmin5 );*/
		
	// Normalization Shift Stage 3 and final guard, sticky and round bits
	FPAddSub_NormalizeShift2 NormalizeShift2
	(  // Inputs
		Sum, CExp, Shift_2,
		// Outputs
		NormM, NormE, ZeroSum, NegE, R, S, FG) ;

	// Round and put result together
	FPAddSub_RoundModule RoundModule
	(  // Inputs
		 ZeroSum, NormE, NormM, R, S, FG, Sa, Sb, Opr, MaxAB, 
		// Outputs
		Z, EOF) ;
	
	// Check for exceptions
	FPAddSub_ExceptionModule Exceptionmodule
	(  // Inputs
		Z, NegE, R, S, InputExc, EOF, 
		// Outputs
		result, flags) ;			
	
		endmodule
