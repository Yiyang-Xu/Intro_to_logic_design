`timescale 1ns / 1ps

module TB_3;
  parameter half_period = 50;
  
  wire [3:0] Out;
  reg clk;
  
  HW5_3 UUT (Out,clk);
  initial begin
    #0 clk = 0;
 end
  
  always #half_period clk = ~clk;
  initial #2000 $stop;
endmodule
