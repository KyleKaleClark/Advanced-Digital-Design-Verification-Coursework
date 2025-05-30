
module fifo_tb();

logic[7:0] wdata, rdata;
logic winc, wclk,wrst_n;
logic rinc, rclk, rrst_n;
logic wfull, rempty;
integer scenario_num;

fifo f1(.*);
	
	//clk logic
	//Write clock is 2x read clock
	
	always begin
		#5 wclk = ~wclk; #5;
	end
	always begin
		#10 rclk = ~rclk; #10;
	end

	task fifo_full_then_empty();
		wdata = 8'd1;
		wrst_n = 1'd0; rrst_n = 1'd0; rinc=1'd0; #10;
		wrst_n = 1'd1; rrst_n = 1'd1; winc=1'd1; #10
		#100;
		winc=1'd0; rinc=1'd1; #10;
		#100;
	endtask

	
	task fifo_rw();
		winc = 1'd1; rinc = 1'd1; #10
		#100;
	endtask

	
	
	initial begin
		if (!$test$plusargs("test")) begin
			$display("No test provided, exiting");
			$finish;
		end

		if (scenario_num == 1) begin
			fifo_full_then_empty();
			$display("Fifo write till full and read till empty test complete");
			$finish;
		end

		if (scenario_num ==2) begin
			fifo_rw();
			$display("Fifo simultaneous read and write test complete");
			$finish;
		end
	end

	initial begin
		$fsdbDumpvars();
	end

endmodule
