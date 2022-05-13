`timescale 1ns / 1ps

module HW5_4(Q, set, clear, clk, CE);
 output [3:0] Q;
 input set, clear, clk, CE;
 wire Q3, Q2, Q1, Q0;
 wire D3,D2,D1,D0;
 wire w31,w32,w33,w21,w22,w23,w11,w12,w13,w01,w02,w03;
 
 assign D3 = ((~Q3)&(~Q2)&(~Q1)&(~Q0))|(Q2 & Q1)|(Q2 & Q1);
 assign D2 = ((~Q2)&(~Q1)&(~Q0))|(Q2 & Q0)|(Q2 & Q1);
 xnor (D1, Q1, Q0);
 assign D0 = ~Q0;
 
 D_ff FF3 (Q3,w33,clk);
 D_ff FF2 (Q2,w23,clk);
 D_ff FF1 (Q1,w13,clk);
 D_ff FF0 (Q0,w03,clk);
 
 MUX M31 (w31, Q3,D3,CE);
 MUX M21 (w21, Q2,D2,CE);
 MUX M11 (w11, Q1,D1,CE);
 MUX M01 (w01, Q0,D0,CE);
 
 MUX M32 (w32, w31,0,clear);
 MUX M22 (w22, w21,0,clear);
 MUX M12 (w12, w11,0,clear);
 MUX M02 (w02, w01,0,clear);
 
 MUX M33 (w33, w32,1,set);
 MUX M23 (w23, w22,1,set);
 MUX M13 (w13, w12,1,set);
 MUX M03 (w03, w02,1,set);
 
 assign Q = {Q3,Q2,Q1,Q0};
endmodule
