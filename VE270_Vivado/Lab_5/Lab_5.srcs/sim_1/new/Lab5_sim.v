`timescale 1ns / 1ps
module Test_bench;
    parameter half_period = 10;
   
    reg clock, reset;
    wire [3:0] A;
    wire [6:0] light;
    wire clk_1;
    wire [17:0] Out_1;
    wire [8:0] Out_2;
    
    Lab_5 UUT (clk_1,Out_1,Out_2,A,light,clk,reset);
    initial begin
        #10 clock = 0; reset = 1;
        #20 reset = 0;
        
        end
    always #0.001 clock = ~clock;
    initial #20000000 $stop;
endmodule