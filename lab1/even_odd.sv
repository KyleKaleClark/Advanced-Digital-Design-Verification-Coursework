module even_odd
(
	input 	clk, reset, w_en, r_en,
	input 	[7:0] d_in,
	output logic 	[7:0] d_out
);

	logic even_wen, odd_wen;
	logic even_ren, odd_ren;
	logic[7:0] even_dout, odd_dout;
	logic even_wfull, even_wfull_a, even_rempty, even_rempty_a;
	logic odd_wfull, odd_full_a, odd_rempty, odd_rempty_a;

	//Instantiations of Even and Odd registers. 
	//Address size of 7 to ensure depth is large
	//enough to hold 40 pieces of 8bit data
	
	fifo #(8,7) even(.wdata(d_in), .winc(even_wen), .rinc(even_ren), .wclk(clk), .rclk(clk),
		.wrst_n(reset), .rrst_n(reset), .wfull(even_wfull), .wfull_a(even_wfull_a), .rempty(even_rempty),
		.rempty_a(even_rempty_a), .rdata(even_dout));

	fifo #(8,7) odd(.wdata(d_in), .winc(odd_wen), .rinc(odd_ren), .wclk(clk), .rclk(clk),
		.wrst_n(reset), .rrst_n(reset), .wfull(odd_wfull), .wfull_a(odd_wfull_a), .rempty(odd_rempty),
		.rempty_a(odd_rempty_a), .rdata(odd_dout));

	//Write enable logic
	//Checks LSB of the input data, if it is 1, the data is odd 
	assign even_wen = (d_in[0] == 0) ? 1'd1: 1'd0;
	assign odd_wen = (d_in[0] == 1) ? 1'd1: 1'd0;

	
	//FSM for switching between reading even and odd
	//Will always start with reading even
	
	logic [1:0] state, next_state;

	always_ff @ (posedge clk or negedge reset)

		if (~reset)
			d_out <= 8'd0;
		else if (even_ren)
			d_out <= even_dout;
		else if (odd_ren)
			d_out <= odd_dout;
		else
			d_out <= 8'dx;

	localparam RESET = 2'd00;
	localparam READ_EVEN = 2'd01;
	localparam READ_ODD = 2'd10;

	always_ff @ (posedge clk or negedge reset)

		if (~reset)
			state <= RESET;
		else 
			state <= next_state;

	always_comb begin
		next_state = RESET; even_ren = 1'd0; odd_ren = 1'd0;

		unique case (state)
	
			RESET: begin
				even_ren = 1'd0;
				odd_ren = 1'd0;
				next_state = READ_EVEN;
			end	

			READ_EVEN: begin
				even_ren = r_en;
				odd_ren = 1'd0;
				next_state = READ_ODD;
			end

			READ_ODD: begin
				even_ren = 1'd0;
				odd_ren = r_en;
				next_state = READ_EVEN;
			end
		endcase
	end

endmodule
