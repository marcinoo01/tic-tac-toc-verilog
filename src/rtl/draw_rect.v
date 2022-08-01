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
      input wire rst
      //input wire [11:0] xpos,
      //input wire [11:0] ypos
    );
    
    localparam RECT_WIDTH = 100;
    localparam RECT_LENGTH = 50;
    localparam RECT_COLOR = 12'hf_f_0;
    
    reg [11:0] rgb_out_nxt;
    reg hsync_out_nxt;
    reg vsync_out_nxt;
    reg [10:0] hcount_out_nxt;
    reg [10:0] vcount_out_nxt;
    reg hblnk_out_nxt;
    reg vblnk_out_nxt;
    
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
        vcount_out_nxt = vcount_in;
        hcount_out_nxt = hcount_in;
        hsync_out_nxt = hsync_in;
        hblnk_out_nxt = hblnk_in;
        vsync_out_nxt = vsync_in;
        vblnk_out_nxt = vblnk_in;
        
        //if(hcount_in >= xpos && hcount_in < (xpos + RECT_WIDTH) && vcount_in >= ypos && vcount_in < (ypos + RECT_LENGTH))
            //begin
                //rgb_out_nxt = RECT_COLOR;
            //end            if(((hcount_in >= 339) && (hcount_in <= 343)) || ((hcount_in >= 680) && (hcount_in <= 684)))
            begin
                rgb_out_nxt = 12'h0_0_0;
            end
            else if((vcount_in >= 252) && (vcount_in <= 258) || (vcount_in >= 508) && (vcount_in <= 514))
            begin
                rgb_out_nxt = 12'h0_0_0;
            end
            else
            begin
                rgb_out_nxt = rgb_in;
            end
    end
    
    
endmodule

