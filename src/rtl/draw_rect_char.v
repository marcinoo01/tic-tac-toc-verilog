`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH UST
// Engineers: Hubert Kwaoniewski, Marcin Mistela
// 
// Create Date: 15.08.2022 10:39:59
// Design Name: 
// Module Name: draw_rect_char
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

module draw_rect_char(
    input wire pclk,
    input wire rst,
    input wire [10:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire [7:0] char_pixels,
    input wire start_en,
    input wire choice_en,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output wire [7:0] char_xy,
    output wire [3:0] char_line
    );
    
    reg hsync_nxt, vsync_nxt, hblnk_nxt, vblnk_nxt;
    reg [10:0] hcount_nxt, vcount_nxt;
    wire [10:0] hcount_rect, vcount_rect;
    reg [11:0] rgb_out_nxt;
    // DISPLAY TIC TAC TOC 
//          X,Y
//          
//          
//          
//        
//          
//    p1  p38   p2  p4     p6      p7          p10   p39 p11   p13     p14  p19    p20         p25  p40   p26  p28     p29     p32    p33
//   x x x x x x    x       x x x x             x x x x x x     x x x x x    x x x x            x x x x x x     x x x x x       x x x x
//        x         x       x                        x          x       x    x                       x          x       x       x
//        x         x       x                        x          x       x    x                       x          x       x       x
//        x         x       x                        x       p15x x x x x    x                       x          x       x   p34 x x x x  p35
//        x         x       x                        x          x    p16x    x                       x          x       x       x
//        x         x       x                        x          x       x    x                       x          x       x       x
//        x         x       x x x x                  x          x       x    x x x x                 x          x x x x x       x x x x
//        p3        p5     p8     p9               p12         p17     p18   p23    p24             p27         p30     p31     p36  p37
//          
//   M1          M2 M5      M6   M9          M12     M13    M16      M17        M22     M23  M28       M29   M34  M36  M38  M37 M40  M42      M43  M46    M47
//    x x x x x x   x x x x x    x           x x x x x      x x x x x           x x x x x    x x x x x x h1  x    x x x x x x   x     x x x x x    x       x
//    x             x       x    x           x       x      x       x           x            x      M30 x    x         x        x     x       x    x x     x
//    x             x       x    x           x       x      x       x           x       M25  x          x    x         x        x     x       x    x  x    x
//    x             x       x    x           x       x  M18 xx x x x  M19   M24 x x x x x    x          x    x         x        x     x       x    x   x   x     
//    x             x       x    x           x       x      x   x               x            x          x    x         x        x     x       x    x    x  x
//    x             x       x    x           x       x      x    x              x            x      M31 x    x         x        x     x       x    x     x x 
//    x x x x x x   x x x x x    x x x x x   x x x x x      x      x            x x x x x    x x x x x x h2  x         x        x     x x x x x    x       x
//    M3        M4  M7      M8   M10     M11 M14     M15    M20      M21      M26       M27 M32       M33    M35      M39       M41   M44     M45  M48      M49
//
//
//  
    localparam P_X_DIMENSION_ROTATION = 11'd100;
    localparam P_Y_DIMENSION_ROTATION = 11'd100;

    localparam P1_X = 11'd30 + P_X_DIMENSION_ROTATION;   //P1(x,y)= (30,100)
    localparam P1_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P2_X = 11'd100 + P_X_DIMENSION_ROTATION;  //P2(x,y)= (100,100)
    localparam P2_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P38_X = 11'd65 + P_X_DIMENSION_ROTATION;   //P38(x,y) = (65, 100)
    localparam P38_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P3_X = 11'd65 + P_X_DIMENSION_ROTATION;   //P3(x,y)= (65,200)
    localparam P3_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P4_X = 11'd120 + P_X_DIMENSION_ROTATION;  //P4(x,y)= (120,100)
    localparam P4_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P5_X = 11'd120 + P_X_DIMENSION_ROTATION;  //P5(x,y)= (120,200)
    localparam P5_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P6_X = 11'd140 + P_X_DIMENSION_ROTATION; //P6(x,y)= (140,100)
    localparam P6_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P7_X = 11'd210 + P_X_DIMENSION_ROTATION;  //P7(x,y)= (210,100)
    localparam P7_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P8_X = 11'd140 + P_X_DIMENSION_ROTATION;   //P8(x,y)= (140,200)
    localparam P8_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P9_X = 11'd210 + P_X_DIMENSION_ROTATION;   //P9(x,y)= (210,200)
    localparam P9_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P10_X = 11'd250 + P_X_DIMENSION_ROTATION;  //P10(x,y)= (250,100)
    localparam P10_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P11_X = 11'd320 + P_X_DIMENSION_ROTATION;  //P11(x,y)= (320,100)
    localparam P11_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P39_X = 11'd285 + P_X_DIMENSION_ROTATION;  //P39(x,y)= (285,100)
    localparam P39_Y = 11'd100 + P_Y_DIMENSION_ROTATION;

    localparam P12_X = 11'd285 + P_X_DIMENSION_ROTATION;  //P12(x,y)= (285,200)
    localparam P12_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P13_X = 11'd340 + P_X_DIMENSION_ROTATION;  //P13(x,y)= (340,100)
    localparam P13_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P14_X = 11'd410 + P_X_DIMENSION_ROTATION;  //P14(x,y)= (410,100)
    localparam P14_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P15_X = 11'd340 + P_X_DIMENSION_ROTATION;  //P15(x,y)= (340,150)
    localparam P15_Y = 11'd150 + P_Y_DIMENSION_ROTATION;
    
    localparam P16_X = 11'd410 + P_X_DIMENSION_ROTATION;  //P15(x,y)= (410,150)
    localparam P16_Y = 11'd150 + P_Y_DIMENSION_ROTATION;
    
    localparam P17_X = 11'd340 + P_X_DIMENSION_ROTATION;  //P13(x,y)= (340,200)
    localparam P17_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P18_X = 11'd410 + P_X_DIMENSION_ROTATION;  //P18(x,y)= (410,200)
    localparam P18_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P19_X = 11'd430 + P_X_DIMENSION_ROTATION;  //P19(x,y)= (430,100)
    localparam P19_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P20_X = 11'd500 + P_X_DIMENSION_ROTATION;  //P20(x,y)= (500,100)
    localparam P20_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P23_X = 11'd430 + P_X_DIMENSION_ROTATION;  //P23(x,y)= (430,200)
    localparam P23_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P24_X = 11'd500 + P_X_DIMENSION_ROTATION; //P24(x,y)= (500,200)
    localparam P24_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P25_X = 11'd540 + P_X_DIMENSION_ROTATION;  //P25(x,y)= (540,100)
    localparam P25_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P26_X = 11'd610 + P_X_DIMENSION_ROTATION;  //P26(x,y)= (610,100)
    localparam P26_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P40_X = 11'd575 + P_X_DIMENSION_ROTATION;  //P40(x,y)= (575,100)
    localparam P40_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P27_X = 11'd575 + P_X_DIMENSION_ROTATION;  //P27(x,y)= (575,150)
    localparam P27_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P28_X = 11'd630 + P_X_DIMENSION_ROTATION;  //P28(x,y)= (630,100)
    localparam P28_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P29_X = 11'd700 + P_X_DIMENSION_ROTATION;  //P29(x,y)= (700,100)
    localparam P29_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P30_X = 11'd630 + P_X_DIMENSION_ROTATION;  //P30(x,y)= (630,200)
    localparam P30_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P31_X = 11'd700 + P_X_DIMENSION_ROTATION;  //P31(x,y)= (700,200)
    localparam P31_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P32_X = 11'd720 + P_X_DIMENSION_ROTATION;  //P32(x,y)= (720,100)
    localparam P32_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P33_X = 11'd790 + P_X_DIMENSION_ROTATION;  //P33(x,y)= (790,100)
    localparam P33_Y = 11'd100 + P_Y_DIMENSION_ROTATION;
    
    localparam P34_X = 11'd720 + P_X_DIMENSION_ROTATION;  //P34(x,y)= (720,150)
    localparam P34_Y = 11'd150 + P_Y_DIMENSION_ROTATION;
    
    localparam P35_X = 11'd790 + P_X_DIMENSION_ROTATION;  //P35(x,y)= (790,150)
    localparam P35_Y = 11'd150 + P_Y_DIMENSION_ROTATION;
    
    localparam P36_X = 11'd720 + P_X_DIMENSION_ROTATION;  //P36(x,y)= (720,200)
    localparam P36_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam P37_X = 11'd790 + P_X_DIMENSION_ROTATION;  //P37(x,y)= (790,200)
    localparam P37_Y = 11'd200 + P_Y_DIMENSION_ROTATION;
    
    localparam M_X_DIMENSION_ROTATION = 11'd0;
    localparam M_Y_DIMENSION_ROTATION = 11'd40;
    
    localparam M1_X = 11'd100 + M_X_DIMENSION_ROTATION; // M1(x,y) = (100, 300)
    localparam M1_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M2_X = 11'd150 + M_X_DIMENSION_ROTATION; // M2(x,y) = (150, 300)
    localparam M2_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M3_X = 11'd100 + M_X_DIMENSION_ROTATION; // M3(x,y) = (100, 380)
    localparam M3_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M4_X = 11'd150 + M_X_DIMENSION_ROTATION; // M4(x,y) = (150, 380)
    localparam M4_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M5_X = 11'd170 + M_X_DIMENSION_ROTATION; // M5(x,y) = (170, 300)
    localparam M5_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M6_X = 11'd220 + M_X_DIMENSION_ROTATION; // M6(x,y) = (220, 300)
    localparam M6_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M7_X = 11'd170 + M_X_DIMENSION_ROTATION; // M7(x,y) = (170, 380)
    localparam M7_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M8_X = 11'd220 + M_X_DIMENSION_ROTATION; // M8(x,y) = (220, 380)
    localparam M8_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
        
    localparam M9_X = 11'd240 + M_X_DIMENSION_ROTATION; // M9(x,y) = (240, 300)
    localparam M9_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M10_X = 11'd240 + M_X_DIMENSION_ROTATION; // M10(x,y) = (240, 380)
    localparam M10_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M11_X = 11'd290 + M_X_DIMENSION_ROTATION; // M11(x,y) = (290, 380)
    localparam M11_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
     
    localparam M12_X = 11'd310 + M_X_DIMENSION_ROTATION; // M12(x,y) = (310, 300)
    localparam M12_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M13_X = 11'd360 + M_X_DIMENSION_ROTATION; // M13(x,y) = (360, 300)
    localparam M13_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M14_X = 11'd310 + M_X_DIMENSION_ROTATION; // M14(x,y) = (310, 380)
    localparam M14_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M15_X = 11'd360 + M_X_DIMENSION_ROTATION; // M15(x,y) = (360, 380)
    localparam M15_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M16_X = 11'd380 + M_X_DIMENSION_ROTATION; // M16(x,y) = (380, 300)
    localparam M16_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M17_X = 11'd430 + M_X_DIMENSION_ROTATION; // M17(x,y) = (430, 300)
    localparam M17_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M18_X = 11'd380 + M_X_DIMENSION_ROTATION; // M18(x,y) = (380, 340)
    localparam M18_Y = 11'd340 + M_Y_DIMENSION_ROTATION;
    
    localparam M19_X = 11'd430 + M_X_DIMENSION_ROTATION; // M19(x,y) = (430, 340)
    localparam M19_Y = 11'd340 + M_Y_DIMENSION_ROTATION;
    
    localparam M20_X = 11'd380 + M_X_DIMENSION_ROTATION; // M20(x,y) = (380, 380)
    localparam M20_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M21_X = 11'd430 + M_X_DIMENSION_ROTATION; // M21(x,y) = (430, 380)
    localparam M21_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M22_X = 11'd500 + M_X_DIMENSION_ROTATION; // M22(x,y) = (500, 300)
    localparam M22_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M23_X = 11'd550 + M_X_DIMENSION_ROTATION; // M23(x,y) = (550, 300)
    localparam M23_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M24_X = 11'd500 + M_X_DIMENSION_ROTATION; // M24(x,y) = (500, 340)
    localparam M24_Y = 11'd340 + M_Y_DIMENSION_ROTATION;
    
    localparam M25_X = 11'd550 + M_X_DIMENSION_ROTATION; // M25(x,y) = (550, 340)
    localparam M25_Y = 11'd340 + M_Y_DIMENSION_ROTATION;
    
    localparam M26_X = 11'd500 + M_X_DIMENSION_ROTATION; // M26(x,y) = (500, 380)
    localparam M26_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M27_X = 11'd550 + M_X_DIMENSION_ROTATION; // M27(x,y) = (550, 380)
    localparam M27_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M28_X = 11'd570 + M_X_DIMENSION_ROTATION; // M28(x,y) = (570, 300)
    localparam M28_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M29_X = 11'd615 + M_X_DIMENSION_ROTATION; // M29(x,y) = (615, 300)
    localparam M29_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam H1_X = 11'd620 + M_X_DIMENSION_ROTATION; // H1(x,y) = (620, 300)
    localparam H1_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam H2_X = 11'd620 + M_X_DIMENSION_ROTATION; // H1(x,y) = (620, 300)
    localparam H2_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M30_X = 11'd620 + M_X_DIMENSION_ROTATION; // M30(x,y) = (620, 305)
    localparam M30_Y = 11'd305 + M_Y_DIMENSION_ROTATION;
    
    localparam M31_X = 11'd620 + M_X_DIMENSION_ROTATION; // M31(x,y) = (620, 375)
    localparam M31_Y = 11'd375 + M_Y_DIMENSION_ROTATION;
    
    localparam M32_X = 11'd570 + M_X_DIMENSION_ROTATION; // M32(x,y) = (570, 380)
    localparam M32_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M33_X = 11'd615 + M_X_DIMENSION_ROTATION; // M33(x,y) = (615, 380)
    localparam M33_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M34_X = 11'd640 + M_X_DIMENSION_ROTATION; // M34(x,y) = (640, 300)
    localparam M34_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M35_X = 11'd640 + M_X_DIMENSION_ROTATION; // M35(x,y) = (640, 380)
    localparam M35_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M36_X = 11'd660 + M_X_DIMENSION_ROTATION; // M36(x,y) = (660, 300)
    localparam M36_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M37_X = 11'd710 + M_X_DIMENSION_ROTATION; // M37(x,y) = (710, 300)
    localparam M37_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M38_X = 11'd685 + M_X_DIMENSION_ROTATION; // M38(x,y) = (685, 300)
    localparam M38_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M39_X = 11'd685 + M_X_DIMENSION_ROTATION; // M38(x,y) = (685, 380)
    localparam M39_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M40_X = 11'd710 + M_X_DIMENSION_ROTATION; // M40(x,y) = (710, 300)
    localparam M40_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M41_X = 11'd710 + M_X_DIMENSION_ROTATION; // M41(x,y) = (710, 380)
    localparam M41_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M42_X = 11'd730 + M_X_DIMENSION_ROTATION; // M42(x,y) = (730, 300)
    localparam M42_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M43_X = 11'd780 + M_X_DIMENSION_ROTATION; // M43(x,y) = (780, 300)
    localparam M43_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M44_X = 11'd730 + M_X_DIMENSION_ROTATION; // M44(x,y) = (730, 380)
    localparam M44_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M45_X = 11'd780 + M_X_DIMENSION_ROTATION; // M45(x,y) = (780, 380)
    localparam M45_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M46_X = 11'd800 + M_X_DIMENSION_ROTATION; // M46(x,y) = (800, 300)
    localparam M46_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M47_X = 11'd850 + M_X_DIMENSION_ROTATION; // M47(x,y) = (850, 300)
    localparam M47_Y = 11'd300 + M_Y_DIMENSION_ROTATION;
    
    localparam M48_X = 11'd800 + M_X_DIMENSION_ROTATION; // M48(x,y) = (800, 380)
    localparam M48_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam M49_X = 11'd850 + M_X_DIMENSION_ROTATION; // M49(x,y) = (850, 380)
    localparam M49_Y = 11'd380 + M_Y_DIMENSION_ROTATION;
    
    localparam WIDTH = 40;
    localparam LENGTH = 15;
    localparam LETTERS_COLOR = 12'h3_3_3;
    localparam BACKGROUND_COLOR = 12'he_e_e;
    localparam RED_COLOR = 12'hf_0_0;
    localparam RECT_X_POS = 490;
    localparam RECT_Y_POS = 600;
    
    
    reg [11:0] pk, pk_nxt;
    
    always@(posedge pclk)
    begin
        if(rst)
        begin
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            rgb_out <= 0;
            pk <= 0;
        end
        else
        begin
            hcount_out <= hcount_nxt;
            hsync_out <= hsync_nxt;
            hblnk_out <= hblnk_nxt;
            vcount_out <= vcount_nxt;
            vsync_out <= vsync_nxt;
            vblnk_out <= vblnk_nxt;
            rgb_out <= rgb_out_nxt;
            pk = pk_nxt;
        end
    end
    
    always@*
    begin
        hblnk_nxt = hblnk_in;
        vblnk_nxt = vblnk_in;
        vsync_nxt = vsync_in;
        hsync_nxt = hsync_in;
        hcount_nxt = hcount_in;
        vcount_nxt = vcount_in;
        pk_nxt = pk;
        
        if(~start_en)
        begin
            if((vcount_in >= RECT_Y_POS) && (vcount_in < RECT_Y_POS + LENGTH) && (hcount_in >= RECT_X_POS) && (hcount_in < RECT_X_POS + WIDTH))
            begin
                if(char_pixels[4'b1000 - hcount_rect[3:0]])
                    rgb_out_nxt = LETTERS_COLOR;
                else
                    rgb_out_nxt = BACKGROUND_COLOR;
            end
            //line p1 - p2
            else if(vcount_in == P1_Y && (hcount_in >= P1_X && hcount_in <= P2_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p38 - p3
            else if(hcount_in == P3_X && (vcount_in >= P38_Y && vcount_in <= P3_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p4 - p5
            else if(hcount_in == P4_X && (vcount_in >= P4_Y && vcount_in <= P5_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p6 - p8
            else if(hcount_in == P6_X && (vcount_in >= P6_Y && vcount_in <= P8_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p6 - p7
            else if(vcount_in == P6_Y && (hcount_in >= P6_X && hcount_in <= P7_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p8 - p9
            else if(vcount_in == P8_Y && (hcount_in >= P8_X && hcount_in <= P9_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p10 - p11
            else if(vcount_in == P10_Y && (hcount_in >= P10_X && hcount_in <= P11_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p39 - p12
            else if(hcount_in == P12_X && (vcount_in >= P39_Y && vcount_in <= P12_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p13 - p17
            else if(hcount_in == P13_X && (vcount_in >= P13_Y && vcount_in <= P17_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p14- p18
            else if(hcount_in == P14_X && (vcount_in >= P14_Y && vcount_in <= P18_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p14- p13
            else if(vcount_in == P14_Y && (hcount_in >= P13_X && hcount_in <= P14_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p15- p16
            else if(vcount_in == P15_Y && (hcount_in >= P15_X && hcount_in <= P16_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p19- p20
            else if(vcount_in == P19_Y && (hcount_in >= P19_X && hcount_in <= P20_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end    
           //line p23- p24
            else if(vcount_in == P23_Y && (hcount_in >= P23_X && hcount_in <= P24_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p19- p23
            else if(hcount_in == P23_X && (vcount_in >= P19_Y && vcount_in <= P23_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p40- p27
            else if(hcount_in == P27_X && (vcount_in >= P40_Y && vcount_in <= P27_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p25- p26
            else if(vcount_in == P25_Y && (hcount_in >= P25_X && hcount_in <= P26_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p28- p29
            else if(vcount_in == P28_Y && (hcount_in >= P28_X && hcount_in <= P29_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p30- p31
            else if(vcount_in == P30_Y && (hcount_in >= P30_X && hcount_in <= P31_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p28- p30
            else if(hcount_in == P30_X && (vcount_in >= P28_Y && vcount_in <= P30_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p29- p31
            else if(hcount_in == P29_X && (vcount_in >= P29_Y && vcount_in <= P31_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p32- p36
            else if(hcount_in == P32_X && (vcount_in >= P32_Y && vcount_in <= P36_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p32- p33
            else if(vcount_in == P32_Y && (hcount_in >= P32_X && hcount_in <= P33_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p34- p35
            else if(vcount_in == P34_Y && (hcount_in >= P34_X && hcount_in <= P35_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p36- p37
            else if(vcount_in == P36_Y && (hcount_in >= P36_X && hcount_in <= P37_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M1- M2
            else if(vcount_in == M1_Y && (hcount_in >= M1_X && hcount_in <= M2_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M1- M3
            else if(hcount_in == M1_X && (vcount_in >= M1_Y && vcount_in <= M3_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M3- M4
            else if(vcount_in == M3_Y && (hcount_in >= M3_X && hcount_in <= M4_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end 
            //line M5- M6
            else if(vcount_in == M5_Y && (hcount_in >= M5_X && hcount_in <= M6_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M7- M8
            else if(vcount_in == M7_Y && (hcount_in >= M7_X && hcount_in <= M8_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M5- M7
            else if(hcount_in == M5_X && (vcount_in >= M5_Y && vcount_in <= M7_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M6- M8
            else if(hcount_in == M6_X && (vcount_in >= M6_Y && vcount_in <= M8_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end                
            //line M9- M10
            else if(hcount_in == M9_X && (vcount_in >= M9_Y && vcount_in <= M10_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M10- M11
            else if(vcount_in == M10_Y && (hcount_in >= M10_X && hcount_in <= M11_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M12- M13
            else if(vcount_in == M12_Y && (hcount_in >= M12_X && hcount_in <= M13_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M14- M15
            else if(vcount_in == M14_Y && (hcount_in >= M14_X && hcount_in <= M15_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M12- M14
            else if(hcount_in == M12_X && (vcount_in >= M12_Y && vcount_in <= M14_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M13- M15
            else if(hcount_in == M13_X && (vcount_in >= M13_Y && vcount_in <= M15_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M16- M20
            else if(hcount_in == M16_X && (vcount_in >= M16_Y && vcount_in <= M20_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M17- M19
            else if(hcount_in == M17_X && (vcount_in >= M17_Y && vcount_in <= M19_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M16- M17
            else if(vcount_in == M16_Y && (hcount_in >= M16_X && hcount_in <= M17_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M18- M19
            else if(vcount_in == M18_Y && (hcount_in >= M18_X && hcount_in <= M19_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M18- M21
            else if((vcount_in > M18_Y && vcount_in < M20_Y) && (hcount_in >= M18_X && hcount_in <= M19_X))//diagonal
                begin
                    if(hcount_in == M18_X + pk && vcount_in == M18_Y + pk) begin
                        rgb_out_nxt = RED_COLOR;
                        pk_nxt = pk + 1;
                    end
                end
            //line M22- M23
            else if(vcount_in == M22_Y && (hcount_in >= M22_X && hcount_in <= M23_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M24- M25
            else if(vcount_in == M24_Y && (hcount_in >= M24_X && hcount_in <= M25_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M26- M27
            else if(vcount_in == M26_Y && (hcount_in >= M26_X && hcount_in <= M27_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M22- M26
            else if(hcount_in == M22_X && (vcount_in >= M22_Y && vcount_in <= M26_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M28- M32
            else if(hcount_in == M32_X && (vcount_in >= M28_Y && vcount_in <= M32_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M28- M29
            else if(vcount_in == M28_Y && (hcount_in >= M28_X && hcount_in <= M29_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M31- M33
            else if((vcount_in > M31_Y && vcount_in < M33_Y) && (hcount_in >= M33_X && hcount_in <= H2_X))//diagonal
                begin
                    if(hcount_in == M31_X + pk && vcount_in == M31_Y + pk) begin
                        rgb_out_nxt = RED_COLOR;
                        pk_nxt = pk + 1;
                    end
                end  
            //line M29- M30
            else if((vcount_in > M29_Y && vcount_in < M30_Y) && (hcount_in >= M29_X && hcount_in <= H1_X))//diagonal
                begin
                    if(hcount_in == M29_X + pk && vcount_in == M29_Y + pk) begin
                        rgb_out_nxt = RED_COLOR;
                        pk_nxt = pk + 1;
                    end
                end  
            //line M32- M33
            else if(vcount_in == M32_Y && (hcount_in >= M32_X && hcount_in <= M33_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M30- M31
            else if(hcount_in == M31_X && (vcount_in >= M30_Y && vcount_in <= M31_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M34- M35
            else if(hcount_in == M34_X && (vcount_in >= M34_Y && vcount_in <= M35_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M37- M38
            else if(hcount_in == M37_X && (vcount_in >= M37_Y && vcount_in <= M38_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M38- M39
            else if(vcount_in == M38_Y && (hcount_in >= M38_X && hcount_in <= M39_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M40- M41
            else if(hcount_in == M40_X && (vcount_in >= M40_Y && vcount_in <= M41_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M42- M44
            else if(hcount_in == M42_X && (vcount_in >= M42_Y && vcount_in <= M44_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M42- M43
            else if(vcount_in == M42_Y && (hcount_in >= M42_X && hcount_in <= M43_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M43- M45
            else if(hcount_in == M43_X && (vcount_in >= M43_Y && vcount_in <= M45_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M44- M45
            else if(vcount_in == M44_Y && (hcount_in >= M44_X && hcount_in <= M45_X))//horizontal
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line M46- M48
            else if(hcount_in == M46_X && (vcount_in >= M46_Y && vcount_in <= M48_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M47- M49
            else if(hcount_in == M47_X && (vcount_in >= M47_Y && vcount_in <= M49_Y))//vertical
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line M46- M49
            else if((vcount_in > M46_Y && vcount_in < M48_Y) && (hcount_in >= M46_X && hcount_in <= M47_X))//diagonal
                begin
                    if(hcount_in == M46_X + pk && vcount_in == M46_Y + pk) begin
                        rgb_out_nxt = RED_COLOR;
                        pk_nxt = pk + 1;
                    end
                end
            else
            begin
                rgb_out_nxt = 12'h8_8_8;
            end
        end
        else if(choice_en)
        begin
            if((vcount_in >= 300) && (vcount_in < 300 + LENGTH) && (hcount_in >= 470) && (hcount_in < 470 + 110))
            begin
                if(char_pixels[4'b1000 - hcount_rect[3:0]])
                    rgb_out_nxt = LETTERS_COLOR;
                else
                    rgb_out_nxt = BACKGROUND_COLOR;
            end
            else if((vcount_in >= 450) && (vcount_in <= 550) && (hcount_in >= 300) && (hcount_in <= 400))
            begin
                rgb_out_nxt = 12'h0_0_f;
            end
            else if((vcount_in >= 450) && (vcount_in <= 550) && (hcount_in >= 650) && (hcount_in <= 750))
            begin
                rgb_out_nxt = 12'hf_f_0;
            end
            else
            begin
                rgb_out_nxt = 12'h8_8_8;
            end
        end
        else
        begin
            rgb_out_nxt = 12'h8_8_8;
        end
    end
    
    assign vcount_rect = choice_en ? (vcount_in - 300) : (vcount_in - RECT_Y_POS);
    assign hcount_rect = choice_en ? (hcount_in - 470): (hcount_in - RECT_X_POS);
    assign char_xy = {vcount_rect[7:4], hcount_rect[6:3]};
    assign char_line = vcount_rect[3:0];
    
endmodule