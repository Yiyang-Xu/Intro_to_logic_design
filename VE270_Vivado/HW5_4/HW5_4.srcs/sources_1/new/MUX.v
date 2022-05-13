`timescale 1ns / 1ps

module MUX( Out, I0, I1, Sel);
 output Out;
 input I0, I1, Sel;
 reg Out;
 
 always @ (I0, I1, Sel)
 begin
  case (Sel)
  1'b0: Out = I0;
  1'b1: Out = I1;
  default Out = 0;
 endcase
end

endmodule
