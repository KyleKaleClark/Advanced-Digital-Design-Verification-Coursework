`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Create Date:    16:05:07 09/07/2012
// Module Name:    FBAddSub_NormalizeModule
// Project Name: 	 Floating Point Project
// Author:			 Fredrik Brosser
//
// Description:	 Determine the normalization shift amount and perform 16-shift
//
//////////////////////////////////////////////////////////////////////////////////

module FPAddSub_NormalizeModule(
 
	// Input ports
	input logic [8:0] Sum,					// Mantissa sum including hidden 1 and GRS
	
	// Output ports
	output logic [8:0] Mmin,					// Mantissa after 16|0 shift
	output logic [2:0] Shift );					// Shift amount
	
	// Determine normalization shift amount by finding leading nought
    always_comb begin
        // Default values
	
        Shift = 0;
        Mmin = Sum;

        // Normalize by finding first '1' from MSB and shifting left
        if (Sum[8]) begin Shift = 0;  Mmin = Sum; end
        else if (Sum[7]) begin Shift = 3'd1;  Mmin = Sum << 1; end
        else if (Sum[6]) begin Shift = 3'd2;  Mmin = Sum << 2; end
        else if (Sum[5]) begin Shift = 3'd3;  Mmin = Sum << 3; end
        else if (Sum[4]) begin Shift = 3'd4;  Mmin = Sum << 4; end
        else if (Sum[3]) begin Shift = 3'd5;  Mmin = Sum << 5; end
        else if (Sum[2]) begin Shift = 3'd6;  Mmin = Sum << 6; end
        else if (Sum[1]) begin Shift = 3'd7;  Mmin = Sum << 7; end
        else begin Shift = 3'd8;  Mmin = Sum << 8; end
    end	

endmodule
