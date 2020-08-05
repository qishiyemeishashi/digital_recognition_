`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/05 00:41:34
// Design Name: 
// Module Name: digital2num
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


module digital2num(
 input [3:0] digital,
    output reg [6:0]num//=7'b1001111
    );
    always@(*)
        begin
            case(digital)
                0:num <= 7'b1111110;
                1:num <= 7'b0110000;
                2:num <= 7'b1101101;
                3:num <= 7'b1111001;
                4:num <= 7'b0110011;
                5:num <= 7'b1011011;
                6:num <= 7'b1011111;
                7:num <= 7'b1110000;
                8:num <= 7'b1111111;
                9:num <= 7'b1111011;
                default:num <= 7'b1000111;        
            endcase
        end
        
endmodule
