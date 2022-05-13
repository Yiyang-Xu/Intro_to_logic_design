`timescale 1ns / 1ps

module Test_Banch;
  parameter half_period = 50;
  
  wire [3:0] Data_out;
  reg [3:0] Data_in;
  reg clock, reset;
  
  HW5_2_Top  UUT (Data_out, Data_in,clock, reset);
  initial begin 
  #0 clock = 0; Data_in = 0; reset = 1;
  #100 reset = 0;
  #200 Data_in = 8; 
  #200 Data_in = 6;
  #200 reset = 1;
end
always #half_period clock = ~clock;
initial #2000 $stop;
 
endmodule
