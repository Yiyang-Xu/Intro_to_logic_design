`timescale 1ns / 1ps

module TM (Tens,Units,reset,clk_1);
output [3:0] Tens, Units;
input reset, clk_1;
reg [3:0] Tens = 4'b0;
reg [3:0] Units = 4'b0;

always @ (posedge reset or posedge clk_1)
begin
  if (reset == 1) begin
  Tens <= 4'b0;
  Units <= 4'b0;
  end
  else if (Units == 4'b1001)
    if (Tens == 4'b0101) begin
       Tens <= 0;
       Units <= 0;
       end
     else begin
     Tens <= Tens + 1;
     Units <= 0;
     end
  else Units = Units + 1;
end
endmodule
