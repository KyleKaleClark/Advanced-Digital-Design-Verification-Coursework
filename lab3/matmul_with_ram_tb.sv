`timescale 1ns/1ns
module matmul_tb;

logic clk;
logic resetn;
logic pe_resetn;
logic start;
logic done;

matrix_multiplication u_matmul(
  .clk(clk), 
  .clk_mem(clk),
  .resetn(resetn), 
  .pe_resetn(pe_resetn), 
  .address_mat_a(11'b0),
  .address_mat_b(11'b0),
  .address_mat_c(11'b0),
  .address_stride_a(8'd4),
  .address_stride_b(8'd4),
  .address_stride_c(8'd4),
  .start(start),
  .done(done),
  );

initial begin
  clk = 0;
  forever begin
    #10 clk = ~clk;
  end
end

initial begin
  resetn = 0;
  pe_resetn = 0;
  #55;
  resetn = 1;
  pe_resetn = 1;
end

initial begin
  start = 0;
  #115 start = 1;
  @(posedge done);
  start = 0;
  #200;
  $finish;
end

//This code shows one method of initializing memory.
//Also, we are initializing all elements in both matrices to 1. 
initial begin
  for (int i=0; i<4; i++) begin
    for (int j=0; j<4; j++) begin
      u_matmul.matrix_A.ram[4*i + j] = 1'b1;
      u_matmul.matrix_B.ram[4*i + j] = 1'b1;
    end
  end
end


//This code shows another method of initializing memory.
//We have commented it out. You may want to remove the comments and try this testcase.
//Also, we are initializing the matrices as shown below. 
/*
//  A           B        Output       Output in hex
// 8 4 6 8   1 1 3 0   98 90 82 34    62 5A 52 22
// 3 3 3 7   0 1 4 3   75 63 51 26    4B 3F 33 1A
// 5 2 1 6   3 5 3 1   62 48 44 19    3E 30 2C 13
// 9 1 0 5   9 6 3 2   54 40 46 13    36 28 2E 0D

initial begin
  //A is stored in row major format
   u_matmul.matrix_A.ram[0]  = 8'h08;
   u_matmul.matrix_A.ram[1]  = 8'h03;
   u_matmul.matrix_A.ram[2]  = 8'h05;
   u_matmul.matrix_A.ram[3]  = 8'h09;
   u_matmul.matrix_A.ram[4]  = 8'h04;
   u_matmul.matrix_A.ram[5]  = 8'h03;
   u_matmul.matrix_A.ram[6]  = 8'h02;
   u_matmul.matrix_A.ram[7]  = 8'h01;
   u_matmul.matrix_A.ram[8]  = 8'h06;
   u_matmul.matrix_A.ram[9]  = 8'h03;
   u_matmul.matrix_A.ram[10] = 8'h01;
   u_matmul.matrix_A.ram[11] = 8'h00;
   u_matmul.matrix_A.ram[12] = 8'h08;
   u_matmul.matrix_A.ram[13] = 8'h07;
   u_matmul.matrix_A.ram[14] = 8'h06;
   u_matmul.matrix_A.ram[15] = 8'h05;
   //You could use this less verbose method of initializing memory as well.
  // u_matmul.matrix_A.ram[3:0] = '{32'h0506_0708, 32'h0001_0306, 32'h0102_0304, 32'h0905_0308};


  //B is stored in col major format
   u_matmul.matrix_B.ram[0]  = 8'h01;
   u_matmul.matrix_B.ram[1]  = 8'h01;
   u_matmul.matrix_B.ram[2]  = 8'h03;
   u_matmul.matrix_B.ram[3]  = 8'h00;
   u_matmul.matrix_B.ram[4]  = 8'h00;
   u_matmul.matrix_B.ram[5]  = 8'h01;
   u_matmul.matrix_B.ram[6]  = 8'h04;
   u_matmul.matrix_B.ram[7]  = 8'h03;
   u_matmul.matrix_B.ram[8]  = 8'h03;
   u_matmul.matrix_B.ram[9]  = 8'h05;
   u_matmul.matrix_B.ram[10] = 8'h03;
   u_matmul.matrix_B.ram[11] = 8'h01;
   u_matmul.matrix_B.ram[12] = 8'h09;
   u_matmul.matrix_B.ram[13] = 8'h06;
   u_matmul.matrix_B.ram[14] = 8'h03;
   u_matmul.matrix_B.ram[15] = 8'h02;
  // u_matmul.matrix_B.ram[3:0] = '{32'h0203_0609, 32'h0103_0503, 32'h0304_0100, 32'h0003_0101};

 
end
*/

//System Verilog allows even more ways of initializing memories. Try them if you want.
/*
logic [15:0] matA [15:0] = '{1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6};
logic [15:0] matB [15:0] = '{4,5,2,8,5,8,0,2,6,9,5,8,3,9,3,0};
*/


endmodule
