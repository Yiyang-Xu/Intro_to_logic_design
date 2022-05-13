`timescale 1ns / 1ps

module CD2(clk_1,CNT_1,clk_500,reset);
parameter n = 500;
output clk_1;
output [8:0] CNT_1;
input clk_500;
input reset;
reg [8:0] CNT_1 = 9'b0;
reg clk_1;
always @ (posedge reset or posedge clk_500)
   if (reset == 1'b1) begin
   CNT_1 <= 9'b0;
   clk_1 <= 0;
   end
   else if (CNT_1 == n-1) begin
   clk_1 <= 1;
   CNT_1 <= 9'b0;
   end
   else begin
   CNT_1 <= CNT_1+1;
   clk_1 = 0;
   end
endmodule
