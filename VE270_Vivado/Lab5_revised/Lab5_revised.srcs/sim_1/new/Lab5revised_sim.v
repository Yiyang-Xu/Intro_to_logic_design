`timescale 1ns / 1ps

module sim;
wire [6:0] SSD;
reg clk_100M,reset;
wire [3:0] AN;


top UUT (clk_100M,reset,SSD,AN);

initial begin
#0 clk_100M=1;reset=0;
#50 reset=1;
#100 reset=0;
end
always #0.0005 clk_100M=~clk_100M;
initial #20000000 $stop;

endmodule