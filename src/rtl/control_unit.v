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
    input wire rx_tx_done,
    input wire [8:0] square1to9,
    input wire game_over,
    output reg new_game,
    output reg start_en,
    output reg choice_en,
    output reg playerID, uart_en, write_uart_en, uart_mode
    );
    
    localparam IDLE           = 12'b000000000001,
               PLAYER_1       = 12'b000000000010,
               PLAYER_2       = 12'b000000000100,
               WAIT           = 12'b000000001000,
               CHOICE         = 12'b000000010000,
               WAIT2          = 12'b000000100000,
               RX_TRANSMIT    = 12'b000001000000,
               TX_TRANSMIT    = 12'b000010000000,
               UPDATE_BOARD   = 12'b000100000000,
               UPDATE_SQUARES = 12'b001000000000,
               GAME_OVER      = 12'b010000000000,
               NEW_GAME       = 12'b100000000000;
    
    localparam HEIGHT1 = 251,
               WIDTH1  = 338,
               SENDING   = 1'b0,
               RECEIVING = 1'b1;
    
    reg [8:0] updated_square1to9, updated_square1to9_nxt;
    reg [11:0] state;
    reg [11:0] state_nxt;
    reg start_en_nxt, choice_en_nxt, uart_en_nxt, write_uart_en_nxt, uart_mode_nxt, new_game_nxt;
    reg [26:0] counter, counter_nxt;
    reg playerID_nxt;
    
    always@(posedge pclk)
    begin 
        if(rst)
        begin
            state <= IDLE;
            start_en <= 0;
            choice_en <= 0;
            playerID <= 0;
            counter <= 0;
            uart_en    <= 0;
            write_uart_en <= 0;
            uart_mode <= 0;
            updated_square1to9 <= 0;
            new_game <= 0;
        end
        else
        begin
            state <= state_nxt;
            start_en <= start_en_nxt;
            choice_en <= choice_en_nxt;
            playerID <= playerID_nxt;
            counter <= counter_nxt;
            uart_en <= uart_en_nxt;
            write_uart_en <= write_uart_en_nxt;
            uart_mode <= uart_mode_nxt;
            updated_square1to9 <= updated_square1to9_nxt;
            new_game <= new_game_nxt;
        end
    end 
    
    
    always@*
    begin
    
    start_en_nxt = start_en;
    choice_en_nxt = choice_en;
    uart_en_nxt = uart_en;
    counter_nxt = counter;
    playerID_nxt = playerID;
    write_uart_en_nxt = write_uart_en;
    uart_mode_nxt = uart_mode;
    updated_square1to9_nxt = updated_square1to9;
    new_game_nxt = new_game;
    
        case(state)
            IDLE:
                begin
                    start_en_nxt = 0;
                    choice_en_nxt = 0;
                    counter_nxt = 0;
                    uart_en_nxt = 0;
                    write_uart_en_nxt = 0;
                    uart_mode_nxt = SENDING;
                    new_game_nxt = 0;
                    if((mouse_xpos >= 490) && (mouse_xpos <= 530) && (mouse_ypos >= 600) && (mouse_ypos <= 615) && (mouse_left == 1))
                    begin
                        state_nxt = WAIT;
                    end
                    else
                        state_nxt = IDLE;
                end
            WAIT:
                begin
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
                    start_en_nxt = 1;
                    choice_en_nxt = 1;
                    if((mouse_xpos >= 300) && (mouse_xpos <= 400) && (mouse_ypos >= 450) && (mouse_ypos <= 550) && (mouse_left == 1))
                    begin
                        playerID_nxt = 0;
                        state_nxt = WAIT2;
                    end
                    else if((mouse_xpos >= 650) && (mouse_xpos <= 750) && (mouse_ypos >= 450) && (mouse_ypos <= 550) && (mouse_left == 1))
                    begin
                        playerID_nxt = 1;
                        state_nxt = WAIT2;
                    end
                    else
                    begin
                        playerID_nxt = playerID;
                        state_nxt = CHOICE;
                    end
                end
            WAIT2:
                begin
                    if(counter == 75000000)
                    begin
                        counter_nxt = 0;
                        choice_en_nxt = 0;
                        start_en_nxt = 1;
                        if(playerID == 0)
                        begin
                            state_nxt = PLAYER_1;
                            uart_mode_nxt = SENDING;
                            write_uart_en_nxt = 0;
                            uart_en_nxt = 0;
                        end
                        else
                        begin
                            state_nxt = RX_TRANSMIT;
                            uart_mode_nxt = RECEIVING;
                            write_uart_en_nxt = 1;
                        end
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        state_nxt = WAIT2;
                        new_game_nxt = 0;
                    end
                end
            PLAYER_1:
                begin
                    write_uart_en_nxt = 0;
                    uart_mode_nxt = SENDING;
                    if(((mouse_xpos <= WIDTH1) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[0] == 0)) 
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[1] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[2] == 0))
                    || ((mouse_xpos <= WIDTH1) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[3] == 0))
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[4] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[5] == 0))
                    || ((mouse_xpos <= WIDTH1) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[6] == 0))
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[7] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[8] == 0)))
                    begin
                        if(counter == 8000)
                        begin
                            counter_nxt = 0;
                            state_nxt = TX_TRANSMIT;
                        end
                        else
                        begin
                            counter_nxt = counter + 1;
                            state_nxt = PLAYER_1;
                        end
                    end
                    else
                        state_nxt = PLAYER_1;
                end
            RX_TRANSMIT:
                begin
                    if(rx_tx_done)
                    begin
                        counter_nxt = 0;
                        write_uart_en_nxt = 0;
                        uart_en_nxt = 0;
                        state_nxt = UPDATE_BOARD;
                    end
                    else
                    begin
                        state_nxt = RX_TRANSMIT;
                        uart_en_nxt = 1;
                        write_uart_en_nxt = 1; 
                    end       
                end
            TX_TRANSMIT:
                begin
                    uart_en_nxt = 1;
                    write_uart_en_nxt = 1;
                    if(rx_tx_done)
                    begin
                        uart_mode_nxt = RECEIVING;
                        if(game_over)
                            state_nxt = UPDATE_BOARD;
                        else
                            state_nxt = RX_TRANSMIT;
                    end
                    else
                        state_nxt = TX_TRANSMIT;    
                end
             PLAYER_2:
                begin
                    write_uart_en_nxt = 0;
                    uart_mode_nxt = SENDING;
                    if(((mouse_xpos <= WIDTH1) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[0] == 0)) 
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[1] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos <= HEIGHT1) && (mouse_left == 1) && (updated_square1to9[2] == 0))
                    || ((mouse_xpos <= WIDTH1) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[3] == 0))
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[4] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos >= 259) && (mouse_ypos <= 507) && (mouse_left == 1) && (updated_square1to9[5] == 0))
                    || ((mouse_xpos <= WIDTH1) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[6] == 0))
                    || ((mouse_xpos >= 344) && (mouse_xpos <= 679) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[7] == 0))
                    || ((mouse_xpos >= 685) && (mouse_xpos <= 1023) && (mouse_ypos >= 515) && (mouse_ypos <= 767) && (mouse_left == 1) && (updated_square1to9[8] == 0)))
                    begin
                        if(counter == 8000)
                        begin
                            counter_nxt = 0;
                            state_nxt = TX_TRANSMIT;
                        end
                        else
                        begin
                            counter_nxt = counter + 1;
                            state_nxt = PLAYER_2;
                        end
                    end
                    else
                        state_nxt = PLAYER_2;
                end
              UPDATE_BOARD:
                begin
                    write_uart_en_nxt = 1;
                    state_nxt = UPDATE_SQUARES;
                end
              UPDATE_SQUARES:
                begin
                    if(playerID == 0)
                    begin
                        write_uart_en_nxt = 0;
                        if(counter == 80000000)
                        begin
                            counter_nxt = 0;
                            updated_square1to9_nxt = square1to9;
                            if(game_over)
                                state_nxt = GAME_OVER;
                            else
                                state_nxt = PLAYER_1;
                        end
                        else
                        begin
                            counter_nxt = counter + 1;
                            state_nxt = UPDATE_SQUARES;
                        end
                    end
                    else
                    begin
                        write_uart_en_nxt = 0;
                        if(counter == 80000000)
                        begin
                            counter_nxt = 0;
                            updated_square1to9_nxt = square1to9;
                            if(game_over)
                                state_nxt = GAME_OVER;
                            else
                                state_nxt = PLAYER_2;
                        end
                        else
                        begin
                            counter_nxt = counter + 1;
                            state_nxt = UPDATE_SQUARES;
                        end
                    end
                end
              GAME_OVER:
                 begin
                    start_en_nxt = 0;
                    write_uart_en_nxt = 1;
                    uart_en_nxt = 0;
                    new_game_nxt = 0;
                    if(counter == 80000000)
                    begin
                       counter_nxt = 0;
                       state_nxt = NEW_GAME; 
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        state_nxt = GAME_OVER;
                    end    
                 end
               NEW_GAME:
                 begin
                    new_game_nxt = 1;
                    if(counter == 8000000)
                    begin
                        counter_nxt = 0;
                        uart_en_nxt = 0;
                        write_uart_en_nxt = 0;
                        if(playerID == 0)
                            state_nxt = WAIT2;
                        else
                            state_nxt = WAIT2;
                    end
                    else
                    begin
                        counter_nxt = counter + 1;
                        state_nxt = NEW_GAME;
                    end
                 end    
            default:
                begin
                    state_nxt = IDLE;
                    start_en_nxt = 0;
                    counter_nxt = 0;
                    uart_en_nxt = 0;
                    choice_en_nxt = 0;
                    playerID_nxt = 0;
                    write_uart_en_nxt = 0;
                    updated_square1to9_nxt = 0;
                    new_game_nxt = 0;
                end
        endcase
    end

endmodule
