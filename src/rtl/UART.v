`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaœniewski, Marcin Mistela
// 
// Create Date: 23.08.2022 15:27:16
// Design Name: 
// Module Name: UART
// Project Name: Tic-tac-toe game
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: modu³ uart_unit udostêpniony na zajêciach z przedmiotu Uk³ady Elektroniki Cyfrowej 2
// 
//////////////////////////////////////////////////////////////////////////////////


module UART(
    input wire [7:0] w_data,
    input wire clk, reset,
    input wire uart_mode, // 0: tx, 1: rx
    input wire uart_en,
    output wire tx,
    input wire rx,
    output reg rx_tx_done,
    output reg [7:0] rec_data
);

      wire tx_full, rx_empty, dot, rx_done_tick, tx_done_tick; 
      reg rx_tx_done_nxt; 
      reg wr_uart, wr_uart_nxt, rd_uart, rd_uart_nxt;
      wire [7:0] r_data;
      reg [7:0] rec_data_nxt; 
      reg tx_tick_detect, tx_tick_detect_nxt, rx_tick_detect, rx_tick_detect_nxt, rx_block, rx_block_nxt;
   
   always@(posedge clk)
   begin
       if(reset)
       begin
           rec_data <= 0;
           rd_uart <= 0;
           wr_uart <= 0;
           tx_tick_detect <= 0;
           rx_tick_detect <= 0;
           rx_tx_done <= 0;
           rx_block <= 0;
       end
       else
       begin
           rec_data <= rec_data_nxt;
           rd_uart <= rd_uart_nxt;
           wr_uart <= wr_uart_nxt;
           tx_tick_detect <= tx_tick_detect_nxt;
           rx_tick_detect <= rx_tick_detect_nxt;
           rx_tx_done <= rx_tx_done_nxt;
           rx_block <= rx_block_nxt;
       end
   end
    
    
    
   always@*
   begin
       rx_block_nxt = rx_block;
       tx_tick_detect_nxt = tx_tick_detect;
       rx_tick_detect_nxt = rx_tick_detect;
       
       if(uart_en)
       begin
           case(uart_mode)
              1'b0:
              begin
                 if(tx_tick_detect != 1)
                 begin
                     wr_uart_nxt = 1;
                     rd_uart_nxt = 0;
                     rec_data_nxt = 0;
                     rx_tx_done_nxt = 1;
                 end
                 else
                 begin
                     wr_uart_nxt = 0;
                     rd_uart_nxt = 0;
                     rec_data_nxt = 0;
                     rx_tx_done_nxt = 0;
                     if(tx_full)
                       begin
                          tx_tick_detect_nxt = 1;
                       end
                 end
              end
              1'b1:
              begin
                 if(rx_tick_detect == 1 && ~rx_block)
                 begin
                     wr_uart_nxt = 0;
                     rd_uart_nxt = 1;
                     rec_data_nxt = r_data;
                     rx_tx_done_nxt = 1;
                     rx_block_nxt = 1;
                 end
                 else
                 begin
                     wr_uart_nxt = 0;
                     rd_uart_nxt = 0;
                     rec_data_nxt = rec_data;
                     rx_tx_done_nxt = 0;
                     if(rx_done_tick)
                       begin
                         rx_tick_detect_nxt = 1;
                       end
                       else
                       begin
                         rx_tick_detect_nxt = 0;
                       end
                 end
              end
           endcase
       end
       else
       begin
          rd_uart_nxt = 0;
          wr_uart_nxt = 0;
          rec_data_nxt = rec_data;
          rx_tx_done_nxt = 0;
          tx_tick_detect_nxt = 0;
          rx_tick_detect_nxt = 0;
          rx_block_nxt = 0;
       end
   end
    

   uart_unit uart_unit
      (.clk(clk), .reset(reset), .rd_uart(rd_uart),
       .wr_uart(wr_uart), .rx(rx), .w_data(w_data),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(r_data), .tx(tx),  .rx_done_tick(rx_done_tick), .tx_done_tick(tx_done_tick));
          


endmodule