`timescale 1ns / 1ps

module D_ff(q,data_in, clk);
input data_in, clk;
output q;
reg q;
always @ (posedge clk)
  q <= data_in;
endmodule
