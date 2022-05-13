`timescale 1ns / 1ps

module top(C, AN, LED, clock, num, equal);
    input clock, equal;
    input [3:0] num;
    output [6:0] C;
    output [3:0] AN;
    output LED;
    wire clock_500, clock_1;
    wire [1:0] ring;
    wire [3:0] A, B;
    wire reset = 0;
    reg [3:0] Q = 4'h0;
    reg [3:0] Q1=4'h0, Q2=4'h0, Q3=4'h0, Q4=4'h0, Q5=4'h0;
    reg [3:0] AN = 4'hf;
    reg [1:0] ssd_neg = 2'h0;
    reg [1:0] c1=2'h0, c2=2'h0, c3=2'h0, c4=2'h0, c5=2'h0, c6=2'h0;
    reg LED = 0;
    reg type = 0;
    reg [3:0] SJTU = 4'h0;
    reg [3:0] M = 4'h0;
    reg [3:0] new = 4'h0;
    
    clock_divider500 divider1(clock,clock_500,reset);
    clock_divider1 divider2(clock_500,clock_1,reset);
    ring_counter rc(ring, clock_500, reset);
    ssd ssd1(C, Q, ssd_neg);

   
    always @(ring) begin
        if (type==0) begin
            case (ring)
                2'b00: begin Q = Q1; ssd_neg = c1; AN = 4'b0111; end
                2'b01: begin Q = Q2; ssd_neg = c2; AN = 4'b1011; end
                2'b10: begin Q = Q3; ssd_neg = c3; AN = 4'b1101; end
                2'b11: begin Q = Q4; ssd_neg = c4; AN = 4'b1110; end
                default: begin Q = Q1; ssd_neg = c1; AN = 4'b1111; end
            endcase
        end else begin
            case (ring)
                2'b00: begin ssd_neg = 4'h0; AN = 4'b0111; end
                2'b01: begin ssd_neg = 4'h0; AN = 4'b1011; end
                2'b10: begin ssd_neg = c5; AN = 4'b1101; end
                2'b11: begin Q = Q5; ssd_neg = c6; AN = 4'b1110; end
                default: begin AN = 4'b1111; end
            endcase
        end
    end
    

    always @(posedge clock_1) begin
        if (type==0) begin
            case (SJTU)
                4'h0: begin Q4 = 4'h5; c4 = 4'h0; end
                4'h1: begin Q4 = 4'h1; Q3 = 4'h5; c3 = 4'h0; end
                4'h2: begin Q4 = 4'h8; Q3 = 4'h1; Q2 = 4'h5; c2 = 4'h0; end
                4'h3: begin Q4 = 4'h3; Q3 = 4'h8; Q2 = 4'h1; Q1 = 4'h5; c1 = 4'h0; end
                4'h4: begin Q4 = 4'h7; Q3 = 4'h3; Q2 = 4'h8; Q1 = 4'h1; end
                4'h5: begin Q4 = 4'h0; Q3 = 4'h7; Q2 = 4'h3; Q1 = 4'h8; end
                4'h6: begin Q4 = 4'h9; Q3 = 4'h0; Q2 = 4'h7; Q1 = 4'h3; end
                4'h7: begin Q4 = 4'h1; Q3 = 4'h9; Q2 = 4'h0; Q1 = 4'h7; end
                4'h8: begin Q4 = 4'h0; Q3 = 4'h1; Q2 = 4'h9; Q1 = 4'h0; end
                4'h9: begin Q4 = 4'h0; Q3 = 4'h0; Q2 = 4'h1; Q1 = 4'h9; end
                4'ha: begin Q4 = 4'h2; Q3 = 4'h0; Q2 = 4'h0; Q1 = 4'h1; end
                4'hb: begin Q4 = 4'h0; Q3 = 4'h2; Q2 = 4'h0; Q1 = 4'h0; end
                4'hc: begin c4 = 4'h0; Q3 = 4'h0; Q2 = 4'h2; Q1 = 4'h0; end
                4'hd: begin c3 = 4'h0;            Q2 = 4'h0; Q1 = 4'h2; end
                4'he: begin c2 = 4'h0;                        Q1 = 4'h0; end
                4'hf: begin c1 = 4'h0; type = 1; end
            endcase
            
            SJTU = SJTU + 1;
        end
    end

    
    always @(posedge equal) begin
        if (type==1) begin
            new = M + num;
            if (M[3] == num[3] && M[3] ^ new[3]) begin
                LED = 1;
            end else begin
                LED = 0;
            end
            M = new;
            if (M[3] == 1) 
            begin
                Q5 = ~(M-1);   
                c5 = 4'h1;        
                c6 = 4'h0;          
            end 
            else 
            begin
                Q5 = M;          
                c5 = 4'h2;        
                c6 = 4'h0;     
            end
        end
    end


endmodule


module ring_counter(Q, clk, reset);
    input clk, reset;
    output [1:0] Q;
    reg [1:0] Q = 0;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1) 
            Q = 0;
        else 
            Q = Q + 1;
    end
endmodule

module ssd(C, Q, ssd_neg);
    output [6:0] C;
    input [3:0] Q;
    input [1:0] ssd_neg;
    reg [6:0] C;
    always @(Q) begin
        if (ssd_neg==2'b00) begin
            case (Q)
                4'h0: C = 7'b1000000;
                4'h1: C = 7'b1111001;
                4'h2: C = 7'b0100100;
                4'h3: C = 7'b0110000;
                4'h4: C = 7'b0011001;
                4'h5: C = 7'b0010010;
                4'h6: C = 7'b0000010;
                4'h7: C = 7'b1111000;
                4'h8: C = 7'b0000000;
                4'h9: C = 7'b0010000;
                4'ha: C = 7'b0001000;
                4'hb: C = 7'b0000011;
                4'hc: C = 7'b1000110;
                4'hd: C = 7'b0100001;
                4'he: C = 7'b0000110;
                4'hf: C = 7'b0001110;
                default C = 7'b1111111;
            endcase

        end 
        else if (ssd_neg==2'b01) begin
            C = 7'b0111111;
        end
        else 
            begin
            C = 7'b1111111;
            end
    end
endmodule
 

module clock_divider500(clk_100M,clk_500,reset);
input clk_100M,reset;
output reg clk_500;
reg [17:0] count=18'b0;

always @(posedge clk_100M or posedge reset)
begin
    if(reset==1)
    begin
        clk_500<=0;
        count<=18'b0;
    end
    else if(count==18'd199999)
    begin
        clk_500<=1;
        count<=18'b0;
    end
    else
    begin
        clk_500<=0;
        count<=count+1;
    end
end

endmodule

module clock_divider1(clk_500,clk_1,reset);
input clk_500,reset;
output reg clk_1;
reg [8:0] count=9'b0;

always @(posedge clk_500 or posedge reset)
begin
    if(reset==1)
    begin
        clk_1<=0;
        count<=9'b0;
    end
    else if(count==9'd499)
    begin
        clk_1<=1;
        count<=9'b0;
    end
    else
    begin
        clk_1<=0;
        count<=count+1;
    end
end
endmodule