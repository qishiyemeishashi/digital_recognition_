`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/05 00:35:23
// Design Name: 
// Module Name: digital_recognition
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


module digital_recognition(
    input               pclk,
    input       [10:0]  SET_X,
    input       [9:0]   SET_Y,
    input               Binary,
    output  reg [3:0]   digital=0,
    output      [6:0]   num
    );
    
parameter 
    CENTER_H = 640,
    CENTER_V = 360,
    Box_W = 200,
    Box_H = 266,
    Box_L = CENTER_H - (Box_W>>1),              //�߿���߽�
    Box_R = CENTER_H + (Box_W>>1),              //�߿��ұ߽�
    Box_T = CENTER_V - (Box_H>>1),              //�߿��ϱ߽�      
    Box_B = CENTER_V + (Box_H>>1),              //�߿��±߽�
    X1 = Box_T+((Box_H*410)>>10),               //X1
    X2 = Box_T+((Box_H*683)>>10),               //X2
    Y = CENTER_H;                               //Y
    
reg        x1_cnt_l=0, x1_cnt_r=0;
reg        x2_cnt_l=0, x2_cnt_r=0;
reg[1:0] x1_cnt=0, x2_cnt=0, y_cnt=0;


////////        ʶ�𷽷�        ////////

reg        x1_temp=0, x2_temp=0, y_temp=0;
reg        rst=1;
always@(posedge pclk) begin
    if(SET_X==Box_L && SET_Y==Box_T)
        rst<=0;
    else if(SET_X==Box_L+1 && SET_Y==Box_T)
        rst<=1;
    else
        rst<=rst;
    end
    
//X1���ؼ��
always@(posedge pclk) begin
    if(SET_Y==X1)
        x1_temp <= Binary;
    else
        x1_temp <= x1_temp;
    end

always@(posedge x1_temp or negedge rst) begin
    if(!rst)
        begin
            x1_cnt_l <= 0;
        end
    else if(SET_X>Box_L && SET_X<CENTER_H)
        x1_cnt_l<= x1_cnt_l + 1;
    else begin
        x1_cnt_l <= x1_cnt_l;
    end
end

always@(posedge x1_temp or negedge rst) begin
    if(!rst)
        begin
            x1_cnt_r <= 0;
        end
    else if(SET_X<Box_R && SET_X>CENTER_H)
        x1_cnt_r<= x1_cnt_r + 1;
    else begin
        x1_cnt_r <= x1_cnt_r;
    end
end

//X2���ؼ��
always@(posedge pclk) begin
    if(SET_Y==X2)
        x2_temp <= Binary;
    else
        x2_temp <= x2_temp;
    end

always@(posedge x2_temp or negedge rst) begin
    if(!rst)
        begin
            x2_cnt_l <= 0;
        end
    else if(SET_X>Box_L && SET_X<CENTER_H)
        x2_cnt_l<= x2_cnt_l + 1;
    else begin
        x2_cnt_l <= x2_cnt_l;
    end
end

always@(posedge x2_temp or negedge rst) begin
    if(!rst)
        begin
            x2_cnt_r <= 0;
        end
    else if(SET_X<Box_R && SET_X>CENTER_H)
        x2_cnt_r<= x2_cnt_r + 1;
    else begin
        x2_cnt_r <= x2_cnt_r;
    end
end

//Y���ؼ��
always@(posedge pclk) begin
    if(SET_X==Y)
        y_temp <= Binary;
    else
        y_temp <= y_temp;
    end

always@(posedge y_temp or negedge rst) begin
    if(!rst)
        begin
           y_cnt <= 0;
        end
    else if(SET_Y>Box_T && SET_Y<Box_B)
        y_cnt<= y_cnt + 1;
    else
        y_cnt<= y_cnt;
end

////////        ��������        ////////

//ʶ������
always @(posedge pclk) begin
    x1_cnt <= x1_cnt_r + x1_cnt_l;
    x2_cnt <= x2_cnt_r + x2_cnt_l;
    end

always @(posedge pclk)
begin
    if(SET_X==Box_R && SET_Y==Box_B)
        begin
            if(y_cnt==2 && x1_cnt==2 && x2_cnt==2)
                   digital<=4'b0000;                                //����0
            else if(y_cnt==1 && x1_cnt==1 && x2_cnt==1)
                   digital<=4'b0001;                                //����1
            else if(y_cnt==3 && x1_cnt==1 && x2_cnt==1) begin
                   if(x1_cnt_r==1 && x2_cnt_l==1)
                         digital<=4'b0010;                          //����2
                   else if (x1_cnt_r==1 && x2_cnt_r==1)	
                         digital<=4'b0011;                          //����3
                   else if(x1_cnt_l==1 && x2_cnt_r==1)
                         digital<=4'b0101;                          //����5
                   else
                         digital<=4'b1010;                          
                   end 
            else if(y_cnt==2 && x1_cnt==2 && x2_cnt==1)				
                    digital<=4'b0100;                               //����4
            else if(y_cnt==3 && x1_cnt==1 && x2_cnt==2)
                    digital<=4'b0110;                               //����6
            else if(y_cnt==2 && x1_cnt==1 && x2_cnt==1)
                    digital<=4'b0111;                               //����7
            else if(y_cnt==3 && x1_cnt==2 && x2_cnt==2)
                   digital<=4'b1000;                                //����8
            else if(y_cnt==3 && x1_cnt==2 && x2_cnt==1)
                   digital<=4'b1001;                                //����9
            else
                   digital<=4'b1111;
        end
    else
        digital<= digital;
end

//��ʶ�������ת��Ϊ�߶�����
digital2num digital2num(
    .num(num),
    .digital(digital)
    );

endmodule
