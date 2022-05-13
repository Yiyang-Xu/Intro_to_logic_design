`timescale 1ns / 1ps
module CD1(clk_500,CNT_500,clk,reset);
parameter n = 200000;
output clk_500;
output [17:0] CNT_500;
input reset;
input clk;

reg [17:0] CNT_500 = 18'b0;
reg clk_500;

always @ (posedge reset or posedge clk) begin
  if (reset == 1'b1)
     begin
     clk_500 <= 0;
     CNT_500 <= 18'b0;
     end
  else if (CNT_500 == n-1)
      begin
      clk_500 <= 1;
      CNT_500 <= 18'b0;
      end
  else
    begin
      CNT_500 <= CNT_500 + 1;
      clk_500 <= 1'b0;
    end
end
endmodule
