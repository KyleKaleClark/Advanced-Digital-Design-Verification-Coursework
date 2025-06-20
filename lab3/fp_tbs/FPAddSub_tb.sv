`timescale 1ns / 1ps

module FPAdd_tb_fp8_no_exceptions;

  // Inputs
  logic [7:0] a;
  logic [7:0] b;
  logic operation;

  // Outputs
  logic [7:0] result;
  logic [4:0] flags;

  // Instantiate the Unit Under Test (UUT)
  FPAddSub uut (
    .a(a),
    .b(b),
    .operation(operation),
    .result(result),
    .flags(flags)
  );

  // Testcase task
  task automatic test_case(input logic [7:0] ain, 
                           input logic [7:0] bin,
			   input logic operation_in, 
                           input logic [7:0] expected, 
                           input string description);
    begin
      a = ain;
      b = bin;
      operation = operation_in;
      #1; // let result propagate
      $write("%s: ", description);
      $write("a = %h, b = %h -> result = %h (expected = %h)", a, b, result, expected);
      if (result === expected && flags == 5'b00000) begin
        $display(" ✅ PASS");
      end else begin
        $display(" ❌ FAIL");
      end
    end
  endtask

  initial begin
    $display("=== SystemVerilog FP8 Multiply Testbench (No Exceptions) ===");

    // Format: 1 sign | 3 exponent | 4 mantissa | bias = 3

// Test 1: 1.0 + 1.0 = 1.0
test_case(8'b0_011_0000, 8'b0_011_0000, 1'b0, 8'b0_100_0000, "Test 1: 1.0 + 1.0 = 2.0");

// Test 2: 1.0 - 1.0 = 0.0
test_case(8'b0_011_1000, 8'b0_011_1000, 1'b1, 8'b0_000_0000, "Test 2: 1.0 - 1.0 = 0.0");

// Test 3: 1.5 + 2.0 = 3.5
test_case(8'b0_011_1000, 8'b0_100_0000, 1'b0, 8'b0_100_1100, "Test 3: 1.5 + 2.0 = 3.5");

// Test 4: 0.0 + 2.0 = 2.0
test_case(8'b0_000_0000, 8'b0_100_0000, 1'b0, 8'b0_100_0000, "Test 4: 0.0 + 2.0 = 2.0");

// Test 5: 3.5 + 4.5 = 8.0
test_case(8'b0_100_1100, 8'b0_101_0010, 1'b0, 8'b0_110_0000, "Test 5: 3.5 + 4.5 = 8.0");     

// Test 4: inf * 2.0 = inf
test_case(8'b0_111_0000, 8'b0_100_0000, 1'b0, 8'b0_111_0000, "Test 4: 0.75 * 2.0 = 1.5");


// Test 4: inf * 2.0 = inf
test_case(8'h40, 8'h48, 1'b0, 8'h54, "Test xx: x40+x48 = x54");
// Test 4: inf * 2.0 = inf
test_case(8'h54, 8'h40, 1'b0, 8'h5c, "Test xx: x54+x40 = x5C");
// Test 4: inf * 2.0 = inf
test_case(8'h5c, 8'h30, 1'b0, 8'h60, "Test xx: x5C+x30 = x60");


/*
// Test 5: 3.0 * 3.0 = 9.0
test_case(8'b0_100_1000, 8'b0_100_1000, 8'b0_110_0010, "Test 5: 3.0 * 3.0 = 9.0");

// Test 6: 0.5 * 0.5 = 0.25
test_case(8'b0_010_0000, 8'b0_010_0000, 8'b0_001_0000, "Test 6: 0.5 * 0.5 = 0.25");

// Test 7: 1.25 * 1.25 = 1.5625
test_case(8'b0_011_0100, 8'b0_011_0100, 8'b0_011_1001, "Test 7: 1.25 * 1.25 = 1.5625");

// Test 8: 2.5 * 2.5 = 6.25
test_case(8'b0_100_0100, 8'b0_100_0100, 8'b0_101_1001, "Test 8: 2.5 * 2.5 = 6.25");

// Test 9: -1.5 * 2.0 = -3.0
test_case(8'b1_011_1000, 8'b0_100_0000, 8'b1_100_1000, "Test 9: -1.5 * 2.0 = -3.0");

// Test 10: -2.0 * -2.0 = 4.0
test_case(8'b1_100_0000, 8'b1_100_0000, 8'b0_101_0000, "Test 10: -2.0 * -2.0 = 4.0");

// Test 11: inf * 0 = NaN
test_case(8'b0_111_0000, 8'b0_000_0000, 8'b0_111_1111, "Test 11: inf * 0 = NaN");

// Test 12: 0 * 0 = 0
test_case(8'b0_000_0000, 8'b0_000_0000, 8'b0_000_0000, "Test 12: 0 * 0 = 0");

// Test 13: 1 * inf = inf
test_case(8'b0_011_0000, 8'b0_111_0000, 8'b0_111_0000, "Test 13: 1 * inf = inf");     
     */
    $display("=== DONE ===");
    $finish;
  end




   initial begin
      $fsdbDumpvars();
      #1_000;
      $display("ERROR ERROR timeout....");
      $finish;
      
      
   end




   
endmodule

