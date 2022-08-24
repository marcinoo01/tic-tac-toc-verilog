`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 15.08.2022 11:07:38
// Design Name: 
// Module Name: char_rom
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


module char_rom(
    input wire [7:0] char_xy,
    output reg [6:0] char_code
    );
    
    always@*
    begin
        case(char_xy)
            8'h00: char_code = 7'h53; //S
            8'h01: char_code = 7'h74; //t
            8'h02: char_code = 7'h61; //a
            8'h03: char_code = 7'h72; //r
            8'h04: char_code = 7'h74; //t
            default: char_code = 7'h20;
        endcase
    end
    
endmodule
