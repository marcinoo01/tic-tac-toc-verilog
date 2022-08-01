`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 04.08.2022 09:45:43
// Design Name: 
// Module Name: reset_delay
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


module reset_delay(
    input wire pclk,
    input wire locked,
    output reg rst_d
    );
    
    reg [7:0] safe_start;
    reg rst_d_nxt;
    
    always @(posedge pclk or negedge locked) 
    begin
        if(!locked)
        begin
            safe_start <= 0;
            rst_d <= 1;
        end
        else
        begin
            safe_start <= {safe_start[6:0],locked};
            rst_d <= rst_d_nxt;
        end
    end
    
    always@*
    begin
        if(safe_start == 8'b11111111)
            rst_d_nxt = 0;
        else
            rst_d_nxt = 1;
    end

    
    
endmodule
