module fifo #(parameter DSIZE=8, parameter ASIZE=4)
(
	input [DSIZE-1:0] wdata,
	input winc, wclk, wrst_n,
	input rinc, rclk, rrst_n,
	
	output [DSIZE-1:0] rdata,
	output wfull,
	output rempty
);

	logic [ASIZE-1:0] waddr, raddr;
	logic [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
	
	sync_r2w sync_r2w (.*);
	sync_w2r sync_w2r (.*);
	
	//this one can't be .* because we set winc to wclken
	fifomem #(DSIZE, ASIZE) fifomem(.rdata(rdata), .wdata(wdata),
									.waddr(waddr), .raddr(raddr),
									.wclken(winc), .wfull(wfull),
									.wclk(wclk));

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
		if (wclken && !wfull) mem[waddr] <= wdata;

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
	output logic				rempty,
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
	
	
	//fifo almost empty should = wptr+4
	assign rempty_val = (rgraynext == rq2_wptr+3'h4);
	
	always_ff @(posedge rclk or negedge rrst_n) begin
		if (!rrst_n)
			rempty <= 1'b1;
		else
			rempty <= rempty_val;
	end
	
	
endmodule


module wptr_full	#(parameter ADDRSIZE = 4)
(
	input		[ADDRSIZE:0]		wq2_rptr,
	input							winc, wclk, wrst_n,
	output logic					wfull,
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
	assign wgraynexxt = (wbinnext>>1) ^ wbinnext;
	
	//needs to be changed for almost instead of full full
	assign wfull_val = (wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});
	
	always_ff @(posedge wclk or negedge wrst_n) begin
		if (!wrst_n)
			wfull <= 1'b0;
		else
			wfull <= wfull_val;
	end

endmodule





























