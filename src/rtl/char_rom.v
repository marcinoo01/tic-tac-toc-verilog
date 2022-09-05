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
    input wire choice_en,
    input wire [1:0] display_winner,
    output reg [6:0] char_code
    );
    
    always@*
    begin
        if(display_winner == 2'b01)
        begin
            case(char_xy)
                8'h00: char_code = 7'h20; //
                8'h01: char_code = 7'h42; //B
                8'h02: char_code = 7'h4c; //L
                8'h03: char_code = 7'h55; //U
                8'h04: char_code = 7'h45; //E 
                8'h05: char_code = 7'h20; //  
                8'h06: char_code = 7'h57; //W   
                8'h07: char_code = 7'h49; //I  
                8'h08: char_code = 7'h4e; //N 
                8'h09: char_code = 7'h53; //S  
                8'h0a: char_code = 7'h21; //! 
                8'h0b: char_code = 7'h20; //
                8'h0c: char_code = 7'h20; //
                default: char_code = 7'h20;
            endcase 
        end
        else if(display_winner == 2'b10)
        begin
            case(char_xy)
                8'h00: char_code = 7'h20; //
                8'h01: char_code = 7'h59; //Y
                8'h02: char_code = 7'h45; //E
                8'h03: char_code = 7'h4c; //L
                8'h04: char_code = 7'h4c; //L
                8'h05: char_code = 7'h4f; //O  
                8'h06: char_code = 7'h57; //W   
                8'h07: char_code = 7'h20; //  
                8'h08: char_code = 7'h57; //W
                8'h09: char_code = 7'h49; //I 
                8'h0a: char_code = 7'h4e; //N 
                8'h0b: char_code = 7'h53; //S
                8'h0c: char_code = 7'h21; //!
                default: char_code = 7'h20;
            endcase 
        end
        else
        begin
            case(char_xy)
                8'h00: char_code = choice_en ? 7'h43 : 7'h53; //C : S
                8'h01: char_code = choice_en ? 7'h68 : 7'h74; //h : t
                8'h02: char_code = choice_en ? 7'h6f : 7'h61; //o : a
                8'h03: char_code = choice_en ? 7'h6f : 7'h72; //o : r
                8'h04: char_code = choice_en ? 7'h73 : 7'h74; //s : t
                8'h05: char_code = choice_en ? 7'h65 : 7'h20; //e : 
                8'h06: char_code = choice_en ? 7'h20 : 7'h20; //  : 
                8'h07: char_code = choice_en ? 7'h63 : 7'h20; //c : 
                8'h08: char_code = choice_en ? 7'h6f : 7'h20; //o : 
                8'h09: char_code = choice_en ? 7'h6c : 7'h20; //l : 
                8'h0a: char_code = choice_en ? 7'h6f : 7'h20; //o : 
                8'h0b: char_code = choice_en ? 7'h72 : 7'h20; //r : 
                8'h0c: char_code = choice_en ? 7'h3a : 7'h20; //: : 
                default: char_code = 7'h20;
            endcase
         end
    end
    
endmodule
