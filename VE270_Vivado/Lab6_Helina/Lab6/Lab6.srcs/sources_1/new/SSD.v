`timescale 1ns / 1ps

module SSD (display, cathode);
    input [3:0] display;
    output [6:0] cathode;
    reg [6:0] cathode;
    always @ (display) begin
            case (display)
                4'b0000: cathode = 7'b0000001;
                4'b0001: cathode = 7'b1001111;
                4'b0010: cathode = 7'b0010010;
                4'b0011: cathode = 7'b0000110;
                4'b0100: cathode = 7'b1001100;
                4'b0101: cathode = 7'b0100100;
                4'b0110: cathode = 7'b0100000;
                4'b0111: cathode = 7'b0001111;
                4'b1000: cathode = 7'b0000000;
                4'b1001: cathode = 7'b0000100;
                4'b1010: cathode = 7'b0001000;
                4'b1011: cathode = 7'b1100000;
                4'b1100: cathode = 7'b0110001;
                4'b1101: cathode = 7'b1000010;
                4'b1110: cathode = 7'b0110000;
                4'b1111: cathode = 7'b0111000;
                default: cathode = 7'b1111111;
            endcase
    end
endmodule


