`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 15.08.2022 10:39:59
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char(
    input wire pclk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [7:0] char_pixels,
    input wire start_en,
    input wire choice_en,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output wire [7:0] char_xy,
    output wire [3:0] char_line
    );
    
    reg hsync_nxt, vsync_nxt, hblnk_nxt, vblnk_nxt;
    reg [10:0] hcount_nxt, vcount_nxt;
    wire [10:0] hcount_rect, vcount_rect;
    reg [11:0] rgb_out_nxt;
    
    localparam WIDTH = 40;
    localparam LENGTH = 15;
    localparam LETTERS_COLOR = 12'h3_3_3;
    localparam BACKGROUND_COLOR = 12'he_e_e;
    localparam RECT_X_POS = 490;
    localparam RECT_Y_POS = 600;
    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            rgb_out <= 0;
        end
        else
        begin
            hcount_out <= hcount_nxt;
            hsync_out <= hsync_nxt;
            hblnk_out <= hblnk_nxt;
            vcount_out <= vcount_nxt;
            vsync_out <= vsync_nxt;
            vblnk_out <= vblnk_nxt;
            rgb_out <= rgb_out_nxt;
        end
    end
    
    always@*
    begin
        hblnk_nxt = hblnk_in;
        vblnk_nxt = vblnk_in;
        vsync_nxt = vsync_in;
        hsync_nxt = hsync_in;
        hcount_nxt = hcount_in;
        vcount_nxt = vcount_in;
        
        if(~start_en)
        begin
            if((vcount_in >= RECT_Y_POS) && (vcount_in < RECT_Y_POS + LENGTH) && (hcount_in >= RECT_X_POS) && (hcount_in < RECT_X_POS + WIDTH))
            begin
                if(char_pixels[4'b1000 - hcount_rect[3:0]])
                    rgb_out_nxt = LETTERS_COLOR;
                else
                    rgb_out_nxt = BACKGROUND_COLOR;
            end
            else
            begin
                rgb_out_nxt = 12'h8_8_8;
            end
        end
        else if(choice_en)
        begin
            if((vcount_in >= 300) && (vcount_in < 300 + LENGTH) && (hcount_in >= 470) && (hcount_in < 470 + 110))
            begin
                if(char_pixels[4'b1000 - hcount_rect[3:0]])
                    rgb_out_nxt = LETTERS_COLOR;
                else
                    rgb_out_nxt = BACKGROUND_COLOR;
            end
            else if((vcount_in >= 450) && (vcount_in <= 550) && (hcount_in >= 300) && (hcount_in <= 400))
            begin
                rgb_out_nxt = 12'h0_0_f;
            end
            else if((vcount_in >= 450) && (vcount_in <= 550) && (hcount_in >= 650) && (hcount_in <= 750))
            begin
                rgb_out_nxt = 12'hf_f_0;
            end
            else
            begin
                rgb_out_nxt = 12'h8_8_8;
            end
        end
        else
        begin
            rgb_out_nxt = 12'h8_8_8;
        end
    end
    
    assign vcount_rect = choice_en ? (vcount_in - 300) : (vcount_in - RECT_Y_POS);
    assign hcount_rect = choice_en ? (hcount_in - 470): (hcount_in - RECT_X_POS);
    assign char_xy = {vcount_rect[7:4], hcount_rect[6:3]};
    assign char_line = vcount_rect[3:0];
    
endmodule
