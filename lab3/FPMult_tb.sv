`timescale 1ns / 1ps

module FPMult_tb_fp8_no_exceptions;

  // Inputs
  logic [7:0] a;
  logic [7:0] b;

  // Outputs
  logic [7:0] result;
  logic [4:0] flags;

  // Instantiate the Unit Under Test (UUT)
  FPMult uut (
    .a(a),
    .b(b),
    .result(result),
    .flags(flags)
  );

  // Testcase task
  task automatic test_case(input logic [7:0] ain, 
                           input logic [7:0] bin, 
                           input logic [7:0] expected, 
                           input string description);
    begin
      a = ain;
      b = bin;
      #1; // let result propagate
      $write("%s: ", description);
      $write("a = %b, b = %b -> result = %b (expected = %b)", a, b, result, expected);
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

// Test 1: 1.0 * 1.0 = 1.0
//   1.0  = 8'b01000000
//   1.0  = 8'b01000000
//   => 1.0 = 8'b01000000
test_case(8'b01000000, 8'b01000000, 8'b01000000, "Test 1: 1.0 * 1.0 = 1.0");

// Test 2: 1.5 * 1.5 = 2.25
//   1.5  = 8'b01001000
//   1.5  = 8'b01001000
//   => 2.25 = 8'b01010010
test_case(8'b01001000, 8'b01001000, 8'b01010010, "Test 2: 1.5 * 1.5 = 2.25");

// Test 3: 1.5 * 2.0 = 3.0
//   1.5  = 8'b01001000
//   2.0  = 8'b01010000
//   => 3.0 = 8'b01011000
test_case(8'b01001000, 8'b01010000, 8'b01011000, "Test 3: 1.5 * 2.0 = 3.0");

// Test 4: 0.75 * 2.0 = 1.5
//   0.75 = 8'b00111000
//   2.0  = 8'b01010000
//   => 1.5 = 8'b01001000
test_case(8'b00111000, 8'b01010000, 8'b01001000, "Test 4: 0.75 * 2.0 = 1.5");

// Test 5: 3.0 * 3.0 = 9.0
//   3.0 = 8'b01011000
//   3.0 = 8'b01011000
//   => 9.0 = 8'b01100010
test_case(8'b01011000, 8'b01011000, 8'b01100010, "Test 5: 3.0 * 3.0 = 9.0");

// Test 6: 0.5 * 0.5 = 0.25
//   0.5 = 8'b00110000
//   0.5 = 8'b00110000
//   => 0.25 = 8'b00100000
test_case(8'b00110000, 8'b00110000, 8'b00100000, "Test 6: 0.5 * 0.5 = 0.25");

// Test 7: 1.25 * 1.25 = 1.5625
//   1.25 = 8'b01000100
//   1.25 = 8'b01000100
//   => 1.5625 = 8'b01001001
test_case(8'b01000100, 8'b01000100, 8'b01001001, "Test 7: 1.25 * 1.25 = 1.5625");

// Test 8: 2.5 * 2.5 = 6.25
//   2.5 = 8'b01010100
//   2.5 = 8'b01010100
//   => 6.25 = 8'b01100100
test_case(8'b01010100, 8'b01010100, 8'b01100100, "Test 8: 2.5 * 2.5 = 6.25");

// Test 9: -1.5 * 2.0 = -3.0
//   -1.5 = 8'b11001000
//   +2.0 = 8'b01010000
//   => -3.0 = 8'b11011000
test_case(8'b11001000, 8'b01010000, 8'b11011000, "Test 9: -1.5 * 2.0 = -3.0");

// Test 10: -2.0 * -2.0 = 4.0
//   -2.0 = 8'b11010000
//   -2.0 = 8'b11010000
//   => +4.0 = 8'b01100000
test_case(8'b11010000, 8'b11010000, 8'b01100000, "Test 10: -2.0 * -2.0 = 4.0");

    $display("=== DONE ===");
    $finish;
  end

endmodule


