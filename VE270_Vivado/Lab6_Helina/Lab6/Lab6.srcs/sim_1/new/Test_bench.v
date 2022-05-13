`timescale 1ns / 1ps

module Test_Bench;
    parameter half_period = 50;
    wire [3:0] code;
    wire [3:0]col;
    wire [6:0] Light;
    reg [3:0] row;
    reg clock,reset;
    LAB6 UUT (clock,reset,row,col, Light);
    initial begin
    #0 clock = 0; reset = 1;
    #100 reset = 0;
    #150 reset = 1; row = 4'b0010;
    #100 reset = 0;
    #200 reset = 1;row = 4'b1000;
    end
always #half_period clock = ~clock;
initial #2000 $stop;
endmodule
