`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwa�niewski, Marcin Mistela
// 
// Create Date: 23.08.2022 15:33:48
// Design Name: 
// Module Name: mod_m_counter
// Project Name: Tic-tac-toe game
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: �r�d�o kodu: kod udost�pniony na zaj�ciach laboratoryjnych z przedmiotu Uk�ady Elektroniki Cyfrowej 2
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_m_counter
   #(
    parameter N=4, // number of bits in counter
              M=10 // mod-M
   )
   (
    input wire clk, reset,
    output wire max_tick,
    output wire [N-1:0] q
   );

   //signal declaration
   reg [N-1:0] r_reg;
   wire [N-1:0] r_next;

   // body
   // register
   always @(posedge clk, posedge reset)
      if (reset)
         r_reg <= 0;
      else
         r_reg <= r_next;

   // next-state logic
   assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1;
   // output logic
   assign q = r_reg;
   assign max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;

endmodule
