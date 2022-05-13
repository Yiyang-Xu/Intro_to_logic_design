`timescale 1ns / 1ps

module HW5_3(Out, clk);
output [3:0] Out;
input clk;

wire D3_in;
wire Q3, Q2, Q1, Q0;

xor (D3_in, Q3, Q0);
D_ff F3 (Q3,D3_in,clk);
D_ff F2 (Q2,Q3,clk);
D_ff F1 (Q1,Q2,clk);
D_ff F0 (Q0,Q1,clk);
assign Out = {Q3,Q2,Q1,Q0};
endmodule
