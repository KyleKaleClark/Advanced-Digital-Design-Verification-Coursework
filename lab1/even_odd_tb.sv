`timescale 1ns/1ps


module even_odd_tb();

	logic clk, reset, w_en, r_en;
	logic [7:0] d_in, d_out;

	logic [1:0] casenum;

	even_odd eo (.*);


	initial begin
		clk=1'd0; #10;
		repeat (1000) begin
		#5 clk = ~clk; #5;
		end	
	end



	initial begin

	//Test 1
	//Reads enabled for last 8/10 of every write cycle
	//Writes are like Case 3 in the case 9 solution; 20 cycle break at the end, 80 writes/100 cycles
	casenum = 2'd1;
	w_en = 1'b0; r_en = 1'b0; reset = 1'b0; #200;
	w_en = 1'b1; r_en = 1'b0; reset = 1'b1; #20;
	//data stream
	d_in = 8'h1f; #20; //Write 1
	d_in = 8'h3b; #20;
	
	d_in = 8'h1c; #20;
	d_in = 8'h34; #20;
	d_in = 8'h58; #20;
	d_in = 8'h38; #20;
	d_in = 8'h5d; #20;
	
	r_en = 1'b1;
	d_in = 8'h10; #20;
	d_in = 8'h4f; #20;
	
	r_en = 1'b0;
	d_in = 8'h52; #20; //Write 10	
	d_in = 8'h2e; #20;
	r_en = 1'b1;
	d_in = 8'h4e; #20;
	d_in = 8'h47; #20;
	d_in = 8'h36; #20;
	d_in = 8'h23; #20;
	d_in = 8'h2d; #20;
	d_in = 8'h19; #20;
	d_in = 8'h16; #20;
	d_in = 8'h49; #20;
	
	r_en = 1'b0;
	d_in = 8'h9; #20;  //Write 20
	d_in = 8'h17; #20;
	r_en = 1'b1;
	d_in = 8'h3f; #20;
	d_in = 8'h5c; #20;
	d_in = 8'h46; #20;
	d_in = 8'h6; #20;
	d_in = 8'h53; #20;
	d_in = 8'h24; #20;
	d_in = 8'h4; #20;
	d_in = 8'h62; #20;
	
	r_en = 1'b0;
	d_in = 8'h15; #20; //Write 30
	d_in = 8'hd; #20;
	r_en = 1'b1;
	d_in = 8'h2b; #20;
	d_in = 8'h1; #20;
	d_in = 8'hc; #20;
	d_in = 8'h51; #20;
	d_in = 8'h5e; #20;
	d_in = 8'h30; #20;
	d_in = 8'he; #20;
	d_in = 8'h3; #20;
	
	r_en = 1'b0;
	d_in = 8'h56; #20; //Write 40
	d_in = 8'h5b; #20;
	r_en = 1'b1;
	d_in = 8'h2; #20;
	d_in = 8'h2a; #20;
	d_in = 8'h3a; #20;
	d_in = 8'h26; #20;
	d_in = 8'h33; #20;
	d_in = 8'h4b; #20;
	d_in = 8'h1e; #20;
	d_in = 8'h1d; #20;
	
	r_en = 1'b0;
	d_in = 8'h25; #20; //Write 50
	d_in = 8'h3d; #20;
	r_en = 1'b1;
	d_in = 8'h50; #20;
	d_in = 8'h18; #20;
	d_in = 8'h27; #20;
	d_in = 8'h61; #20;
	d_in = 8'ha; #20;
	d_in = 8'h57; #20;
	d_in = 8'h1a; #20;
	d_in = 8'h48; #20;
	
	r_en = 1'b0;
	d_in = 8'h5a; #20; //Write 60
	d_in = 8'h32; #20;
	r_en = 1'b1;
	d_in = 8'h54; #20;
	d_in = 8'h5f; #20;
	d_in = 8'h0; #20;
	d_in = 8'h59; #20;
	d_in = 8'h60; #20;
	d_in = 8'h35; #20;
	d_in = 8'h5; #20;
	d_in = 8'hf; #20;
	
	r_en = 1'b0;
	d_in = 8'h28; #20; //Write 70
	d_in = 8'h14; #20;
	r_en = 1'b1;
	d_in = 8'h1b; #20;
	d_in = 8'h45; #20;
	d_in = 8'hb; #20;
	d_in = 8'h8; #20;
	d_in = 8'h3e; #20;
	d_in = 8'h41; #20;
	d_in = 8'h7; #20;
	d_in = 8'h29; #20;
	d_in = 8'h31; #20; //Write 80
	w_en = 1'b0; #200; //Write break of 10 cycles at the end of the 80 total data

//expected ['0x1c', '0x1f', '0x34', '0x3b', '0x58', '0x5d', '0x38', '0x4f', '0x10', '0x47', '0x52', '0x23', '0x2e', '0x2d', '0x4e', '0x19', '0x36', '0x49', '0x16', '0x9', '0x5c', '0x17', '0x46', '0x3f', '0x6', '0x53', '0x24', '0x15', '0x4', '0xd', '0x62', '0x2b', '0xc', '0x1', '0x5e', '0x51', '0x30', '0x3', '0xe', '0x5b', '0x56', '0x33', '0x2', '0x4b', '0x2a', '0x1d', '0x3a', '0x25', '0x26', '0x3d', '0x1e', '0x27', '0x50', '0x61', '0x18', '0x57', '0xa', '0x5f', '0x1a', '0x59', '0x48', '0x35', '0x5a', '0x5', '0x32', '0xf', '0x54', '0x1b', '0x0', '0x45', '0x60', '0xb', '0x28', '0x41', '0x14', '0x7', '0x8', '0x29', '0x3e', '0x31']
	
	#1000;
	//small separation, then a long wait after enabling read
	
	
	//Test 2
	//Reads enabled for last 8/10 of every write cycle
	//Writes are like Case 3 in the case 9 solution; 20 cycle break at the end
	casenum = 2'd2;
	w_en = 1'b0; r_en = 1'b0; reset = 1'b0; #200;
	w_en = 1'b1; r_en = 1'b0; reset = 1'b1; #20;
	end



	//Waveform dumping
	initial begin
		$fsdbDumpvars();
	end


endmodule
