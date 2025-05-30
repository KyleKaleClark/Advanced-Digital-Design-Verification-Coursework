
module fifo_tb();

logic[7:0] wdata, rdata;
logic winc, wclk,wrst_n;
logic rinc, rclk, rrst_n;
logic wfull, rempty,wfull_a,rempty_a;
integer scenario_num;

fifo f1(.*);
	
	//clk logic
	//Write clock is 2x read clock
	
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

	initial begin
		wrst_n =1'd0;rrst_n=1'd0;wdata=8'd1; winc=1'd0; rinc=1'd0; #50;
		wrst_n = 1'd1; rrst_n=1'd1; winc=1'd1; #10;
		#1000;
		winc=1'd0; rinc=1'd1; #10;
		#1000
		winc=1'd1; #10;
		#1000;
	
	end

	initial begin
		$fsdbDumpvars();
	end

endmodule
