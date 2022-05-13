`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 14:54:22
// Design Name: 
// Module Name: HW5_2_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HW5_2_Top(Data_out, Data_in, clk, rst);
 input [3:0] Data_in;
 input clk, rst;
 output [3:0] Data_out;
 
 D_ff F3 (Data_out[3], Data_in[3],clk,rst);
 D_ff F2 (Data_out[2], Data_in[2],clk,rst);
 D_ff F1 (Data_out[1], Data_in[1],clk,rst);
 D_ff F0 (Data_out[0], Data_in[0],clk,rst);
endmodule
