`timescale 1ns / 1ps
 //////////////////////////////////////////////////////////////////////////////////
 // Company: AGH UST
 // Engineers: Hubert Kwaœniewski, Marcin Mistela
 // 
 // Create Date: 06.08.2022 15:23:35
 // Design Name: 
 // Module Name: ff_synchronizer
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


 module ff_synchronizer #(parameter WIDTH = 1)
    (
     input wire pclk,
     input wire rst,
     input wire [WIDTH - 1 : 0] din,
     output reg [WIDTH - 1 : 0] dout
     );

     always@(posedge pclk)
     begin
         if(rst)
             dout <= 0;
         else
             dout <= din;
     end

 endmodule