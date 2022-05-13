`timescale 1ns / 1ps

module Reg_4bit (code,Reg_load, clock_out, display);
    input [3:0] code;
    input Reg_load, clock_out;
    output [3:0] display;
    reg [3:0] display;
    always @ (negedge clock_out) begin
        if (Reg_load) display <= code;
    end
endmodule
