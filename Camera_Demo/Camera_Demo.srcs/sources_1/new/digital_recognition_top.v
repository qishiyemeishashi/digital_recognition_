`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/05 00:11:27
// Design Name: 
// Module Name: digital_recognition_top
// Project Name: 
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


module digital_recognition_top(
    input pclk,
    input [10:0] SET_X,                         //行同步信号
    input [9:0] SET_Y,                          //场同步信号
    input [23:0] RGB_Raw,
    output [23:0] RGB_Data
    );
    
    wire Binary;
    wire [3:0] digital;                 //识别出的数字
    wire [6:0] num;                     //七段显示数字

//二值化处理    
    RGB2Binary  RGB2Binary(
        .RGB_Data(RGB_Raw),
        .Binary(Binary)
        );

//数字识别part        
    digital_recognition     digital_recognition(
        .pclk(pclk),
        .SET_X(SET_X),
        .SET_Y(SET_Y),
        .Binary(Binary),
        .num(num),
        .digital(digital)
        );

//显示识别的数字        
    digital_display     digital_display(
        .num(num),
        .SET_X(SET_X),
        .SET_Y(SET_Y),
        .Binary(Binary),
        .RGB_Data(RGB_Data)
        );
        
endmodule
