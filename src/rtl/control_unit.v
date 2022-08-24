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
    output reg start_en
    );
    
    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam WAIT  = 2'b11;
    
    reg [1:0] state;
    reg [1:0] state_nxt;
    reg start_en_nxt;
    reg [26:0] counter, counter_nxt;
    
    always@(posedge pclk)
    begin 
        if(rst)
        begin
            state <= IDLE;
            start_en <= 0;
            counter <= 0;
        end
        else
        begin
            state <= state_nxt;
            start_en <= start_en_nxt;
            counter <= counter_nxt;
        end
    end 
    
    
    always@*
    begin
        case(state)
            IDLE:
                begin
                    start_en_nxt = 0;
                    counter_nxt = 0;
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
                    if(counter == 75000000)
                    begin
                        counter_nxt = 0;
                        state_nxt = START;
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        state_nxt = WAIT;
                    end
                end
            START:
                begin
                    start_en_nxt = 1;
                    counter_nxt = 0;
                    state_nxt = START;
                end
            default:
                begin
                    state_nxt = IDLE;
                    start_en_nxt = 0;
                    counter_nxt = 0;
                end
        endcase
    end

endmodule
