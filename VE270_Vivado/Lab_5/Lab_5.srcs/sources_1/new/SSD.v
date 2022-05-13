`timescale 1ns / 1ps
module SSD(Light,numb);
output [6:0] Light;
input [3:0] numb;
reg [6:0] Light;
always @(numb) begin
    case (numb)
        4'b0000:Light = 7'b1000000;
        4'b0001:Light = 7'b1111001;
        4'b0010:Light = 7'b0100100;
        4'b0011:Light = 7'b0110000;
        4'b0100:Light = 7'b0011001;
        4'b0101:Light = 7'b0010010;
        4'b0110:Light = 7'b0000010;
        4'b0111:Light = 7'b1111000;
        4'b1000:Light = 7'b0000000;
        4'b1001:Light = 7'b0010000;
        4'b1010:Light = 7'b0001000;
        4'b1011:Light = 7'b0000011;
        4'b1100:Light = 7'b1000110;
        4'b1101:Light = 7'b0100001;
        4'b1110:Light = 7'b0000110;
        4'b1111:Light = 7'b0001110;    
    endcase
end
endmodule