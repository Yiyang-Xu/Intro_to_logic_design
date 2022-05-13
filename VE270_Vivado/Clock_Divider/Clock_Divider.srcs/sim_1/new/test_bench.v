
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/02 12:34:52
`timescale 1ns / 1ps
module test_bench;
    parameter half_period = 10;
   
    wire clk_500;
    wire [17:0] CNT_500;
    reg clk, reset;
    Clock_divider #(200000) UUT (clk_500,CNT_500,clk,reset);
  
    initial begin
        #10 clk = 0; reset = 1;
        #20 reset = 0;
        
        end
    always #0.001 clk = ~clk;
    initial #2000 $stop;
endmodule