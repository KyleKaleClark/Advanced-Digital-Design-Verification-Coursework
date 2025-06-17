`timescale 1ns / 1ps


module FPAddSub_ExecutionModule(

	// Input ports
	input logic [3:0] Mmax,					// The larger mantissa
	input logic [4:0] Mmin,					// The smaller mantissa
	input logic Sa,								// Sign bit of larger number
	input logic Sb,								// Sign bit of smaller number
	input logic MaxAB,							// Indicates the larger number (0/A, 1/B)
	input logic OpMode,							// Operation to be performed (0/Add, 1/Sub)
	
	// Output ports
	output logic [8:0] Sum,					// The result of the operation
	output logic PSgn,							// The sign for the result
	output logic Opr );							// The effective (performed) operation

	assign Opr = (OpMode^Sa^Sb); 		// Resolve sign to determine operation

	// Perform effective operation
	assign Sum = (OpMode^Sa^Sb) ? ({1'b1, Mmax, 4'b0000} - {Mmin, 4'b0000}) : ({1'b1, Mmax, 4'b0000} + {Mmin, 4'b0000}) ;
	
	// Assign result sign
	assign PSgn = (MaxAB ? Sb : Sa) ;

endmodule
