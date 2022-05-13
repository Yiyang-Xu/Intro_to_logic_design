`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/28 15:08:26
// Design Name: 
// Module Name: D_ff
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


module D_ff(Data_out, Data_in, clk, rst);
  input Data_in, clk, rst;
  output Data_out;
  
  reg Data_out;
  
  always @ (posedge clk)
  begin
    if (rst == 1) Data_out<= 0;
    else Data_out <= Data_in;
  end
endmodule
