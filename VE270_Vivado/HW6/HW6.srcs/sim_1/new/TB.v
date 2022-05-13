`timescale 1ns / 1ps

module TB;
 parameter half_period  = 50;
 
 wire [3:0] Q;
 reg SI,clk,L,Sh;
 reg [3:0] D;
 
 Top UUT (SI,D,clk,L,Q,Sh);
 initial begin
 #0 clk = 0; L=0;Sh=0;SI=0;
 #100 D=5;
 #100 L=1;
 #50 SI=1;
 #100 SI=0;
 #100 Sh=1;
 end
always #half_period clock = ~clock;
initial #2000 $stop;
endmodule