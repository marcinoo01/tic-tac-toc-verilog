`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 04.08.2022 09:45:43
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input wire pclk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    );
    
    reg [11:0] rgb_out_nxt;
    reg hsync_out_nxt;
    reg vsync_out_nxt;
    reg [10:0] hcount_out_nxt;
    reg [10:0] vcount_out_nxt;
    reg hblnk_out_nxt;
    reg vblnk_out_nxt;
    
    always @(posedge pclk)
      begin
        if(rst)
        begin
            hsync_out <= 0;
            vsync_out <= 0;
            hblnk_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            vcount_out <= 0;
            rgb_out <= 0;
        end
        else
        begin
            hsync_out <= hsync_out_nxt;
            vsync_out <= vsync_out_nxt;
            vblnk_out <= vblnk_out_nxt;
            hblnk_out <= hblnk_out_nxt;
            hcount_out <= hcount_out_nxt;
            vcount_out <= vcount_out_nxt;
            rgb_out <= rgb_out_nxt;
        end
      end
    
    always@*
    begin
    
            hsync_out_nxt = hsync_in;
            vsync_out_nxt = vsync_in;
            hblnk_out_nxt = hblnk_in;
            vblnk_out_nxt = vblnk_in;
            hcount_out_nxt = hcount_in;
            vcount_out_nxt = vcount_in;
            
        // During blanking, make it it black.
            if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
            else
            begin
              // Active display, top edge, make a yellow line.
              if (vcount_in == 0) rgb_out_nxt = 12'hf_f_0;
              // Active display, bottom edge, make a red line.
              else if (vcount_in == 767) rgb_out_nxt = 12'hf_0_0;
              // Active display, left edge, make a green line.
              else if (hcount_in == 0) rgb_out_nxt = 12'h0_f_0;
              // Active display, right edge, make a blue line.
              else if (hcount_in == 1023) rgb_out_nxt = 12'h0_0_f;
              // Active display, interior, fill with gray.
              // You will replace this with your own test.
              //Moje inicjaly, pierwsze trzy "else" rysuja "H".
           /*   else if ((hcount_in >= 165) && (hcount_in <= 175) && (vcount_in >= 80) && (vcount_in <= 500)) rgb_out_nxt = 12'hf_0_0;
              
              
              else if ((vcount_in >= 290) && (vcount_in <= 300) && (hcount_in >= 175) && (hcount_in <= 325)) rgb_out_nxt = 12'hf_0_0;
              
              else if ((hcount_in <= 335) && (hcount_in >= 325) && (vcount_in >= 80) && (vcount_in <= 500)) rgb_out_nxt = 12'hf_0_0;
    
              
              //Nastepne "else" rysuja "K.
              else if ((hcount_in >= 440) && (hcount_in <= 450) && (vcount_in >= 80) && (vcount_in <= 500)) rgb_out_nxt = 12'h0_f_0;
              
              
              else if ((hcount_in >= 450) && (hcount_in <= 460) && (vcount_in >= 300) && (vcount_in <= 310)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 460) && (hcount_in <= 470) && (vcount_in >= 310) && (vcount_in <= 320)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 470) && (hcount_in <= 480) && (vcount_in >= 320) && (vcount_in <= 330)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 480) && (hcount_in <= 490) && (vcount_in >= 330) && (vcount_in <= 340)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 490) && (hcount_in <= 500) && (vcount_in >= 340) && (vcount_in <= 350)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 500) && (hcount_in <= 510) && (vcount_in >= 350) && (vcount_in <= 360)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 510) && (hcount_in <= 520) && (vcount_in >= 360) && (vcount_in <= 370)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 520) && (hcount_in <= 530) && (vcount_in >= 370) && (vcount_in <= 380)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 530) && (hcount_in <= 540) && (vcount_in >= 380) && (vcount_in <= 390)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 540) && (hcount_in <= 550) && (vcount_in >= 390) && (vcount_in <= 400)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 550) && (hcount_in <= 560) && (vcount_in >= 400) && (vcount_in <= 410)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 560) && (hcount_in <= 570) && (vcount_in >= 410) && (vcount_in <= 420)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 570) && (hcount_in <= 580) && (vcount_in >= 420) && (vcount_in <= 430)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 580) && (hcount_in <= 590) && (vcount_in >= 430) && (vcount_in <= 440)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 590) && (hcount_in <= 600) && (vcount_in >= 440) && (vcount_in <= 450)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 600) && (hcount_in <= 610) && (vcount_in >= 450) && (vcount_in <= 460)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 610) && (hcount_in <= 620) && (vcount_in >= 460) && (vcount_in <= 470)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 620) && (hcount_in <= 630) && (vcount_in >= 470) && (vcount_in <= 480)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 630) && (hcount_in <= 640) && (vcount_in >= 480) && (vcount_in <= 490)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 640) && (hcount_in <= 650) && (vcount_in >= 490) && (vcount_in <= 500)) rgb_out_nxt = 12'h0_f_0;
              
              else if ((hcount_in >= 450) && (hcount_in <= 460) && (vcount_in >= 290) && (vcount_in <= 300)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 460) && (hcount_in <= 470) && (vcount_in >= 280) && (vcount_in <= 290)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 470) && (hcount_in <= 480) && (vcount_in >= 270) && (vcount_in <= 280)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 480) && (hcount_in <= 490) && (vcount_in >= 260) && (vcount_in <= 270)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 490) && (hcount_in <= 500) && (vcount_in >= 250) && (vcount_in <= 260)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 500) && (hcount_in <= 510) && (vcount_in >= 240) && (vcount_in <= 250)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 510) && (hcount_in <= 520) && (vcount_in >= 230) && (vcount_in <= 240)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 520) && (hcount_in <= 530) && (vcount_in >= 220) && (vcount_in <= 230)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 530) && (hcount_in <= 540) && (vcount_in >= 210) && (vcount_in <= 220)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 540) && (hcount_in <= 550) && (vcount_in >= 200) && (vcount_in <= 210)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 550) && (hcount_in <= 560) && (vcount_in >= 190) && (vcount_in <= 200)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 560) && (hcount_in <= 570) && (vcount_in >= 180) && (vcount_in <= 190)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 570) && (hcount_in <= 580) && (vcount_in >= 170) && (vcount_in <= 180)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 580) && (hcount_in <= 590) && (vcount_in >= 160) && (vcount_in <= 170)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 590) && (hcount_in <= 600) && (vcount_in >= 150) && (vcount_in <= 160)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 600) && (hcount_in <= 610) && (vcount_in >= 140) && (vcount_in <= 150)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 610) && (hcount_in <= 620) && (vcount_in >= 130) && (vcount_in <= 140)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 620) && (hcount_in <= 630) && (vcount_in >= 120) && (vcount_in <= 130)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 630) && (hcount_in <= 640) && (vcount_in >= 110) && (vcount_in <= 120)) rgb_out_nxt = 12'h0_f_0;
              else if ((hcount_in >= 640) && (hcount_in <= 650) && (vcount_in >= 100) && (vcount_in <= 110)) rgb_out_nxt = 12'h0_f_0;
              */
              else rgb_out_nxt = 12'h8_8_8;    
            end
    end
    
endmodule

    
