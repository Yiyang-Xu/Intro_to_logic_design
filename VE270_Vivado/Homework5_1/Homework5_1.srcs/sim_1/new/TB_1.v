`timescale 1ns / 1ps
`timescale 1ns / 1ps

module Test_Banch_1;
  wire [31:0] Out;
  reg [31:0] I1, I0;
  reg Sel;
  
  HW5_1 UUT (Out, I1, I0, Sel);
initial begin
  #0 I1=0; I0 = 0; Sel = 0;
  #100 I1 = 100; I0 = 50; Sel = 1;
  #100 I1 = 200; I0 = 150; Sel = 0;
  #100 I1 = 300; I0 = 250; Sel = 1;
  #100 I1 = 400; I0 = 350; Sel = 0;
  #100 I1 = 400; I0 = 450; Sel = 0;
  #100 I1 = 500; I0 = 550; Sel = 0;
  #100 I1 = 500; I0 = 550; Sel = 1;
end
endmodule