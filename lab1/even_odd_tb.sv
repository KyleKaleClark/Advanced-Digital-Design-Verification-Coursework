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
	d_in = 8'h4a; #20; //Write 1
	d_in = 8'h7d; #20;
	d_in = 8'h2b; #20;
	d_in = 8'h32; #20;
	d_in = 8'h3d; #20;
	d_in = 8'h86; #20;
	d_in = 8'h5a; #20;
	r_en = 1'b1;
	d_in = 8'h1a; #20;
	d_in = 8'h69; #20;

	r_en = 1'b0;
	d_in = 8'h31; #20; //Write 10
	d_in = 8'h0; #20;
	r_en = 1'b1;
	d_in = 8'h3e; #20;
	d_in = 8'h2c; #20;
	d_in = 8'h9f; #20;
	d_in = 8'hb; #20;
	d_in = 8'h13; #20;
	d_in = 8'h22; #20;
	d_in = 8'h4c; #20;
	d_in = 8'h10; #20;

	r_en = 1'b0;
	d_in = 8'h26; #20; //Write 20
	d_in = 8'h45; #20;
	r_en = 1'b1;
	d_in = 8'h36; #20;
	d_in = 8'h16; #20;
	d_in = 8'h55; #20;
	d_in = 8'h6; #20;
	d_in = 8'h93; #20;
	d_in = 8'h20; #20;
	d_in = 8'h71; #20;
	d_in = 8'h6e; #20;

	r_en = 1'b0;
	d_in = 8'h72; #20; //Write 30
	d_in = 8'h70; #20;
	r_en = 1'b1;
	d_in = 8'h2f; #20;
	d_in = 8'h8f; #20;
	d_in = 8'h97; #20;
	d_in = 8'h2d; #20;
	d_in = 8'h67; #20;
	d_in = 8'h6f; #20;
	d_in = 8'h6b; #20;
	d_in = 8'h2a; #20;

	r_en = 1'b0;
	d_in = 8'h1f; #20; //Write 40
	d_in = 8'h3f; #20;
	r_en = 1'b1;
	d_in = 8'h5b; #20;
	d_in = 8'h95; #20;
	d_in = 8'h9c; #20;
	d_in = 8'h5c; #20;
	d_in = 8'h54; #20;
	d_in = 8'h50; #20;
	d_in = 8'h65; #20;

	r_en = 1'b0;
	d_in = 8'h63; #20; //Write 50
	d_in = 8'h83; #20;
	r_en = 1'b1;
	d_in = 8'h9; #20;
	d_in = 8'h7f; #20;
	d_in = 8'h8a; #20;
	d_in = 8'h14; #20;
	d_in = 8'h44; #20;
	d_in = 8'h27; #20;
	d_in = 8'h98; #20;
	d_in = 8'h57; #20;
	d_in = 8'h4e; #20;

	r_en = 1'b0;
	d_in = 8'h87; #20; //Write 60
	d_in = 8'h46; #20;
	r_en = 1'b1;
	d_in = 8'h85; #20;
	d_in = 8'h74; #20;
	d_in = 8'h64; #20;
	d_in = 8'h51; #20;
	d_in = 8'h40; #20;
	d_in = 8'h90; #20;
	d_in = 8'ha0; #20;
	d_in = 8'h30; #20;

	r_en = 1'b0;
	d_in = 8'h60; #20; //Write 70
	d_in = 8'h6c; #20;
	r_en = 1'b1;
	d_in = 8'h41; #20;
	d_in = 8'h77; #20;
	d_in = 8'h79; #20;
	d_in = 8'h9d; #20;
	d_in = 8'h6a; #20;
	d_in = 8'h68; #20;
	d_in = 8'h12; #20;
	d_in = 8'h4; #20;
	
	
	//20 = 1clk cycle, Wait 40 clkcycl = 20*40 = #800
	w_en = 1'b0; r_en = 1'b0; #40;
	r_en = 1'b1; #160; //200/800
	
	r_en = 1'b0; #40;
	r_en = 1'b1; #160; //400/800
	
	r_en = 1'b0; #40;
	r_en = 1'b1; #160; //600/800
	
	
	r_en = 1'b0; #40;
	r_en = 1'b1; #160; //800/800
	 


	w_en = 1'b1;	   //Need to reenable writes after the break
	r_en = 1'b0;
	d_in = 8'h18; #20; //Write 80
	d_in = 8'h25; #20;
	r_en = 1'b1;
	d_in = 8'h4f; #20;
	d_in = 8'h11; #20;
	d_in = 8'h8c; #20;
	d_in = 8'h96; #20;
	d_in = 8'h49; #20;
	d_in = 8'h52; #20;
	d_in = 8'h47; #20;
	d_in = 8'h1e; #20;

	r_en = 1'b0;
	d_in = 8'h9e; #20; //Write 90
	d_in = 8'h5d; #20;
	r_en = 1'b1;
	d_in = 8'h8; #20;
	d_in = 8'h1c; #20;
	d_in = 8'h81; #20;
	d_in = 8'h15; #20;
	d_in = 8'h59; #20;
	d_in = 8'h3; #20;
	d_in = 8'h29; #20;
	d_in = 8'h3a; #20;

	r_en = 1'b0;
	d_in = 8'h1b; #20; //Write 100
	d_in = 8'h82; #20;
	r_en = 1'b1;
	d_in = 8'h21; #20;
	d_in = 8'h17; #20;
	d_in = 8'h5e; #20;
	d_in = 8'h53; #20;
	d_in = 8'h48; #20;
	d_in = 8'h91; #20;
	d_in = 8'h8d; #20;
	d_in = 8'h73; #20;

	r_en = 1'b0;
	d_in = 8'h62; #20; //Write 110
	d_in = 8'h56; #20;
	r_en = 1'b1;
	d_in = 8'h35; #20;
	d_in = 8'h75; #20;
	d_in = 8'h78; #20;
	d_in = 8'h34; #20;
	d_in = 8'h7e; #20;
	d_in = 8'h8b; #20;
	d_in = 8'h5; #20;
	d_in = 8'ha; #20;

	r_en = 1'b0;
	d_in = 8'h88; #20; //Write 120
	d_in = 8'h1; #20;
	r_en = 1'b1;
	d_in = 8'h33; #20;
	d_in = 8'h1d; #20;
	d_in = 8'he; #20;
	d_in = 8'h4b; #20;
	d_in = 8'h43; #20;
	d_in = 8'h5f; #20;
	d_in = 8'hf; #20;
	d_in = 8'h2e; #20;

	r_en = 1'b0;
	d_in = 8'hd; #20; //Write 130
	d_in = 8'h89; #20;
	r_en = 1'b1;
	d_in = 8'h9a; #20;
	d_in = 8'h39; #20;
	d_in = 8'h80; #20;
	d_in = 8'h7c; #20;
	d_in = 8'h7a; #20;
	d_in = 8'h3b; #20;
	d_in = 8'h92; #20;
	d_in = 8'h24; #20;

	r_en = 1'b0;
	d_in = 8'h37; #20; //Write 140
	d_in = 8'h6d; #20;
	r_en = 1'b1;
	d_in = 8'h84; #20;
	d_in = 8'h19; #20;
	d_in = 8'h23; #20;
	d_in = 8'h99; #20;
	d_in = 8'h58; #20;
	d_in = 8'h9b; #20;
	d_in = 8'h42; #20;
	d_in = 8'h76; #20;

	r_en = 1'b0;
	d_in = 8'h4d; #20; //Write 150
	d_in = 8'h7; #20;
	r_en = 1'b1;
	d_in = 8'h8e; #20;
	d_in = 8'h3c; #20;
	d_in = 8'h28; #20;
	d_in = 8'h66; #20;
	d_in = 8'hc; #20;
	d_in = 8'h7b; #20;
	d_in = 8'h61; #20;
	d_in = 8'h94; #20;
	d_in = 8'h2; #20; //Write 160

//expected ['0x4a', '0x7d', '0x32', '0x2b', '0x86', '0x3d', '0x5a', '0x69', '0x1a', '0x31', '0x0', '0x9f', '0x3e', '0xb', '0x2c', '0x13', '0x22', '0x45', '0x4c', '0x55', '0x10', '0x93', '0x26', '0x71', '0x36', '0x2f', '0x16', '0x8f', '0x6', '0x97', '0x20', '0x2d', '0x6e', '0x67', '0x72', '0x6f', '0x70', '0x6b', '0x2a', '0x1f', '0x9c', '0x3f', '0x5c', '0x5b', '0x54', '0x95', '0x50', '0x65', '0x8a', '0x63', '0x14', '0x83', '0x44', '0x9', '0x98', '0x7f', '0x4e', '0x27', '0x46', '0x57', '0x74', '0x87', '0x64', '0x85', '0x40', '0x51', '0x90', '0x41', '0xa0', '0x77', '0x30', '0x79', '0x60', '0x9d', '0x6c', '0x25'!, '0x6a', '0x4f', '0x68', '0x11', '0x12', '0x49', '0x4', '0x47', '0x18', '0x5d', '0x8c', '0x81', '0x96', '0x15', '0x52', '0x59', '0x1e', '0x3', '0x9e', '0x29', '0x8', '0x1b', '0x1c', '0x21', '0x3a', '0x17', '0x82', '0x53', '0x5e', '0x91', '0x48', '0x8d', '0x62', '0x73', '0x56', '0x35', '0x78', '0x75', '0x34', '0x8b', '0x7e', '0x5', '0xa', '0x1', '0x88', '0x33', '0xe', '0x1d', '0x2e', '0x4b', '0x9a', '0x43', '0x80', '0x5f', '0x7c', '0xf', '0x7a', '0xd', '0x92', '0x89', '0x24', '0x39', '0x84', '0x3b', '0x58', '0x37', '0x42', '0x6d', '0x76', '0x19', '0x8e', '0x23', '0x3c', '0x99', '0x28', '0x9b', '0x66', '0x4d', '0xc', '0x7', '0x94', '0x7b', '0x2', '0x61']
	d_in = 8'h0;
	#1000;
	//small separation, then a long wait after enabling read
	
	
	//Test 2
	//Reads enabled for last 8/10 of every write cycle
	//Writes are like Case 3 in the case 9 solution; 20 cycle break at the end
	casenum = 2'd3;
	w_en = 1'b0; r_en = 1'b0; reset = 1'b0; #200;
	w_en = 1'b1; r_en = 1'b0; reset = 1'b1;

	//data stream
	d_in = 8'h15; #20; //Write 1
	d_in = 8'h34; #20;
	d_in = 8'h33; #20;
	d_in = 8'h88; #20;
	d_in = 8'h7a; #20;
	d_in = 8'h35; #20;
	r_en = 1'b1;
	d_in = 8'h75; #20;
	d_in = 8'hf; #20;
	d_in = 8'h4; #20;
	
	r_en = 1'b0;
	d_in = 8'h64; #20; //Write 10
	d_in = 8'h57; #20;
	r_en = 1'b1;
	d_in = 8'h14; #20;
	d_in = 8'h2a; #20;
	d_in = 8'h62; #20;
	d_in = 8'h6e; #20;
	d_in = 8'h0; #20;
	d_in = 8'h79; #20;
	d_in = 8'ha0; #20;
	d_in = 8'h74; #20;
	
	r_en = 1'b0;
	d_in = 8'h98; #20; //Write 20
	d_in = 8'h17; #20;
	r_en = 1'b1;
	d_in = 8'h1; #20;
	d_in = 8'h1d; #20;
	d_in = 8'h56; #20;
	d_in = 8'h92; #20;
	d_in = 8'h7c; #20;
	d_in = 8'h16; #20;
	d_in = 8'h5a; #20;
	d_in = 8'h93; #20;
	
	r_en = 1'b0;
	d_in = 8'h41; #20; //Write 30
	d_in = 8'h46; #20;
	r_en = 1'b1;
	d_in = 8'h49; #20;
	d_in = 8'h9; #20;
	d_in = 8'h4b; #20;
	d_in = 8'h55; #20;
	d_in = 8'h63; #20;
	d_in = 8'h68; #20;
	d_in = 8'h7f; #20;
	d_in = 8'h40; #20;
	
	r_en = 1'b0;
	d_in = 8'h89; #20; //Write 40
	d_in = 8'h28; #20;
	r_en = 1'b1;
	d_in = 8'h76; #20;
	d_in = 8'h26; #20;
	d_in = 8'h45; #20;
	d_in = 8'h3d; #20;
	d_in = 8'h54; #20;
	d_in = 8'h50; #20;
	d_in = 8'h73; #20;
	d_in = 8'h86; #20;
	
	r_en = 1'b0;
	d_in = 8'h82; #20; //Write 50
	d_in = 8'h71; #20;
	r_en = 1'b1;
	d_in = 8'h2; #20;
	d_in = 8'h4e; #20;
	d_in = 8'h2d; #20;
	d_in = 8'h8d; #20;
	d_in = 8'h67; #20;
	d_in = 8'h4a; #20;
	d_in = 8'h5c; #20;
	d_in = 8'h6a; #20;
	
	r_en = 1'b0;
	d_in = 8'h84; #20; //Write 60
	d_in = 8'h42; #20;
	r_en = 1'b1;
	d_in = 8'h25; #20;
	d_in = 8'h7; #20;
	d_in = 8'h9c; #20;
	d_in = 8'h2e; #20;
	d_in = 8'h27; #20;
	d_in = 8'h6b; #20;
	d_in = 8'h3b; #20;
	d_in = 8'h8; #20;

	r_en = 1'b0;
	d_in = 8'h65; #20; //Write 70
	d_in = 8'h83; #20;
	r_en = 1'b1;
	d_in = 8'h8e; #20;
	d_in = 8'h96; #20;
	d_in = 8'h4c; #20;
	d_in = 8'h6f; #20;
	d_in = 8'h12; #20;
	d_in = 8'h1e; #20;
	d_in = 8'h94; #20;
	d_in = 8'h97; #20;
	w_en = 1'b0; #400; //20 = 1clk cycle, Wait 20 clkcycl = 20*20 = #400
	
	w_en = 1'b1;	   //Need to reenable writes after the break
	r_en = 1'b0;
	d_in = 8'h47; #20; //Write 80
	d_in = 8'h10; #20;
	r_en = 1'b1;
	d_in = 8'h13; #20;
	d_in = 8'h80; #20;
	d_in = 8'hb; #20;
	d_in = 8'h4f; #20;
	d_in = 8'h5f; #20;
	d_in = 8'h6; #20;
	d_in = 8'h85; #20;
	d_in = 8'h59; #20;
	
	r_en = 1'b0;
	d_in = 8'h44; #20; //Write 90
	d_in = 8'h29; #20;
	r_en = 1'b1;
	d_in = 8'h5d; #20;
	d_in = 8'h90; #20;
	d_in = 8'h20; #20;
	d_in = 8'h52; #20;
	d_in = 8'h1f; #20;
	d_in = 8'h8c; #20;
	d_in = 8'h31; #20;
	d_in = 8'h30; #20;
	
	r_en = 1'b0;
	d_in = 8'hd; #20; //Write 100
	d_in = 8'h6c; #20;
	r_en = 1'b1;
	d_in = 8'h51; #20;
	d_in = 8'h22; #20;
	d_in = 8'h24; #20;
	d_in = 8'h60; #20;
	d_in = 8'h78; #20;
	d_in = 8'h11; #20;
	d_in = 8'h72; #20;
	d_in = 8'h18; #20;
	
	r_en = 1'b0;
	d_in = 8'h99; #20; //Write 110
	d_in = 8'h7d; #20;
	r_en = 1'b1;
	d_in = 8'h9a; #20;
	d_in = 8'h1b; #20;
	d_in = 8'h66; #20;
	d_in = 8'h3e; #20;
	d_in = 8'h32; #20;
	d_in = 8'h6d; #20;
	d_in = 8'h81; #20;
	d_in = 8'hc; #20;
	
	r_en = 1'b0;
	d_in = 8'h3f; #20; //Write 120
	d_in = 8'h21; #20;
	r_en = 1'b1;
	d_in = 8'h58; #20;
	d_in = 8'h8a; #20;
	d_in = 8'h4d; #20;
	d_in = 8'ha; #20;
	d_in = 8'h53; #20;
	d_in = 8'h2c; #20;
	d_in = 8'h2b; #20;
	d_in = 8'h2f; #20;
	
	r_en = 1'b0;
	d_in = 8'h37; #20; //Write 130
	d_in = 8'he; #20;
	r_en = 1'b1;
	d_in = 8'h69; #20;
	d_in = 8'h70; #20;
	d_in = 8'h91; #20;
	d_in = 8'h8f; #20;
	d_in = 8'h1a; #20;
	d_in = 8'h9f; #20;
	d_in = 8'h5b; #20;
	d_in = 8'h9e; #20;
	
	r_en = 1'b0;
	d_in = 8'h48; #20; //Write 140
	d_in = 8'h95; #20;
	r_en = 1'b1;
	d_in = 8'h43; #20;
	d_in = 8'h8b; #20;
	d_in = 8'h3a; #20;
	d_in = 8'h61; #20;
	d_in = 8'h3c; #20;
	d_in = 8'h7b; #20;
	d_in = 8'h77; #20;
	d_in = 8'h39; #20;
	
	r_en = 1'b0;
	d_in = 8'h19; #20; //Write 150
	d_in = 8'h5e; #20;
	r_en = 1'b1;
	d_in = 8'h87; #20;
	d_in = 8'h7e; #20;
	d_in = 8'h5; #20;
	d_in = 8'h38; #20;
	d_in = 8'h1c; #20;
	d_in = 8'h9b; #20;
	d_in = 8'h3; #20;
	d_in = 8'h23; #20;
	d_in = 8'h9d; #20; //Write 160
	w_en = 1'b0; #400; //20 = 1clk cycle, Wait 20 clkcycl = 20*20 = #400

	casenum = 2'd0; //End of Test
	#1000;
	

//expected ['0x34', '0x15', '0x88', '0x33', '0x7a', '0x35', '0x4', '0x75', '0x64', '0xf', '0x14', '0x57', '0x2a', '0x79', '0x62', '0x17', '0x6e', '0x1', '0x0', '0x1d', '0xa0', '0x93', '0x74', '0x41', '0x98', '0x49', '0x56', '0x9', '0x92', '0x4b', '0x7c', '0x55', '0x16', '0x63', '0x5a', '0x7f', '0x46', '0x89', '0x68', '0x45', '0x40', '0x3d', '0x28', '0x73', '0x76', '0x71', '0x26', '0x2d', '0x54', '0x8d', '0x50', '0x67', '0x86', '0x25', '0x82', '0x7', '0x2', '0x27', '0x4e', '0x6b', '0x4a', '0x3b', '0x5c', '0x65', '0x6a', '0x83', '0x84', '0x6f', '0x42', '0x97', '0x9c', '0x47', '0x2e', '0x13', '0x8', '0xb', '0x8e', '0x4f', '0x96', '0x5f', '0x4c', '0x85', '0x12', '0x59', '0x1e', '0x29', '0x94', '0x5d', '0x10', '0x1f', '0x80', '0x31', '0x6', '0xd', '0x44', '0x51', '0x90', '0x11', '0x20', '0x99', '0x52', '0x7d', '0x8c', '0x1b', '0x30', '0x6d', '0x6c', '0x81', '0x22', '0x3f', '0x24', '0x21', '0x60', '0x4d', '0x78', '0x53', '0x72', '0x2b', '0x18', '0x2f', '0x9a', '0x37', '0x66', '0x69', '0x3e', '0x91', '0x32', '0x8f', '0xc', '0x9f', '0x58', '0x5b', '0x8a', '0x95', '0xa', '0x43', '0x2c', '0x8b', '0xe', '0x61', '0x70', '0x7b', '0x1a', '0x77', '0x9e', '0x39', '0x48', '0x19', '0x3a', '0x87', '0x3c', '0x5', '0x5e', '0x9b', '0x7e', '0x3', '0x38', '0x23', '0x1c', '0x9d']
	end



	//Waveform dumping
	initial begin
		$fsdbDumpvars();
	end


endmodule
