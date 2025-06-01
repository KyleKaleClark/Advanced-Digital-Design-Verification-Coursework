`timescale 1ns/1ps


module even_odd_tb();

	logic clk, reset, w_en, r_en;
	logic [7:0] d_in, d_out;

	even_odd eo (.*);


	initial begin
		clk=1'd0; #10;
		repeat (1000) begin
		#5 clk = ~clk; #5;
		end	
	end



	initial begin

	//Test 1, feed in all Even numbers then all Odd, and see them sort.
	
	w_en = 1'b0; r_en = 1'b0; reset = 1'b0; #200;
	w_en = 1'b1; r_en = 1'b0; reset = 1'b1; #20;
	//data stream
	d_in = 8'd0; #20;
	d_in = 8'd2; #20;
	d_in = 8'd4; #20;
	d_in = 8'd6; #20;
	d_in = 8'd8; #20;
	d_in = 8'd10; #20;
	d_in = 8'd12; #20;
	d_in = 8'd14; #20;
	d_in = 8'd1; #20;
	d_in = 8'd3; #20;
	d_in = 8'd5; #20;
	d_in = 8'd7; #20;
	d_in = 8'd9; #20;
	d_in = 8'd11; #20;
	d_in = 8'd13; #20;
	d_in = 8'd15; #20;

	#100;
	//small separation, then a long wait after enabling read
	w_en = 1'b0; r_en = 1'b1; #1000;
	//expected output = [1,2,3,4,..15] just in order
	
	
	//Test 2, mixed around input data couting downward
	w_en = 1'b0; r_en = 1'b0; reset = 1'b1; #200;
	w_en = 1'b1; r_en = 1'b0; reset = 1'b0; #20;
	d_in = 8'd15; #20;
	d_in = 8'd13; #20;
	d_in = 8'd11; #20;
	d_in = 8'd14; #20;
	d_in = 8'd12; #20;
	d_in = 8'd10; #20;
	d_in = 8'd9; #20;
	d_in = 8'd8; #20;
	d_in = 8'd7; #20;
	d_in = 8'd6; #20;
	d_in = 8'd4; #20;
	d_in = 8'd2; #20;
	d_in = 8'd5; #20;
	d_in = 8'd3; #20;
	d_in = 8'd1; #20;
	d_in = 8'd0; #20;
	#100;
	//small separation, then a long wait after enabling read
	w_en = 1'b0; r_en = 1'b1; #1000;
	//expected output = [15, 14, 13, ..., 1]
	end


	//Waveform dumping
	initial begin
		$fsdbDumpvars();
	end


endmodule
