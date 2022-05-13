`timescale 1ns / 1ps
module Divider_10000Hz (clock_in, clock_out);
    input clock_in;
    output clock_out;
    reg  [13:0] Q;
    reg clock_out;
    always @ (posedge clock_in) begin
        clock_out = Q[0] & Q[1] & Q[2] & Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7] & Q[8] & Q[9] & Q[10] & ~Q[11] & ~Q[12] & Q[13];
        if (clock_out == 1'b1) Q <= 0;
        else Q <= Q + 1;
    end
endmodule
module LAB6(clock,reset,row,col,Light);
    input clock, reset;
    input [3:0] row;
    output [3:0] col;
    output [6:0] Light;
    wire Reg_ld,clock_out;
    wire [3:0]C;
    wire [3:0] code;
    Key_Scanner kd(clock_out,reset,row,col,Reg_ld,code);
    Reg R(C,code,clock_out,Reg_ld);
    SSD sd(code, Light);
    
endmodule
