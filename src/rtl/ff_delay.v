`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 04.08.2022 09:45:43
// Design Name: 
// Module Name: ff_delay
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


module ff_delay(
    input wire pclk,
    input wire rst,
    input wire hsync_in,
    input wire vsync_in,
    output reg hsync_out,
    output reg vsync_out
    );
    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            hsync_out <= 0;
            vsync_out <= 0;
        end
        else
        begin
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
        end
    end
    
    
endmodule
