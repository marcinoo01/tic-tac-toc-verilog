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
//          1024x768
//          
//  
    localparam X_DIMENSION_ROTATION = 12'd100;
    localparam Y_DIMENSION_ROTATION = 12'd100;

    localparam P1_X = 12'd30 + X_DIMENSION_ROTATION;   //P1(x,y)= (30,100)
    localparam P1_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P2_X = 12'd100 + X_DIMENSION_ROTATION;  //P2(x,y)= (100,100)
    localparam P2_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P38_X = 12'd65 + X_DIMENSION_ROTATION;   //P38(x,y) = (65, 100)
    localparam P38_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P3_X = 12'd65 + X_DIMENSION_ROTATION;   //P3(x,y)= (65,200)
    localparam P3_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P4_X = 12'd120 + X_DIMENSION_ROTATION;  //P4(x,y)= (120,100)
    localparam P4_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P5_X = 12'd120 + X_DIMENSION_ROTATION;  //P5(x,y)= (120,200)
    localparam P5_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P6_X = 12'd140 + X_DIMENSION_ROTATION; //P6(x,y)= (140,100)
    localparam P6_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P7_X = 12'd210 + X_DIMENSION_ROTATION;  //P7(x,y)= (210,100)
    localparam P7_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P8_X = 12'd140 + X_DIMENSION_ROTATION;   //P8(x,y)= (140,200)
    localparam P8_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P9_X = 12'd210 + X_DIMENSION_ROTATION;   //P9(x,y)= (210,200)
    localparam P9_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P10_X = 12'd250 + X_DIMENSION_ROTATION;  //P10(x,y)= (250,100)
    localparam P10_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P11_X = 12'd320 + X_DIMENSION_ROTATION;  //P11(x,y)= (320,100)
    localparam P11_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P39_X = 12'd285 + X_DIMENSION_ROTATION;  //P39(x,y)= (285,100)
    localparam P39_Y = 12'd100 + Y_DIMENSION_ROTATION;

    localparam P12_X = 12'd285 + X_DIMENSION_ROTATION;  //P12(x,y)= (285,200)
    localparam P12_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P13_X = 12'd340 + X_DIMENSION_ROTATION;  //P13(x,y)= (340,100)
    localparam P13_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P14_X = 12'd410 + X_DIMENSION_ROTATION;  //P14(x,y)= (410,100)
    localparam P14_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P15_X = 12'd340 + X_DIMENSION_ROTATION;  //P15(x,y)= (340,150)
    localparam P15_Y = 12'd150 + Y_DIMENSION_ROTATION;
    
    localparam P16_X = 12'd410 + X_DIMENSION_ROTATION;  //P15(x,y)= (410,150)
    localparam P16_Y = 12'd150 + Y_DIMENSION_ROTATION;
    
    localparam P17_X = 12'd340 + X_DIMENSION_ROTATION;  //P13(x,y)= (340,200)
    localparam P17_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P18_X = 12'd410 + X_DIMENSION_ROTATION;  //P18(x,y)= (410,200)
    localparam P18_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P19_X = 12'd430 + X_DIMENSION_ROTATION;  //P19(x,y)= (430,100)
    localparam P19_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P20_X = 12'd500 + X_DIMENSION_ROTATION;  //P20(x,y)= (500,100)
    localparam P20_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P23_X = 12'd430 + X_DIMENSION_ROTATION;  //P23(x,y)= (430,200)
    localparam P23_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P24_X = 12'd500 + X_DIMENSION_ROTATION; //P24(x,y)= (500,200)
    localparam P24_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P25_X = 12'd540 + X_DIMENSION_ROTATION;  //P25(x,y)= (540,100)
    localparam P25_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P26_X = 12'd610 + X_DIMENSION_ROTATION;  //P26(x,y)= (610,100)
    localparam P26_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P40_X = 12'd575 + X_DIMENSION_ROTATION;  //P40(x,y)= (575,100)
    localparam P40_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P27_X = 12'd575 + X_DIMENSION_ROTATION;  //P27(x,y)= (575,150)
    localparam P27_Y = 12'd150 + Y_DIMENSION_ROTATION;
    
    localparam P28_X = 12'd630 + X_DIMENSION_ROTATION;  //P28(x,y)= (630,100)
    localparam P28_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P29_X = 12'd700 + X_DIMENSION_ROTATION;  //P29(x,y)= (700,100)
    localparam P29_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P30_X = 12'd630 + X_DIMENSION_ROTATION;  //P30(x,y)= (630,200)
    localparam P30_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P31_X = 12'd700 + X_DIMENSION_ROTATION;  //P31(x,y)= (700,200)
    localparam P31_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P32_X = 12'd720 + X_DIMENSION_ROTATION;  //P32(x,y)= (720,100)
    localparam P32_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P33_X = 12'd790 + X_DIMENSION_ROTATION;  //P33(x,y)= (790,100)
    localparam P33_Y = 12'd100 + Y_DIMENSION_ROTATION;
    
    localparam P34_X = 12'd720 + X_DIMENSION_ROTATION;  //P34(x,y)= (720,150)
    localparam P34_Y = 12'd150 + Y_DIMENSION_ROTATION;
    
    localparam P35_X = 12'd790 + X_DIMENSION_ROTATION;  //P35(x,y)= (790,150)
    localparam P35_Y = 12'd150 + Y_DIMENSION_ROTATION;
    
    localparam P36_X = 12'd720 + X_DIMENSION_ROTATION;  //P36(x,y)= (720,200)
    localparam P36_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam P37_X = 12'd790 + X_DIMENSION_ROTATION;  //P37(x,y)= (790,200)
    localparam P37_Y = 12'd200 + Y_DIMENSION_ROTATION;
    
    localparam WIDTH = 40;
    localparam LENGTH = 15;
    localparam LETTERS_COLOR = 12'h3_3_3;
    localparam BACKGROUND_COLOR = 12'he_e_e;
    localparam RED_COLOR = 12'hf_0_0;
    localparam RECT_X_POS = 490;
    localparam RECT_Y_POS = 600;
    
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
            else if(vcount_in == P1_Y && (hcount_in >= P1_X && hcount_in <= P2_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p38 - p3
            else if(hcount_in == P3_X && (vcount_in >= P38_Y && vcount_in <= P3_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p4 - p5
            else if(hcount_in == P4_X && (vcount_in >= P4_Y && vcount_in <= P5_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p6 - p8
            else if(hcount_in == P6_X && (vcount_in >= P6_Y && vcount_in <= P8_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p6 - p7
            else if(vcount_in == P6_Y && (hcount_in >= P6_X && hcount_in <= P7_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p8 - p9
            else if(vcount_in == P8_Y && (hcount_in >= P8_X && hcount_in <= P9_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p10 - p11
            else if(hcount_in == P10_Y && (vcount_in >= P10_X && vcount_in <= P11_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p39 - p12
            else if(hcount_in == P12_X && (vcount_in >= P39_Y && vcount_in <= P12_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p13 - p17
            else if(hcount_in == P13_X && (vcount_in >= P13_Y && vcount_in <= P17_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p14- p18
            else if(hcount_in == P14_X && (vcount_in >= P14_Y && vcount_in <= P18_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p14- p13
            else if(vcount_in == P14_Y && (hcount_in >= P13_X && hcount_in <= P14_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p15- p16
            else if(vcount_in == P15_Y && (hcount_in >= P15_X && hcount_in <= P16_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p19- p20
            else if(vcount_in == P19_Y && (hcount_in >= P19_X && hcount_in <= P20_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end    
           //line p23- p24
            else if(vcount_in == P23_Y && (hcount_in >= P23_X && hcount_in <= P24_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p19- p23
            else if(hcount_in == P23_X && (vcount_in >= P19_Y && vcount_in <= P23_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
             //line p19- p23
            else if(hcount_in == P23_X && (vcount_in >= P19_Y && vcount_in <= P23_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p40- p27
            else if(hcount_in == P27_X && (vcount_in >= P40_Y && vcount_in <= P27_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p25- p26
            else if(vcount_in == P25_Y && (hcount_in >= P25_X && hcount_in <= P26_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p28- p29
            else if(vcount_in == P28_Y && (hcount_in >= P28_X && hcount_in <= P29_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p30- p31
            else if(vcount_in == P30_Y && (hcount_in >= P30_X && hcount_in <= P31_X))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p28- p30
            else if(hcount_in == P30_X && (vcount_in >= P28_Y && vcount_in <= P30_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p29- p31
            else if(hcount_in == P29_X && (vcount_in >= P29_Y && vcount_in <= P31_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p32- p36
            else if(hcount_in == P32_X && (vcount_in >= P32_Y && vcount_in <= P36_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p32- p33
            else if(vcount_in == P32_Y && (hcount_in >= P32_Y && vcount_in <= P33_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
           //line p34- p35
            else if(vcount_in == P34_Y && (hcount_in >= P34_Y && vcount_in <= P35_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
                end
            //line p36- p37
            else if(vcount_in == P36_Y && (hcount_in >= P36_Y && vcount_in <= P37_Y))
                begin
                    rgb_out_nxt = RED_COLOR;
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