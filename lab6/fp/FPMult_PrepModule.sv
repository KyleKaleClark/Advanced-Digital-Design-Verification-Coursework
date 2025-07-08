

 module FPMult_PrepModule (
		a,
		b,
		Sa,
		Sb,
		Ea,
		Eb,
		Ma,
		Mb,
		InputExc,
		zeroFlag
	);
	
	// Input ports
	input logic [7:0] a ;			// Input A, a 8-bit floating point number
	input logic [7:0] b ;			// Input B, a 8-bit floating point number
	
	// Output ports
	output logic Sa ;			// A's sign
	output logic Sb ;			// B's sign
	output logic [2:0] Ea ;			// A's exponent
	output logic [2:0] Eb ;			// B's exponent
	output logic [3:0] Ma ;
	output logic [3:0] Mb ;
	output logic [4:0] InputExc ;		// Input numbers are exceptions
        output logic 	   zeroFlag;
   
	
	// Internal signals			// If signal is high...
	logic ANaN ;					// A is a signalling NaN
	logic BNaN ;					// B is a signalling NaN
	logic AInf ;					// A is infinity
	logic BInf ;					// B is infinityi
	logic Zeroinput;				// A or B is zero	
	
	assign ANaN = &(a[6:4]) & |(a[3:0]) ;		// All one exponent and not all zero mantissa - NaN
	assign BNaN = &(b[6:4]) & |(b[3:0]);		// All one exponent and not all zero mantissa - NaN
	assign AInf = &(a[6:4]) & ~|(a[3:0]) ;		// All one exponent and all zero mantissa - Infinity
	assign BInf = &(b[6:4]) & ~|(b[3:0]) ;		// All one exponent and all zero mantissa - Infinity
	assign Zeroinput = (a[6:0] == 0 || b[6:0] == 0);
        assign zeroFlag = Zeroinput;
   
	// Check for any exceptions and put all flags into exception vector
	assign InputExc = {(Zeroinput| ANaN | BNaN | AInf | BInf), Zeroinput, ANaN, BNaN, AInf, BInf} ;
	
	// Take input numbers apart
	assign Sa = a[7] ;				// A's sign
	assign Sb = b[7] ;				// B's sign
	assign Ea = (a[6:4]);				// Store A's exponent in Ea, unless A is an exception
	assign Eb = (b[6:4]);				// Store B's exponent in Eb, unless B is an exception	
	assign Ma = (a[3:0]);
	assign Mb = (b[3:0]);

endmodule
