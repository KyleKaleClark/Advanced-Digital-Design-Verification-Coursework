
module fifo_tb();

logic[7:0] wdata, rdata;
logic winc, wclk,wrst_n;
logic rinc, rclk, rrst_n;
logic wfull, rempty,wfull_a,rempty_a;
integer scenario_num;

fifo f1(.*);
	
	//clk logic
	//Write clock is 4x read clock
	
	initial begin
		wclk=1'd0; #10;
		repeat (1000) begin
		#5 wclk = ~wclk; #5;
		end	
	end

	initial begin
		rclk=1'd0; #10;
		repeat (1000) begin
		#10 rclk = ~rclk; #10;
		end
	end
	
	//Set up for actual test
	//1st test is filling the fifo up with read disabled
	//Disables write and enables read to verify fifo empties
	//Last test enables read and write together
	
	initial begin
		//First test
		wrst_n =1'd0;rrst_n=1'd0;wdata=8'd1; winc=1'd0; rinc=1'd0; #500;
		wrst_n = 1'd1; rrst_n=1'd1; winc=1'd1;
		#20;
		wdata = 8'd2;
		#20;
		wdata = 8'd3;
		#20;
		wdata = 8'd4;
		#20;
		wdata = 8'd5;
		#20;
		wdata = 8'd6;
		#20;
		wdata = 8'd7;
		#20;
		wdata = 8'd8;
		#20;
		wdata = 8'd9;
		#20;
		wdata = 8'd10;
		#20;
		wdata = 8'd11;
		#20;
		wdata = 8'd12;
		#20;
		wdata = 8'd13;
		#20;
		wdata = 8'd14;
		#20;
		wdata = 8'd15;
		#20;
		wdata = 8'd1;
		#20;
		wdata = 8'd2;
		#20;
		//End of first test
		//
		//Start of Second test
		winc=1'd0; rinc=1'd1; #1000;
		//End of second test
		//
		//Start of third test
		wrst_n=1'd0; rrst_n=1'd0; rinc=1'd0;  #60;
		wrst_n=1'd1; rrst_n=1'd1; #60;
		winc=1'd1; rinc=1'd1;  wdata= 8'd1; #20;
		wdata = 8'd2; #20;
		wdata = 8'd3; #20;
		wdata = 8'd4; #20;
		wdata = 8'd5; #20;
		wdata = 8'd6; #20;
		wdata = 8'd7; #20;
		wdata = 8'd8; #20;
		wdata = 8'd9; #20;
		wdata = 8'd10; #20;
		wdata = 8'd11; #20;
		wdata = 8'd12; #20;
		wdata = 8'd13; #20;
		wdata = 8'd14; #20;
		wdata = 8'd15; #20;
		//End of third test
	end

	initial begin
		$fsdbDumpvars();
	end

endmodule
