`timescale 1ns / 1ps

module FPAddSub_NormalizeModule(
 
	// Input ports
	input logic [9:0] Sum,					// Mantissa sum including hidden 1 and GRS
	
	// Output ports
	output logic [8:0] Mmin,					// Mantissa after 16|0 shift
	output logic [2:0] Shift );					// Shift amount
	
	// Determine normalization shift amount by finding leading nought
    always_comb begin
        // Default values
	
        Shift = 0;
        Mmin = Sum;

        // Normalize by finding first '1' from MSB and shifting left
        if (Sum[8])  Shift = 0;
	else if (Sum[7]) Shift = 3'd1;       
      	else if (Sum[6]) Shift = 3'd2;        
       	else if (Sum[5]) Shift = 3'd3;       
      	else if (Sum[4]) Shift = 3'd4;       
      	else if (Sum[3]) Shift = 3'd5;       
      	else if (Sum[2]) Shift = 3'd6;         
	else if (Sum[1]) Shift = 3'd7;         
	else Shift = 3'd8;   
end	

endmodule
