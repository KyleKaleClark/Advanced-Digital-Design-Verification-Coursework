module fifo #(parameter DSIZE=8, parameter ASIZE=4)
(
	input [DSIZE-1:0] wdata,
	input winc, wclk, wrst_n,
	input rinc, rclk, rrst_n,
	
	output [DSIZE-1:0] rdata,
	output wfull, wfull_a,
	output rempty, rempty_a
);

	logic [ASIZE-1:0] waddr, raddr;
	logic [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
	
	
	//synchronizer blocks
	sync_r2w #(.ADDRSIZE(ASIZE)) sync_r2w (.rptr(rptr), .wclk(wclk), .wrst_n(wrst_n), .wq2_rptr(wq2_rptr));
	sync_w2r #(.ADDRSIZE(ASIZE)) sync_w2r (.wptr(wptr), .rclk(rclk), .rrst_n(rrst_n), .rq2_wptr(rq2_wptr));
	
	//this one can't be .* because we set winc to wclken
	fifomem #(DSIZE, ASIZE) fifomem(.rdata(rdata), .wdata(wdata),
									.waddr(waddr), .raddr(raddr),
									.wclken(winc), .wfull(wfull),
									.wclk(wclk));

	//empty/full signal blocks
	rptr_empty #(ASIZE) rptr_empty(.*);
	wptr_full #(ASIZE) wptr_full(.*);

endmodule	


module fifomem #(	parameter DATASIZE = 8,
					parameter ADDRSIZE = 4)
(
	input [DATASIZE-1:0] 	wdata, 
	input [ADDRSIZE-1:0] 	waddr, raddr,
	input 					wclken, wfull, wclk,
	output [DATASIZE-1:0]	rdata
);

	localparam DEPTH = 1<<ADDRSIZE;
	logic [DATASIZE-1:0] mem [0:DEPTH-1];
	
	assign rdata = mem[raddr];
	
	always_ff @(posedge wclk)
	  `ifdef BUG
	      if (wclken && !wfull && waddr%DEPTH-4 !=0 ) begin
		 mem[waddr] <= wdata;
	      end
	  `else
              if (wclken && !wfull) begin
		 mem[waddr] <= wdata;
	      end
	  `endif

endmodule


module sync_r2w #(parameter ADDRSIZE=4)
(
	input 			[ADDRSIZE:0]	rptr,
	input							wclk, wrst_n,
	output logic 	[ADDRSIZE:0]	wq2_rptr
);

	logic [ADDRSIZE:0] wq1_rptr;

	always_ff @(posedge wclk or negedge wrst_n) begin
		if (!wrst_n)
			{wq2_rptr, wq1_rptr} <= 0;
		else
			{wq2_rptr, wq1_rptr} <= {wq1_rptr, rptr};
	end

endmodule

module sync_w2r #(parameter ADDRSIZE=4)
(
	input		[ADDRSIZE:0] 	wptr,
	input 						rclk, rrst_n,
	output logic [ADDRSIZE:0]	rq2_wptr
);

	logic [ADDRSIZE:0] rq1_wptr;

	always_ff @(posedge rclk or negedge rrst_n) begin
		if (!rrst_n)
			{rq2_wptr, rq1_wptr} <= 0;
		else
			{rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
	end
	
endmodule


module rptr_empty #(parameter ADDRSIZE = 4)
(
	input		[ADDRSIZE:0]	rq2_wptr,
	input						rinc, rclk, rrst_n,
	output logic [ADDRSIZE:0]	rptr,
	output logic				rempty, rempty_a,
	output 		[ADDRSIZE-1:0]	raddr
);

	logic [ADDRSIZE:0] rbin;
	logic [ADDRSIZE:0] rgraynext, rbinnext;
	
	//Gray Pointer
	always_ff @(posedge rclk or negedge rrst_n) begin
		if (!rrst_n)
			{rbin, rptr} <= 0;
		else
			{rbin, rptr} <= {rbinnext, rgraynext};
	end
	
	assign raddr = rbin[ADDRSIZE-1:0];
	assign rbinnext = rbin + (rinc & ~rempty);
	assign rgraynext = (rbinnext>>1) ^ rbinnext;
	
	
	//empty values
	assign rempty_val = (rgraynext == rq2_wptr);
	
	//almost empty is always when rq2_wptr top 4 MSB = 0 101... because of mathmatical reasons, so we flip those to match the max gray value of 1 000
	//and thats when we know we're 3/4th of the way through dumping the data
	assign rempty_almost_val = (rgraynext[ADDRSIZE:ADDRSIZE-2] == {~rq2_wptr[ADDRSIZE], rq2_wptr[ADDRSIZE-1], rq2_wptr[ADDRSIZE-2]} | rempty_val);
	 
	
	always_ff @(posedge rclk or negedge rrst_n) begin
		if (!rrst_n) begin
			rempty <= 1'b1;
			rempty_a <= 1'b0;
		end
		else begin
			rempty <= rempty_val;
			rempty_a <= rempty_almost_val;
		end
	end
	
	
endmodule


module wptr_full	#(parameter ADDRSIZE = 4)
(
	input		[ADDRSIZE:0]		wq2_rptr,
	input							winc, wclk, wrst_n,
	output logic					wfull, wfull_a,
	output		[ADDRSIZE-1:0]		waddr,
	output logic [ADDRSIZE:0]		wptr
);

	logic	[ADDRSIZE:0] wbin;
	logic	[ADDRSIZE:0] wgraynext, wbinnext;
	
	always_ff @(posedge wclk or negedge wrst_n) begin
		if (!wrst_n)
			{wbin, wptr} <= 0;
		else
			{wbin, wptr} <= {wbinnext, wgraynext};
	end
	
	//memory write
	assign waddr = wbin[ADDRSIZE-1:0];
	
	assign wbinnext = wbin + (winc & ~wfull);
	assign wgraynext = (wbinnext>>1) ^ wbinnext;
	
	//buffer full signal
	assign wfull_val = (wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});
	
	//almost full = when gray = A, so we have to match wq2rptr, which happens with top 4 MSB = 0 10, so we have to invert the all 0s to = 0 10, hence . ~. OR if its just full, b/c almost full is full
	assign wfull_almost_val = (wgraynext[ADDRSIZE:ADDRSIZE-2] == {wq2_rptr[ADDRSIZE], ~wq2_rptr[ADDRSIZE-1], wq2_rptr[ADDRSIZE-2]} | wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});
	
	
	always_ff @(posedge wclk or negedge wrst_n) begin
		if (!wrst_n) begin
			wfull <= 1'b0;
			wfull_a <= 1'b0;
		end
		else begin
			wfull <= wfull_val;
			wfull_a <= wfull_almost_val;			
		end
	end

endmodule





























