`timescale 1ns / 1ps

module RC(A,clk_500,reset);
  output [3:0] A;
  input clk_500;
  input reset;
  reg [3:0] A;
  
always @ (posedge clk_500 or posedge reset)
  if (reset == 1'b1)
  A <= 4'b1110;
  else
  begin
  A[3] <= A[0];
  A[2] <= A[3];
  A[1] <= A[2];
  A[0] <= A[1];
  end
endmodule
