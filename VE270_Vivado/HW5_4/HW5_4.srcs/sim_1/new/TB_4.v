`timescale 1ns / 1ps

module TB_4;
 parameter half_period  = 50;
 
 wire [3:0] Q;
 reg clock, set, clear, CE;
 
 HW5_4 UUT (Q, set, clear, clock, CE);
 initial begin
 #0 clock = 0; set = 0; clear = 1; CE = 1;
 #100 clear = 0;set = 1;
 #100 set = 0;
 #100 CE = 0;
 #100 CE = 1;
 #100 clear = 1;
 end
always #half_period clock = ~clock;
initial #2000 $stop;
endmodule
