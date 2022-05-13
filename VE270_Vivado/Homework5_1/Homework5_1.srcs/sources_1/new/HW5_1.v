`timescale 1ns / 1ps

module HW5_1(Out, I0, I1, Sel);
    input [31:0] I0;
    input [31:0] I1;
    input Sel;
    output [31:0] Out;
    reg [31:0] Out;
    
 always @(I0, I1, Sel) begin
    case (Sel)
    1'b0:Out = I0;
    1'b1:Out = I1;
    default Out = 0;
    endcase
    end

endmodule
