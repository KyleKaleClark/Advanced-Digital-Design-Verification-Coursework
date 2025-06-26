
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

   bit 		    wfull;
   bit 		    rempty;
   

   function new();
   endfunction // new
   
   
endclass // transaction

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
      if ((wr_vif.winc && !wr_vif.wfull) || !wr_vif.wrst_n) begin
	 txn = new();
	 txn.wdata = wr_vif.wdata;
	 txn.winc = wr_vif.winc;
	 txn.wrst_n = wr_vif.wrst_n;
	 txn.rinc = 1'b0;
	 txn.rrst_n = rd_vif.rrst_n;
	 
	 txn.wfull = wr_vif.wfull;
	 txn.rempty = rd_vif.rempty;

	 //mail time
	 txn_mail.put(txn);
      end // if (wr_vif.winc && !wr_vif.wfull)
      end // forever begin
      
   endtask // monitor_write

   task monitor_read();
      forever begin
      @(posedge rd_vif.rclk);
      if ((rd_vif.rinc && !rd_vif.rempty) || !rd_vif.rrst_n) begin
	 txn = new();
	 txn.rdata = rd_vif.rdata;
	 txn.wdata = 8'h00;
	 txn.winc = 1'b0;
	 txn.wrst_n = wr_vif.wrst_n;
	 txn.rinc = rd_vif.rinc;
	 txn.rrst_n = rd_vif.rrst_n;

	 txn.wfull = wr_vif.wfull;
	 txn.rempty = rd_vif.rempty;
	 
	 //mail time	 
	 txn_mail.put(txn);
      end
      end // forever begin
   endtask // monitor_read

endclass // monitor



class scoreboard;


   localparam FIFO_DEPTH = 16;
   
   
   mailbox #(transaction) txn_mail;
   transaction txn;

   bit [7:0] fifo_q[$:FIFO_DEPTH];


   function new();
   endfunction // new
   
   task run();
      logic full;
      logic empty;

      forever begin
	 txn_mail.get(txn);
	 //some debugs
//	 $display("scoreboard queue: %p - size: %0d", fifo_q, fifo_q.size());
//	 $display("resets: rrst_n:", txn.rrst_n, " || wrst_n: ", txn.wrst_n);
	 
	 //this seems crazy, but we have to account for the double delay that the empty signal takes for when it
	 //gets set in the fifo
	 empty = (fifo_q.size() < 3) ? 1 : 0;

	 //we have to do the same stuff but to account for the full in the opposite way
	 full = (fifo_q.size() > (FIFO_DEPTH-2)) ? 1 : 0;
	 
	 //full/empty checks
	 if (txn.rempty) begin
	    if (txn.rempty == empty)
	      $display("scoreboard: Successful Empty Read, DUT rempty: ", txn.rempty, " || SB: ", empty);
	    else
	      $display("FAIL!! Mismatch Empty Flags - DUT rempty: ", txn.rempty, " || SB: ", empty);
	 end
	 

	 if (txn.wfull) begin
	    if (txn.wfull == full)
	      $display("scoreboard: Successful Full Read, DUT wfull: ", txn.wfull, " || SB: ", full);
	    else
	      $display("FAIL!! Mismatch Full Flags - DUT wfull: ", txn.wfull, " || SB: ", full);
	 end
	 
	 if (!txn.rrst_n && !txn.wrst_n) begin
//	    $display("!!!queue prereset: %p (size: %0d)", fifo_q, fifo_q.size());
	    fifo_q = {};
//	    $display("!!!queue post: %p (size: %0d)", fifo_q, fifo_q.size());
	 end
	 
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
	   wr_if.wrst_n =1'd0; rd_if.rrst_n=1'd0; wr_if.wdata=8'd1; wr_if.winc=1'd0; rd_if.rinc=1'd0; #100;
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
	   rd_if.rinc = 1'd1; #40; //0
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; // 2
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; // 4
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; // 
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //6
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //8
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //10
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; // 12
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //14
	   rd_if.rinc = 1'd0; #40;	   
	   rd_if.rinc = 1'd1; #40; //15
	   rd_if.rinc = 1'd0; #40;	   
	   
	   
	   //End of second test
	   //

	   //Start of third test
	   wr_if.wrst_n=1'd0; rd_if.rrst_n=1'd0; rd_if.rinc=1'd0;  #100;
	   wr_if.wrst_n=1'd1; rd_if.rrst_n=1'd1; #60;

	   $display("TEST 2---------------------------------");
	   

	   wr_if.winc = 0; #20;	                 //items in fifo
	   wr_if.winc = 1; wr_if.wdata = 8'h0; #20; //0 +1
	   wr_if.winc = 0; #20;
	   wr_if.winc = 1; wr_if.wdata = 8'h1; #20; //1 +1
	   wr_if.winc = 0; #20;
	   wr_if.winc = 1; wr_if.wdata = 8'h2; #20; //2 +1 
	   wr_if.winc = 0; #20;
	   wr_if.winc = 1; wr_if.wdata = 8'h3; #20; //3 +1 = 4
	   wr_if.winc = 0; #20;

	   wr_if.winc = 1; wr_if.wdata = 8'h4; #20; //4 +1 -1 = 4
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h5; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h6; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h7; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h8; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h9; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'ha; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hb; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hc; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hd; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'he; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hf; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'he; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hd; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hc; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hb; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'ha; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h9; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'h8; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'ha; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
   	   wr_if.winc = 1; wr_if.wdata = 8'hc; #20; 
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'he; #20; 
	   wr_if.winc = 0; rd_if.rinc = 0; #20;
	   	   
	   wr_if.winc = 1; wr_if.wdata = 8'hd; #20; //--full
	   wr_if.winc = 0; rd_if.rinc = 1; #20;
	   	   
	   //a ton of reads so we can just empty it out lol
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

	   
	   wr_if.wrst_n=1'd0; rd_if.rrst_n=1'd0; rd_if.rinc=1'd0;  #20;
	   wr_if.wrst_n=1'd1; rd_if.rrst_n=1'd1; #20;
	   
	end

	initial begin
		$fsdbDumpvars();
	end

endmodule
