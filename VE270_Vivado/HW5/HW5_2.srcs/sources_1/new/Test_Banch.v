`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 15:35:46
// Design Name: 
// Module Name: Test_Banch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_Banch;
  parameter half_period = 50;
  parameter FF_size = 4;
  
  reg [FF_size-1:0] Data_in;
  reg clock, reset;
  
  D_ff_N_bit #(FF_size) UUT (Data_in,clock, reset);
  initial begin
  #0 clock = 0; Data_in = 0; reset = 1;
  #100 reset = 0;
  #200 Data_in = 8; 
  #300 Data_in = 6;
  #400 reset = 1;
end
always #half_period clock = ~clock;
initial #2000 $stop;
 
endmodule
