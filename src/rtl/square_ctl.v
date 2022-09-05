`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 28.08.2022 16:10:26
// Design Name: 
// Module Name: square_ctl
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


module square_ctl(
    input wire pclk, rst,
    input wire mouse_left,
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire start_en,
    input wire choice_en,
    input wire playerID,
    input wire write_uart_en,
    input wire [7:0] rec_data,
    input wire new_game,
    output reg [7:0] w_data,
    output reg [8:0] square1to9, square1to9_color
    );
    
    reg [7:0] w_data_nxt;
    reg [8:0] square1to9_nxt, square1to9_color_nxt;
    
    localparam HEIGHT1 = 251,
               WIDTH1  = 338,
               BLUE    = 1'b0,
               YELLOW  = 1'b1;   
    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            w_data <= 0;
            square1to9 <= 0;
            square1to9_color <= 0;
        end
        else
        begin
            w_data <= w_data_nxt;
            square1to9 <= square1to9_nxt;
            square1to9_color <= square1to9_color_nxt;
        end
    end
    
    always@*
    begin
        if(~new_game)
        begin
            w_data_nxt = w_data;
            square1to9_nxt = square1to9;
            square1to9_color_nxt = square1to9_color;
        end
        else
        begin
            w_data_nxt = 0;
            square1to9_nxt = 0;
            square1to9_color_nxt = 0;
        end
            
            if((start_en && (~choice_en)))
            begin
                
                if(write_uart_en)
                begin
                    case(playerID)
                        1'b1:
                        begin
                            case(rec_data)
                                8'b01001000:
                                begin
                                    square1to9_nxt[0] = 1'b1;
                                    square1to9_color_nxt[0] = BLUE;
                                end
                                8'b01000100:
                                begin
                                    square1to9_nxt[1] = 1'b1;
                                    square1to9_color_nxt[1] = BLUE;
                                end
                                8'b01000010:
                                begin
                                    square1to9_nxt[2] = 1'b1;
                                    square1to9_color_nxt[2] = BLUE;
                                end
                                8'b00101000:
                                begin
                                    square1to9_nxt[3] = 1'b1;
                                    square1to9_color_nxt[3] = BLUE;
                                end
                                8'b00100100:
                                begin
                                    square1to9_nxt[4] = 1'b1;
                                    square1to9_color_nxt[4] = BLUE;
                                end
                                8'b00100010:
                                begin
                                    square1to9_nxt[5] = 1'b1;
                                    square1to9_color_nxt[5] = BLUE;
                                end
                                8'b00011000:
                                begin
                                    square1to9_nxt[6] = 1'b1;
                                    square1to9_color_nxt[6] = BLUE;
                                end
                                8'b00010100:
                                begin
                                    square1to9_nxt[7] = 1'b1;
                                    square1to9_color_nxt[7] = BLUE;
                                end
                                8'b00010010:
                                begin
                                    square1to9_nxt[8] = 1'b1;
                                    square1to9_color_nxt[8] = BLUE;
                                end
                            endcase
                        end
                        1'b0:
                        begin
                            case(rec_data)
                                8'b01001000:
                                begin
                                    square1to9_nxt[0] = 1'b1;
                                    square1to9_color_nxt[0] = YELLOW;
                                end
                                8'b01000100:
                                begin
                                    square1to9_nxt[1] = 1'b1;
                                    square1to9_color_nxt[1] = YELLOW;
                                end
                                8'b01000010:
                                begin
                                    square1to9_nxt[2] = 1'b1;
                                    square1to9_color_nxt[2] = YELLOW;
                                end
                                8'b00101000:
                                begin
                                    square1to9_nxt[3] = 1'b1;
                                    square1to9_color_nxt[3] = YELLOW;
                                end
                                8'b00100100:
                                begin
                                    square1to9_nxt[4] = 1'b1;
                                    square1to9_color_nxt[4] = YELLOW;
                                end
                                8'b00100010:
                                begin
                                    square1to9_nxt[5] = 1'b1;
                                    square1to9_color_nxt[5] = YELLOW;
                                end
                                8'b00011000:
                                begin
                                    square1to9_nxt[6] = 1'b1;
                                    square1to9_color_nxt[6] = YELLOW;
                                end
                                8'b00010100:
                                begin
                                    square1to9_nxt[7] = 1'b1;
                                    square1to9_color_nxt[7] = YELLOW;
                                end
                                8'b00010010:
                                begin
                                    square1to9_nxt[8] = 1'b1;
                                    square1to9_color_nxt[8] = YELLOW;
                                end
                            endcase
                        end
                    endcase
                end
                else
                begin
                    if((xpos <= WIDTH1) && (ypos <= HEIGHT1) && (mouse_left == 1) && (~square1to9[0]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[0] = 1'b1;
                                square1to9_color_nxt[0] = BLUE;
                                w_data_nxt = 8'b01001000;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[0] = 1'b1;
                                square1to9_color_nxt[0] = YELLOW;
                                w_data_nxt = 8'b01001000;
                            end
                        endcase
                    end

                    if((xpos >= 344) && (xpos <= 679) && (ypos <= HEIGHT1) && (mouse_left == 1) && (~square1to9[1]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[1] = 1'b1;
                                square1to9_color_nxt[1] = BLUE;
                                w_data_nxt = 8'b01000100;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[1] = 1'b1;
                                square1to9_color_nxt[1] = YELLOW;
                                w_data_nxt = 8'b01000100;
                            end
                        endcase
                    end

                    if((xpos >= 685) && (xpos <= 1023) && (ypos <= HEIGHT1) && (mouse_left == 1) && (~square1to9[2]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[2] = 1'b1;
                                square1to9_color_nxt[2] = BLUE;
                                w_data_nxt = 8'b01000010;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[2] = 1'b1;
                                square1to9_color_nxt[2] = YELLOW;
                                w_data_nxt = 8'b01000010;
                            end
                        endcase
                    end

                    if((xpos <= WIDTH1) && (ypos >= 259) && (ypos <= 507) && (mouse_left == 1) && (~square1to9[3]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[3] = 1'b1;
                                square1to9_color_nxt[3] = BLUE;
                                w_data_nxt = 8'b00101000;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[3] = 1'b1;
                                square1to9_color_nxt[3] = YELLOW;
                                w_data_nxt = 8'b00101000;
                            end
                        endcase
                    end

                    if((xpos >= 344) && (xpos <= 679) && (ypos >= 259) && (ypos <= 507) && (mouse_left == 1) && (~square1to9[4]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[4] = 1'b1;
                                square1to9_color_nxt[4] = BLUE;
                                w_data_nxt = 8'b00100100;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[4] = 1'b1;
                                square1to9_color_nxt[4] = YELLOW;
                                w_data_nxt = 8'b00100100;
                            end
                        endcase
                    end

                    if((xpos >= 685) && (xpos <= 1023) && (ypos >= 259) && (ypos <= 507) && (mouse_left == 1) && (~square1to9[5]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[5] = 1'b1;
                                square1to9_color_nxt[5] = BLUE;
                                w_data_nxt = 8'b00100010;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[5] = 1'b1;
                                square1to9_color_nxt[5] = YELLOW;
                                w_data_nxt = 8'b00100010;
                            end
                        endcase
                    end

                    if((xpos <= WIDTH1) && (ypos >= 515) && (ypos <= 767) && (mouse_left == 1) && (~square1to9[6]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[6] = 1'b1;
                                square1to9_color_nxt[6] = BLUE;
                                w_data_nxt = 8'b00011000;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[6] = 1'b1;
                                square1to9_color_nxt[6] = YELLOW;
                                w_data_nxt = 8'b00011000;
                            end
                        endcase
                    end

                    if((xpos >= 344) && (xpos <= 679) && (ypos >= 515) && (ypos <= 767) && (mouse_left == 1) && (~square1to9[7]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[7] = 1'b1;
                                square1to9_color_nxt[7] = BLUE;
                                w_data_nxt = 8'b00010100;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[7] = 1'b1;
                                square1to9_color_nxt[7] = YELLOW;
                                w_data_nxt = 8'b00010100;
                            end
                        endcase
                    end

                    if((xpos >= 685) && (xpos <= 1023) && (ypos >= 515) && (ypos <= 767) && (mouse_left == 1) && (~square1to9[8]))
                    begin
                        case(playerID)
                            1'b0:
                            begin
                                square1to9_nxt[8] = 1'b1;
                                square1to9_color_nxt[8] = BLUE;
                                w_data_nxt = 8'b00010010;
                            end
                            1'b1:
                            begin
                                square1to9_nxt[8] = 1'b1;
                                square1to9_color_nxt[8] = YELLOW;
                                w_data_nxt = 8'b00010010;
                            end
                        endcase
                    end
               end
           end
     end
    
endmodule
