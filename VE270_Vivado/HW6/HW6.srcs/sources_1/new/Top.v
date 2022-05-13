`timescale 1ns / 1ps

module Top(SI,D,clk,L,Q,Sh);
input SI,clk,L,Sh;
input [3:0] D;
output reg [3:0] Q;
 always @ (posedge clk)
 begin
 if (Sh==0)
 begin
    if (L==0)
    begin
    Q<=Q;
    end
    else if (L==1)
    begin
    Q<=D;
    end
end
else if (Sh==1)
begin
    Q[2:0]<=Q[3:1];
    Q[3]=SI;
end
end
endmodule