
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 15.08.2022 11:39:40
// Design Name: 
// Module Name: control_unit
// Project Name: Tic-tac-toe game
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


module control_unit(
    input wire pclk,
    input wire rst,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire mouse_left,
    output reg start_en,
    output reg choice_en,
    output reg [11:0] square_color
    );
    
    localparam IDLE   = 5'b00001;
    localparam START  = 5'b00010;
    localparam WAIT   = 5'b00100;
    localparam CHOICE = 5'b01000;
    localparam WAIT2  = 5'b10000;
    
    reg [4:0] state;
    reg [4:0] state_nxt;
    reg start_en_nxt, choice_en_nxt;
    reg [11:0] square_color_nxt;
    reg [26:0] counter, counter_nxt;
    
    always@(posedge pclk)
    begin 
        if(rst)
        begin
            state <= IDLE;
            start_en <= 0;
            choice_en <= 0;
            square_color <= 12'h0_0_0;
            counter <= 0;
        end
        else
        begin
            state <= state_nxt;
            start_en <= start_en_nxt;
            choice_en <= choice_en_nxt;
            square_color <= square_color_nxt;
            counter <= counter_nxt;
        end
    end 
    
    
    always@*
    begin
        case(state)
            IDLE:
                begin
                    start_en_nxt = 0;
                    choice_en_nxt = 0;
                    counter_nxt = 0;
                    square_color_nxt = square_color;
                    if((mouse_xpos >= 490) && (mouse_xpos <= 530) && (mouse_ypos >= 600) && (mouse_ypos <= 615) && (mouse_left == 1))
                    begin
                        state_nxt = WAIT;
                    end
                    else
                        state_nxt = IDLE;
                end
            WAIT:
                begin
                    counter_nxt = 0;
                    start_en_nxt = 0;
                    square_color_nxt = square_color;
                    if(counter == 75000000)
                    begin
                        counter_nxt = 0;
                        choice_en_nxt = 1;
                        state_nxt = CHOICE;
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        choice_en_nxt = 0;
                        state_nxt = WAIT;
                    end
                end
            CHOICE:
                begin
                    counter_nxt = 0;
                    start_en_nxt = 1;
                    choice_en_nxt = 1;
                    if((mouse_xpos >= 300) && (mouse_xpos <= 400) && (mouse_ypos >= 450) && (mouse_ypos <= 550) && (mouse_left == 1))
                    begin
                        square_color_nxt = 12'h0_0_f;
                        state_nxt = WAIT2;
                    end
                    else if((mouse_xpos >= 650) && (mouse_xpos <= 750) && (mouse_ypos >= 450) && (mouse_ypos <= 550) && (mouse_left == 1))
                    begin
                        square_color_nxt = 12'hf_f_0;
                        state_nxt = WAIT2;
                    end
                    else
                    begin
                        square_color_nxt = square_color;
                        state_nxt = CHOICE;
                    end
                end
            WAIT2:
                begin
                    counter_nxt = 0;
                    start_en_nxt = 1;
                    choice_en_nxt = 1;
                    square_color_nxt = square_color;
                    if(counter == 75000000)
                    begin
                        counter_nxt = 0;
                        state_nxt = START;
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        state_nxt = WAIT2;
                    end
                end
            START:
                begin
                    start_en_nxt = 1;
                    counter_nxt = 0;
                    choice_en_nxt = 0;
                    square_color_nxt = square_color;
                    state_nxt = START;
                end
            default:
                begin
                    state_nxt = IDLE;
                    start_en_nxt = 0;
                    counter_nxt = 0;
                    choice_en_nxt = 0;
                    square_color_nxt = 12'h0_0_0;
                end
        endcase
    end

endmodule