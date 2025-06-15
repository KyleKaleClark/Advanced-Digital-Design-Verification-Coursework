`timescale 1ns / 1ps

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
		a,
		b,
		operation,
		result,
		flags
	);
	
	// Clock and reset
	
	// Input ports
	input logic [7:0] a ;								// Input A, a 32-bit floating point number
	input logic [7:0] b ;								// Input B, a 32-bit floating point number
	input logic operation ;								// Operation select signal
	
	// Output ports
	output logic [7:0] result ;						// Result of the operation
	output logic [4:0] flags ;							// Flags indicating exceptions according to IEEE754
	
	
	// Internal wires between modules
	logic [6:0] Aout_0 ;							// A - sign
	logic [6:0] Bout_0 ;							// B - sign
	logic Opout_0 ;									// A's sign
	logic Sa_0 ;										// A's sign
	logic Sb_0 ;										// B's sign
	logic MaxAB_1 ;									// Indicates the larger of A and B(0/A, 1/B)
	logic [2:0] CExp_1 ;							// Common Exponent
	wire [4:0] Shift_1 ;							// Number of steps to smaller mantissa shift right (align)
	wire [22:0] Mmax_1 ;							// Larger mantissa
	wire [4:0] InputExc_0 ;						// Input numbers are exceptions
	wire [9:0] ShiftDet_0 ;
	wire [22:0] MminS_1 ;						// Smaller mantissa after 0/16 shift
	wire [23:0] MminS_2 ;						// Smaller mantissa after 0/4/8/12 shift
	wire [23:0] Mmin_3 ;							// Smaller mantissa after 0/1/2/3 shift
	wire [32:0] Sum_4 ;
	wire PSgn_4 ;
	wire Opr_4 ;
	wire [4:0] Shift_5 ;							// Number of steps to shift sum left (normalize)
	wire [32:0] SumS_5 ;							// Sum after 0/16 shift
	wire [32:0] SumS_6 ;							// Sum after 0/16 shift
	wire [32:0] SumS_7 ;							// Sum after 0/16 shift
	wire [22:0] NormM_8 ;						// Normalized mantissa
	wire [8:0] NormE_8;							// Adjusted exponent
	wire ZeroSum_8 ;								// Zero flag
	wire NegE_8 ;									// Flag indicating negative exponent
	wire R_8 ;										// Round bit
	wire S_8 ;										// Final sticky bit
	wire FG_8 ;										// Final sticky bit
	wire [31:0] P_int ;
	wire EOF ;
	
	// Prepare the operands for alignment and check for exceptions
	FPAddSub_PrealignModule PrealignModule
	(	// Inputs
		a, b, operation,
		// Outputs
		Sa_0, Sb_0, ShiftDet_0[9:0], InputExc_0[4:0], Aout_0[30:0], Bout_0[30:0], Opout_0) ;
		
	// Prepare the operands for alignment and check for exceptions
	FPAddSub_AlignModule AlignModule
	(	// Inputs
		pipe_1[78:48], pipe_1[47:17], pipe_1[14:5],
		// Outputs
		CExp_1[7:0], MaxAB_1, Shift_1[4:0], MminS_1[22:0], Mmax_1[22:0]) ;	

	// Alignment Shift Stage 1
	FPAddSub_AlignShift1 AlignShift1
	(  // Inputs
		pipe_2[22:0], pipe_2[55:53],
		// Outputs
		MminS_2[23:0]) ;

	// Alignment Shift Stage 3 and compution of guard and sticky bits
	FPAddSub_AlignShift2 AlignShift2  
	(  // Inputs
		pipe_3[23:0], pipe_3[53:52],
		// Outputs
		Mmin_3[23:0]) ;
						
	// Perform mantissa addition
	FPAddSub_ExecutionModule ExecutionModule
	(  // Inputs
		pipe_4[51:29], pipe_4[23:0], pipe_4[67], pipe_4[66], pipe_4[65], pipe_4[68],
		// Outputs
		Sum_4[32:0], PSgn_4, Opr_4) ;
	
	// Prepare normalization of result
	FPAddSub_NormalizeModule NormalizeModule
	(  // Inputs
		pipe_5[32:0], 
		// Outputs
		SumS_5[32:0], Shift_5[4:0]) ;
					
	// Normalization Shift Stage 1
	FPAddSub_NormalizeShift1 NormalizeShift1
	(  // Inputs
		pipe_6[32:0], pipe_6[54:51],
		// Outputs
		SumS_7[32:0]) ;
		
	// Normalization Shift Stage 3 and final guard, sticky and round bits
	FPAddSub_NormalizeShift2 NormalizeShift2
	(  // Inputs
		pipe_7[32:0], pipe_7[45:38], pipe_7[55:51],
		// Outputs
		NormM_8[22:0], NormE_8[8:0], ZeroSum_8, NegE_8, R_8, S_8, FG_8) ;

	// Round and put result together
	FPAddSub_RoundModule RoundModule
	(  // Inputs
		 pipe_8[3], pipe_8[12:4], pipe_8[35:13], pipe_8[1], pipe_8[0], pipe_8[54], pipe_8[51], pipe_8[50], pipe_8[53], pipe_8[49], 
		// Outputs
		P_int[31:0], EOF) ;
	
	// Check for exceptions
	FPAddSub_ExceptionModule Exceptionmodule
	(  // Inputs
		pipe_9[40:9], pipe_9[8], pipe_9[7], pipe_9[6], pipe_9[5:1], pipe_9[0], 
		// Outputs
		result[31:0], flags[4:0]) ;			
	

