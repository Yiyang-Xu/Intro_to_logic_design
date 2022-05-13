`timescale 1ns / 1ps

module clock_divider_10000(clock_in,clock_out);
    input clock_in;
    output  clock_out;
    reg [13:0] counter=14'd0;
    always @(posedge clock_in) begin
        counter<=counter+14'd1;
        if (counter>=14'd10000) counter<=14'd0;
        end
    assign clock_out=(counter<13'd5000)?1'b0:1'b1;
endmodule

module reg4(load,cin,cout,clock);
    input load,clock;
    input [3:0]cin;
    output reg[3:0] cout;
    always @(posedge clock) begin
        if (load==1) cout<=cin;
        end
endmodule

module scanner(clock,reset,row,col,load,code);
    parameter state0=4'b0000;
    parameter state1=4'b0001;
    parameter state2=4'b0010;
    parameter state3=4'b0100;
    parameter state4=4'b1000;
    parameter state5=4'b0101;
    parameter state6=4'b0110;
    parameter state7=4'b0111;
    parameter state8=4'b1000;
    parameter state9=4'b1001;
    input clock,reset;
    input [3:0] row;
    output reg [3:0] col;
    output reg [3:0] code;
    output reg load;
    reg [3:0]current_state=4'b0000;
    reg [3:0] next_state=4'b0000;
    wire OR_row;
    or(OR_row,row[0],row[1],row[2],row[3]);
    always @(posedge clock or posedge reset) begin
    begin
        if (reset==1) current_state<=state0;
        else current_state<=next_state;
    end
    case (next_state)
        state0:col<=4'b1111;
        state1:col<=4'b0001;
        state2:col<=4'b0010;
        state3:col<=4'b0100;
        state4:col<=4'b1000;
        state5:     begin 
                        col<=4'b0001;load=1;
                        case(row)
                            4'b0001:code<=4'b0000;
                            4'b0010:code<=4'b0100;
                            4'b0100:code<=4'b1000;
                            4'b1000:code<=4'b1100;
                            default:code<=4'b0000;
                        endcase
                    end
        state6:     begin
                    col<=4'b0010;load=1;
                        case(row)
                            4'b0001:code<=4'b0001;
                            4'b0010:code<=4'b0101;
                            4'b0100:code<=4'b1001;
                            4'b1000:code<=4'b1101;
                            default:code<=4'b0000;
                        endcase
                    end
         state7:
                    begin
                    col<=4'b0100;load=1;
                        case(row)
                            4'b0001:code<=4'b0010;
                            4'b0010:code<=4'b0110;
                            4'b0100:code<=4'b1010;
                            4'b1000:code<=4'b1110;
                            default:code<=4'b0000;
                        endcase
                    end
         state8:
                    begin
                    col<=4'b1000;load=1;
                        case(row)
                            4'b0001:code<=4'b0011;
                            4'b0010:code<=4'b0111;
                            4'b0100:code<=4'b1011;
                            4'b1000:code<=4'b1111;
                            default:code<=4'b0000;
                        endcase
                    end
          state9:
                    begin
                    col<=4'b1111;load=0;
                    end
          default: code=4'b0000;
    endcase
end

    always @(current_state or OR_row) begin
        case(current_state)
            state0:if(OR_row==0) next_state=state0;
                else    next_state=state1;
            state1:if(OR_row==0) next_state=state2;
                else    next_state=state5;
             state2:if(OR_row==0) next_state=state3;
                else    next_state=state6;
            state3:if(OR_row==0) next_state=state4;
                else    next_state=state7;
            state4:if(OR_row==0) next_state=state5;
                else    next_state=state8;
            state5:next_state<=state9;
            state6:next_state<=state9;
            state7:next_state<=state9;
            state8:next_state<=state9;
            state9:if(OR_row==0) next_state<=state0;
                    else if (OR_row==1) next_state=state9;
            default:next_state<=state0;
        endcase
        end
endmodule

module ssd(light,Q);
input [3:0] Q;
output reg [6:0] light;
always @(Q) begin
    case (Q)
        4'b0000: light = 7'b0000001;
                4'b0001: light = 7'b1001111;
                4'b0010: light = 7'b0010010;
                4'b0011: light = 7'b0000110;
                4'b0100: light = 7'b1001100;
                4'b0101: light = 7'b0100100;
                4'b0110: light = 7'b0100000;
                4'b0111: light = 7'b0001111;
                4'b1000: light = 7'b0000000;
                4'b1001: light = 7'b0000100;
                4'b1010: light = 7'b0001000;
                4'b1011: light = 7'b1100000;
                4'b1100: light = 7'b0110001;
                4'b1101: light = 7'b1000010;
                4'b1110: light = 7'b0110000;
                4'b1111: light = 7'b0111000;
                default: light = 7'b1111111; 
    endcase
    end
endmodule

module top(clock_in,reset,row,col,light);
    input clock_in,reset;
    input [3:0] row;
    output [3:0] col;
    output [6:0]light;
    wire clock_out,load;
    wire [3:0] load_out;
    wire [3:0] code;
    clock_divider_10000 CLK (clock_in,clock_out);
    scanner S1(clock_out,reset,row,col,load,code);
    reg4 R1(load,code,load_out,clock_out);
    SSD ssd1(load_out,light);
endmodule
