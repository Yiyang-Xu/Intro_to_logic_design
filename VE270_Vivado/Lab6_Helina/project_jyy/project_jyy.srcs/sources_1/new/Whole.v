`timescale 1ns / 1ps
module Divider_10000Hz (clock_in, clock_out);
    input clock_in;
    output clock_out;
    reg  [13:0] Q;
    reg clock_out;
    always @ (posedge clock_in) begin
        clock_out = Q[0] & Q[1] & Q[2] & Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7] & Q[8] & Q[9] & Q[10] & ~Q[11] & ~Q[12] & Q[13];
        if (clock_out == 1'b1) Q <= 0;
        else Q <= Q + 1;
    end
endmodule

module Reg_4bit (code,Reg_load, clock_out, display);
    input [3:0] code;
    input Reg_load, clock_out;
    output [3:0] display;
    reg [3:0] display;
    always @ (negedge clock_out) begin
        if (Reg_load) display <= code;
    end
endmodule

module SSD (display, cathode);
    input [3:0] display;
    output [6:0] cathode;
    reg [6:0] cathode;
    always @ (display) begin
            case (display)
                4'b0000: cathode = 7'b0000001;
                4'b0001: cathode = 7'b1001111;
                4'b0010: cathode = 7'b0010010;
                4'b0011: cathode = 7'b0000110;
                4'b0100: cathode = 7'b1001100;
                4'b0101: cathode = 7'b0100100;
                4'b0110: cathode = 7'b0100000;
                4'b0111: cathode = 7'b0001111;
                4'b1000: cathode = 7'b0000000;
                4'b1001: cathode = 7'b0000100;
                4'b1010: cathode = 7'b0001000;
                4'b1011: cathode = 7'b1100000;
                4'b1100: cathode = 7'b0110001;
                4'b1101: cathode = 7'b1000010;
                4'b1110: cathode = 7'b0110000;
                4'b1111: cathode = 7'b0111000;
                default: cathode = 7'b1111111;
            endcase
    end
endmodule

module Scanner(reset, clock_out, col, row, code, Reg_load);
    input reset, clock_out;
    input [3:0] row;
    output [3:0] col, code;
    output Reg_load;
    reg [3:0] col, code;
    reg [3:0] curr_state=4'b0000;
    reg [3:0] next_state=4'b0000;
    reg Reg_load;
    wire OR_row;
    
    parameter state0 = 4'b0000;
    parameter state1 = 4'b0001;
    parameter state2 = 4'b0010;
    parameter state3 = 4'b0011;
    parameter state4 = 4'b0100;
    parameter state5 = 4'b0101;
    parameter state6 = 4'b0110;
    parameter state7 = 4'b0111;
    parameter state8 = 4'b1000;
    parameter state9 = 4'b1001;
    
    or (OR_row, row[0], row[1], row[2], row[3]);
    
    //set output
    always @ (posedge clock_out or posedge reset) begin
        begin
        if (reset == 1)  curr_state <= state0;
        else curr_state <= next_state; end
        case (next_state)
            state0: col <= 4'b1111;
            state1: col <= 4'b0001;
            state2: col <= 4'b0010;
            state3: col <= 4'b0100;
            state4: col <= 4'b1000;
            state5: begin col <= 4'b0001; Reg_load <= 1'b1; 
                    case (row)
                        4'b0001: code =4'b0000;
                        4'b0010: code =4'b0100;
                        4'b0100: code =4'b1000;
                        4'b1000: code =4'b1100;   
                        default: code =4'b0000;                                                                     
                    endcase
                    end
                    state6: begin col <= 4'b0010; Reg_load <= 1'b1; 
                                        case (row)
                                            4'b0001: code =4'b0001;
                                            4'b0010: code =4'b0101;
                                            4'b0100: code =4'b1001;
                                            4'b1000: code =4'b1101;      
                                            default: code =4'b0000;                                                                  
                                        endcase
                                        end
                                state7: begin col <= 4'b0100; Reg_load <= 1'b1; 
                                        case (row)
                                            4'b0001: code =4'b0010;
                                            4'b0010: code =4'b0110;
                                            4'b0100: code =4'b1010;
                                            4'b1000: code =4'b1110;      
                                            default: code =4'b0000;                                                                  
                                        endcase                    
                                        end
                                state8: begin col <= 4'b1000; Reg_load <= 1'b1; 
                                        case (row)
                                            4'b0001: code =4'b0011;
                                            4'b0010: code =4'b0111;
                                            4'b0100: code =4'b1011;
                                            4'b1000: code =4'b1111;  
                                            default: code =4'b0000;                                                                     
                                        endcase             
                                        end
                                state9: begin col <= 4'b1111; Reg_load <= 1'b0; end
                                default col <= 4'b1111;
                            endcase
                        end
                        
                        //state trans
                        always @ (curr_state or OR_row) begin
                            case (curr_state)
                                state0: if(OR_row == 0) next_state <= state0;
                                        else if (OR_row == 1) next_state <= state1;
                                state1: if(OR_row == 0) next_state <= state2;
                                        else if (OR_row == 1) next_state <= state5;
                                state2: if(OR_row == 0) next_state <= state3;
                                        else if (OR_row == 1) next_state <= state6;
                                state3: if(OR_row == 0) next_state <= state4;
                                        else if (OR_row == 1) next_state <= state7;
                                state4: if(OR_row == 0) next_state <= state0;
                                        else if (OR_row == 1) next_state <= state8;
                                state5: next_state <= state9;
                                state6: next_state <= state9;
                                state7: next_state <= state9;
                                state8: next_state <= state9;
                                state9: if(OR_row == 0) next_state <= state0;
                                                    else if (OR_row == 1) next_state <= state9;
                                default:next_state <= state0;
                                        endcase
                                    end                                                                                  
                                endmodule
                                
module Whole (clock_in, reset, row, col, anode, cathode);
                                    input clock_in, reset;
                                    input [3:0] row;
                                    output [3:0] col;
                                    output [3:0] anode;
                                    output [6:0] cathode;
                                    assign anode = 4'b1110;
                                    wire clock_out, Reg_load;
                                    wire [3:0] code;
                                    wire [3:0] display;
                                    
                                    Divider_10000Hz D1 (clock_in, clock_out);
                                    Scanner S1 (reset, clock_out, col, row, code, Reg_load);
                                    Reg_4bit R1 (code, Reg_load, clock_out, display);
                                    SSD SSD1 (display, cathode); 
                                endmodule