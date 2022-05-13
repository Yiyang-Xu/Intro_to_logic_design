`timescale 1ns / 1ps

module HW5_5(Q,upper,CE,load,clk,LE);
output [3:0] Q;
output upper;
reg upper;
//output upper;
input CE,clk,LE;
input [3:0] load;
wire Q3,Q2,Q1,Q0;
wire D3,D2,D1,D0;
wire L3,L2,L1,L0;
wire w31,w32,w21,w22,w11,w12,w01,w02;

assign L3 = load[3];
assign L2 = load[2];
assign L1 = load[1];
assign L0 = load[0];

assign D3 = (Q3 & (~Q2))|(Q3 & (~Q1))|(Q3 & (~Q0))|((~Q3)& Q2 & Q1 & Q0);
assign D2 = (Q2 & (~Q1))|(Q2 & (~Q0))|((~Q2) & Q1 & Q0);
xor (D1,Q1,Q0);
assign D0 = ~Q0;

MUX M31 (w31, Q3, D3, CE);
MUX M21 (w21, Q2, D2, CE);
MUX M11 (w11, Q1, D1, CE);
MUX M01 (w01, Q0, D0, CE);

MUX M32 (w32, w31,L3,LE);
MUX M22 (w22, w21,L2,LE);
MUX M12 (w12, w11,L1,LE);
MUX M02 (w02, w01,L0,LE);


D_ff F3 (Q3, w32,clk);
D_ff F2 (Q2, w22,clk);
D_ff F1 (Q1, w12,clk);
D_ff F0 (Q0, w02,clk);

assign Q = {Q3,Q2,Q1,Q0};

always @ (Q)
begin 
if (Q>7) upper = 1;
else upper  = 0 ;
end
endmodule
