`timescale 1ns / 1ps

module TB_5;
 parameter half_period  = 50;
 
 wire [3:0] Q;
 wire upper;
 reg clock,CE,LE;
 reg [3:0] load;
 
 HW5_5 UUT (Q,upper,CE,load,clock,LE);
 initial begin
 #0 clock = 0; load = 5; CE = 1;LE = 0;
 #100 CE = 0;
 #100 CE = 1; load  = 3; LE= 1;
 #50 LE = 0;
 #100 CE = 0;
 #100 CE = 1;
 #100 load  = 10; LE= 1;
 end
always #half_period clock = ~clock;
initial #2000 $stop;
endmodule
