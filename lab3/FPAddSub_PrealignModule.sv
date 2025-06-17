`timescale 1ns / 1ps

module FPAddSub_PrealignModule(
	
	// Input ports
	input logic [7:0] A,										// Input A, a 32-bit floating point number
	input logic [7:0] B,										// Input B, a 32-bit floating point number
	input logic operation,
	
	// Output ports
	output logic Sa,												// A's sign
	output logic Sb,												// B's sign
	output logic [5:0] ShiftDet,
	output logic [4:0] InputExc,								// Input numbers are exceptions
	output logic [6:0] Aout,
	output logic [6:0] Bout,
	output logic Opout );
	
	// Internal signals									// If signal is high...
	logic ANaN ;												// A is a NaN (Not-a-Number)
	logic BNaN ;												// B is a NaN
	logic AInf ;												// A is infinity
	logic BInf ;												// B is infinity
	logic [2:0] DAB ;										// ExpA - ExpB					
	logic [2:0] DBA ;										// ExpB - ExpA	
	
	assign ANaN = &(A[6:4]) & |(A[3:0]) ;		// All one exponent and not all zero mantissa - NaN
	assign BNaN = &(B[6:4]) & |(B[3:0]);		// All one exponent and not all zero mantissa - NaN
	assign AInf = &(A[6:4]) & ~|(A[3:0]) ;	// All one exponent and all zero mantissa - Infinity
	assign BInf = &(B[6:4]) & ~|(B[3:0]) ;	// All one exponent and all zero mantissa - Infinity
	
	// Put all flags into exception vector
	assign InputExc = {(ANaN | BNaN | AInf | BInf), ANaN, BNaN, AInf, BInf} ;
	
	//assign DAB = (A[30:23] - B[30:23]) ;
	//assign DBA = (B[30:23] - A[30:23]) ;
	assign DAB = (A[6:4] + ~(B[6:4]) + 1) ;
	assign DBA = (B[6:4] + ~(A[6:4]) + 1) ;
	
	assign Sa = A[7] ;									// A's sign bit
	assign Sb = B[7] ;									// B's sign	bit
	assign ShiftDet = {DBA[2:0], DAB[2:0]} ;		// Shift data
	assign Opout = operation ;
	assign Aout = A[6:0] ;
	assign Bout = B[6:0] ;
	
endmodule
