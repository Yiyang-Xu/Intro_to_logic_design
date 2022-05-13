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