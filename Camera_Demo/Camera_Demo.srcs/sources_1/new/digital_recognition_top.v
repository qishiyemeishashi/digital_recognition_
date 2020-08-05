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
    input [10:0] SET_X,                         //��ͬ���ź�
    input [9:0] SET_Y,                          //��ͬ���ź�
    input [23:0] RGB_Raw,
    output [23:0] RGB_Data
    );
    
    wire Binary;
    wire [3:0] digital;                 //ʶ���������
    wire [6:0] num;                     //�߶���ʾ����

//��ֵ������    
    RGB2Binary  RGB2Binary(
        .RGB_Data(RGB_Raw),
        .Binary(Binary)
        );

//����ʶ��part        
    digital_recognition     digital_recognition(
        .pclk(pclk),
        .SET_X(SET_X),
        .SET_Y(SET_Y),
        .Binary(Binary),
        .num(num),
        .digital(digital)
        );

//��ʾʶ�������        
    digital_display     digital_display(
        .num(num),
        .SET_X(SET_X),
        .SET_Y(SET_Y),
        .Binary(Binary),
        .RGB_Data(RGB_Data)
        );
        
endmodule
