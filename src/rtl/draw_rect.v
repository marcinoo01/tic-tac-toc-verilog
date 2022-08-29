`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 04.08.2022 09:45:43
// Design Name: 
// Module Name: draw_rect
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


module draw_rect(
      output reg [10:0] vcount_out,
      output reg [10:0] hcount_out,
      output reg hsync_out,
      output reg hblnk_out,
      output reg vsync_out,
      output reg vblnk_out,
      output reg [11:0] rgb_out,
      input wire pclk,
      input wire [10:0] hcount_in,
      input wire hsync_in,
      input wire hblnk_in,
      input wire [10:0] vcount_in,
      input wire vsync_in,
      input wire vblnk_in,
      input wire [11:0] rgb_in,
      input wire rst,
      input wire start_en,
      input wire choice_en,
      input wire [8:0] square1to9,
      input wire [8:0] square1to9_color
    );
               
    
    reg [11:0] rgb_out_nxt;
    wire [11:0] rgb_out1, rgb_out2, rgb_out3, rgb_out4, rgb_out5, rgb_out6, rgb_out7, rgb_out8, rgb_out9;
    reg hsync_out_nxt;
    wire hsync_out1, hsync_out2, hsync_out3, hsync_out4, hsync_out5, hsync_out6, hsync_out7, hsync_out8, hsync_out9;
    reg vsync_out_nxt;
    wire vsync_out1, vsync_out2, vsync_out3, vsync_out4, vsync_out5, vsync_out6, vsync_out7, vsync_out8, vsync_out9;
    reg [10:0] hcount_out_nxt;
    wire [10:0] hcount_out1, hcount_out2, hcount_out3, hcount_out4, hcount_out5, hcount_out6, hcount_out7, hcount_out8, hcount_out9;
    reg [10:0] vcount_out_nxt;
    wire [10:0] vcount_out1, vcount_out2, vcount_out3, vcount_out4, vcount_out5, vcount_out6, vcount_out7, vcount_out8, vcount_out9;
    reg hblnk_out_nxt;
    wire hblnk_out1, hblnk_out2, hblnk_out3, hblnk_out4, hblnk_out5, hblnk_out6, hblnk_out7, hblnk_out8, hblnk_out9;
    reg vblnk_out_nxt;
    wire vblnk_out1, vblnk_out2, vblnk_out3, vblnk_out4, vblnk_out5, vblnk_out6, vblnk_out7, vblnk_out8, vblnk_out9;

    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            vcount_out <= 0;
            hcount_out <= 0;
            hsync_out  <= 0;
            vsync_out  <= 0;
            hblnk_out  <= 0;
            vblnk_out  <= 0;
            rgb_out    <= 0;
        end
        else
        begin
            vcount_out <= vcount_out_nxt;
            hcount_out <= hcount_out_nxt;
            hsync_out  <= hsync_out_nxt;
            vsync_out  <= vsync_out_nxt;
            hblnk_out  <= hblnk_out_nxt;
            vblnk_out  <= vblnk_out_nxt;
            rgb_out    <= rgb_out_nxt;
        end
    end
    
    always@*
    begin
        vcount_out_nxt = vcount_out9;
        hcount_out_nxt = hcount_out9;
        hsync_out_nxt = hsync_out9;
        hblnk_out_nxt = hblnk_out9;
        vsync_out_nxt = vsync_out9;
        vblnk_out_nxt = vblnk_out9;
        rgb_out_nxt = rgb_out9;
    end
    
    
    draw_square1 draw_square1(
    .vcount_out(vcount_out1),
    .hcount_out(hcount_out1),
    .hsync_out(hsync_out1),
    .hblnk_out(hblnk_out1),
    .vsync_out(vsync_out1),
    .vblnk_out(vblnk_out1),
    .rgb_out(rgb_out1),
    .pclk(pclk),
    .hcount_in(hcount_in),
    .hsync_in(hsync_in),
    .hblnk_in(hblnk_in),
    .vcount_in(vcount_in),
    .vsync_in(vsync_in),
    .vblnk_in(vblnk_in),
    .rgb_in(rgb_in),
    .rst(rst),
    .square1(square1to9[0]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square1_color(square1to9_color[0])
    );
    
    draw_square2 draw_square2(
    .vcount_out(vcount_out2),
    .hcount_out(hcount_out2),
    .hsync_out(hsync_out2),
    .hblnk_out(hblnk_out2),
    .vsync_out(vsync_out2),
    .vblnk_out(vblnk_out2),
    .rgb_out(rgb_out2),
    .pclk(pclk),
    .hcount_in(hcount_out1),
    .hsync_in(hsync_out1),
    .hblnk_in(hblnk_out1),
    .vcount_in(vcount_out1),
    .vsync_in(vsync_out1),
    .vblnk_in(vblnk_out1),
    .rgb_in(rgb_out1),
    .rst(rst),
    .square2(square1to9[1]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square2_color(square1to9_color[1])
    );
    
    draw_square3 draw_square3(
    .vcount_out(vcount_out3),
    .hcount_out(hcount_out3),
    .hsync_out(hsync_out3),
    .hblnk_out(hblnk_out3),
    .vsync_out(vsync_out3),
    .vblnk_out(vblnk_out3),
    .rgb_out(rgb_out3),
    .pclk(pclk),
    .hcount_in(hcount_out2),
    .hsync_in(hsync_out2),
    .hblnk_in(hblnk_out2),
    .vcount_in(vcount_out2),
    .vsync_in(vsync_out2),
    .vblnk_in(vblnk_out2),
    .rgb_in(rgb_out2),
    .rst(rst),
    .square3(square1to9[2]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square3_color(square1to9_color[2])
    );
    
    draw_square4 draw_square4(
    .vcount_out(vcount_out4),
    .hcount_out(hcount_out4),
    .hsync_out(hsync_out4),
    .hblnk_out(hblnk_out4),
    .vsync_out(vsync_out4),
    .vblnk_out(vblnk_out4),
    .rgb_out(rgb_out4),
    .pclk(pclk),
    .hcount_in(hcount_out3),
    .hsync_in(hsync_out3),
    .hblnk_in(hblnk_out3),
    .vcount_in(vcount_out3),
    .vsync_in(vsync_out3),
    .vblnk_in(vblnk_out3),
    .rgb_in(rgb_out3),
    .rst(rst),
    .square4(square1to9[3]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square4_color(square1to9_color[3])
    );
    
    draw_square5 draw_square5(
    .vcount_out(vcount_out5),
    .hcount_out(hcount_out5),
    .hsync_out(hsync_out5),
    .hblnk_out(hblnk_out5),
    .vsync_out(vsync_out5),
    .vblnk_out(vblnk_out5),
    .rgb_out(rgb_out5),
    .pclk(pclk),
    .hcount_in(hcount_out4),
    .hsync_in(hsync_out4),
    .hblnk_in(hblnk_out4),
    .vcount_in(vcount_out4),
    .vsync_in(vsync_out4),
    .vblnk_in(vblnk_out4),
    .rgb_in(rgb_out4),
    .rst(rst),
    .square5(square1to9[4]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square5_color(square1to9_color[4])
    );
    
    draw_square6 draw_square6(
    .vcount_out(vcount_out6),
    .hcount_out(hcount_out6),
    .hsync_out(hsync_out6),
    .hblnk_out(hblnk_out6),
    .vsync_out(vsync_out6),
    .vblnk_out(vblnk_out6),
    .rgb_out(rgb_out6),
    .pclk(pclk),
    .hcount_in(hcount_out5),
    .hsync_in(hsync_out5),
    .hblnk_in(hblnk_out5),
    .vcount_in(vcount_out5),
    .vsync_in(vsync_out5),
    .vblnk_in(vblnk_out5),
    .rgb_in(rgb_out5),
    .rst(rst),
    .square6(square1to9[5]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square6_color(square1to9_color[5])
    );
    
    draw_square7 draw_square7(
    .vcount_out(vcount_out7),
    .hcount_out(hcount_out7),
    .hsync_out(hsync_out7),
    .hblnk_out(hblnk_out7),
    .vsync_out(vsync_out7),
    .vblnk_out(vblnk_out7),
    .rgb_out(rgb_out7),
    .pclk(pclk),
    .hcount_in(hcount_out6),
    .hsync_in(hsync_out6),
    .hblnk_in(hblnk_out6),
    .vcount_in(vcount_out6),
    .vsync_in(vsync_out6),
    .vblnk_in(vblnk_out6),
    .rgb_in(rgb_out6),
    .rst(rst),
    .square7(square1to9[6]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square7_color(square1to9_color[6])
    );
    
    draw_square8 draw_square8(
    .vcount_out(vcount_out8),
    .hcount_out(hcount_out8),
    .hsync_out(hsync_out8),
    .hblnk_out(hblnk_out8),
    .vsync_out(vsync_out8),
    .vblnk_out(vblnk_out8),
    .rgb_out(rgb_out8),
    .pclk(pclk),
    .hcount_in(hcount_out7),
    .hsync_in(hsync_out7),
    .hblnk_in(hblnk_out7),
    .vcount_in(vcount_out7),
    .vsync_in(vsync_out7),
    .vblnk_in(vblnk_out7),
    .rgb_in(rgb_out7),
    .rst(rst),
    .square8(square1to9[7]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square8_color(square1to9_color[7])
    );
    
    draw_square9 draw_square9(
    .vcount_out(vcount_out9),
    .hcount_out(hcount_out9),
    .hsync_out(hsync_out9),
    .hblnk_out(hblnk_out9),
    .vsync_out(vsync_out9),
    .vblnk_out(vblnk_out9),
    .rgb_out(rgb_out9),
    .pclk(pclk),
    .hcount_in(hcount_out8),
    .hsync_in(hsync_out8),
    .hblnk_in(hblnk_out8),
    .vcount_in(vcount_out8),
    .vsync_in(vsync_out8),
    .vblnk_in(vblnk_out8),
    .rgb_in(rgb_out8),
    .rst(rst),
    .square9(square1to9[8]),
    .start_en(start_en),
    .choice_en(choice_en),
    .square9_color(square1to9_color[8])
    );
    
    
endmodule

