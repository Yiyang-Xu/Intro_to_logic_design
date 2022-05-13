`timescale 1ns / 1ps

module top(clk_100M,reset,SSD,AN);
input reset,clk_100M;
output reg [6:0] SSD;
wire clk_500,clk_1;
wire [3:0] QR;
wire [3:0] QL;
output [3:0] AN;
wire [17:0] count1;
wire [8:0] count2;
wire [6:0] out1;
wire [6:0] out2;

clock_divider_500 C1(clk_100M,reset,clk_500,count1);
clock_divider_1 C2(clk_500,reset,clk_1,count2);
ring_counter R1(clk_500,reset,AN);
timer T1(clk_1,reset, QL,QR);
ssd S1(out1,QL);
ssd S2(out2,QR);

always @(posedge clk_500)
begin
case (AN)
4'b 1101:SSD=out1;
4'b 1110:SSD=out2;
4'b 1011:SSD=7'b1111111;
4'b 0111:SSD=7'b1111111;
default SSD=7'b1111111;
endcase
end
endmodule

module clock_divider_500 (clk_100M,reset,clk_500,count);
input clk_100M,reset;
output reg clk_500;
output reg [17:0] count=18'b0;

always @ (posedge clk_100M or posedge reset)
begin
    if (reset==1) 
        begin
        count<=18'b0;
        clk_500<=1'b0;
        end
    else if (count==18'd199999)
        begin
        count<=18'b0;    
        clk_500<=1'b1;
    end
    else 
        begin
        count<=count+1;
        clk_500<=1'b0;
    end
end
endmodule

module clock_divider_1 (clk_500,reset,clk_1,count);
input clk_500,reset;
output reg [8:0] count=9'b0;
output reg clk_1;

always @(posedge clk_500 or posedge reset)
begin
    if (reset==1'b1)
        begin
        count<=9'b0;
        clk_1<=1'b0;
        end
    else if (count==9'd499)
        begin 
        count<=9'b0;
        clk_1<=1'b1;
        end
    else 
        begin
        count<=count+1;
        clk_1<=1'b0;
        end
end
endmodule

module ring_counter (clk_500,reset,AN);
input clk_500,reset;
output reg [3:0] AN=4'b1110;

always @ (posedge clk_500 or posedge reset)
begin
    if (reset==1) AN<=4'b1110;
    else 
        begin
        AN[0]<=AN[1];
        AN[1]<=AN[2];
        AN[2]<=AN[3];
        AN[3]<=AN[0];
        end
end
endmodule


module timer(clk,reset,QL,QR);
input clk,reset;
output reg [3:0]QL=4'b0;
output reg [3:0]QR=4'b0;

always @(posedge clk or posedge reset)
begin
    if (reset==1'b1)
        begin
        QL<=4'b0;
        QR<=4'b0;
        end
    else if (QR==4'b1001)
    begin
        if (QL==4'b0101)
            begin
            QR<=0;
            QL<=0;
            end
        else
            begin
            QR<=0;
            QL<=QL+1;
            end
    end
    else 
        QR<=QR+1;
end
endmodule   


module ssd(Light,Q);
input [3:0] Q;
output reg [6:0] Light;
always @(Q) begin
    case (Q)
        4'b0000:Light = 7'b0000001;
        4'b0001:Light = 7'b1001111;
        4'b0010:Light = 7'b0010010;
        4'b0011:Light = 7'b0000110;
        4'b0100:Light = 7'b1001100;
        4'b0101:Light = 7'b0100100;
        4'b0110:Light = 7'b0100000;
        4'b0111:Light = 7'b0001111;
        4'b1000:Light = 7'b0000000;
        4'b1001:Light = 7'b0000100;

    endcase
end
endmodule