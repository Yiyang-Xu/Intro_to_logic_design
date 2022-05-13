`timescale 1ns / 1ps

module Lab_5(A,light,clk,reset);
output [6:0] light;
output [3:0] A;

input clk;
input reset;

reg [6:0] light;
wire clk_500,clk_1,reset;
wire [3:0] Tens,Units;
wire [6:0] light_tens, light_units;
wire [17:0] CNT_500;
wire [8:0] CNT_1;


CD1 CD_1 (clk_500,CNT_500,clk,reset);
CD2 CD_2 (clk_1,CNT_1,clk_500,reset);
RC Round_Counter (A,clk_500,reset);
TM Timer (Tens,Units,clk_1,reset);
SSD ssd_tens (light_tens,Tens);
SSD ssd_units (light_units,Units);

always @(posedge clk)
begin
    case (A)
        4'b0111: light = 7'b1111111;
        4'b1011: light = 7'b1111111;
        4'b1101: light = light_tens;
        4'b1110: light = light_units;
        4'b1111: light = 7'b1111111;
    endcase
end
endmodule
