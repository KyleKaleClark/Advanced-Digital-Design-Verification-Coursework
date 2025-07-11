import "DPI-C" function int push(int wdata);
import "DPI-C" function int pop();
import "DPI-C" function int rst_r_ptr();
import "DPI-C" function int rst_w_ptr();
import "DPI-C" function int is_empty();
import "DPI-C" function int is_full();
import "DPI-C" function int get_r_ptr();
import "DPI-C" function int get_w_ptr();



interface fifo_write_if #(parameter DSIZE=8) (input logic wclk);

   logic [DSIZE-1:0] wdata;
   logic 	     winc;
   logic 	     wrst_n;
   logic 	     wfull;
   logic 	     wfull_a;

endinterface // fifo_write_if

interface fifo_read_if #(parameter DSIZE=8) (input logic rclk);

   logic [DSIZE-1:0] rdata;
   logic 	    rinc;
   logic 	    rrst_n;
   logic 	    rempty;
   logic 	    rempty_a;

endinterface // fifo_read_if


class transaction;

   bit [7:0] 	    wdata;
   bit [7:0] 	    rdata;
   bit 		    winc;
   bit 		    wrst_n;
   bit 		    rinc;
   bit 		    rrst_n;

   function new();
   endfunction // new
   
   
endclass // transaction



  
module checker(input wrst_n, rrst_n, wclk, rclk, winc, rinc, wfull, rempty, input [7:0] wdata, rdata);

   logic [7:0] dpi_read;
   logic       g_empty, g_full;
   logic [7:0] r_ptr, w_ptr;


   //complete writes
   always_ff @(posedge wclk) begin
      if (winc) begin
	 push(wdata);
	 $display(" PUSH: %h", wdata);
      end
      if (wrst_n == 0)
	rst_w_ptr();
   end


   //check reads
   always_ff @(posedge rclk) begin
      if (rinc) begin
	 //dpi_read = pop
	 dpi_read = pop();
	 if (dpi_read == rdata)
	   $display("Successful Read: Golden data: %h", dpi_read, " || DUT: %h", rdata);
	 else
	   $display("FAIL!! Read: Golden data: %h", dpi_read, " || DUT: %h", rdata);
      end

      if (rrst_n == 0)
	rst_r_ptr();
   end


   //update pointers and flags
   always_ff @(posedge wclk or posedge rclk) begin
      g_empty = is_empty();
      g_full = is_full();
      r_ptr = get_r_ptr();
      w_ptr = get_w_ptr();
   end

   //Display Statements
   always_ff @(posedge wfull or posedge rempty) begin
      $display("g_full: ", g_full, " || wfull: ", wfull);
      $display("g_empty: ", g_empty, " || rempty: ", rempty);
      $display("wptr:  ", w_ptr, " || rptr: ", r_ptr);	   

      if (g_empty) begin
	 if (g_empty == rempty) begin
	    $display("Successful Empty Read!");
	    $display("-----------------------------------------\n");
	 end
	 else begin
	    $display("FAIL!! Empty mismatch");
	    $display("-----------------------------------------\n");
	 end
      end // if (g_empty)

      if (g_full) begin
	 if (g_full == wfull) begin
	    $display("Sucessful Full Read!");
	    $display("-----------------------------------------\n");
	 end
	 else begin
	    $display("FAIL!! Full mismatch");
	    $display("-----------------------------------------\n");
	 end
      end     
      $display("-----------------------------------------\n"); 
   end
   

endmodule // checker


class monitor;

   virtual fifo_write_if wr_vif;
   virtual fifo_read_if rd_vif;

   mailbox #(transaction) txn_mail;
   transaction txn;

   function new(virtual fifo_write_if wr_vif, virtual fifo_read_if rd_vif);
      this.wr_vif = wr_vif;
      this.rd_vif = rd_vif;
   endfunction // new

   task run();
      fork
	 monitor_write();
	 monitor_read();
      join_none
   endtask // run


   task monitor_write();
      forever begin
      @(posedge wr_vif.wclk);
      if (wr_vif.winc && !wr_vif.wfull) begin
	 txn = new();
	 txn.wdata = wr_vif.wdata;
	 txn.winc = wr_vif.winc;
	 txn.wrst_n = wr_vif.wrst_n;
	 txn.rinc = 1'b0;
	 txn.rrst_n = rd_vif.rrst_n;

	 //mail time
	 txn_mail.put(txn);
      end // if (wr_vif.winc && !wr_vif.wfull)
      end // forever begin
      
   endtask // monitor_write

   task monitor_read();
      forever begin
      @(posedge rd_vif.rclk);
      if (rd_vif.rinc && !rd_vif.rempty) begin
	 txn = new();
	 txn.rdata = rd_vif.rdata;
	 txn.wdata = 8'h00;
	 txn.winc = 1'b0;
	 txn.wrst_n = wr_vif.wrst_n;
	 txn.rinc = rd_vif.rinc;
	 txn.rrst_n = rd_vif.rrst_n;
	 
	 txn_mail.put(txn);
      end
      end // forever begin
   endtask // monitor_read

endclass // monitor



class scoreboard;

   mailbox #(transaction) txn_mail;
   transaction txn;

   bit [7:0] fifo_q[$:16];


   function new();
   endfunction // new
   
   task run();
      forever begin
	 txn_mail.get(txn);
	 
	 if (txn.winc && !txn.rinc) begin
	    fifo_q.push_back(txn.wdata);
	    $display("scoreboard: write: wdata= 0x%02h", txn.wdata);
	 end
	 else if(txn.rinc && !txn.winc) begin
	    if (fifo_q.size() == 0) begin
	       $display("FAIL!! read from empty fifo");
	    end
	    else begin
	       bit [7:0] exp_res = fifo_q.pop_front();
	       if (txn.rdata == exp_res) begin
		  $display("scoreboard: Successful read: DUT rdata=0x%02h", txn.rdata, " ||  SB queue rdata=0x%02h", exp_res);
	       end
	       else begin
		  $display("FAIL!! read failure: DUT rdata=0x%02h, SB queue rdata=0x%02h", txn.rdata, exp_res);
	       end
	    end
	 end
      end
   endtask // run
   

endclass // scoreboard





module fifo_tb();

   logic wclk, rclk;
   
/*   
logic[7:0] wdata, rdata;
logic winc, wclk,wrst_n;
logic rinc, rclk, rrst_n;
logic wfull, rempty,wfull_a,rempty_a;
*/
   
   integer scenario_num;

   parameter DSIZE = 8;
   parameter ASIZE = 4;

   fifo_write_if #(.DSIZE(DSIZE)) wr_if(wclk);
   fifo_read_if  #(.DSIZE(DSIZE)) rd_if(rclk);
   
   
   fifo #(.DSIZE(DSIZE), .ASIZE(ASIZE)) f1(
					   .wdata(wr_if.wdata),
					   .winc(wr_if.winc),
					   .wclk(wclk),
					   .wrst_n(wr_if.wrst_n),
					   .wfull(wr_if.wfull),
					   .wfull_a(wr_if.wfull_a),

					   .rdata(rd_if.rdata),
					   .rinc(rd_if.rinc),
					   .rclk(rclk),
					   .rrst_n(rd_if.rrst_n),
					   .rempty(rd_if.rempty),
					   .rempty_a(rd_if.rempty_a)
					   );  

//checker from pt 1
//   checker checker_inst(.wrst_n(wr_if.wrst_n), .rrst_n(rd_if.rrst_n), .wclk(wclk), .rclk(rclk), .winc(wr_if.winc), .rinc(rd_if.rinc), .wfull(wr_if.wfull), .rempty(rd_if.rempty), .wdata(wr_if.wdata), .rdata(rd_if.rdata));
   
	
	//clk logic
	//Write clock is 4x read clock


   mailbox #(transaction) txn_mail;
   monitor mon;
   scoreboard sb;

   initial begin
      txn_mail = new();
      mon = new(wr_if, rd_if);
      sb = new();
      mon.txn_mail = txn_mail;
      sb.txn_mail = txn_mail;
      fork
	 mon.run();
	 sb.run();
      join
   end
   

   
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
		//First test .wr_if.
		wr_if.wrst_n =1'd0; rd_if.rrst_n=1'd0; wr_if.wdata=8'd1; wr_if.winc=1'd0; rd_if.rinc=1'd0; #500;
		wr_if.wrst_n = 1'd1; rd_if.rrst_n=1'd1; wr_if.winc=1'd1;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd2;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd3;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd4;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd5;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd6;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd7;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd8;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd9;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd10;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd11;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd12;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd13;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd14;
		#20;
	        wr_if.winc = 0;
	        #20;
                wr_if.winc = 1;	   
		wr_if.wdata = 8'd15;
		#40;
		//End of first test
	        wr_if.winc=1'd0; rd_if.rinc=1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	        rd_if.rinc = 1'd1; #40;
	        rd_if.rinc = 1'd0; #40;	   
	   
	    
		//End of second test
		//
		//Start of third test
/*		wr_if.wrst_n=1'd0; rd_if.rrst_n=1'd0; rd_if.rinc=1'd0;  #60;
		wr_if.wrst_n=1'd1; rd_if.rrst_n=1'd1; #60;
		wr_if.winc=1'd1; rd_if.rinc=1'd1;  wr_if.wdata= 8'd1; #20;
		wr_if.wdata = 8'd2; #20;
		wr_if.wdata = 8'd3; #20;
		wr_if.wdata = 8'd4; #20;
		wr_if.wdata = 8'd5; #20;
		wr_if.wdata = 8'd6; #20;
		wr_if.wdata = 8'd7; #20;
		wr_if.wdata = 8'd8; #20;
		wr_if.wdata = 8'd9; #20;
		wr_if.wdata = 8'd10; #20;
		wr_if.wdata = 8'd11; #20;
		wr_if.wdata = 8'd12; #20;
		wr_if.wdata = 8'd13; #20;
		wr_if.wdata = 8'd14; #20;
		wr_if.wdata = 8'd15; #20;
		//End of third test */
	        rd_if.rinc = 0;
	   
	end

	initial begin
		$fsdbDumpvars();
	end

endmodule
