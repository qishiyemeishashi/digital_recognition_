`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/05 00:47:24
// Design Name: 
// Module Name: digital_display
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


module digital_display(
    input [6:0]num,
    input [10:0]SET_X,
    input [9:0]SET_Y,
    input Binary,
    output reg[23:0]RGB_Data                //RGB
    );
    
parameter 
    CENTER_H = 640,
    CENTER_V = 360,
    VtcVCnt_max = 266,
    VtcHCnt_max = 200,
    VtcHCnt_l=CENTER_H-100,
    VtcHCnt_r=CENTER_H+100,
    VtcVCnt_u=CENTER_V-133,      
    VtcVCnt_d=CENTER_V+133,
    X1 = (CENTER_V-(VtcVCnt_max>>1))+((VtcVCnt_max*410)>>10),
    X2 = (CENTER_V-(VtcVCnt_max>>1))+((VtcVCnt_max*683)>>10);

//Æß¶ÎÏÔÊ¾
always@(*)
    begin
        if( (SET_X>=5&&SET_X<25) && (SET_Y<VtcVCnt_u) )
            begin
                if(SET_Y>=25&&SET_Y<105)
                    begin
                        if(num[1])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else if(SET_Y>=125&&SET_Y<205)
                    begin
                        if(num[2])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else
                    RGB_Data<={24{Binary}};
            end
        else if( (SET_X>=25&&SET_X<105) && (SET_Y<VtcVCnt_u) )
            begin
                if(SET_Y>=5&&SET_Y<25)
                    begin
                        if(num[6])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else if(SET_Y>=105&&SET_Y<125)
                    begin
                        if(num[0])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else if(SET_Y>=205&&SET_Y<225)
                    begin
                        if(num[3])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else
                    RGB_Data<={24{Binary}};
            end
        else if( (SET_X>=105&&SET_X<125) && (SET_Y<VtcVCnt_u) )
            begin
                if(SET_Y>=25&&SET_Y<105)
                    begin
                        if(num[5])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else if(SET_Y>=125&&SET_Y<205)
                    begin
                        if(num[4])
                            RGB_Data<=24'h0000ff;
                        else
                            RGB_Data<={24{Binary}};
                    end
                else
                    RGB_Data<={24{Binary}};
            end
        else if( SET_X ==  CENTER_H || SET_Y == X1 || SET_Y == X2 )                     //ÏÔÊ¾X1¡¢X2¡¢Y
            RGB_Data <= 24'hff0000;
       //ÏÔÊ¾±ß¿ò
        else if( (SET_X>=VtcHCnt_l && SET_X<VtcHCnt_r) && (SET_Y==VtcVCnt_u || SET_Y==VtcVCnt_d) )
            RGB_Data <= 24'h000000;
        else if( (SET_Y>=VtcVCnt_u && SET_Y<VtcVCnt_d) && (SET_X==VtcHCnt_l || SET_X==VtcHCnt_r) )
            RGB_Data <= 24'h000000;
        else
            RGB_Data<={24{Binary}}; 
    
    end

endmodule
