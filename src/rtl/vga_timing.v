`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 04.08.2022 09:45:43
// Design Name: 
// Module Name: vga_timing
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


module vga_timing(
      output reg [10:0] vcount,
      output reg vsync,
      output reg vblnk,
      output reg [10:0] hcount,
      output reg hsync,
      output reg hblnk,
      input wire pclk,
      input wire rst
    );
    
  reg [10:0] hcount_nxt;
  reg [10:0] vcount_nxt;
  wire vsync_nxt;
  wire hsync_nxt;
  wire hblnk_nxt;
  wire vblnk_nxt;
  
  parameter H_DISP_TIME = 1024;
  parameter H_F_PORCH = 24;
  parameter H_S_PULSE = 136;
  parameter H_B_PORCH = 160;
  parameter V_DISP_TIME = 768;
  parameter V_F_PORCH = 3;
  parameter V_S_PULSE = 6;
  parameter V_B_PORCH = 29;
  parameter H_MAX = H_DISP_TIME + H_F_PORCH + H_S_PULSE + H_B_PORCH - 1;
  parameter V_MAX = V_DISP_TIME + V_F_PORCH + V_S_PULSE + V_B_PORCH - 1;
  
  always@(posedge pclk) begin
	if(rst) begin
		vcount <= 0;
		hcount <= 0;
		hsync <= 0;
        vsync <= 0;
        vblnk <= 0;
        hblnk <= 0;
    end 
    else begin
		hcount <= hcount_nxt;
		vcount <= vcount_nxt;
		hsync <= hsync_nxt;
		vsync <= vsync_nxt;
		vblnk <= vblnk_nxt;
		hblnk <= hblnk_nxt;
    end
  end
  
  assign hsync_nxt = ((hcount >= (H_DISP_TIME + H_F_PORCH - 1)) && (hcount < (H_MAX - H_B_PORCH))) ? 1:0;
  assign hblnk_nxt = (hcount >= (H_DISP_TIME - 1) && hcount < H_MAX) ? 1:0;
  
  always@* begin
	if(hcount == H_MAX)
        hcount_nxt = 0;
    else
        hcount_nxt = hcount + 1;
  end
  
  always@* begin
	if(hcount == H_MAX)
    begin
        if(vcount == V_MAX)
            vcount_nxt = 0;
        else
            vcount_nxt = vcount + 1;
    end
    else
    begin
        vcount_nxt = vcount;
    end
  end
  
  assign vsync_nxt = ((vcount >= V_DISP_TIME + 1) && (vcount <= (V_MAX - V_B_PORCH))) ? 1:0;
  assign vblnk_nxt = ((vcount >= V_DISP_TIME) && vcount <= V_MAX) ? 1:0;
  
    
endmodule
