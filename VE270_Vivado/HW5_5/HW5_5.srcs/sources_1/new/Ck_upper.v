`timescale 1ns / 1ps
module Ck_upper(is_upper, Q);
output is_upper;
input [3:0] Q;
reg is_upper;

always @ (Q)
begin
  if (Q>7) is_upper = 1;
  else is_upper = 0;
end
endmodule
