`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 31.08.2022 14:39:17
// Design Name: 
// Module Name: winner_check
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


module winner_check(
    input wire pclk, rst,
    input wire [8:0] square1to9,
    input wire [8:0] square1to9_color,
    output reg [1:0] display_winner, // 00: nobody wins, game is on 01: Player1 wins, 10: Player2 wins, 11: Draw
    output reg game_over
    );
    
    reg [1:0] display_winner_nxt;
    reg game_over_nxt;
    
    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            display_winner <= 0;
            game_over <= 0;
        end
        else
        begin
            display_winner <= display_winner_nxt;
            game_over <= game_over_nxt;
        end
    end
    
    always@*
    begin
        if((square1to9[0] && square1to9[1] && square1to9[2] && (square1to9_color[0] == 0) && (square1to9_color[1] == 0) && (square1to9_color[2] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[3] && square1to9[4] && square1to9[5] && (square1to9_color[3] == 0) && (square1to9_color[4] == 0) && (square1to9_color[5] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[6] && square1to9[7] && square1to9[8] && (square1to9_color[6] == 0) && (square1to9_color[7] == 0) && (square1to9_color[8] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[0] && square1to9[4] && square1to9[8] && (square1to9_color[0] == 0) && (square1to9_color[4] == 0) && (square1to9_color[8] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[2] && square1to9[4] && square1to9[6] && (square1to9_color[2] == 0) && (square1to9_color[4] == 0) && (square1to9_color[6] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[0] && square1to9[3] && square1to9[6] && (square1to9_color[0] == 0) && (square1to9_color[3] == 0) && (square1to9_color[6] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[1] && square1to9[4] && square1to9[7] && (square1to9_color[1] == 0) && (square1to9_color[4] == 0) && (square1to9_color[7] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[2] && square1to9[5] && square1to9[8] && (square1to9_color[2] == 0) && (square1to9_color[5] == 0) && (square1to9_color[8] == 0)))
        begin
            display_winner_nxt = 2'b01;
            game_over_nxt = 1;
        end
        else if((square1to9[0] && square1to9[1] && square1to9[2] && (square1to9_color[0] == 1) && (square1to9_color[1] == 1) && (square1to9_color[2] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[3] && square1to9[4] && square1to9[5] && (square1to9_color[3] == 1) && (square1to9_color[4] == 1) && (square1to9_color[5] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[6] && square1to9[7] && square1to9[8] && (square1to9_color[6] == 1) && (square1to9_color[7] == 1) && (square1to9_color[8] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[0] && square1to9[4] && square1to9[8] && (square1to9_color[0] == 1) && (square1to9_color[4] == 1) && (square1to9_color[8] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[2] && square1to9[4] && square1to9[6] && (square1to9_color[2] == 1) && (square1to9_color[4] == 1) && (square1to9_color[6] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[0] && square1to9[3] && square1to9[6] && (square1to9_color[0] == 1) && (square1to9_color[3] == 1) && (square1to9_color[6] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[1] && square1to9[4] && square1to9[7] && (square1to9_color[1] == 1) && (square1to9_color[4] == 1) && (square1to9_color[7] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if((square1to9[2] && square1to9[5] && square1to9[8] && (square1to9_color[2] == 1) && (square1to9_color[5] == 1) && (square1to9_color[8] == 1)))
        begin
            display_winner_nxt = 2'b10;
            game_over_nxt = 1;
        end
        else if(square1to9 == 9'b111111111)
        begin
            display_winner_nxt = 2'b11;
            game_over_nxt = 1;
        end
        else
        begin
            display_winner_nxt = 2'b00;
            game_over_nxt = 0;
        end
    end
    
endmodule
